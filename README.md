# HarmonyOS Cursor Rules - GUI 增强版 ✨

> 🙏 本项目基于 [@skindhu](https://github.com/skindhu) 的 [harmony-cursor-rules](https://github.com/skindhu/harmony-cursor-rules) 开发

[![基于原项目](https://img.shields.io/badge/基于-harmony--cursor--rules-blue)](https://github.com/skindhu/harmony-cursor-rules)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![HarmonyOS](https://img.shields.io/badge/HarmonyOS-开发规范-orange.svg)](https://developer.harmonyos.com/)
[![Windows](https://img.shields.io/badge/platform-Windows-blue.svg)](https://www.microsoft.com/windows)

一个用于爬取华为 HarmonyOS 开发文档并生成 AI 开发规则的工具，提供易用的**图形界面版本**，无需安装 Python 环境！

---

## 🎯 项目简介

HarmonyOS Cursor Rules GUI 版是一个可视化工具，可以自动爬取 HarmonyOS 官方开发文档，并通过 Gemini AI 优化处理，生成适合 Cursor、Copilot 等 AI 编程工具使用的规则文件（.cursorrules）。

### ✨ 核心功能

- 🖥️ **图形化界面** - 简洁直观的 GUI 操作界面
- ⚙️ **可视化配置** - 轻松设置 API 密钥和输出路径
- 📊 **实时日志** - 爬取过程实时显示，进度一目了然
- 💾 **配置持久化** - 设置自动保存，无需重复配置
- 🎯 **模块选择** - 灵活选择需要爬取的文档模块
- 🧹 **一键清理** - 快速清空输出目录
- 🚀 **开箱即用** - EXE 版本无需安装 Python

---

## 📥 快速开始

### 系统要求

- Windows 7/8/10/11
- 约 200MB 磁盘空间
- 稳定的网络连接（访问 HarmonyOS 文档和 Gemini API）

### 安装步骤

1. **下载程序**
   - 从 [Releases](https://github.com/Foraes/harmony-cursor-rules-gui-enhancement/releases) 下载最新版本
   - 解压到任意目录

2. **配置 API 密钥**
   - 复制 `.env.example` 并重命名为 `.env`
   - 编辑 `.env` 文件，填入你的 Gemini API 密钥：
     ```env
     GEMINI_API_KEY=your-api-key-here
     GEMINI_BASE_URL=https://generativelanguage.googleapis.com
     ```

3. **启动程序**
   - 双击 `启动GUI.bat` 或直接运行 `gui_app/gui_app.exe`

4. **开始使用**
   - 在界面中选择要爬取的文档模块
   - 点击"开始爬取"按钮
   - 等待完成，规则文件将保存在指定的输出目录

---

## 🔑 获取 Gemini API 密钥

1. 访问 [Google AI Studio](https://makersuite.google.com/app/apikey)
2. 使用 Google 账号登录
3. 点击 "Create API Key" 创建新密钥
4. 复制密钥并配置到 `.env` 文件

**注意**：Gemini API 目前在部分地区可能需要使用代理访问。

---

## 📖 使用说明

### 界面功能介绍

#### 1. API 配置区
- **API Key 输入框**：输入 Gemini API 密钥
- **测试连接按钮**：验证 API 是否有效
- 配置会自动保存，下次启动自动加载

#### 2. 爬取配置区
- **输出目录**：选择规则文件的保存位置
- **模块选择**：勾选需要爬取的 HarmonyOS 文档模块
  - 动画与转场
  - 组件封装与复用
  - 声明式语法
  - 手势与导航
  - 布局与弹窗
  - 主题与样式
  - ArkTS 规范

#### 3. 操作按钮
- **开始爬取**：启动爬取流程
- **停止爬取**：中断正在进行的任务
- **清空输出目录**：删除输出目录中的所有文件
- **打开输出目录**：快速打开结果文件夹

#### 4. 日志窗口
- 实时显示爬取进度
- 显示错误和警告信息
- 任务完成通知

### 使用流程

```
1. 配置 API 密钥 → 2. 选择输出目录 → 3. 勾选模块 → 4. 开始爬取 → 5. 查看结果
```

---

## 📚 支持的文档模块

本工具支持爬取以下 HarmonyOS 开发文档模块：

| 模块 | 说明 | 输出文件 |
|-----|------|---------|
| 动画与转场 | 动画效果、页面转场 | animation_transition.cursorrules.md |
| 组件封装与复用 | 自定义组件、组件复用 | component_encapsulation_reuse.cursorrules.md |
| 声明式语法 | 状态管理、数据绑定 | declarative_syntax.cursorrules.md |
| 手势与导航 | 手势识别、页面导航 | gesture_navigation.cursorrules.md |
| 布局与弹窗 | 布局管理、弹窗组件 | layout_dialog.cursorrules.md |
| 主题与样式 | 主题适配、样式定制 | theme_style.cursorrules.md |
| ArkTS 规范 | 代码规范、最佳实践 | arkts-lint-rules.md |

---

## 🆚 与原项目对比

| 特性 | 原项目 | GUI 增强版 |
|------|--------|----------|
| 运行方式 | 命令行 | 图形界面 |
| 配置方式 | 修改代码/环境变量 | 可视化界面配置 |
| 使用门槛 | 需要 Python 环境 | 无需安装 Python |
| 进度显示 | 终端文本输出 | 图形化日志窗口 |
| 模块选择 | 修改配置文件 | 界面勾选 |
| Windows 兼容 | 需要特殊配置 | 完美支持 |
| 分发方式 | 需要安装依赖 | 独立 EXE 程序 |

---

## 🛠️ 技术栈

- **界面**：Python Tkinter
- **爬虫**：Crawl4AI + Playwright
- **AI 处理**：Google Gemini API
- **打包**：PyInstaller

---

## 📝 更新日志

查看 [CHANGELOG.md](CHANGELOG.md) 了解版本更新历史。

---

## 🙏 致谢

### 原项目作者

感谢 [@skindhu](https://github.com/skindhu) 创建的优秀项目：
- **原项目地址**：https://github.com/skindhu/harmony-cursor-rules
- **核心贡献**：爬虫逻辑、AI 处理流程、HarmonyOS 文档整理

### GUI 增强版改进

本 GUI 增强版在原项目基础上添加：
- 完整的图形用户界面
- Windows 平台优化
- 配置持久化功能
- 一键打包发布方案

---

## 📄 许可证

本项目遵循原项目的许可证协议。

---

## 🔗 相关链接

- **原项目**：https://github.com/skindhu/harmony-cursor-rules
- **HarmonyOS 开发文档**：https://developer.harmonyos.com/
- **Google Gemini API**：https://ai.google.dev/
- **问题反馈**：[Issues](https://github.com/Foraes/harmony-cursor-rules-gui-enhancement/issues)

---

## ❓ 常见问题

<details>
<summary><b>Q: API 连接失败怎么办？</b></summary>

- 检查 API 密钥是否正确
- 确认网络可以访问 Google 服务（可能需要代理）
- 验证 API 密钥是否有效且未过期
</details>

<details>
<summary><b>Q: 爬取过程中出错？</b></summary>

- 检查网络连接是否稳定
- 确认 HarmonyOS 官网可以正常访问
- 查看日志窗口的具体错误信息
- 尝试重新启动程序
</details>

<details>
<summary><b>Q: 生成的规则文件如何使用？</b></summary>

将生成的 `.cursorrules.md` 文件：
- **Cursor**：复制到项目根目录，重命名为 `.cursorrules`
- **GitHub Copilot**：作为项目文档参考
- **其他 AI 工具**：根据工具要求配置
</details>

<details>
<summary><b>Q: 支持其他操作系统吗？</b></summary>

当前版本仅提供 Windows EXE 版本。如需在其他系统运行，请访问原项目获取源代码。
</details>

---

<p align="center">
  <strong>如果这个项目对你有帮助，请给个 ⭐ Star 支持！</strong>
</p>

<p align="center">
  <sub>Built with ❤️ based on harmony-cursor-rules by @skindhu</sub>
</p>
