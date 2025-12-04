@echo off
chcp 65001 > nul
echo ========================================
echo    HarmonyOS规则爬虫工具 - 打包脚本
echo ========================================
echo.

echo 请选择打包方式：
echo [1] 文件夹模式（多个文件，启动快）
echo [2] 单文件模式（一个EXE，便于分发）
echo.
set /p choice="请输入选择 (1 或 2): "

echo.
echo [1/5] 检查PyInstaller是否已安装...
pip show pyinstaller >nul 2>&1
if errorlevel 1 (
    echo PyInstaller未安装，正在安装...
    pip install pyinstaller
) else (
    echo ✓ PyInstaller已安装
)
echo.

echo [2/5] 检查所有依赖...
pip install -r Requirements.txt
echo.

echo [3/5] 安装Playwright浏览器...
python -m playwright install chromium
echo.

echo [4/5] 清理旧的打包文件...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist
echo.

echo [5/5] 开始打包...
if "%choice%"=="2" (
    echo 使用单文件模式打包...
    pyinstaller build_single_exe.spec --clean --noconfirm
    set "exe_path=dist\HarmonyOS规则爬虫工具.exe"
) else (
    echo 使用文件夹模式打包...
    pyinstaller build_exe.spec --clean --noconfirm
    set "exe_path=dist\HarmonyOS规则爬虫工具\HarmonyOS规则爬虫工具.exe"
)
echo.

if exist "%exe_path%" (
    echo ========================================
    echo ✅ 打包成功！
    echo ========================================
    echo.
    if "%choice%"=="2" (
        echo 📦 单文件模式
        echo 可执行文件: dist\HarmonyOS规则爬虫工具.exe
        echo.
        echo ⚠️ 注意：首次运行会较慢（需要解压临时文件）
        echo 💡 优点：只有一个EXE文件，便于分发
    ) else (
        echo 📦 文件夹模式
        echo 可执行文件: dist\HarmonyOS规则爬虫工具\HarmonyOS规则爬虫工具.exe
        echo.
        echo 💡 需要分发整个文件夹
        echo 💡 优点：启动速度快
    )
    echo.
    echo 按任意键打开输出目录...
    pause >nul
    explorer "dist"
) else (
    echo ========================================
    echo ❌ 打包失败！
    echo ========================================
    echo.
    echo 可能的原因：
    echo 1. 缺少必要的依赖包
    echo 2. Python版本不兼容
    echo 3. 磁盘空间不足
    echo.
    echo 请查看上面的错误信息，或尝试以下步骤：
    echo 1. 确保已安装所有依赖：pip install -r Requirements.txt
    echo 2. 更新PyInstaller：pip install --upgrade pyinstaller
    echo 3. 以管理员身份运行此脚本
    echo.
    pause
)
