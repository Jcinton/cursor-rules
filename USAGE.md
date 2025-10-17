# Cursor Rules 使用指南

## 📖 目录

- [安装方式对比](#安装方式对比)
- [Git 子模块方式详解](#git-子模块方式详解)
- [常见问题](#常见问题)
- [使用示例](#使用示例)
- [团队协作](#团队协作)

## 安装方式对比

### 方式一：Git 子模块（推荐）⭐

**优点**:
- ✅ 规则自动同步，始终保持最新
- ✅ 团队成员克隆项目后自动拥有规则
- ✅ 统一管理，避免版本不一致
- ✅ 可以随时更新和回滚规则版本
- ✅ 规则更新后团队可以统一升级

**缺点**:
- ⚠️ 需要理解 Git 子模块概念
- ⚠️ 不能直接修改子模块中的规则文件

**适用场景**:
- ✅ 团队协作项目
- ✅ 需要保持规则同步
- ✅ 长期维护的项目

### 方式二：直接复制

**优点**:
- ✅ 简单直接，容易理解
- ✅ 可以自由修改规则文件
- ✅ 不需要网络访问

**缺点**:
- ❌ 规则更新需要手动同步
- ❌ 团队成员可能使用不同版本
- ❌ 无法轻松回滚到之前的版本

**适用场景**:
- ✅ 个人项目
- ✅ 需要自定义规则
- ✅ 一次性使用

## Git 子模块方式详解

### 1. 初次安装

#### 方式 A: 使用安装脚本（推荐）

```bash
# 在项目根目录执行
cd /path/to/your/project

# 使用在线安装脚本
bash <(curl -fsSL https://raw.githubusercontent.com/Jcinton/cursor-rules/main/install.sh)
```

**脚本功能**:
- ✅ 自动检查项目是否是 Git 仓库
- ✅ 自动添加子模块到 `.cursor/rules` 目录
- ✅ 自动初始化子模块
- ✅ 显示安装结果和使用提示

#### 方式 B: 手动安装

```bash
# 在项目根目录执行
cd /path/to/your/project

# 添加子模块
git submodule add git@github.com:Jcinton/cursor-rules.git .cursor/rules

# 初始化子模块
git submodule update --init --recursive

# 提交子模块配置
git add .gitmodules .cursor/rules
git commit -m "feat(项目配置): 添加 Cursor 规则子模块"
```

### 2. 更新规则

#### 方式 A: 使用更新脚本（推荐）

```bash
# 在项目根目录执行
bash .cursor/rules/update-rules.sh
```

**脚本功能**:
- ✅ 自动检查子模块状态
- ✅ 显示当前版本和更新后版本
- ✅ 显示变更内容
- ✅ 列出所有规则文件

#### 方式 B: 手动更新

```bash
# 进入子模块目录
cd .cursor/rules

# 拉取最新更新
git pull origin main

# 返回项目根目录
cd ../..

# 提交子模块版本更新
git add .cursor/rules
git commit -m "chore(项目配置): 更新 Cursor 规则"
```

### 3. 团队成员克隆项目

当团队成员克隆包含子模块的项目时：

```bash
# 方式 A: 克隆时同时初始化子模块（推荐）
git clone --recurse-submodules <your-project-repo>

# 方式 B: 先克隆项目，再初始化子模块
git clone <your-project-repo>
cd <your-project>
git submodule update --init --recursive
```

### 4. 查看子模块状态

```bash
# 查看子模块状态
git submodule status

# 查看子模块信息
git submodule

# 输出示例:
# +a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0 .cursor/rules (heads/main)
# + 表示子模块已初始化
# 哈希值是当前子模块的 commit
```

### 5. 删除子模块

如果需要移除规则子模块：

```bash
# 1. 反初始化子模块（删除工作目录）
git submodule deinit -f .cursor/rules

# 2. 从 Git 中删除子模块
git rm -f .cursor/rules

# 3. 删除 Git 模块缓存
rm -rf .git/modules/.cursor/rules

# 4. 提交更改
git commit -m "chore(项目配置): 移除 Cursor 规则子模块"
```

## 常见问题

### Q1: 子模块显示 "modified" 状态

**问题**: `git status` 显示 `.cursor/rules (modified content)`

**原因**: 子模块中有未提交的更改或版本不一致

**解决方案**:

```bash
# 方式 1: 重置子模块到原始状态
git submodule update --init --recursive --force

# 方式 2: 如果确实需要更新子模块版本
cd .cursor/rules
git pull origin main
cd ../..
git add .cursor/rules
git commit -m "chore(项目配置): 更新 Cursor 规则"
```

### Q2: 克隆项目后子模块目录为空

**问题**: `.cursor/rules` 目录存在但里面没有文件

**原因**: 忘记初始化子模块

**解决方案**:

```bash
# 初始化并更新子模块
git submodule update --init --recursive
```

### Q3: 如何固定子模块版本

**问题**: 不想自动更新子模块，希望使用特定版本

**解决方案**:

```bash
# 1. 进入子模块目录
cd .cursor/rules

# 2. 切换到指定版本（commit 或 tag）
git checkout v1.0.0

# 3. 返回项目根目录
cd ../..

# 4. 提交子模块版本
git add .cursor/rules
git commit -m "chore(项目配置): 固定 Cursor 规则版本为 v1.0.0"
```

### Q4: 能否在子模块中修改规则

**问题**: 想要自定义某些规则

**建议**:

**方式 A: Fork 仓库（推荐）**

```bash
# 1. Fork cursor-rules 仓库到你的账号
# 2. 删除现有子模块
git submodule deinit -f .cursor/rules
git rm -f .cursor/rules

# 3. 添加你 Fork 的仓库作为子模块
git submodule add git@github.com:your-username/cursor-rules.git .cursor/rules
git submodule update --init --recursive
```

**方式 B: 直接复制**

如果需要大量自定义，建议改用直接复制方式。

### Q5: 如何为不同项目使用不同的规则版本

**解决方案**:

每个项目的子模块可以独立管理版本：

```bash
# 项目 A 使用最新版本
cd /path/to/project-a/.cursor/rules
git checkout main
git pull

# 项目 B 使用固定版本
cd /path/to/project-b/.cursor/rules
git checkout v1.0.0
```

## 使用示例

### 示例 1: 新建项目并添加规则

```bash
# 1. 创建新项目
mkdir my-spring-boot-project
cd my-spring-boot-project

# 2. 初始化 Git 仓库
git init

# 3. 安装 Cursor 规则
bash <(curl -fsSL https://raw.githubusercontent.com/Jcinton/cursor-rules/main/install.sh)

# 4. 开始开发
# 在 Cursor 中打开项目，规则会自动生效
```

### 示例 2: 现有项目添加规则

```bash
# 1. 进入项目目录
cd /path/to/existing-project

# 2. 确保项目是 Git 仓库
git status

# 3. 安装规则
bash <(curl -fsSL https://raw.githubusercontent.com/Jcinton/cursor-rules/main/install.sh)

# 4. 提交更改
git add .gitmodules .cursor/rules
git commit -m "feat(项目配置): 添加 Cursor 规则"
git push
```

### 示例 3: 团队成员克隆项目

```bash
# 1. 克隆项目（包含子模块）
git clone --recurse-submodules git@github.com:your-org/your-project.git

# 2. 进入项目目录
cd your-project

# 3. 在 Cursor 中打开项目
# 规则已经自动就绪，无需额外操作

# 4. 如果忘记使用 --recurse-submodules
git submodule update --init --recursive
```

### 示例 4: 定期更新规则

```bash
# 方式 1: 使用更新脚本
bash .cursor/rules/update-rules.sh

# 方式 2: 手动更新
cd .cursor/rules && git pull && cd ../..

# 提交更新（如果需要团队同步）
git add .cursor/rules
git commit -m "chore(项目配置): 更新 Cursor 规则"
git push
```

## 团队协作

### 规则更新流程

**场景**: 规则仓库有新版本，团队需要统一升级

```bash
# 1. 项目负责人更新规则
cd /path/to/project
bash .cursor/rules/update-rules.sh

# 2. 测试新规则是否影响现有代码
# （可选）运行测试，检查 Cursor 生成的代码

# 3. 提交更新
git add .cursor/rules
git commit -m "chore(项目配置): 更新 Cursor 规则到最新版本"
git push

# 4. 团队成员拉取更新
git pull
git submodule update --init --recursive
```

### CI/CD 配置

在 CI/CD 流程中初始化子模块：

**GitHub Actions 示例**:

```yaml
name: CI

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
        with:
          submodules: recursive  # 自动初始化子模块
      
      - name: Build and Test
        run: |
          # 你的构建和测试命令
          mvn clean test
```

**GitLab CI 示例**:

```yaml
variables:
  GIT_SUBMODULE_STRATEGY: recursive  # 自动初始化子模块

build:
  script:
    - mvn clean test
```

### 团队规范建议

1. **在项目 README 中说明**:
   ```markdown
   ## 开发环境
   
   本项目使用 Cursor AI 编辑器进行开发，并使用统一的代码规范。
   
   克隆项目时请使用：
   \`\`\`bash
   git clone --recurse-submodules <repo-url>
   \`\`\`
   ```

2. **新人入职检查清单**:
   - [ ] 克隆项目时使用 `--recurse-submodules`
   - [ ] 确认 `.cursor/rules` 目录不为空
   - [ ] 在 Cursor 中打开项目
   - [ ] 测试规则是否生效

3. **规则版本管理**:
   - 主分支始终使用最新规则
   - 发布分支固定规则版本
   - 重要更新前充分测试

## 高级用法

### 使用别名简化命令

在 `~/.bashrc` 或 `~/.zshrc` 中添加：

```bash
# Cursor 规则管理别名
alias cursor-install='bash <(curl -fsSL https://raw.githubusercontent.com/Jcinton/cursor-rules/main/install.sh)'
alias cursor-update='bash .cursor/rules/update-rules.sh'
alias cursor-status='cd .cursor/rules && git status && git log -1 && cd ../..'
```

### 多项目批量更新

创建批量更新脚本 `update-all-projects.sh`:

```bash
#!/bin/bash

# 项目列表
PROJECTS=(
    "/path/to/project1"
    "/path/to/project2"
    "/path/to/project3"
)

for project in "${PROJECTS[@]}"; do
    echo "更新项目: $project"
    cd "$project"
    
    if [ -d ".cursor/rules" ]; then
        bash .cursor/rules/update-rules.sh
        echo "✅ $project 更新完成"
    else
        echo "⚠️  $project 未安装规则"
    fi
    
    echo ""
done

echo "🎉 所有项目更新完成！"
```

---

如有问题，请访问 [GitHub Issues](https://github.com/Jcinton/cursor-rules/issues)

