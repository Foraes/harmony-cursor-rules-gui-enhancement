@echo off
chcp 65001 >nul
echo ========================================
echo Git Pull 和 Push 脚本
echo ========================================
echo.
echo 此脚本用于处理远程仓库已有内容的情况
echo.

echo [步骤1] 从远程仓库拉取内容...
git pull origin main --allow-unrelated-histories

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [警告] Pull失败，尝试其他方法...
    echo.
    echo 如果提示需要合并信息，按照以下步骤：
    echo 1. 如果打开了编辑器，直接关闭保存即可
    echo 2. 或者按 Esc 然后输入 :wq 回车（Vim编辑器）
    echo.
    pause
)

echo.
echo [步骤2] 推送到GitHub...
git push -u origin main

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [失败] 推送仍然失败
    echo.
    echo 最后的解决方案（强制推送，会覆盖远程内容）：
    echo git push -u origin main --force
    echo.
    echo 是否要执行强制推送？（会覆盖远程仓库的所有内容）
    echo 输入 yes 确认，其他任意键取消
    set /p confirm=
    
    if /i "%confirm%"=="yes" (
        echo.
        echo [执行] 强制推送...
        git push -u origin main --force
        
        if %ERRORLEVEL% EQU 0 (
            echo.
            echo [成功] 强制推送完成！
        ) else (
            echo.
            echo [失败] 强制推送也失败了
            echo 请手动检查GitHub账号权限和网络连接
        )
    ) else (
        echo.
        echo [取消] 已取消强制推送
    )
    
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
