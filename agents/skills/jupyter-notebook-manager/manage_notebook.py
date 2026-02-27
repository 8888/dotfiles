#!/usr/bin/env python3
import sys
import json
import argparse
import os

def load_notebook(path):
    if not os.path.exists(path):
        # Default for new notebooks
        return {
            "cells": [],
            "metadata": {},
            "nbformat": 4,
            "nbformat_minor": 5
        }
    with open(path, 'r', encoding='utf-8') as f:
        return json.load(f)

def save_notebook(path, nb):
    with open(path, 'w', encoding='utf-8') as f:
        json.dump(nb, f, indent=1, ensure_ascii=False)
        f.write('\n')

def list_cells(nb):
    if not nb['cells']:
        print("No cells found.")
        return
    for i, cell in enumerate(nb['cells']):
        source = "".join(cell.get('source', []))
        snippet = source.replace('\n', ' ')[:60]
        print(f"{i}: {cell['cell_type']} | {snippet}")

def view_cell(nb, index):
    try:
        cell = nb['cells'][index]
        source = "".join(cell.get('source', []))
        print(source)
    except IndexError:
        print(f"Error: Cell index {index} out of range.", file=sys.stderr)
        sys.exit(1)

def insert_cell(nb, index, cell_type, source):
    new_cell = {
        "cell_type": cell_type,
        "metadata": {},
        "source": source.splitlines(keepends=True)
    }

    if cell_type == "code":
        new_cell["execution_count"] = None
        new_cell["outputs"] = []

    if index >= len(nb['cells']):
        nb['cells'].append(new_cell)
    else:
        nb['cells'].insert(max(0, index), new_cell)

def replace_cell(nb, index, source):
    try:
        cell = nb['cells'][index]
        cell['source'] = source.splitlines(keepends=True)
    except IndexError:
        print(f"Error: Cell index {index} out of range.", file=sys.stderr)
        sys.exit(1)

def delete_cell(nb, index):
    try:
        nb['cells'].pop(index)
    except IndexError:
        print(f"Error: Cell index {index} out of range.", file=sys.stderr)
        sys.exit(1)

def move_cell(nb, from_idx, to_idx):
    try:
        cell = nb['cells'].pop(from_idx)
        nb['cells'].insert(to_idx, cell)
    except IndexError:
        print(f"Error: Index out of range.", file=sys.stderr)
        sys.exit(1)

def main():
    parser = argparse.ArgumentParser(description="Programmatic Jupyter Notebook editor.")
    parser.add_argument("notebook", help="Path to the .ipynb file")

    subparsers = parser.add_subparsers(dest="command", help="Command to execute")

    subparsers.add_parser("list", help="List cells in the notebook")

    view_p = subparsers.add_parser("view", help="View a specific cell's content")
    view_p.add_argument("--index", type=int, required=True, help="Cell index")

    insert_p = subparsers.add_parser("insert", help="Insert a new cell")
    insert_p.add_argument("--index", type=int, required=True, help="Index to insert at")
    insert_p.add_argument("--type", choices=["code", "markdown"], default="code", help="Cell type")
    insert_p.add_argument("--source", required=True, help="Cell source content")

    replace_p = subparsers.add_parser("replace", help="Replace a cell's content")
    replace_p.add_argument("--index", type=int, required=True, help="Index of cell to replace")
    replace_p.add_argument("--source", required=True, help="New source content")

    delete_p = subparsers.add_parser("delete", help="Delete a cell")
    delete_p.add_argument("--index", type=int, required=True, help="Index of cell to delete")

    move_p = subparsers.add_parser("move", help="Move a cell")
    move_p.add_argument("--from", dest="from_idx", type=int, required=True, help="Source index")
    move_p.add_argument("--to", dest="to_idx", type=int, required=True, help="Destination index")

    args = parser.parse_args()

    if not args.command:
        parser.print_help()
        return

    nb = load_notebook(args.notebook)

    if args.command == "list":
        list_cells(nb)
    elif args.command == "view":
        view_cell(nb, args.index)
    elif args.command == "insert":
        insert_cell(nb, args.index, args.type, args.source)
        save_notebook(args.notebook, nb)
        print(f"Inserted {args.type} cell at index {args.index}")
    elif args.command == "replace":
        replace_cell(nb, args.index, args.source)
        save_notebook(args.notebook, nb)
        print(f"Replaced cell at index {args.index}")
    elif args.command == "delete":
        delete_cell(nb, args.index)
        save_notebook(args.notebook, nb)
        print(f"Deleted cell at index {args.index}")
    elif args.command == "move":
        move_cell(nb, args.from_idx, args.to_idx)
        save_notebook(args.notebook, nb)
        print(f"Moved cell from {args.from_idx} to {args.to_idx}")

if __name__ == "__main__":
    main()
