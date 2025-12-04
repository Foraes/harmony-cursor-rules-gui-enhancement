# 🎨 HarmonyOS规则爬虫工具 - GUI版本

一个带有友好图形界面的华为开发文档爬虫工具，可以自动爬取HarmonyOS开发最佳实践并生成AI开发规范文件。

## ✨ 特性

- 🖥️ **图形化界面** - 无需命令行，点击即可使用
- 🔐 **配置管理** - API密钥和设置自动保存
- 📊 **实时日志** - 彩色日志实时显示运行状态
- 📁 **一键打包** - 轻松打包成独立EXE程序
- 🎯 **智能爬取** - 自动跳过已存在文件，支持断点续传
- 🤖 **AI优化** - 使用Gemini AI优化输出内容

## 🚀 快速开始

### 方式一：直接运行（开发/测试）

1. **安装依赖**
   ```bash
   pip install -r Requirements.txt
   python -m playwright install chromium
   ```

2. **运行GUI程序**
   ```bash
   python gui_app.py
   ```

3. **配置并开始**
   - 输入Gemini API密钥
   - 点击"保存配置"
   - 点击"开始爬取"

### 方式二：打包成EXE（推荐分发）

1. **安装依赖**
   ```bash
   pip install -r Requirements.txt
   ```

2. **运行打包脚本**
   ```bash
   build.bat
   ```
   或手动打包：
   ```bash
   pip install pyinstaller
   python -m playwright install chromium
   pyinstaller build_exe.spec --clean
   ```

3. **获取EXE程序**
   - 位置：`dist\HarmonyOS规则爬虫工具\HarmonyOS规则爬虫工具.exe`
   - 双击运行，无需Python环境

## 📖 详细使用说明

请查看 [GUI使用说明.md](GUI使用说明.md) 获取完整的使用指南。

## 🔑 获取Gemini API密钥

1. 访问 [Google AI Studio](https://makersuite.google.com/app/apikey)
2. 登录Google账号
3. 创建新的API密钥
4. 复制密钥到程序中

## 📂 输出文件

程序会生成以下文件结构：

```
harmony_cursor_rules/
├── final_cursor_rules/          # 最终规则文件（重要！）
│   ├── animation_transition.cursorrules.md
│   ├── component_encapsulation_reuse.cursorrules.md
│   ├── declarative_syntax.cursorrules.md
│   ├── gesture_navigation.cursorrules.md
│   ├── layout_dialog.cursorrules.md
│   ├── theme_style.cursorrules.md
│   └── arkts-lint-rules.md
├── animation_transition/         # 原始文档
├── component_encapsulation_reuse/
├── declarative_syntax/
├── gesture_navigation/
├── layout_dialog/
└── theme_style/
```

**重要：** `final_cursor_rules/` 文件夹中的 `.cursorrules.md` 文件可直接用于Cursor等AI编程工具。

## 🖼️ 界面预览

GUI程序包含以下功能区：

1. **配置设置区域**
   - Gemini API密钥（支持显示/隐藏）
   - API地址配置
   - 输出目录选择
   - 调试模式开关

2. **操作区域**
   - 开始/停止爬取
   - 打开输出目录
   - 清空日志

3. **运行日志**
   - 彩色日志显示
   - 实时更新状态

4. **状态栏**
   - 当前状态
   - 进度指示

## ⚙️ 配置文件

程序使用 `.env` 文件保存配置：

```env
GEMINI_API_KEY=your-api-key-here
GEMINI_BASE_URL=https://generativelanguage.googleapis.com
```

## 🔧 技术栈

- **GUI:** Tkinter
- **异步:** asyncio
- **爬虫:** crawl4ai + Playwright
- **AI:** Google Gemini API
- **打包:** PyInstaller

## 📋 系统要求

- Windows 10/11
- Python 3.8+ (开发模式)
- 网络连接
- 约200-300MB磁盘空间（打包后）

## ⚠️ 常见问题

### 1. 程序无法启动？
- 检查是否安装了所有依赖
- 尝试重新运行 `build.bat`

### 2. 爬取失败？
- 检查网络连接
- 验证API密钥是否有效
- 查看日志中的错误信息

### 3. 打包后体积大？
- 这是正常的，包含了Python运行时和浏览器引擎
- 可以使用压缩工具减小分发体积

### 4. API配置不生效？
- 点击"保存配置"按钮
- 重启程序
- 检查.env文件是否正确生成

## 📝 更新日志

### v1.0 (2024)
- ✨ 初始版本
- 🎨 图形化界面
- 📦 支持打包EXE
- 🤖 集成Gemini AI

## 🤝 贡献

欢迎提交Issue和Pull Request！

## 📄 许可证

本项目遵循原项目的开源许可证。

## 🎉 开始使用

```bash
# 快速测试
python gui_app.py

# 或打包分发
build.bat
```

---

**提示：** 首次使用请阅读 [GUI使用说明.md](GUI使用说明.md) 获取详细指导。
