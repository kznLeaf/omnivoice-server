# Multi-stage build for omnivoice-server
FROM python:3.12-slim AS builder

COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

WORKDIR /build

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

ENV UV_COMPILE_BYTECODE=1 UV_LINK_MODE=copy

# Copy project files
COPY pyproject.toml uv.lock README.md ./
COPY omnivoice_server ./omnivoice_server

# Install dependencies (PyTorch CPU via uv index config in pyproject.toml)
RUN uv sync --frozen --no-dev

# Runtime stage
FROM python:3.12-slim

WORKDIR /app

# Install runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libsndfile1 \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

ENV VIRTUAL_ENV=/build/.venv
ENV PATH="${VIRTUAL_ENV}/bin:${PATH}"

# Copy virtual environment from builder
COPY --from=builder ${VIRTUAL_ENV} ${VIRTUAL_ENV}

# Create profile directory
RUN mkdir -p /app/profiles

# Expose server port
EXPOSE 8880

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8880/health')" || exit 1

# Run server
CMD ["omnivoice-server", "--host", "0.0.0.0", "--port", "8880", "--profile-dir", "/app/profiles"]
