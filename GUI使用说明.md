# HarmonyOS规则爬虫工具 - GUI版本使用说明

## 📦 打包成EXE程序

### 方法一：使用自动打包脚本（推荐）

1. **确保已安装Python依赖**
   ```bash
   pip install -r Requirements.txt
   ```

2. **双击运行 `build.bat`**
   - 脚本会自动检查并安装PyInstaller
   - 自动安装Playwright浏览器
   - 自动打包成EXE程序
   - 完成后自动打开输出目录

3. **打包完成**
   - 程序位置：`dist\HarmonyOS规则爬虫工具\HarmonyOS规则爬虫工具.exe`
   - 整个文件夹可以复制到任何Windows电脑使用

### 方法二：手动打包

```bash
# 1. 安装PyInstaller
pip install pyinstaller

# 2. 安装Playwright浏览器
python -m playwright install chromium

# 3. 打包
pyinstaller build_exe.spec --clean
```

---

## 🚀 使用GUI程序

### 启动程序

**开发模式（测试）：**
```bash
python gui_app.py
```

**打包后：**
- 双击 `HarmonyOS规则爬虫工具.exe` 运行

### 界面说明

#### 1. 配置设置区域

- **Gemini API密钥**
  - 输入你的Google Gemini API密钥
  - 点击 👁 按钮可以显示/隐藏密钥
  - 如何获取API密钥：访问 [Google AI Studio](https://makersuite.google.com/app/apikey)

- **API地址**
  - 默认：`https://generativelanguage.googleapis.com`
  - 如果使用代理或自定义服务，修改此地址

- **输出目录**
  - 设置爬取结果的保存位置
  - 点击"浏览..."按钮选择目录
  - 默认：`harmony_cursor_rules`

- **调试模式**
  - 勾选后会保存原始HTML文件，方便调试
  - 一般情况下不需要勾选

- **💾 保存配置**
  - 点击保存配置到 `.env` 文件
  - 下次启动会自动加载配置

#### 2. 操作区域

- **🚀 开始爬取**
  - 开始执行爬取任务
  - 会爬取所有配置的HarmonyOS模块
  - 自动生成Cursor Rules规则文件

- **⏹ 停止**
  - 中途停止爬取任务

- **📁 打开输出目录**
  - 快速打开结果文件夹

- **🗑 清空日志**
  - 清空运行日志显示

#### 3. 运行日志

- 实时显示程序运行状态
- 颜色标识：
  - 🔵 蓝色：普通信息
  - 🟢 绿色：成功消息
  - 🟠 橙色：警告信息
  - 🔴 红色：错误消息

#### 4. 状态栏

- 显示当前程序状态
- 进度条显示任务进度

---

## 📋 完整使用流程

### 第一次使用

1. **获取API密钥**
   - 访问 [Google AI Studio](https://makersuite.google.com/app/apikey)
   - 创建或登录Google账号
   - 创建API密钥并复制

2. **配置程序**
   - 打开程序
   - 在"Gemini API密钥"框中粘贴你的密钥
   - 选择输出目录（可选，使用默认即可）
   - 点击"💾 保存配置"

3. **开始爬取**
   - 点击"🚀 开始爬取"
   - 等待爬取完成（可能需要几分钟）
   - 完成后会弹出提示框

4. **查看结果**
   - 点击"📁 打开输出目录"
   - 查看生成的规则文件

### 后续使用

1. 启动程序（配置已保存，无需重新设置）
2. 点击"🚀 开始爬取"
3. 等待完成

---

## 📂 输出文件说明

爬取完成后，输出目录结构如下：

```
harmony_cursor_rules/
├── animation_transition/          # 动画与转场
│   ├── animation_usage_guide.md
│   └── ...
├── component_encapsulation_reuse/ # 组件封装与复用
├── declarative_syntax/            # 声明式语法
├── gesture_navigation/            # 手势与导航
├── layout_dialog/                 # 布局与弹窗
├── theme_style/                   # 主题与样式
└── final_cursor_rules/            # 最终规则文件（重要！）
    ├── animation_transition.cursorrules.md
    ├── component_encapsulation_reuse.cursorrules.md
    ├── declarative_syntax.cursorrules.md
    ├── gesture_navigation.cursorrules.md
    ├── layout_dialog.cursorrules.md
    ├── theme_style.cursorrules.md
    └── arkts-lint-rules.md
```

**重要文件：**
- `final_cursor_rules/` 文件夹中的 `.cursorrules.md` 文件
- 这些文件可以直接用于Cursor等AI编程工具

---

## ⚠️ 常见问题

### 1. 提示"未提供Gemini API密钥"

**原因：** 未配置或配置错误

**解决：**
- 检查API密钥是否正确输入
- 点击"💾 保存配置"保存
- 重新启动程序

### 2. 爬取失败或超时

**可能原因：**
- 网络连接问题
- API密钥无效
- 华为开发者网站访问受限

**解决：**
- 检查网络连接
- 验证API密钥是否有效
- 尝试使用VPN（如果在国外）

### 3. 打包后程序无法运行

**可能原因：**
- 缺少依赖
- Playwright浏览器未安装

**解决：**
- 重新运行 `build.bat`
- 确保依赖完整安装

### 4. 程序启动慢

**原因：** 首次启动需要加载依赖

**说明：** 这是正常现象，打包后的程序首次启动会稍慢

---

## 🔧 技术说明

### 使用的技术栈

- **GUI框架：** Tkinter（Python标准库）
- **异步处理：** asyncio
- **网页爬取：** crawl4ai + Playwright
- **AI处理：** Google Gemini API
- **打包工具：** PyInstaller

### 打包后文件说明

打包后的程序包含：
- 主程序 EXE
- Python解释器
- 所有依赖库
- Playwright浏览器引擎
- 配置文件

**总大小：** 约 200-300MB

---

## 📞 支持

如遇问题，请：
1. 查看运行日志中的错误信息
2. 检查网络和API配置
3. 查看项目GitHub Issues

---

## 📄 许可证

本项目遵循原项目的开源许可证。

---

## 🎉 开始使用

现在你可以：
1. 运行 `build.bat` 打包程序
2. 或直接运行 `python gui_app.py` 测试
3. 享受便捷的图形界面操作！
