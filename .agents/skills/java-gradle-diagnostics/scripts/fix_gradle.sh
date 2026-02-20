#!/bin/bash

# Java & Gradle Fixer Script
# Aimed at resolving "Unbound classpath container" and build configuration issues.

PROJECT_DIR=${1:-"."}
DEEP_CLEAN=false

if [[ "$2" == "--deep" ]]; then
    DEEP_CLEAN=true
fi

cd "$PROJECT_DIR" || exit 1

echo "--- Starting Java/Gradle Diagnostics for $PROJECT_DIR ---"

# 1. Check Java Environment
echo "Checking Java version..."
if command -v java >/dev/null 2>&1; then
    java -version
else
    echo "ERROR: Java not found in PATH."
fi

if command -v mise >/dev/null 2>&1; then
    echo "Mise detected. Checking local ruby/java config..."
    mise current java
fi

# 2. Clean IDE Artifacts
echo "Cleaning IDE configuration files (.classpath, .project, .settings)..."
rm -rf .classpath .project .settings/ .idea/ *.iml

# 3. Clean Gradle Build Artifacts
echo "Cleaning Gradle build directory and local cache..."
./gradlew clean --no-daemon

# 4. Deep Clean (Optional)
if [ "$DEEP_CLEAN" = true ]; then
    echo "CAUTION: Performing deep clean of ~/.gradle/caches..."
    rm -rf ~/.gradle/caches
fi

# 5. Refresh Dependencies and Regenerate IDE Files
echo "Refreshing dependencies and regenerating IDE files..."
./gradlew cleanEclipse eclipse --refresh-dependencies --no-daemon
./gradlew cleanIdea idea --no-daemon

echo "--- Diagnostics and Fix Actions Complete ---"
echo "Please restart your IDE or refresh the project."
