@echo off
chcp 65001 >nul
echo ========================================
echo Git 提交和推送脚本
echo ========================================
echo.

REM 检查Git是否已安装
where git >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [错误] 未检测到Git，请先安装Git
    echo 下载地址: https://git-scm.com/download/win
    pause
    exit /b 1
)

echo [步骤1] 检查Git仓库状态...
git status >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [提示] 当前目录不是Git仓库，正在初始化...
    git init
    echo [完成] Git仓库已初始化
) else (
    echo [完成] Git仓库已存在
)
echo.

echo [步骤2] 配置Git用户信息...
git config user.name >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [提示] 请输入你的GitHub用户名:
    set /p username=
    git config --global user.name "%username%"
    
    echo [提示] 请输入你的GitHub邮箱:
    set /p email=
    git config --global user.email "%email%"
    echo [完成] Git用户信息已配置
) else (
    for /f "delims=" %%i in ('git config user.name') do set current_user=%%i
    for /f "delims=" %%i in ('git config user.email') do set current_email=%%i
    echo [完成] 当前用户: %current_user% (%current_email%)
)
echo.

echo [步骤3] 配置远程仓库地址...
git remote get-url origin >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [提示] 正在添加远程仓库...
    git remote add origin https://github.com/Foraes/harmony-cursor-rules-gui-enhancement.git
    echo [完成] 远程仓库已添加
) else (
    for /f "delims=" %%i in ('git remote get-url origin') do set current_origin=%%i
    echo [完成] 远程仓库已存在: %current_origin%
)

git remote get-url upstream >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [提示] 正在添加上游仓库...
    git remote add upstream https://github.com/skindhu/harmony-cursor-rules.git
    echo [完成] 上游仓库已添加
) else (
    echo [完成] 上游仓库已存在
)
echo.

echo [步骤4] 显示远程仓库配置...
git remote -v
echo.

echo [步骤5] 添加所有文件到暂存区...
git add .
echo [完成] 文件已添加
echo.

echo [步骤6] 显示将要提交的文件...
git status
echo.

echo [步骤7] 提交更改...
git commit -m "Initial commit: GUI Enhanced Version" -m "New features: GUI interface, visual configuration, real-time logs, one-click packaging" -m "Improvements: Windows optimization, packaging optimization, complete documentation" -m "Credits: Based on harmony-cursor-rules by @skindhu"

if %ERRORLEVEL% NEQ 0 (
    echo [错误] 提交失败
    pause
    exit /b 1
)
echo [完成] 更改已提交
echo.

echo [步骤8] 设置主分支为main...
git branch -M main
echo [完成] 分支已设置
echo.

echo [步骤9] 推送到GitHub...
echo [提示] 如果弹出登录窗口，请使用你的GitHub账号登录
echo.
git push -u origin main

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [错误] 推送失败，可能的原因：
    echo 1. 需要登录GitHub账号
    echo 2. 远程仓库已有内容需要先pull
    echo.
    echo 尝试解决方案：
    echo 方案1：先pull再push
    echo   git pull origin main --allow-unrelated-histories
    echo   git push -u origin main
    echo.
    echo 方案2：强制推送（谨慎使用）
    echo   git push -u origin main --force
    echo.
    pause
    exit /b 1
)

echo.
echo ========================================
echo [成功] 所有操作已完成！
echo ========================================
echo.
echo 后续步骤：
echo 1. 访问你的仓库: https://github.com/Foraes/harmony-cursor-rules-gui-enhancement
echo 2. 添加项目描述和标签
echo 3. 检查README显示是否正确
echo 4. （可选）创建Release发布v1.0.0版本
echo.
pause
