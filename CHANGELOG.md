# 更新日志 / Changelog

本项目基于 [harmony-cursor-rules](https://github.com/skindhu/harmony-cursor-rules) 开发

---

## [1.0.0] - 2024-12-04

### ✨ 首次发布

首个正式版本发布，提供完整的图形界面和可执行程序。

#### 新增功能

**图形用户界面**
- 基于 Tkinter 的现代化 GUI 界面
- 实时日志输出窗口
- 进度状态显示
- 响应式布局设计

**可视化配置**
- API 密钥配置界面
- API 连接测试功能
- 输出目录选择
- 模块选择复选框
- 配置自动保存和加载

**核心功能**
- 支持 7 个 HarmonyOS 文档模块爬取
- Gemini AI 内容优化处理
- 多线程异步爬取
- 错误处理和重试机制

**便捷操作**
- 一键启动批处理文件
- 清空输出目录功能
- 快速打开输出目录
- 停止爬取功能

#### 技术改进

**Windows 平台优化**
- 使用 `.env` 文件替代 export 命令
- 完美支持 Windows 路径
- 批处理脚本简化启动

**打包发布**
- PyInstaller 打包为独立 EXE
- 包含所有运行时依赖
- 无需安装 Python 环境
- 文件夹模式约 200MB

**代码质量**
- 异常处理机制
- 日志记录系统
- 配置持久化
- 模块化设计

#### 支持的文档模块

1. 动画与转场 (Animation & Transition)
2. 组件封装与复用 (Component Encapsulation & Reuse)
3. 声明式语法 (Declarative Syntax)
4. 手势与导航 (Gesture & Navigation)
5. 布局与弹窗 (Layout & Dialog)
6. 主题与样式 (Theme & Style)
7. ArkTS 规范 (ArkTS Lint Rules)

---

## 📋 版本说明

### 关于版本号

本项目采用[语义化版本](https://semver.org/lang/zh-CN/)规范：

- **主版本号**：不兼容的 API 修改
- **次版本号**：向下兼容的功能性新增
- **修订号**：向下兼容的问题修正

### 发布类型

- **正式版本** (Release)：稳定可用的生产版本
- **候选版本** (RC)：即将发布的预览版本
- **测试版本** (Beta)：功能完整但可能存在问题
- **开发版本** (Alpha)：早期开发测试版本

---

## 🔗 相关链接

- **原项目**: [harmony-cursor-rules](https://github.com/skindhu/harmony-cursor-rules) by [@skindhu](https://github.com/skindhu)
- **当前项目**: [harmony-cursor-rules-gui-enhancement](https://github.com/Foraes/harmony-cursor-rules-gui-enhancement)
- **问题反馈**: [Issues](https://github.com/Foraes/harmony-cursor-rules-gui-enhancement/issues)

---

## 📌 致谢

感谢 [@skindhu](https://github.com/skindhu) 的原始项目，为本 GUI 版本提供了核心功能基础。
