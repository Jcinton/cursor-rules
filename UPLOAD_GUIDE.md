# 上传到 GitHub 指南

## 📝 准备工作

本地仓库已经准备完毕，包含以下文件：
- ✅ 7 个 `.mdc` 规则文件
- ✅ README.md（专业的项目说明）
- ✅ LICENSE（MIT 许可证）
- ✅ .gitignore
- ✅ docs/ 目录（包含快速参考和原始 README）
- ✅ Git 仓库已初始化并完成首次提交

## 🚀 上传步骤

### 方法 1: 使用 GitHub 网页创建仓库（推荐）

#### 1. 在 GitHub 上创建新仓库

访问：https://github.com/new

填写信息：
```
Repository name: cursor-rules
Description: 🚀 Cursor AI 专用的 Java 开发规范集 | Java Development Rules for Cursor AI
Public/Private: Public（公开仓库）
☐ 不要勾选 "Add a README file"
☐ 不要勾选 "Add .gitignore"
☐ 不要勾选 "Choose a license"
```

#### 2. 关联远程仓库并推送

创建完成后，GitHub 会显示推送命令。在当前目录执行：

```bash
# 已经在 E:\code\idea\springboot-demo\cursor-rules-repo 目录下

# 添加远程仓库（替换 YOUR_USERNAME 为你的 GitHub 用户名）
git remote add origin https://github.com/YOUR_USERNAME/cursor-rules.git

# 设置主分支名称
git branch -M main

# 推送代码
git push -u origin main
```

### 方法 2: 使用 GitHub CLI（需要先安装 gh）

```bash
# 1. 安装 GitHub CLI（如果未安装）
# 访问: https://cli.github.com/

# 2. 登录 GitHub
gh auth login

# 3. 创建仓库并推送
gh repo create cursor-rules --public --source=. --remote=origin --push
```

### 方法 3: 使用 GitHub Desktop

1. 打开 GitHub Desktop
2. File -> Add Local Repository
3. 选择 `E:\code\idea\springboot-demo\cursor-rules-repo` 目录
4. Publish repository
5. 命名为 `cursor-rules`，选择 Public
6. 点击 Publish

## ✅ 验证上传成功

上传完成后，访问你的仓库：
```
https://github.com/YOUR_USERNAME/cursor-rules
```

你应该能看到：
- ✅ 完整的 README.md（带徽章和目录）
- ✅ 7 个 .mdc 文件
- ✅ LICENSE 文件
- ✅ docs/ 目录

## 📦 仓库文件结构

```
cursor-rules/
├── README.md              # 项目主页说明
├── LICENSE                # MIT 开源协议
├── .gitignore            # Git 忽略文件
├── api-design.mdc        # RESTful API 设计规范
├── code-quality.mdc      # 代码质量规范
├── git-workflow.mdc      # Git 工作流规范
├── java.mdc              # Java 基础规范
├── mybatis-plus.mdc      # MyBatis-Plus 使用规范
├── spring-boot.mdc       # Spring Boot 开发规范
├── unit-test.mdc         # 单元测试规范
└── docs/                 # 文档目录
    ├── QUICK_REFERENCE.md  # 快速参考
    └── README.md           # 原始说明
```

## 🎨 美化仓库（可选）

### 添加 Topics 标签

在仓库主页，点击 "Add topics"，添加：
```
cursor
cursor-ai
java
spring-boot
mybatis-plus
coding-standards
best-practices
code-quality
restful-api
unit-testing
```

### 设置仓库描述

确保仓库描述完整显示：
```
🚀 Cursor AI 专用的 Java 开发规范集 | Java Development Rules for Cursor AI - Spring Boot, MyBatis-Plus, RESTful API, Unit Testing & More
```

### 启用 GitHub Pages（可选）

Settings -> Pages -> Source -> main branch -> Save

这样可以通过网页访问你的文档。

## 📢 分享给团队

创建完成后，团队成员可以这样使用：

```bash
# 克隆到本地
git clone https://github.com/YOUR_USERNAME/cursor-rules.git

# 复制到自己的项目
cp -r cursor-rules/*.mdc /your-project/.cursor/rules/

# 或者创建符号链接（推荐）
ln -s /path/to/cursor-rules/*.mdc /your-project/.cursor/rules/
```

## 🔄 后续更新

当规则文件有更新时：

```bash
cd cursor-rules-repo

# 修改文件后
git add .
git commit -m "feat: 更新规则文件"
git push origin main
```

## ❓ 常见问题

### Q: 推送时要求输入用户名密码？
A: GitHub 已不支持密码认证，需要使用 Personal Access Token (PAT)

生成 Token：
1. GitHub Settings -> Developer settings -> Personal access tokens -> Tokens (classic)
2. Generate new token
3. 选择 repo 权限
4. 复制 token
5. 推送时使用 token 作为密码

### Q: 推送被拒绝？
A: 确保远程仓库是空的，没有 README 等初始化文件

### Q: 文件太大无法推送？
A: 所有 .mdc 文件都很小，应该不会有问题。如果有，检查是否误添加了其他大文件。

---

## 🎉 完成！

按照以上步骤，你的 `cursor-rules` 仓库就创建完成了！

接下来你可以：
1. ⭐ Star 自己的仓库
2. 📢 分享给团队成员
3. 📝 继续完善规则文档
4. 🔄 定期更新和维护

---

**祝你编码愉快！Happy Coding with Cursor! 🚀**

