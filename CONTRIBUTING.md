# Contributing to OmniVoice Server

Thank you for your interest in contributing!

## Quick Start

1. Fork and clone the repository
2. Install [uv](https://docs.astral.sh/uv/getting-started/installation/)
3. Install dependencies: `uv sync --extra dev`
4. Start the server: `uv run omnivoice-server`
5. Create a branch: `git checkout -b feature/your-feature`
6. Make changes and add tests
7. Run tests: `uv run pytest tests/ -v`
8. Run linting: `uv run ruff check omnivoice_server/ tests/`
9. Commit: `git commit -m "feat: your feature"`
10. Push and create PR

## Code Style

- Follow PEP 8
- Use type hints
- Max line length: 100
- Run `ruff check --fix` before committing

## Testing

- Write tests for new features
- Maintain 80%+ coverage
- Use pytest fixtures

## Commit Convention

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `test`: Tests
- `refactor`: Refactoring

## Questions?

Open an issue or discussion!
