#!/usr/bin/env python3
import os
import glob
import re

# We will implement the actual logic in the next step after I import toml.
# Wait, standard library doesn't have a toml parser built in until Python 3.11 (tomllib). Let's see if we have tomllib or if we need a simple custom parser for just extracting prompt and description.
import sys
try:
    import tomllib
except ModuleNotFoundError:
    try:
        import tomli as tomllib
    except ModuleNotFoundError:
        # Fallback for simple toml if not installed
        tomllib = None

# Let's write the real script.

def simple_toml_parse(content):
    # A very basic parser for our gemini toml files if tomllib is not available
    # We expect `name = "..."`, `description = "..."`, `prompt = """..."""`
    result = {}

    # Extract description
    desc_match = re.search(r'^description\s*=\s*"(.*?)"', content, re.MULTILINE)
    if desc_match:
        result['description'] = desc_match.group(1)

    # Extract prompt
    # Finding multi-line string for prompt
    prompt_match = re.search(r'prompt\s*=\s*"""(.*?)"""', content, re.DOTALL)
    if prompt_match:
        result['prompt'] = prompt_match.group(1)

    return result

def main():
    home = os.path.expanduser("~")
    dotfiles_dir = os.path.join(home, "dotfiles")
    gemini_commands_dir = os.path.join(dotfiles_dir, "gemini", "commands")
    workflows_out_dir = os.path.join(dotfiles_dir, ".agents", "workflows")

    if not os.path.exists(workflows_out_dir):
        os.makedirs(workflows_out_dir, exist_ok=True)

    toml_files = glob.glob(os.path.join(gemini_commands_dir, "**", "*.toml"), recursive=True)

    for toml_path in toml_files:
        with open(toml_path, 'r', encoding='utf-8') as f:
            content = f.read()

        if tomllib:
            try:
                data = tomllib.loads(content)
            except Exception as e:
                print(f"Error parsing {toml_path} with tomllib: {e}")
                data = simple_toml_parse(content)
        else:
            data = simple_toml_parse(content)

        description = data.get('description', 'No description provided')
        prompt_content = data.get('prompt', '')

        # Resolve @{.../.gemini/docs/persona.md} includes
        # Note: the toml files might hardcode ~/.gemini/docs/
        # We replace `@{.../docs/...}` with the actual contents from dotfiles/gemini/docs
        def replacer(match):
            include_path = match.group(1)
            # if it's __HOME__/.gemini/docs/..., map to ~/dotfiles/gemini/docs/...
            # or if it's an absolute path
            basename = os.path.basename(include_path)
            actual_doc_path = os.path.join(dotfiles_dir, "gemini", "docs", basename)
            if os.path.exists(actual_doc_path):
                with open(actual_doc_path, 'r', encoding='utf-8') as doc_f:
                    return doc_f.read()
            else:
                return f"<!-- Failed to load {include_path} -->"

        resolved_prompt = re.sub(r'#?@\{(.*?)\}', replacer, prompt_content)

        # Generate the destination workflow filename
        # e.g., dev/task.toml -> dev-task.md
        rel_path = os.path.relpath(toml_path, gemini_commands_dir)
        base_name = os.path.splitext(rel_path)[0].replace(os.path.sep, '-')
        out_file = os.path.join(workflows_out_dir, f"{base_name}.md")

        # Write the workflow markdown file with YAML frontmatter
        with open(out_file, 'w', encoding='utf-8') as out_f:
            out_f.write("---\n")
            out_f.write(f"description: {description}\n")
            out_f.write("---\n\n")
            out_f.write(resolved_prompt.strip() + "\n")

        print(f"Generated: {out_file}")

if __name__ == "__main__":
    main()
