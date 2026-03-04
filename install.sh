#!/bin/bash
# install.sh - Installs the latest Zephyr compiler release
set -e

# Detect OS and architecture
OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m)"

SUFFIX=""
if [ "$OS" = "linux" ]; then
    if [ "$ARCH" = "x86_64" ]; then
        SUFFIX="linux-amd64"
    elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
        SUFFIX="linux-arm64"
    fi
elif [ "$OS" = "darwin" ]; then
    if [ "$ARCH" = "x86_64" ]; then
        SUFFIX="macos-amd64"
    elif [ "$ARCH" = "arm64" ]; then
        SUFFIX="macos-arm64"
    fi
fi

if [ -z "$SUFFIX" ]; then
    echo "Unsupported OS/Arch: $OS/$ARCH"
    exit 1
fi

echo "Detected Platform: $OS ($ARCH)"
echo "Fetching the latest Zephyr compiler release..."

# Get latest tag name
if ! command -v curl >/dev/null 2>&1; then
    echo "Error: curl is required to install Zephyr."
    exit 1
fi

LATEST_TAG=$(curl -s https://api.github.com/repos/0xZephyria/zephyr/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

if [ -z "$LATEST_TAG" ]; then
    echo "Could not find the latest release on GitHub."
    echo "Check https://github.com/0xZephyria/zephyr/releases for availability."
    exit 1
fi

BINARY_URL="https://github.com/0xZephyria/zephyr/releases/download/${LATEST_TAG}/zeph-${SUFFIX}"

echo "Downloading $BINARY_URL ..."
TMP_BIN="/tmp/zeph"
curl -L -o "$TMP_BIN" "$BINARY_URL"
chmod +x "$TMP_BIN"

echo "Installing to /usr/local/bin/zeph (may require sudo)..."
if [ -w "/usr/local/bin" ]; then
    mv "$TMP_BIN" /usr/local/bin/zeph
else
    sudo mv "$TMP_BIN" /usr/local/bin/zeph
fi

echo "✅ Successfully installed Zephyr Compiler ($LATEST_TAG)!"
echo "Run 'zeph --help' to get started."
