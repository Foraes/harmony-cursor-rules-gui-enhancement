# 更新日志

本项目基于 [harmony-cursor-rules](https://github.com/skindhu/harmony-cursor-rules) 开发

## [1.0.0] - 2025-12-04

### ✨ 新增功能

#### 🖥️ 图形用户界面（GUI）
- 可视化配置界面（API密钥、输出目录、模块选择）
- 实时日志输出窗口
- 进度显示和状态提示
- 配置持久化保存
- 一键清理输出目录

#### 📦 打包和部署
- 一键打包脚本（文件夹模式/单文件模式）
- 快速启动脚本（启动GUI.bat）
- 完善的PyInstaller配置文件
- 自动安装依赖和Playwright浏览器

#### 🔧 工具和文档
- 依赖测试工具（test_imports.py）
- 完整的中文文档
  - GUI使用说明.md
  - 快速开始指南.md
  - 打包问题排查.md
- 项目文件清单

### 🛠️ 改进
- Windows环境优化（使用.env文件替代export命令）
- 打包优化（完善hiddenimports，包含所有必要模块）
- 用户体验优化（配置持久化、一键清理、实时日志）
- 异步爬虫与GUI的完美集成

### 🐛 修复
- 修复Windows下export命令无法使用的问题
- 修复PyInstaller打包时的ModuleNotFoundError
- 修复crawl4ai、google.genai等模块的隐藏导入问题
- 修复异步爬虫在GUI中的兼容性问题

### 📚 文档
- 新增README.md（包含原作者致谢）
- 新增GUI使用说明
- 新增快速开始指南
- 新增打包问题排查文档

---

**原作者**: [@skindhu](https://github.com/skindhu)  
**原项目**: [harmony-cursor-rules](https://github.com/skindhu/harmony-cursor-rules)  
**许可证**: 遵循原项目许可证
