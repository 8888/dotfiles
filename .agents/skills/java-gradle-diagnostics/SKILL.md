---
name: java-gradle-diagnostics
description: Diagnoses and repairs common Java and Gradle environment issues like unbound classpath containers and project configuration failures.
---

# Java & Gradle Diagnostics Skill

This skill allows Antigravity to diagnose and fix common Java/Gradle development environment issues.

## Capabilities
- **Identify JDK versions**: Checks current Java environment using `mise` or system defaults.
- **Repair Gradle Projects**: Cleans IDE artifacts and Gradle caches to resolve "Unbound classpath container" errors.
- **Dependency Refresh**: Forces Gradle to re-download missing or corrupted dependencies.

## Usage
When you detect build errors or IDE sync issues (e.g., in Eclipse or VS Code), you can run the provided diagnostic script.

### Diagnostic Script
The primary tool for this skill is the `fix_gradle.sh` script located in the `scripts/` directory.

**Command:**
`./scripts/fix_gradle.sh [project_dir] [--deep]`

- `[project_dir]`: Path to the Gradle project (defaults to current directory).
- `--deep`: Also clears the global Gradle cache (use with caution as it triggers a full re-download).

### Recommended Steps
1. **Analyze Error**: Examine the build log or IDE error message.
2. **Run Diagnostic**: Execute `fix_gradle.sh` in the project root.
3. **Verify Build**: Try running `./gradlew build` after the script completes.
