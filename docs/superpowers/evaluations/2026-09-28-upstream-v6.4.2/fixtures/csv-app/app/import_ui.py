def show_import(path):
    from app.csv_import import load_rows
    try:
        rows = load_rows(path)
    except (OSError, ValueError):
        return "Could not read this import"
    return "\n".join(str(row) for row in rows)
