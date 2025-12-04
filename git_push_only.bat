@echo off
chcp 65001 >nul
echo ========================================
echo Git 推送脚本（仅推送）
echo ========================================
echo.

echo [检查] 查看当前分支和提交状态...
git log --oneline -1
echo.

echo [提示] 准备推送到GitHub...
echo 远程仓库: https://github.com/Foraes/harmony-cursor-rules-gui-enhancement.git
echo.

echo [执行] 设置主分支为main...
git branch -M main
echo.

echo [执行] 推送到GitHub...
echo 如果需要登录，请使用你的GitHub账号
echo.

git push -u origin main

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ========================================
    echo [失败] 推送失败！
    echo ========================================
    echo.
    echo 可能的原因和解决方案：
    echo.
    echo 1. 远程仓库已有内容，需要先合并
    echo    解决方法：
    echo    git pull origin main --allow-unrelated-histories
    echo    git push -u origin main
    echo.
    echo 2. 需要GitHub认证
    echo    解决方法：
    echo    - 使用 gh auth login 登录GitHub CLI
    echo    - 或使用Personal Access Token
    echo.
    echo 3. 强制推送（会覆盖远程内容，谨慎使用）
    echo    git push -u origin main --force
    echo.
    pause
    exit /b 1
)

echo.
echo ========================================
echo [成功] 推送完成！
echo ========================================
echo.
echo 访问你的仓库：
echo https://github.com/Foraes/harmony-cursor-rules-gui-enhancement
echo.
pause
