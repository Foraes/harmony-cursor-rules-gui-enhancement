@echo off
chcp 65001 > nul
echo ========================================
echo    HarmonyOS规则爬虫工具 - 打包脚本
echo ========================================
echo.

echo [1/4] 检查PyInstaller是否已安装...
pip show pyinstaller >nul 2>&1
if errorlevel 1 (
    echo PyInstaller未安装，正在安装...
    pip install pyinstaller
) else (
    echo ✓ PyInstaller已安装
)
echo.

echo [2/4] 安装Playwright浏览器...
python -m playwright install chromium
echo.

echo [3/4] 开始打包...
pyinstaller build_exe.spec --clean
echo.

if exist "dist\HarmonyOS规则爬虫工具\HarmonyOS规则爬虫工具.exe" (
    echo [4/4] 打包成功！
    echo.
    echo ========================================
    echo 打包完成！
    echo 可执行文件位置: dist\HarmonyOS规则爬虫工具\
    echo ========================================
    echo.
    echo 按任意键打开输出目录...
    pause >nul
    explorer "dist\HarmonyOS规则爬虫工具"
) else (
    echo [4/4] 打包失败，请检查错误信息
    echo.
    pause
)
