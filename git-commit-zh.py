#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Git 中文提交工具

用途：在 Windows PowerShell 环境下正确提交中文 Git 信息，避免乱码。
原理：使用 Python 生成无 BOM 的 UTF-8 提交信息文件，然后调用 git commit -F。

使用方法：
    python git-commit-zh.py

作者：开发团队
最后更新：2024-01-16
"""

import os
import subprocess
import sys


def create_commit_message():
    """交互式创建提交信息"""
    print("=" * 60)
    print("Git 中文提交工具")
    print("=" * 60)
    print()
    
    # 输入 type
    print("提交类型 (type):")
    print("  feat     - 新功能")
    print("  fix      - Bug 修复")
    print("  docs     - 文档修改")
    print("  style    - 代码格式")
    print("  refactor - 重构")
    print("  perf     - 性能优化")
    print("  test     - 测试相关")
    print("  chore    - 构建过程或辅助工具")
    print()
    commit_type = input("请输入类型 (默认: feat): ").strip() or "feat"
    
    # 输入 scope
    scope = input("作用域 (scope，可选): ").strip()
    
    # 输入主题
    subject = input("主题描述 (必填): ").strip()
    if not subject:
        print("❌ 错误：主题描述不能为空")
        sys.exit(1)
    
    # 构建第一行
    if scope:
        first_line = f"{commit_type}({scope}): {subject}"
    else:
        first_line = f"{commit_type}: {subject}"
    
    # 输入详细说明
    print()
    print("详细说明 (可选，输入空行结束):")
    body_lines = []
    while True:
        line = input()
        if not line:
            break
        body_lines.append(line)
    
    # 输入 footer
    print()
    footer = input("Footer (如 Closes #123，可选): ").strip()
    
    # 构建完整提交信息
    commit_msg = first_line
    if body_lines:
        commit_msg += "\n\n" + "\n".join(body_lines)
    if footer:
        commit_msg += "\n\n" + footer
    
    return commit_msg


def write_commit_file(message):
    """写入无 BOM 的 UTF-8 提交信息文件"""
    filename = '.git_commit_msg.txt'
    with open(filename, 'w', encoding='utf-8') as f:
        f.write(message)
    return filename


def git_commit(filename):
    """调用 git commit"""
    try:
        result = subprocess.run(
            ['git', 'commit', '-F', filename],
            capture_output=True,
            text=True,
            encoding='utf-8'
        )
        print(result.stdout)
        if result.returncode != 0:
            print(result.stderr)
            return False
        return True
    except Exception as e:
        print(f"❌ 提交失败: {e}")
        return False


def cleanup(filename):
    """清理临时文件"""
    try:
        if os.path.exists(filename):
            os.remove(filename)
    except Exception as e:
        print(f"⚠️  清理临时文件失败: {e}")


def main():
    """主函数"""
    print()
    
    # 检查是否在 Git 仓库中
    result = subprocess.run(
        ['git', 'rev-parse', '--git-dir'],
        capture_output=True,
        text=True
    )
    if result.returncode != 0:
        print("❌ 错误：当前目录不是 Git 仓库")
        sys.exit(1)
    
    # 检查是否有暂存的文件
    result = subprocess.run(
        ['git', 'diff', '--cached', '--quiet'],
        capture_output=True
    )
    if result.returncode == 0:
        print("⚠️  警告：没有暂存的文件")
        choice = input("是否继续？(y/N): ").strip().lower()
        if choice != 'y':
            print("已取消")
            sys.exit(0)
    
    # 创建提交信息
    message = create_commit_message()
    
    # 显示预览
    print()
    print("=" * 60)
    print("提交信息预览:")
    print("-" * 60)
    print(message)
    print("-" * 60)
    print()
    
    # 确认提交
    choice = input("确认提交？(Y/n): ").strip().lower()
    if choice == 'n':
        print("已取消")
        sys.exit(0)
    
    # 写入文件
    filename = write_commit_file(message)
    
    # 执行提交
    print()
    print("正在提交...")
    success = git_commit(filename)
    
    # 清理
    cleanup(filename)
    
    if success:
        print()
        print("✅ 提交成功！")
        print()
        print("查看提交信息:")
        subprocess.run(['git', 'log', '-1', '--oneline'])
    else:
        print()
        print("❌ 提交失败")
        sys.exit(1)


if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print()
        print("已取消")
        sys.exit(0)

