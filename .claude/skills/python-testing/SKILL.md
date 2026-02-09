---
name: python-testing
description: pytest testing patterns for Python projects including fixtures, parametrize, mocking, and test coverage.
---

# Python Testing Patterns

Testing patterns using pytest for Python projects.

## Project Structure

```
project/
├── mypackage/
│   ├── __init__.py
│   └── module.py
├── tests/
│   ├── __init__.py
│   ├── conftest.py       # Shared fixtures
│   ├── test_module.py
│   └── integration/
│       └── test_api.py
└── pyproject.toml
```

## Test Structure

```python
# tests/test_user_service.py
import pytest
from mypackage.user_service import UserService

class TestUserService:
    """Group related tests in a class."""

    def test_create_user_with_valid_input(self):
        # Arrange
        service = UserService()
        input_data = {"name": "Alice", "email": "alice@example.com"}

        # Act
        user = service.create_user(input_data)

        # Assert
        assert user.id is not None
        assert user.name == "Alice"

    def test_create_user_raises_for_invalid_email(self):
        service = UserService()
        input_data = {"name": "Alice", "email": "invalid"}

        with pytest.raises(ValueError, match="Invalid email"):
            service.create_user(input_data)
```

## Fixtures

### Basic Fixtures

```python
# tests/conftest.py
import pytest
from mypackage.database import Database

@pytest.fixture
def db():
    """Create test database connection."""
    database = Database(":memory:")
    database.create_tables()
    yield database
    database.close()

@pytest.fixture
def user_service(db):
    """Create UserService with test database."""
    from mypackage.user_service import UserService
    return UserService(db)
```

### Fixture Scopes

```python
@pytest.fixture(scope="function")  # Default: new instance per test
def temp_file(tmp_path):
    return tmp_path / "test.txt"

@pytest.fixture(scope="class")  # Shared within test class
def shared_resource():
    return create_expensive_resource()

@pytest.fixture(scope="module")  # Shared within module
def db_connection():
    conn = create_connection()
    yield conn
    conn.close()

@pytest.fixture(scope="session")  # Shared across entire test session
def docker_container():
    container = start_container()
    yield container
    container.stop()
```

### Autouse Fixtures

```python
@pytest.fixture(autouse=True)
def reset_environment():
    """Automatically run before each test."""
    os.environ.clear()
    yield
    os.environ.clear()
```

## Parametrize

### Basic Parametrize

```python
@pytest.mark.parametrize("input,expected", [
    (2, 4),
    (3, 9),
    (4, 16),
    (-2, 4),
])
def test_square(input, expected):
    assert square(input) == expected
```

### Multiple Parameters

```python
@pytest.mark.parametrize("a,b,expected", [
    (1, 2, 3),
    (0, 0, 0),
    (-1, 1, 0),
])
def test_add(a, b, expected):
    assert add(a, b) == expected
```

### Parametrize with IDs

```python
@pytest.mark.parametrize("input,expected", [
    pytest.param("hello", "HELLO", id="lowercase"),
    pytest.param("WORLD", "WORLD", id="uppercase"),
    pytest.param("MiXeD", "MIXED", id="mixed-case"),
])
def test_uppercase(input, expected):
    assert input.upper() == expected
```

### Parametrize with Error Cases

```python
@pytest.mark.parametrize("input,expected_error", [
    ("", ValueError),
    (None, TypeError),
    (-1, ValueError),
])
def test_parse_invalid_input(input, expected_error):
    with pytest.raises(expected_error):
        parse(input)
```

## Mocking

### Function Mocking

```python
from unittest.mock import Mock, patch, MagicMock

def test_with_mock():
    mock_func = Mock(return_value=42)
    result = mock_func("arg1", "arg2")

    assert result == 42
    mock_func.assert_called_once_with("arg1", "arg2")

def test_with_side_effect():
    mock_func = Mock(side_effect=[1, 2, 3])
    assert mock_func() == 1
    assert mock_func() == 2
    assert mock_func() == 3

def test_with_exception():
    mock_func = Mock(side_effect=ValueError("error"))
    with pytest.raises(ValueError, match="error"):
        mock_func()
```

### Patching

