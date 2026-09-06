# Case B evidence completion

Continue the existing Case B review with this previously missing test source.
The code range and requirements are unchanged. Inspect the assertions, update
only the missing coverage, and return the completed verdict. No new review gate
or code correction is needed. Do not rerun tests.

`test_lookup.py`, complete unchanged source:
```python
from lookup import find

def test_missing():
    assert find([{'id': 'a'}], 'b') is None

def test_empty_rows():
    assert find([], 'a') is None

def test_empty_identifier():
    row = {'id': ''}
    assert find([row], '') is row

def test_unicode():
    row = {'id': 'É🙂'}
    assert find([row], 'É🙂') is row
    assert find([row], 'é🙂') is None

def test_first_duplicate():
    first, second = {'id': 'a'}, {'id': 'a'}
    assert find([first, second], 'a') is first
```

Reported command remains `python -m pytest test_lookup.py` -> 5 passed.
