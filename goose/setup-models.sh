#!/bin/bash
# Pull base local models and build the Goose-tuned derived models (16K context).
# Idempotent — safe to re-run. Called by install.sh (home profile) and runnable by hand.
# Guide: life/guides/local-llm.md
set -uo pipefail

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OLLAMA="${OLLAMA:-/opt/homebrew/bin/ollama}"

if ! command -v "$OLLAMA" >/dev/null 2>&1; then
    echo "ollama not found at $OLLAMA — install it first (Brewfile.home: cask ollama-app)." >&2
    exit 1
fi

# Wait for the server (LaunchAgent) to be reachable before pulling.
for _ in $(seq 1 15); do
    curl -fsS http://localhost:11434/api/version >/dev/null 2>&1 && break
    sleep 2
done

# Base models. ollama.com occasionally returns transient EOFs mid-pull — retry each.
pull() {
    local model="$1"
    "$OLLAMA" show "$model" >/dev/null 2>&1 && { echo "✓ $model already present"; return 0; }
    for attempt in 1 2 3 4 5; do
        echo "pulling $model (attempt $attempt)..."
        "$OLLAMA" pull "$model" && return 0
        sleep 5
    done
    echo "⚠️  failed to pull $model after retries — re-run this script later." >&2
    return 1
}

pull qwen3:8b       # default agent model (best tool-caller in class; has thinking mode)
pull qwen2.5:7b     # non-thinking alternative — faster per agentic step
pull llama3.2:3b    # tiny + fast for trivial non-agentic tasks

# Derived models with 16K context baked in (Goose ignores server context; needs this).
"$OLLAMA" show qwen3:8b   >/dev/null 2>&1 && "$OLLAMA" create qwen3-goose  -f "$dir/Modelfile.qwen3-goose"  >/dev/null 2>&1 && echo "✓ qwen3-goose (16K)"
"$OLLAMA" show qwen2.5:7b >/dev/null 2>&1 && "$OLLAMA" create qwen25-goose -f "$dir/Modelfile.qwen25-goose" >/dev/null 2>&1 && echo "✓ qwen25-goose (16K)"

echo "Done. Models:"
"$OLLAMA" list
