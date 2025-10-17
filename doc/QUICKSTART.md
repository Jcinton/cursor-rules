# 快速开始指南

## 🚀 5 分钟快速上手

### 第一步：安装规则（2 分钟）

在你的项目根目录执行一条命令：

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Jcinton/cursor-rules/main/install.sh)
```

**⚠️ 如果遇到 404 错误**，说明仓库是私有的，请使用以下替代方案：

```bash
# 方案 1: 使用 SSH 方式（推荐）
git submodule add git@github.com:Jcinton/cursor-rules.git .cursor/rules
git submodule update --init --recursive

# 方案 2: 使用本地路径（如果有本地副本）
git submodule add /path/to/cursor-rules .cursor/rules
git submodule update --init --recursive
```

详见 [故障排除指南](./TROUBLESHOOTING.md#1-安装脚本返回-404-错误)

**完成！** 🎉 规则已经安装到 `.cursor/rules/` 目录。

### 第二步：开始使用（1 分钟）

在 Cursor 中打开你的项目，规则会自动生效。

试试这些提示词：

```
创建一个用户管理的 Controller，包含 CRUD 操作
```

```
使用 MyBatis-Plus 实现用户分页查询
```

```
为 UserService 生成单元测试
```

### 第三步：更新规则（1 分钟）

当规则有更新时，执行：

```bash
bash .cursor/rules/update-rules.sh
```

## 📋 完整流程示例

### 新建项目

```bash
# 1. 创建项目
mkdir my-project && cd my-project
git init

# 2. 安装规则
bash <(curl -fsSL https://raw.githubusercontent.com/Jcinton/cursor-rules/main/install.sh)

# 3. 提交
git add .
git commit -m "feat: 初始化项目并添加 Cursor 规则"

# 4. 在 Cursor 中开发
code .
```

### 现有项目

```bash
# 1. 进入项目
cd /path/to/existing-project

# 2. 安装规则
bash <(curl -fsSL https://raw.githubusercontent.com/Jcinton/cursor-rules/main/install.sh)

# 3. 提交
git add .gitmodules .cursor/rules
git commit -m "feat: 添加 Cursor 规则"
git push
```

### 团队成员克隆

```bash
# 克隆项目（带子模块）
git clone --recurse-submodules <repo-url>

# 或者，如果已经克隆
git submodule update --init --recursive
```

## 🎯 核心命令

```bash
# 安装规则
bash <(curl -fsSL https://raw.githubusercontent.com/Jcinton/cursor-rules/main/install.sh)

# 更新规则
bash .cursor/rules/update-rules.sh

# 查看规则状态
git submodule status

# 删除规则
git submodule deinit -f .cursor/rules
git rm -f .cursor/rules
```

## ❓ 常见问题

**Q: 安装脚本返回 404 错误怎么办？**  
A: 说明仓库是私有的。使用 SSH 方式安装：`git submodule add git@github.com:Jcinton/cursor-rules.git .cursor/rules`。详见 [故障排除指南](./TROUBLESHOOTING.md)。

**Q: 需要每个项目都安装吗？**  
A: 是的，每个项目独立管理规则。但团队成员克隆项目后会自动拥有规则。

**Q: 规则会自动更新吗？**  
A: 不会自动更新，需要手动执行更新脚本。这样可以控制更新时机。

**Q: 可以自定义规则吗？**  
A: 建议 Fork 仓库后作为子模块使用。详见 [USAGE.md](./USAGE.md)。

**Q: 如何验证规则是否生效？**  
A: 在 Cursor 中输入提示词，观察 AI 生成的代码是否符合规范。

## 📚 进阶学习

- [完整使用指南](./USAGE.md)
- [规则文件说明](./README.md#规则文件列表)
- [团队协作指南](./USAGE.md#团队协作)

## 💡 提示

1. **第一次使用**: 建议先在测试项目中尝试
2. **团队使用**: 确保所有成员都理解 Git 子模块
3. **定期更新**: 每月检查一次规则更新
4. **反馈问题**: 遇到问题请提 [Issue](https://github.com/Jcinton/cursor-rules/issues)

---

**现在就开始使用 Cursor Rules，让 AI 按照你的规范编码！** 🚀

