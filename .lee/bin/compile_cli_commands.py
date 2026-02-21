#!/usr/bin/env python3
import os
import glob
import re
import shutil

def main():
    home = os.path.expanduser("~")
    dotfiles_dir = os.path.join(home, "dotfiles")
    workflows_in_dir = os.path.join(dotfiles_dir, "agents", "workflows")
    gemini_commands_dir = os.path.join(home, ".gemini", "commands")

    # Clean the commands directory first to make it idempotent
    if os.path.exists(gemini_commands_dir):
        shutil.rmtree(gemini_commands_dir)
    os.makedirs(gemini_commands_dir, exist_ok=True)

    md_files = glob.glob(os.path.join(workflows_in_dir, "*.md"))

    for md_path in md_files:
        with open(md_path, 'r', encoding='utf-8') as f:
            content = f.read()

        # Parse YAML frontmatter
        desc_match = re.search(r'^---\n(.*?)\n---', content, re.DOTALL)
        description = "No description provided"
        prompt_content = content

        if desc_match:
            frontmatter = desc_match.group(1)
            desc_line = re.search(r'^description:\s*(.*?)$', frontmatter, re.MULTILINE)
            if desc_line:
                description = desc_line.group(1).strip()

            # The prompt is everything after the second '---'
            prompt_start = desc_match.end()
            prompt_content = content[prompt_start:].strip()

        # Determine output path: dev-task.md -> dev/task.toml
        basename = os.path.basename(md_path)
        name_without_ext = os.path.splitext(basename)[0]

        parts = name_without_ext.split('-', 1)
        if len(parts) == 2:
            folder, command_name = parts
            out_dir = os.path.join(gemini_commands_dir, folder)
            out_file = os.path.join(out_dir, f"{command_name}.toml")
            command_label = f"{folder}:{command_name}"
        else:
            out_dir = gemini_commands_dir
            out_file = os.path.join(out_dir, f"{name_without_ext}.toml")
            command_label = name_without_ext

        os.makedirs(out_dir, exist_ok=True)

        # Basic escaping for TOML multi-line strings
        safe_prompt = prompt_content.replace('"""', '\\"\\"\\"')

        with open(out_file, 'w', encoding='utf-8') as out_f:
            out_f.write(f'name = "{command_label}"\n')
            out_f.write(f'description = "{description}"\n')
            out_f.write(f'prompt = """\n{safe_prompt}\n"""\n')

        print(f"Generated: {out_file}")

if __name__ == "__main__":
    main()
