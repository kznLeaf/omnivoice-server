## Development

This project uses [uv](https://docs.astral.sh/uv/) for dependency management.

### Setup

```bash
# Clone repository
git clone https://github.com/maemreyo/omnivoice-server.git
cd omnivoice-server

# Install uv (if not already installed)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install with dev dependencies
uv sync --extra dev
```

### Run Server

```bash
# Start server (default: http://127.0.0.1:8880)
uv run omnivoice-server

# Or run as a module
uv run python -m omnivoice_server

# With custom settings
uv run omnivoice-server --host 0.0.0.0 --port 8880 --device cuda

# With authentication
export OMNIVOICE_API_KEY="your-secret-key"
uv run omnivoice-server
```

You can also use `make run` as a shortcut.

First run downloads the model weights; this may take a few minutes.

### Run Tests

```bash
# Run all tests
uv run pytest

# Run with coverage
uv run pytest --cov=omnivoice_server --cov-report=term-missing

# Run specific test
uv run pytest tests/test_streaming.py -v
```

### Code Quality

```bash
# Lint
uv run ruff check omnivoice_server/ tests/

# Format
uv run ruff format omnivoice_server/ tests/

# Type check
uv run mypy omnivoice_server/
```

### Updating Dependencies

```bash
# After changing pyproject.toml
uv lock
uv sync --extra dev
```

### CI/CD

GitHub Actions workflow runs on every push:
- Linting (ruff)
- Type checking (mypy)
- Tests (pytest)
- Python 3.10, 3.11, 3.12
