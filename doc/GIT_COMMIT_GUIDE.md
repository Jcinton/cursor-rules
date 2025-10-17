# Git 中文提交信息指南

## 🔧 问题描述

在 Windows PowerShell 环境下使用 Git 提交中文信息时，经常会出现乱码问题。

## 🎯 根本原因

1. **PowerShell 默认使用 GBK 编码（代码页 936）**
2. **`Out-File -Encoding UTF8` 会添加 BOM（字节顺序标记）**
3. **Git 读取带 BOM 的文件或从 GBK 环境接收参数时会出现编码问题**

## ✅ 正确的提交方法

### 方法 1：使用 Python 脚本生成无 BOM UTF-8 文件（推荐）⭐

这是最可靠的方法，适用于所有场景。

#### 步骤：

1. **创建 Python 脚本** (`commit.py`):

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-

msg = """feat(用户模块): 添加用户注册功能

- 实现用户名密码注册
- 添加邮箱验证
- 完善用户信息表单"""

# 写入无 BOM 的 UTF-8 文件
with open('.git_commit_msg.txt', 'w', encoding='utf-8') as f:
    f.write(msg)

print("Commit message file created")
```

2. **运行脚本并提交**:

```bash
# 生成提交信息文件
python commit.py

# 暂存文件
git add .

# 使用文件提交
git commit -F .git_commit_msg.txt

# 清理临时文件
Remove-Item .git_commit_msg.txt
```

#### 优点：
- ✅ 完全避免编码问题
- ✅ 无 BOM，Git 可以正确读取
- ✅ 支持多行提交信息
- ✅ 可复用、可自动化

---

### 方法 2：使用 WSL（如果可用）

如果你的 Windows 系统安装了 WSL，可以在 Linux 环境中提交：

```bash
# 在 PowerShell 中执行
wsl bash

# 在 WSL 中
cd /mnt/e/code/your-project

git add .

git commit -m "feat(用户模块): 添加用户注册功能

- 实现用户名密码注册
- 添加邮箱验证
- 完善用户信息表单"

exit
```

#### 优点：
- ✅ Linux 环境原生支持 UTF-8
- ✅ 没有编码转换问题
- ✅ 可以直接使用 `-m` 参数

#### 缺点：
- ❌ 需要安装和配置 WSL
- ❌ 路径需要转换（Windows 路径 → WSL 路径）

---

### 方法 3：使用 Git Bash

如果安装了 Git for Windows，它自带 Git Bash：

```bash
# 打开 Git Bash（不是 PowerShell）
git add .

git commit -m "feat(用户模块): 添加用户注册功能

- 实现用户名密码注册
- 添加邮箱验证
- 完善用户信息表单"
```

#### 优点：
- ✅ 模拟 Linux 环境
- ✅ 原生支持 UTF-8
- ✅ Git for Windows 自带，无需额外安装

---

## ❌ 不推荐的方法

### 使用 PowerShell 的 `Out-File -Encoding UTF8`

```bash
# ❌ 这种方式会产生带 BOM 的 UTF-8 文件
echo "feat(用户): 添加用户注册功能" | Out-File -Encoding UTF8 .git_commit_msg.txt
git commit -F .git_commit_msg.txt
```

**问题**：`Out-File -Encoding UTF8` 会在文件开头添加 BOM（EF BB BF），导致 Git 读取时出现乱码。

### 直接使用 `-m` 参数（在 PowerShell 中）

```bash
# ❌ 在 PowerShell 中这样做会乱码
git commit -m "feat(用户): 添加用户注册功能"
```

**问题**：PowerShell 默认使用 GBK 编码传递参数给 Git，导致中文乱码。

---

## 🔍 验证提交信息

提交后，使用以下命令验证中文是否正确：

```bash
# 查看最近的提交
git log -1

# 查看详细信息
git log --format=fuller -1

# 查看提交信息（纯文本）
git log -1 --pretty=%B
```

如果看到乱码，说明提交方法不正确，需要修复。

---

## 🛠️ 修复已有的乱码提交

如果已经提交了乱码的信息，可以修复：

### 修复最近一次提交

```bash
# 使用 Python 脚本生成正确的提交信息
python commit.py

# 修改最近一次提交
git commit --amend -F .git_commit_msg.txt

# 清理
Remove-Item .git_commit_msg.txt
```

### 修复多个提交

```bash
# 软重置到某个提交（保留所有更改）
git reset --soft HEAD~3

# 重新分组提交（使用 Python 脚本）
# ... 按照正确方法重新提交
```

---

## 📋 自动化脚本

创建一个可复用的提交脚本 `gitcommit.py`：

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import sys
import subprocess

if len(sys.argv) < 2:
    print("用法: python gitcommit.py <提交信息>")
    print("示例: python gitcommit.py 'feat(用户): 添加注册功能'")
    sys.exit(1)

msg = sys.argv[1]

# 写入无 BOM 的 UTF-8 文件
with open('.git_commit_msg.txt', 'w', encoding='utf-8') as f:
    f.write(msg)

# 执行 git commit
subprocess.run(['git', 'commit', '-F', '.git_commit_msg.txt'])

# 清理临时文件
import os
os.remove('.git_commit_msg.txt')
```

使用：

```bash
git add .
python gitcommit.py "feat(用户): 添加用户注册功能

- 实现用户名密码注册
- 添加邮箱验证
- 完善用户信息表单"
```

---

## 💡 最佳实践

1. **统一使用 Python 脚本方法** - 可靠、可复用、团队统一
2. **提交前先验证** - 使用 `git log -1` 检查
3. **配置 Git 编码** - 确保 Git 使用 UTF-8：
   ```bash
   git config --global i18n.commitencoding utf-8
   git config --global i18n.logoutputencoding utf-8
   ```
4. **团队规范** - 在项目中提供统一的提交脚本
5. **CI/CD 检查** - 添加编码检查，防止乱码提交

---

## 📚 相关资源

- [Git Commit 规范](./git-workflow.mdc)
- [Git 工作流指南](../git-workflow.mdc)
- [Python UTF-8 文档](https://docs.python.org/3/howto/unicode.html)

---

**最后更新**: 2024-01-16  
**维护者**: 开发团队

