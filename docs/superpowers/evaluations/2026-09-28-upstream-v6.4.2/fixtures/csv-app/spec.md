# CSV import
Revision: r1. Approved.
Add a local CSV reader load_rows(path: Path) -> list[dict[str,str]] to this Python application. Files use UTF-8, first row is the header, records map headers to field text, and the caller displays a friendly error for unreadable input. Files come from users. Use stdlib csv; no dependencies. Existing show_import displays each returned row; no external writes. New function belongs in app/csv_import.py and its tests in tests/test_csv_import.py. Project suite is python3 -m unittest discover -s tests.