```python
# Patch a module-level function
@patch("mypackage.module.external_api_call")
def test_with_patch(mock_api):
    mock_api.return_value = {"data": "mocked"}

    result = my_function()

    assert result == {"data": "mocked"}
    mock_api.assert_called_once()

# Patch as context manager
def test_with_context_manager():
    with patch("mypackage.module.get_config") as mock_config:
        mock_config.return_value = {"debug": True}
        result = initialize()
        assert result.debug is True

# Patch object method
@patch.object(UserService, "save")
def test_patch_method(mock_save):
    mock_save.return_value = True
    service = UserService()
    assert service.save(user) is True
```

### Async Mocking

```python
from unittest.mock import AsyncMock

@pytest.mark.asyncio
async def test_async_function():
    mock_fetch = AsyncMock(return_value={"data": "async"})

    result = await mock_fetch()

    assert result == {"data": "async"}
    mock_fetch.assert_awaited_once()
```

## Async Testing

```python
import pytest

@pytest.mark.asyncio
async def test_async_function():
    result = await fetch_data()
    assert result is not None

@pytest.mark.asyncio
async def test_async_with_fixture(async_client):
    response = await async_client.get("/api/users")
    assert response.status_code == 200
```

## Markers

### Built-in Markers

```python
@pytest.mark.skip(reason="Not implemented yet")
def test_future_feature():
    pass

@pytest.mark.skipif(sys.version_info < (3, 10), reason="Requires Python 3.10+")
def test_new_syntax():
    pass

@pytest.mark.xfail(reason="Known bug #123")
def test_known_bug():
    assert buggy_function() == expected

@pytest.mark.slow
def test_slow_integration():
    pass
```

### Custom Markers

```python
# pytest.ini or pyproject.toml
# [pytest]
# markers =
#     slow: marks tests as slow
#     integration: integration tests

@pytest.mark.slow
def test_database_migration():
    pass

# Run: pytest -m "not slow"
# Run: pytest -m "integration"
```

## Common Assertions

```python
# Equality
assert result == expected
assert result != other

# Identity
assert result is None
assert result is not None

# Truthiness
assert result
assert not result

# Containment
assert item in collection
assert "substring" in text

# Type checking
assert isinstance(result, MyClass)

# Approximate equality (floats)
assert result == pytest.approx(expected, rel=1e-3)
assert result == pytest.approx(expected, abs=0.01)

# Exception checking
with pytest.raises(ValueError):
    raise_error()

with pytest.raises(ValueError, match="specific message"):
    raise_error()

# Warnings
with pytest.warns(DeprecationWarning):
    deprecated_function()
```

## Test Coverage

### Configuration

```toml
# pyproject.toml
[tool.coverage.run]
source = ["src"]
branch = true
omit = ["*/tests/*", "*/__init__.py"]

[tool.coverage.report]
exclude_lines = [
    "pragma: no cover",
    "if TYPE_CHECKING:",
    "raise NotImplementedError",
]
fail_under = 80
```

### Running Coverage

```bash
# Run tests with coverage
pytest --cov=mypackage --cov-report=term-missing

# Generate HTML report
pytest --cov=mypackage --cov-report=html

# Fail if coverage below threshold
pytest --cov=mypackage --cov-fail-under=80
```

## Testing Commands

**ALWAYS check for Makefile first:**
- If `Makefile` exists → Use `make test` or `make check`
- If not → Ask user before creating one (see `coding-style` skill)
- If user declines → Use commands below

```bash
# Run all tests
pytest

# Verbose output
pytest -v

# Run specific test file
pytest tests/test_module.py

# Run specific test function
pytest tests/test_module.py::test_function

# Run specific test class
pytest tests/test_module.py::TestClass

# Run tests matching pattern
pytest -k "user and not slow"

# Run marked tests
pytest -m slow
pytest -m "not integration"

# Stop on first failure
pytest -x

# Run last failed tests
pytest --lf

# Run failed first, then rest
pytest --ff

# Show local variables in tracebacks
pytest -l

# Parallel execution (pytest-xdist)
pytest -n auto

# Generate coverage
pytest --cov=mypackage --cov-report=term-missing
```

## Best Practices

**DO:**
- Write tests FIRST (TDD)
- Use descriptive test names: `test_create_user_raises_when_email_invalid`
- One assertion per test (or related assertions)
- Use fixtures for setup/teardown
- Use parametrize for multiple test cases
- Keep tests independent and isolated

**DON'T:**
- Test implementation details
- Use `time.sleep()` in tests
- Share state between tests
- Mock everything (prefer integration tests when practical)
- Ignore flaky tests
