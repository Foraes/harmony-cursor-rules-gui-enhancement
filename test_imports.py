"""
测试所有必要的模块导入
用于验证打包前的环境是否正确
"""

import sys
print("=" * 60)
print("模块导入测试")
print("=" * 60)
print(f"Python版本: {sys.version}")
print(f"Python路径: {sys.executable}")
print("=" * 60)

modules_to_test = [
    ('tkinter', 'GUI框架'),
    ('asyncio', '异步IO'),
    ('threading', '多线程'),
    ('dotenv', '环境变量'),
    ('google.genai', 'Gemini AI'),
    ('crawl4ai', '网页爬虫'),
    ('playwright', '浏览器自动化'),
    ('bs4', 'BeautifulSoup'),
    ('lxml', 'XML解析'),
    ('aiofiles', '异步文件操作'),
    ('main', '主程序'),
    ('config', '配置模块'),
    ('ai', 'AI处理'),
    ('crawler', '爬虫核心'),
    ('batch', '批量处理'),
    ('arkts_lint', 'ArkTS规则'),
    ('utils', '工具函数'),
    ('gemini_api', 'Gemini API'),
]

print("\n检查模块导入:")
print("-" * 60)

success_count = 0
fail_count = 0
failed_modules = []

for module_name, description in modules_to_test:
    try:
        __import__(module_name)
        print(f"✓ {module_name:25s} - {description}")
        success_count += 1
    except ImportError as e:
        print(f"✗ {module_name:25s} - {description} (失败)")
        fail_count += 1
        failed_modules.append((module_name, str(e)))
    except Exception as e:
        print(f"⚠ {module_name:25s} - {description} (警告: {str(e)[:30]})")
        success_count += 1

print("-" * 60)
print(f"\n测试结果:")
print(f"  成功: {success_count}/{len(modules_to_test)}")
print(f"  失败: {fail_count}/{len(modules_to_test)}")

if failed_modules:
    print(f"\n失败的模块:")
    for module_name, error in failed_modules:
        print(f"  - {module_name}: {error}")
    print(f"\n请运行以下命令安装缺失的依赖:")
    print(f"  pip install -r Requirements.txt")
    sys.exit(1)
else:
    print(f"\n✅ 所有模块导入成功！可以进行打包。")
    sys.exit(0)
