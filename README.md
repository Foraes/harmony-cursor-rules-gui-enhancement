# HarmonyOS规则爬虫工具 - GUI增强版 🎨

[![基于项目](https://img.shields.io/badge/基于-skindhu/harmony--cursor--rules-blue)](https://github.com/skindhu/harmony-cursor-rules)
[![License](https://img.shields.io/github/license/Foraes/harmony-cursor-rules-gui-enhancement)](./LICENSE)
[![Python](https://img.shields.io/badge/Python-3.8+-green.svg)](https://www.python.org/)

> 🙏 **本项目基于 [@skindhu](https://github.com/skindhu) 的 [harmony-cursor-rules](https://github.com/skindhu/harmony-cursor-rules) 开发**  
> 感谢原作者的开源贡献！本版本专注于提升Windows用户体验，新增GUI界面和一键打包功能。

---

## ✨ GUI增强版的新特性

相比原项目，本版本新增：

### 🖥️ 图形化界面
- ✅ 友好的GUI界面，无需命令行操作
- ✅ 可视化配置API密钥和输出路径
- ✅ 实时彩色日志显示
- ✅ 一键开始/停止爬取

### 📦 Windows优化
- ✅ 修复Windows环境下的配置问题（`.env`文件替代`export`命令）
- ✅ 一键打包成EXE程序（`build_improved.bat`）
- ✅ 支持文件夹和单文件两种打包模式
- ✅ 快速启动脚本（`启动GUI.bat`）

### 📖 完善的中文文档
- ✅ GUI使用说明
- ✅ 打包问题排查指南
- ✅ 快速开始指南
- ✅ 项目文件清单

---

## 🚀 快速开始

### 方式一：直接使用GUI（推荐）

```bash
# 1. 安装依赖
pip install -r Requirements.txt
python -m playwright install chromium

# 2. 启动GUI
python gui_app.py
# 或双击：启动GUI.bat

# 3. 在GUI中配置API密钥并开始使用
```

### 方式二：打包成EXE

```bash
# 双击运行打包脚本
build_improved.bat

# 选择打包模式：
# [1] 文件夹模式 - 启动快，适合自用
# [2] 单文件模式 - 一个EXE，便于分发
```

---

## 📸 界面预览

GUI程序包含：
- **配置设置区域** - API密钥、输出目录、调试模式
- **操作区域** - 开始/停止、打开目录、清空日志
- **运行日志** - 彩色实时日志显示
- **状态栏** - 当前状态和进度条

---

## 🔑 获取API密钥

1. 访问 [Google AI Studio](https://makersuite.google.com/app/apikey)
2. 登录Google账号
3. 创建API密钥
4. 在GUI中输入或保存到`.env`文件

---

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

---

## 📖 详细文档

- [快速开始指南](快速开始指南.md) - 立即开始使用
- [GUI使用说明](GUI使用说明.md) - 详细的GUI操作指南
- [打包问题排查](打包问题排查.md) - 解决打包相关问题
- [项目文件清单](GUI项目文件清单.txt) - 所有文件说明

---

## 🆚 与原项目的对比

| 特性 | 原项目 | GUI增强版 |
|------|--------|-----------|
| 命令行界面 | ✅ | ✅ |
| GUI界面 | ❌ | ✅ |
| Windows配置 | 需要手动配置 | 可视化配置 |
| 打包EXE | ❌ | ✅ |
| 实时日志 | ✅ | ✅ 彩色显示 |
| 中文文档 | 部分 | 完整 |

---

## 🛠️ 技术栈

- **GUI框架:** Tkinter（Python标准库）
- **异步处理:** asyncio
- **网页爬取:** crawl4ai + Playwright
- **AI处理:** Google Gemini API
- **打包工具:** PyInstaller

---

## 📋 系统要求

- Windows 10/11
- Python 3.8+ (开发模式)
- 网络连接
- 约200-300MB磁盘空间（打包后）

---

## 🤝 贡献

欢迎提交Issue和Pull Request！

如果你有好的想法或发现了bug：
1. Fork本项目
2. 创建你的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的改动 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启一个Pull Request

---

## 📜 许可证

本项目基于原项目 [harmony-cursor-rules](https://github.com/skindhu/harmony-cursor-rules) 开发。

- 原项目部分：遵循原项目的许可证
- GUI增强部分：采用 MIT License

详见 [LICENSE](LICENSE) 文件。

---

## 🙏 致谢

- 感谢 [@skindhu](https://github.com/skindhu) 开发的原始项目
- 感谢所有为本项目提供建议和反馈的用户

---

## 📞 支持

如遇问题：
1. 查看 [打包问题排查.md](打包问题排查.md)
2. 查看 [GUI使用说明.md](GUI使用说明.md)
3. 提交 [Issue](https://github.com/Foraes/harmony-cursor-rules-gui-enhancement/issues)

---

## ⭐ Star History

如果这个项目对你有帮助，请给个⭐️支持一下！

---

**开始使用：** 双击 `启动GUI.bat` 或运行 `python gui_app.py` 🚀
