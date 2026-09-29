import unittest

class ImportUiTest(unittest.TestCase):
    def test_module_imports(self):
        from app.import_ui import show_import
        self.assertTrue(callable(show_import))
