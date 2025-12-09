# QR Code Generator

A containerized QR code generator that validates URLs and creates QR codes with customizable colors.

## Docker Hub

**Image:** [ryahjanee/qr_codemaker](https://hub.docker.com/r/ryahjanee/qr_codemaker)

Pull the image:
```bash
docker pull ryahjanee/qr_codemaker
```

Run the container:
```bash
docker run ryahjanee/qr_codemaker --url "https://example.com"
```

## Quick Start

### Local Setup

1. Clone the repository:
```bash
git clone https://github.com/Ryahjanee92/qr_code.git
cd qr_code
```

2. Create a virtual environment:
```bash
python3 -m venv .venv
source .venv/bin/activate
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```

4. Run the application:
```bash
python main.py --url "https://example.com"
```

### Docker Setup

Build the image:
```bash
docker build -t qr_codemaker .
```

Run with docker-compose:
```bash
docker-compose up --build
```

Or run directly with volume mount:
```bash
docker run -v ./qr_codes:/app/qr_codes ryahjanee/qr_codemaker --url "https://example.com"
```

## Configuration

### Environment Variables
- `QR_CODE_DIR`: Directory to save QR codes (default: `qr_codes/`)
- `FILL_COLOR`: QR code color (default: `red`)
- `BACK_COLOR`: Background color (default: `white`)

### CLI Arguments
- `--url`: URL to encode in QR code (default: `http://github.com/kaw393939`)

## Features

- ✅ URL validation using the `validators` library
- ✅ Customizable QR code colors
- ✅ Timestamped file naming
- ✅ Runs as non-root user in Docker
- ✅ Easy configuration via environment variables or CLI args
- ✅ Graceful error handling with logging

## Output

QR codes are saved to the `qr_codes/` directory with filenames like:
```
QRCode_YYYYMMDDHHMMSS.png
```

## Project Files

- `main.py` - Application logic
- `Dockerfile` - Container build configuration
- `docker-compose.yml` - Docker Compose setup
- `requirements.txt` - Python dependencies
- `.github/copilot-instructions.md` - AI agent instructions
