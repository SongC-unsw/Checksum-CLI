#!/bin/bash

# 构建发布版本
echo "Building release version..."
cargo build --release

# 检查是否成功构建
if [ ! -f "target/release/checksum" ]; then
    echo "Build failed!"
    exit 1
fi

# 确定安装目录
INSTALL_DIR=""
if [ -w "/usr/local/bin" ]; then
    INSTALL_DIR="/usr/local/bin"
elif [ -d "$HOME/.local/bin" ]; then
    INSTALL_DIR="$HOME/.local/bin"
    # 确保 .local/bin 在 PATH 中
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        echo "Adding ~/.local/bin to PATH in your profile..."
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc" 2>/dev/null || true
    fi
else
    # 如果以上目录都不可用，则创建 .local/bin
    INSTALL_DIR="$HOME/.local/bin"
    mkdir -p "$INSTALL_DIR"
    echo "Adding ~/.local/bin to PATH in your profile..."
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc" 2>/dev/null || true
fi

# 复制二进制文件
echo "Installing checksum to $INSTALL_DIR..."
cp "target/release/checksum" "$INSTALL_DIR/"

# 设置执行权限
chmod +x "$INSTALL_DIR/checksum"

echo "Installation complete!"
echo "You may need to restart your terminal or run 'source ~/.bashrc' (or ~/.zshrc) to update your PATH."
echo "Run 'checksum --help' to get started."
