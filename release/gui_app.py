#!/usr/bin/env python3
"""
HarmonyOS规则爬虫 - GUI版本
带有图形界面的用户友好版本
"""

import asyncio
import tkinter as tk
from tkinter import ttk, filedialog, messagebox, scrolledtext
import threading
import sys
import os
from pathlib import Path
from datetime import datetime

# 导入项目核心模块
from main import SPACrawler
from config import ConfigManager


class CrawlerGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("HarmonyOS规则爬虫工具 v1.0")
        self.root.geometry("800x700")
        self.root.resizable(True, True)
        
        # 设置图标（如果有的话）
        try:
            self.root.iconbitmap('icon.ico')
        except:
            pass
        
        # 配置变量
        self.api_key_var = tk.StringVar()
        self.api_url_var = tk.StringVar(value="https://generativelanguage.googleapis.com")
        self.output_dir_var = tk.StringVar(value="harmony_cursor_rules")
        self.debug_var = tk.BooleanVar(value=False)
        
        # 加载已保存的配置
        self.load_config()
        
        # 创建界面
        self.create_widgets()
        
        # 爬虫实例
        self.crawler = None
        self.is_running = False

    def create_widgets(self):
        """创建GUI组件"""
        # 主容器
        main_frame = ttk.Frame(self.root, padding="10")
        main_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        # 配置网格权重
        self.root.columnconfigure(0, weight=1)
        self.root.rowconfigure(0, weight=1)
        main_frame.columnconfigure(1, weight=1)
        
        # ===== 配置区域 =====
        config_frame = ttk.LabelFrame(main_frame, text="配置设置", padding="10")
        config_frame.grid(row=0, column=0, columnspan=2, sticky=(tk.W, tk.E), pady=(0, 10))
        config_frame.columnconfigure(1, weight=1)
        
        # API密钥
        ttk.Label(config_frame, text="Gemini API密钥:").grid(row=0, column=0, sticky=tk.W, pady=5)
        api_key_entry = ttk.Entry(config_frame, textvariable=self.api_key_var, width=50, show="*")
        api_key_entry.grid(row=0, column=1, sticky=(tk.W, tk.E), padx=(5, 0), pady=5)
        
        # 显示/隐藏密钥按钮
        self.show_key_btn = ttk.Button(config_frame, text="👁", width=3, 
                                        command=self.toggle_api_key_visibility)
        self.show_key_btn.grid(row=0, column=2, padx=(5, 0), pady=5)
        self.api_key_entry = api_key_entry
        
        # API地址
        ttk.Label(config_frame, text="API地址:").grid(row=1, column=0, sticky=tk.W, pady=5)
        ttk.Entry(config_frame, textvariable=self.api_url_var, width=50).grid(
            row=1, column=1, columnspan=2, sticky=(tk.W, tk.E), padx=(5, 0), pady=5)
        
        # 输出目录
        ttk.Label(config_frame, text="输出目录:").grid(row=2, column=0, sticky=tk.W, pady=5)
        ttk.Entry(config_frame, textvariable=self.output_dir_var, width=40).grid(
            row=2, column=1, sticky=(tk.W, tk.E), padx=(5, 0), pady=5)
        ttk.Button(config_frame, text="浏览...", command=self.browse_output_dir).grid(
            row=2, column=2, padx=(5, 0), pady=5)
        
        # 调试模式
        ttk.Checkbutton(config_frame, text="调试模式（保存HTML文件）", 
                       variable=self.debug_var).grid(row=3, column=0, columnspan=3, 
                                                     sticky=tk.W, pady=5)
        
        # 保存配置按钮
        ttk.Button(config_frame, text="💾 保存配置", 
                  command=self.save_config).grid(row=4, column=0, columnspan=3, pady=(10, 0))
        
        # ===== 操作区域 =====
        action_frame = ttk.LabelFrame(main_frame, text="操作", padding="10")
        action_frame.grid(row=1, column=0, columnspan=2, sticky=(tk.W, tk.E), pady=(0, 10))
        
        # 按钮容器
        btn_container = ttk.Frame(action_frame)
        btn_container.pack(fill=tk.X)
        
        # 开始爬取按钮
        self.start_btn = ttk.Button(btn_container, text="🚀 开始爬取", 
                                    command=self.start_crawling)
        self.start_btn.pack(side=tk.LEFT, padx=5)
        
        # 停止按钮（初始禁用）
        self.stop_btn = ttk.Button(btn_container, text="⏹ 停止", 
                                   command=self.stop_crawling, state=tk.DISABLED)
        self.stop_btn.pack(side=tk.LEFT, padx=5)
        
        # 打开输出目录按钮
        ttk.Button(btn_container, text="📁 打开输出目录", 
                  command=self.open_output_dir).pack(side=tk.LEFT, padx=5)
        
        # 清空日志按钮
        ttk.Button(btn_container, text="🗑 清空日志", 
                  command=self.clear_log).pack(side=tk.LEFT, padx=5)
        
        # ===== 日志区域 =====
        log_frame = ttk.LabelFrame(main_frame, text="运行日志", padding="10")
        log_frame.grid(row=2, column=0, columnspan=2, sticky=(tk.W, tk.E, tk.N, tk.S), pady=(0, 10))
        
        # 配置网格权重使日志区域可扩展
        main_frame.rowconfigure(2, weight=1)
        
        # 日志文本框
        self.log_text = scrolledtext.ScrolledText(log_frame, height=15, width=80, 
                                                   wrap=tk.WORD, state=tk.DISABLED)
        self.log_text.pack(fill=tk.BOTH, expand=True)
        
        # 配置日志文本样式
        self.log_text.tag_config("success", foreground="green")
        self.log_text.tag_config("error", foreground="red")
        self.log_text.tag_config("warning", foreground="orange")
        self.log_text.tag_config("info", foreground="blue")
        
        # ===== 状态栏 =====
        status_frame = ttk.Frame(main_frame)
        status_frame.grid(row=3, column=0, columnspan=2, sticky=(tk.W, tk.E))
        
        self.status_label = ttk.Label(status_frame, text="就绪", relief=tk.SUNKEN, anchor=tk.W)
        self.status_label.pack(fill=tk.X, side=tk.LEFT, expand=True)
        
        # 进度条
        self.progress = ttk.Progressbar(status_frame, mode='indeterminate')
        self.progress.pack(side=tk.RIGHT, padx=(10, 0))

    def toggle_api_key_visibility(self):
        """切换API密钥显示/隐藏"""
        if self.api_key_entry.cget('show') == '*':
            self.api_key_entry.config(show='')
            self.show_key_btn.config(text='🙈')
        else:
            self.api_key_entry.config(show='*')
            self.show_key_btn.config(text='👁')

    def browse_output_dir(self):
        """浏览选择输出目录"""
        directory = filedialog.askdirectory(
            title="选择输出目录",
            initialdir=self.output_dir_var.get()
        )
        if directory:
            self.output_dir_var.set(directory)

    def load_config(self):
        """加载保存的配置"""
        try:
            if os.path.exists('.env'):
                with open('.env', 'r', encoding='utf-8') as f:
                    for line in f:
                        line = line.strip()
                        if line and not line.startswith('#'):
                            if '=' in line:
                                key, value = line.split('=', 1)
                                if key == 'GEMINI_API_KEY':
                                    self.api_key_var.set(value)
                                elif key == 'GEMINI_BASE_URL':
                                    self.api_url_var.set(value)
        except Exception as e:
            self.log(f"加载配置失败: {e}", "warning")

    def save_config(self):
        """保存配置到.env文件"""
        try:
            with open('.env', 'w', encoding='utf-8') as f:
                f.write(f"GEMINI_API_KEY={self.api_key_var.get()}\n")
                f.write(f"GEMINI_BASE_URL={self.api_url_var.get()}\n")
            self.log("✅ 配置已保存", "success")
            messagebox.showinfo("成功", "配置已保存到 .env 文件")
        except Exception as e:
            self.log(f"❌ 保存配置失败: {e}", "error")
            messagebox.showerror("错误", f"保存配置失败：{e}")

    def log(self, message, tag="info"):
        """添加日志消息"""
        self.log_text.config(state=tk.NORMAL)
        timestamp = datetime.now().strftime("%H:%M:%S")
        self.log_text.insert(tk.END, f"[{timestamp}] {message}\n", tag)
        self.log_text.see(tk.END)
        self.log_text.config(state=tk.DISABLED)

    def clear_log(self):
        """清空日志"""
        self.log_text.config(state=tk.NORMAL)
        self.log_text.delete(1.0, tk.END)
        self.log_text.config(state=tk.DISABLED)

    def update_status(self, message):
        """更新状态栏"""
        self.status_label.config(text=message)

    def open_output_dir(self):
        """打开输出目录"""
        output_dir = self.output_dir_var.get()
        if os.path.exists(output_dir):
            os.startfile(output_dir)
        else:
            messagebox.showwarning("警告", f"输出目录不存在：{output_dir}")

    def validate_config(self):
        """验证配置"""
        if not self.api_key_var.get().strip():
            messagebox.showerror("错误", "请输入Gemini API密钥")
            return False
        
        if not self.api_url_var.get().strip():
            messagebox.showerror("错误", "请输入API地址")
            return False
        
        if not self.output_dir_var.get().strip():
            messagebox.showerror("错误", "请选择输出目录")
            return False
        
        return True

    def start_crawling(self):
        """开始爬取"""
        if not self.validate_config():
            return
        
        # 保存配置
        self.save_config()
        
        # 更新UI状态
        self.is_running = True
        self.start_btn.config(state=tk.DISABLED)
        self.stop_btn.config(state=tk.NORMAL)
        self.progress.start(10)
        self.update_status("正在爬取中...")
        self.clear_log()
        
        self.log("🚀 开始爬取任务", "info")
        
        # 在新线程中运行爬虫
        thread = threading.Thread(target=self.run_crawler, daemon=True)
        thread.start()

    def stop_crawling(self):
        """停止爬取"""
        self.is_running = False
        self.log("⏹ 用户停止了任务", "warning")
        self.update_status("已停止")
        self.progress.stop()
        self.start_btn.config(state=tk.NORMAL)
        self.stop_btn.config(state=tk.DISABLED)

    def run_crawler(self):
        """运行爬虫（在独立线程中）"""
        try:
            # 创建新的事件循环
            loop = asyncio.new_event_loop()
            asyncio.set_event_loop(loop)
            
            # 创建配置管理器
            config_manager = ConfigManager.from_settings(
                debug=self.debug_var.get(),
                output_dir=self.output_dir_var.get()
            )
            
            # 创建爬虫实例
            self.crawler = SPACrawler(config_manager)
            self.log("✅ 爬虫初始化成功", "success")
            
            # 执行爬取
            results = loop.run_until_complete(self.crawler.crawl_all_harmony_modules())
            
            if not self.is_running:
                return
            
            # 处理结果
            if results:
                successful_count = len([r for r in results if r.get("success")])
                total_count = len(results)
                
                self.log(f"🎊 爬取任务完成！", "success")
                self.log(f"📊 成功率: {successful_count}/{total_count} ({successful_count/total_count*100:.1f}%)", "info")
                
                # 整合最佳实践
                if successful_count > 0:
                    self.log("🔄 开始整合最佳实践...", "info")
                    integration_results = loop.run_until_complete(
                        self.crawler.integrate_best_practices()
                    )
                    if integration_results:
                        successful_integrations = len([r for r in integration_results if r['success']])
                        self.log(f"🎯 Cursor Rules生成完成！成功整合 {successful_integrations} 个模块", "success")
                
                # 提取ArkTS规则
                self.log("🔄 开始提取ArkTS规则...", "info")
                arkts_result = loop.run_until_complete(self.crawler.extract_arkts_rules())
                if arkts_result.get("success", False):
                    if arkts_result.get("skipped", False):
                        self.log("⏭️ ArkTS规则文件已存在", "info")
                    else:
                        self.log(f"🎊 ArkTS规则提取完成！提取了 {arkts_result.get('rules_count', 0)} 个规则", "success")
                
                self.update_status("完成")
                messagebox.showinfo("成功", f"爬取完成！\n成功: {successful_count}/{total_count}")
            else:
                self.log("❌ 爬取任务失败", "error")
                self.update_status("失败")
                messagebox.showerror("错误", "爬取失败，请检查配置和网络连接")
            
        except Exception as e:
            self.log(f"❌ 发生错误: {str(e)}", "error")
            self.update_status("错误")
            messagebox.showerror("错误", f"发生错误：{str(e)}")
        finally:
            # 恢复UI状态
            self.progress.stop()
            self.start_btn.config(state=tk.NORMAL)
            self.stop_btn.config(state=tk.DISABLED)
            self.is_running = False
            loop.close()


def main():
    """主函数"""
    root = tk.Tk()
    app = CrawlerGUI(root)
    root.mainloop()


if __name__ == "__main__":
    main()
