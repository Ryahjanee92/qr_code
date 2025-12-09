# Copilot Instructions for QR Code Generator

This is a containerized QR code generator application that validates URLs and creates QR codes with customizable colors.

## Architecture Overview

**Single-service Docker application** with three main concerns:

1. **Configuration Layer** (`main.py`): Uses environment variables and CLI arguments
   - Environment vars: `QR_CODE_DIR`, `FILL_COLOR`, `BACK_COLOR` (defined in `docker-compose.yml`)
   - CLI args: `--url` (default: `http://github.com/kaw393939`)
   - `python-dotenv` loads `.env` files for local development

2. **Validation Layer** (`main.py:is_valid_url()`): Uses `validators` library
   - All URLs must be validated before QR code generation
   - Invalid URLs log an error and skip generation

3. **Generation Layer** (`main.py:generate_qr_code()`): Creates PNG files with timestamps
   - Output: `qr_codes/QRCode_YYYYMMDDHHMMSS.png`
   - File ownership managed in Dockerfile for non-root user `myuser`

## Development Workflows

### Running Locally
```bash
# Install dependencies
pip install -r requirements.txt

# Run with default URL
python main.py

# Run with custom URL
python main.py --url "https://example.com"
```

### Docker Workflow
```bash
# Build and run with docker-compose
docker-compose up --build

# Override command at runtime
docker-compose run qr_code_app --url "https://your-url.com"
```

**Key detail**: Docker Compose uses volume mount at `./qr_codes:/app/qr_codes` — QR codes are saved locally on host machine.

### Directory Structure
- `qr_codes/`: Output directory (created by Dockerfile, owned by `myuser`)
- `logs/`: Log directory (created by Dockerfile, owned by `myuser`)

## Project-Specific Patterns

### Error Handling
- **Logging-first approach**: Errors logged via Python `logging` module to stdout
- **Graceful degradation**: Invalid URLs don't crash the app, just log and skip
- `exit(1)` only for critical failures (directory creation failure)

### Security
- **Non-root user execution**: Container runs as `myuser`, not root
- Dockerfile creates directories with explicit ownership before user switch
- `--no-cache-dir` for pip to minimize image size

### Configuration Priority
1. CLI arguments (highest priority): `--url`
2. Environment variables: `QR_CODE_DIR`, `FILL_COLOR`, `BACK_COLOR`
3. Hardcoded defaults (lowest priority)

## Dependencies & External Integration

- **qrcode**: Generates QR code images
- **pillow**: Image processing (required by qrcode)
- **validators**: URL validation (strict validation via `validators.url()`)
- **python-dotenv**: Loads `.env` for local dev
- **pypng, typing_extensions**: Support dependencies

## Key Files to Reference

- `main.py`: Application logic, argument parsing, validation
- `Dockerfile`: Build process, user creation, volume setup
- `docker-compose.yml`: Runtime config, env vars, volume mounts, default command
- `requirements.txt`: All dependencies pinned to specific versions

## Common Modifications

When adding features, preserve these patterns:

1. **New CLI arguments**: Add to `parser.add_argument()` in `main()`, document in Dockerfile CMD
2. **New config options**: Use environment variables (read via `os.getenv()`) and add to `docker-compose.yml`
3. **New output files**: Create directories in Dockerfile with `mkdir` and `chown` to `myuser:myuser`
4. **Error handling**: Log via `logging` module, don't raise silent exceptions
