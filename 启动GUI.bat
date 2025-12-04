@echo off
chcp 65001 > nul
title HarmonyOS规则爬虫工具
echo.
echo ========================================
echo    HarmonyOS规则爬虫工具 - GUI版本
echo ========================================
echo.
echo 正在启动程序...
echo.

python gui_app.py

if errorlevel 1 (
    echo.
    echo ❌ 启动失败！
    echo.
    echo 可能的原因：
    echo 1. Python未安装或未添加到PATH
    echo 2. 依赖未安装，请运行: pip install -r Requirements.txt
    echo.
    pause
)
