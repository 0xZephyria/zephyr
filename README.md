# ⚡ ZephyrLang Compiler (`zeph`)

Welcome to the standalone repository for **ZephyrLang**, the next-generation smart contract language designed specifically for the **Zephyria Virtual Machine**. 

With ZephyrLang, you can write highly secure, 100% Solidity-compatible logic but with native features that Solidity lacks (like native Roles, Checked-by-default Arithmetic, and granular Resource Controls). The compiler translates ZephyrLang (`.zeph`) files into highly optimized **RISC-V (`.elf`)** bytecode.

## 🚀 Quick Install (Mac / Linux)

Run the following command to download the latest binary for your system (Mac/Linux/Windows WSL):

```bash
curl -L https://raw.githubusercontent.com/0xZephyria/zephyr/main/install.sh | bash
```

## 🛠 Usage

You can use the `zeph` CLI to initialize projects, compile contracts, or transpile existing Solidity files:

```bash
# 1. Initialize a new project 
zeph init my-project
cd my-project

# 2. Compile tests
zeph test test/my-project.test.zeph

# 3. Compile to RISC-V bytecode and print the ABI
zeph compile src/my-project.zeph --abi --emit-asm

# 4. (Optional) Transpile your legacy Solidity code to ZephyrLang
zeph transpile contracts/LegacyToken.sol -o contracts/Token.zeph
```

## 🖥 Building from Source

If you prefer to compile `zeph` yourself, you need [Zig](https://ziglang.org/download/) (v0.13.0 or later).

```bash
# Clone the repo
git clone https://github.com/0xZephyria/zephyr.git
cd zephyr

# Build the binary using Zig 
zig build

# Run the binary locally
./zig-out/bin/zeph compile --help
```

## 📜 License
MIT License.
