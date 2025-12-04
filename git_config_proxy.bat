@echo off
chcp 65001 >nul
echo ========================================
echo Git 代理配置工具
echo ========================================
echo.
echo 错误 "Failed to connect to github.com port 443" 
echo 通常是因为网络无法直接访问GitHub
echo.
echo 请选择解决方案：
echo.
echo [1] 配置HTTP/HTTPS代理（如果你有代理软件如Clash/V2Ray等）
echo [2] 测试网络连接
echo [3] 取消代理配置
echo [4] 查看当前代理配置
echo [0] 退出
echo.
set /p choice=请输入选项 (0-4): 

if "%choice%"=="1" goto SET_PROXY
if "%choice%"=="2" goto TEST_CONNECTION
if "%choice%"=="3" goto UNSET_PROXY
if "%choice%"=="4" goto SHOW_PROXY
if "%choice%"=="0" goto END
goto MENU

:SET_PROXY
echo.
echo ========================================
echo 配置代理
echo ========================================
echo.
echo 常见代理端口：
echo - Clash: 7890
echo - V2Ray: 10809
echo - 其他: 请查看你的代理软件设置
echo.
echo 请输入代理地址（例如: 127.0.0.1:7890）
echo 如果不确定，请先打开你的代理软件查看端口
set /p proxy=代理地址: 

if "%proxy%"=="" (
    echo [错误] 代理地址不能为空
    pause
    goto MENU
)

echo.
echo [配置] 正在设置Git代理...
git config --global http.proxy http://%proxy%
git config --global https.proxy http://%proxy%

echo [完成] 代理已配置为: %proxy%
echo.
echo 现在可以尝试推送了！
echo 运行 git_push_only.bat 或手动执行：
echo   git push -u origin main
echo.
pause
goto MENU

:TEST_CONNECTION
echo.
echo ========================================
echo 测试网络连接
echo ========================================
echo.
echo [测试1] Ping GitHub...
ping -n 3 github.com
echo.
echo [测试2] 测试HTTPS连接...
curl -I https://github.com
echo.
echo 如果上面都失败，说明需要配置代理
echo.
pause
goto MENU

:UNSET_PROXY
echo.
echo ========================================
echo 取消代理配置
echo ========================================
echo.
git config --global --unset http.proxy
git config --global --unset https.proxy
echo [完成] 代理配置已清除
echo.
pause
goto MENU

:SHOW_PROXY
echo.
echo ========================================
echo 当前代理配置
echo ========================================
echo.
git config --global --get http.proxy >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    for /f "delims=" %%i in ('git config --global --get http.proxy') do set current_proxy=%%i
    echo HTTP代理: %current_proxy%
) else (
    echo HTTP代理: 未配置
)

git config --global --get https.proxy >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    for /f "delims=" %%i in ('git config --global --get https.proxy') do set current_proxy=%%i
    echo HTTPS代理: %current_proxy%
) else (
    echo HTTPS代理: 未配置
)
echo.
pause
goto MENU

:MENU
echo.
echo ========================================
echo.
echo [1] 配置HTTP/HTTPS代理
echo [2] 测试网络连接
echo [3] 取消代理配置
echo [4] 查看当前代理配置
echo [0] 退出
echo.
set /p choice=请输入选项 (0-4): 

if "%choice%"=="1" goto SET_PROXY
if "%choice%"=="2" goto TEST_CONNECTION
if "%choice%"=="3" goto UNSET_PROXY
if "%choice%"=="4" goto SHOW_PROXY
if "%choice%"=="0" goto END
goto MENU

:END
echo.
echo 再见！
pause
