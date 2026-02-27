---
name: jupyter-notebook-manager
description: Programmatic manipulation of Jupyter Notebook (.ipynb) files.
---

# Jupyter Notebook Management Skill

Use this skill when you need to read, edit, or create Jupyter Notebook (.ipynb) files. Notebooks are complex JSON structures, so programmatic tools are safer than direct text manipulation.

## Core Utility

The `manage_notebook.py` script provides a CLI for common notebook operations.

### Usage Patterns

#### 1. List Cells
Always start by listing cells to understand the notebook structure and identify target indices.
```bash
python3 path/to/jupyter-notebook-manager/manage_notebook.py notebook.ipynb list
```

#### 2. View a Cell
Read the full content of a specific cell.
```bash
python3 path/to/manage_notebook.py notebook.ipynb view --index 0
```

#### 3. Insert a Cell
Add a new code or markdown cell at a specific position.
```bash
python3 path/to/manage_notebook.py notebook.ipynb insert --index 0 --type markdown --source "# Title"
```

#### 4. Replace Cell Content
Update the source code or text of an existing cell.
```bash
python3 path/to/manage_notebook.py notebook.ipynb replace --index 1 --source "print('hello world')"
```

#### 5. Delete a Cell
Remove a cell by its index.
```bash
python3 path/to/manage_notebook.py notebook.ipynb delete --index 2
```

#### 6. Move a Cell
Reorder cells programmatically.
```bash
python3 path/to/manage_notebook.py notebook.ipynb move --from 2 --to 0
```

## Best Practices
- **Backup**: If doing complex multi-step edits, consider making a temporary backup of the `.ipynb` file.
- **Verification**: After editing, use the `list` or `view` commands to confirm the changes are correct.
- **Indices**: Remember that indices shift after `insert`, `delete`, or `move`. Always re-list if you are unsure of the current state.
