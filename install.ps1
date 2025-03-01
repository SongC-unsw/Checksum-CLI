# Windows PowerShell 安装脚本

# 构建发布版本
Write-Host "Building release version..." -ForegroundColor Green
cargo build --release

# 检查是否成功构建
if (-not (Test-Path "target\release\checksum.exe")) {
    Write-Host "Build failed!" -ForegroundColor Red
    exit 1
}

# 确定安装目录
$InstallDir = "$env:USERPROFILE\.local\bin"

# 创建目录（如果不存在）
if (-not (Test-Path $InstallDir)) {
    Write-Host "Creating directory $InstallDir..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
}

# 复制二进制文件
Write-Host "Installing checksum to $InstallDir..." -ForegroundColor Green
Copy-Item "target\release\checksum.exe" -Destination $InstallDir -Force

# 添加到 PATH（如果尚未添加）
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($currentPath -notlike "*$InstallDir*") {
    Write-Host "Adding $InstallDir to your PATH..." -ForegroundColor Yellow
    [Environment]::SetEnvironmentVariable("Path", "$currentPath;$InstallDir", "User")
    $env:Path = "$env:Path;$InstallDir"
}

Write-Host "Installation complete!" -ForegroundColor Green
Write-Host "You may need to restart your terminal to use checksum from anywhere." -ForegroundColor Yellow
Write-Host "Run 'checksum --help' to get started." -ForegroundColor Cyan
