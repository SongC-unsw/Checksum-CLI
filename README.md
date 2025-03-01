# 🔐 Checksum

[![Crates.io](https://img.shields.io/crates/v/checksum)](https://crates.io/crates/checksum)
[![Build Status](https://img.shields.io/github/actions/workflow/status/username/checksum/rust.yml?branch=main)](https://github.com/username/checksum/actions)
[![Downloads](https://img.shields.io/crates/d/checksum)](https://crates.io/crates/checksum)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Rust Version](https://img.shields.io/badge/rust-1.70%2B-blue.svg)](https://www.rust-lang.org/)

一个简单的命令行工具，用于计算文件的哈希值（checksums）。

## ✨ 支持的哈希算法

- 📊 MD5
- 🔑 SHA1
- 🔒 SHA256 (默认)
- 🛡️ SHA512

## 🚀 安装

### 📦 方法 1：使用 Cargo 安装

确保您已安装 Rust 和 Cargo，然后运行：

```bash
# 从本地目录安装
cargo install --path .

# 或者直接从 GitHub 安装（如果已发布）
# cargo install checksum
```

安装后，`checksum` 命令将自动添加到您的 PATH 中，可以在任何目录下使用。

### ⚙️ 方法 2：手动安装

1. 构建发布版本：

```bash
cargo build --release
```

2. 将编译好的二进制文件复制到 PATH 中的一个目录：

```bash
# Linux/macOS
cp target/release/checksum ~/.local/bin/
# 或
sudo cp target/release/checksum /usr/local/bin/

# Windows
# 复制 target\release\checksum.exe 到 PATH 中的一个目录
```

## 📝 用法

基本用法：

```bash
checksum [选项] <文件路径>
```

选项：

- `-a, --algorithm <ALGORITHM>`: 指定哈希算法 [默认: sha256] [可选值: md5, sha1, sha256, sha512]
- `-c, --compare <HASH>`: 与已知哈希值比较
- `-h, --help`: 显示帮助信息
- `-V, --version`: 显示版本信息

## 🔍 示例

计算文件的 SHA256 哈希值：

```bash
checksum document.pdf
```

使用 MD5 算法：

```bash
checksum -a md5 document.pdf
```

计算哈希值并与已知值比较：

```bash
checksum document.pdf -c 8b1a9953c4611296a827abf8c47804d7
```

## 📄 许可证

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)