# Cursor Rules - Java 开发规范集

> 🚀 为 Cursor AI 量身定制的 Java 开发规范文档集合

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

## 📖 简介

这是一套专门为 **Cursor AI 编辑器**设计的 Java 开发规范文档集。通过这些 `.mdc` 规则文件，可以让 Cursor AI 按照统一的编码规范生成高质量的 Java 代码。

适合：
- ✅ Java 后端开发团队
- ✅ Spring Boot 项目
- ✅ 使用 MyBatis-Plus 的项目
- ✅ RESTful API 开发
- ✅ 需要规范代码质量的团队

## 📁 规则文件列表

### 核心规则 (alwaysApply: true)

| 文件 | 说明 | 适用场景 |
|------|------|----------|
| [code-quality.mdc](./code-quality.mdc) | 代码质量规范 | 代码格式、注释、异常处理、性能优化 |
| [java.mdc](./java.mdc) | Java 基础规范 | 命名规范、Lombok 使用、日志规范 |
| [spring-boot.mdc](./spring-boot.mdc) | Spring Boot 规范 | 项目结构、三层架构、依赖注入 |
| [mybatis-plus.mdc](./mybatis-plus.mdc) | MyBatis-Plus 规范 | 实体类、Mapper、条件构造器 |
| [unit-test.mdc](./unit-test.mdc) | 单元测试规范 | JUnit 5、Mockito、测试模板 |

### 按需引用规则 (alwaysApply: false)

| 文件 | 说明 | 适用场景 |
|------|------|----------|
| [api-design.mdc](./api-design.mdc) | RESTful API 设计 | URL 规范、HTTP 方法、响应格式 |
| [git-workflow.mdc](./git-workflow.mdc) | Git 工作流规范 | 分支管理、Commit 规范、协作流程 |

## 🚀 快速开始

### 方法一：Git 子模块方式（推荐）⭐

这是最优雅的方式，可以让规则始终保持最新，团队成员自动同步。

#### 1. 在你的项目中安装

```bash
# 在项目根目录执行
cd /path/to/your/project

# 方式 1: 使用在线安装脚本（推荐）
bash <(curl -fsSL https://raw.githubusercontent.com/Jcinton/cursor-rules/main/install.sh)

# 方式 2: 手动安装
git submodule add git@github.com:Jcinton/cursor-rules.git .cursor/rules
git submodule update --init --recursive
```

#### 2. 更新规则到最新版本

```bash
# 方式 1: 使用更新脚本（推荐）
bash .cursor/rules/update-rules.sh

# 方式 2: 手动更新
cd .cursor/rules && git pull && cd ../..
```

#### 3. 团队成员克隆项目后

```bash
# 克隆项目并初始化子模块
git clone <your-project-repo>
cd <your-project>
git submodule update --init --recursive
```

#### 4. 删除规则子模块（如果需要）

```bash
git submodule deinit -f .cursor/rules
git rm -f .cursor/rules
rm -rf .git/modules/.cursor/rules
```

### 方法二：直接复制（简单但不推荐）

```bash
# 克隆仓库
git clone git@github.com:Jcinton/cursor-rules.git

# 复制规则文件到你的项目
mkdir -p /your-project/.cursor
cp -r cursor-rules/*.mdc /your-project/.cursor/rules/
```

**⚠️ 注意**: 直接复制方式无法自动更新规则，需要手动同步。

### 在 Cursor 中使用

#### 方式 1: 自动应用（推荐）
所有标记为 `alwaysApply: true` 的规则会自动生效，无需任何操作。

#### 方式 2: 手动引用
在与 Cursor AI 对话时，使用 `@` 符号引用特定规则：

```
@api-design.mdc 请根据 RESTful 规范创建一个用户管理接口
@git-workflow.mdc 告诉我如何创建一个 feature 分支
```

### 3. 使用示例

**创建 CRUD Controller**:
```
根据规范创建一个 UserController，包含完整的 CRUD 操作
```

**数据库查询**:
```
使用 MyBatis-Plus 实现用户分页查询，支持按用户名模糊搜索
```

**编写单元测试**:
```
为 UserService.createUser 方法生成完整的单元测试
```

## 📚 规则文件说明

### code-quality.mdc - 代码质量规范

包含内容：
- ✅ 代码格式规范（缩进、空格、大括号）
- ✅ 注释规范（类注释、方法注释）
- ✅ 异常处理最佳实践
- ✅ 空值处理（Optional、判空）
- ✅ 集合操作（Stream API）
- ✅ 资源关闭（try-with-resources）
- ✅ 常量使用（避免魔法值）
- ✅ 方法设计原则
- ✅ 日志规范
- ✅ 性能优化建议

### java.mdc - Java 基础规范

包含内容：
- ✅ 命名规范（类、方法、变量、常量）
- ✅ 代码格式规范
- ✅ Lombok 使用规范
- ✅ 构造器注入
- ✅ 异常处理
- ✅ 日志规范
- ✅ Spring Boot 基本规范

### spring-boot.mdc - Spring Boot 开发规范

包含内容：
- ✅ 项目结构规范
- ✅ Controller 层规范
- ✅ Service 层规范
- ✅ 配置管理规范
- ✅ 统一响应格式
- ✅ 全局异常处理
- ✅ 依赖注入规范
- ✅ 事务管理规范
- ✅ 日志规范
- ✅ API 设计规范

### mybatis-plus.mdc - MyBatis-Plus 使用规范

包含内容：
- ✅ 实体类注解规范
- ✅ Mapper 接口规范
- ✅ Service 层规范
- ✅ LambdaQueryWrapper 使用
- ✅ 分页查询规范
- ✅ 批量操作规范
- ✅ 逻辑删除配置
- ✅ 自动填充配置
- ✅ 代码生成器使用

### unit-test.mdc - 单元测试规范

包含内容：
- ✅ JUnit 5 + Mockito 使用规范
- ✅ Controller/Service/Mapper 测试模板
- ✅ AAA/Given-When-Then 模式
- ✅ 断言（JUnit & AssertJ）
- ✅ Mock 使用规范
- ✅ MockMvc 使用
- ✅ 测试数据准备
- ✅ 测试覆盖场景
- ✅ 测试最佳实践

### api-design.mdc - RESTful API 设计规范

包含内容：
- ✅ URL 设计规范
- ✅ HTTP 方法使用规范
- ✅ 状态码使用规范
- ✅ 统一响应格式
- ✅ 分页查询规范
- ✅ 参数校验规范
- ✅ JWT 认证规范
- ✅ 错误处理规范
- ✅ API 文档规范（Knife4j）

### git-workflow.mdc - Git 工作流规范

包含内容：
- ✅ 分支管理规范
- ✅ Commit 消息规范
- ✅ Git 工作流程
- ✅ 常用 Git 命令
- ✅ Git 配置
- ✅ 协作规范
- ✅ Pull Request 规范
- ✅ Code Review 规范
- ✅ 版本号规范

## 🎯 使用场景

### 场景 1: 新项目开发
```
1. 将规则文件复制到项目 .cursor/rules/ 目录
2. 开始编码，Cursor AI 会自动应用规范
3. 享受高质量代码！
```

### 场景 2: 代码审查
```
提示词: 请审查以下代码是否符合规范

AI 会根据所有规则检查：
- 命名规范
- 代码格式
- 异常处理
- 日志使用
- 性能问题
```

### 场景 3: 代码重构
```
提示词: 请根据代码质量规则重构这段代码

AI 会应用：
- code-quality.mdc
- java.mdc
- 相关框架规范
```

### 场景 4: 生成测试代码
```
提示词: 为 UserService.createUser 方法生成完整的单元测试

AI 会应用 unit-test.mdc，生成：
- 正常流程测试
- 边界条件测试
- 异常情况测试
- Mock 配置
```

## 🔧 自定义规则

### 修改现有规则
直接编辑对应的 `.mdc` 文件即可。

### 添加新规则
创建新的 `.mdc` 文件：

```markdown
---
alwaysApply: true
globs: .java
---

# 你的规则标题

## 规则内容
...
```

### 禁用某个规则
将 `alwaysApply` 改为 `false`：

```markdown
---
alwaysApply: false
---
```

## 📖 相关文档

- [Cursor 官方文档](https://cursor.sh/docs)
- [.mdc 文件格式说明](./docs/mdc-format.md)
- [规则编写指南](./docs/writing-rules.md)

## 🤝 贡献

欢迎提交 Pull Request 来完善规则！

### 贡献指南
1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/amazing-rule`)
3. 提交更改 (`git commit -m 'feat: 添加新规则'`)
4. 推送到分支 (`git push origin feature/amazing-rule`)
5. 创建 Pull Request

### 贡献者

感谢所有为本项目做出贡献的开发者！

## 📊 规则覆盖范围

### 命名规范 ✅
- 类名、方法名、变量名
- 常量、包名
- 数据库表名、字段名

### 代码结构 ✅
- 项目分层结构
- Controller/Service/Mapper 规范
- 包结构规范

### 编码规范 ✅
- 代码格式、注释
- 异常处理、日志
- 资源管理

### 框架使用 ✅
- Spring Boot 最佳实践
- MyBatis-Plus 使用规范
- 依赖注入、事务管理

### API 设计 ✅
- RESTful 规范
- URL 设计、HTTP 方法
- 响应格式、错误处理

### 代码质量 ✅
- 空值处理、集合操作
- 性能优化、代码复用
- 最佳实践

### Git 协作 ✅
- 分支管理、Commit 规范
- Pull Request、Code Review
- 版本控制

## 💡 最佳实践

1. **使用 Git 子模块管理规则（推荐）**
   - ✅ 规则自动同步，始终保持最新
   - ✅ 团队成员克隆项目后自动拥有规则
   - ✅ 统一管理，避免版本不一致
   - ✅ 可以随时更新和回滚规则版本

2. **团队统一使用**
   - 所有团队成员使用相同的规则文件
   - 定期更新和完善规则
   - 将规则配置加入版本控制

3. **持续改进**
   - 根据团队实际情况调整规则
   - 定期 Review 和优化规则
   - 收集团队反馈

4. **新人培训**
   - 新人入职时学习规则文档
   - 结合实际项目应用
   - 建立代码审查机制

## ⚠️ 注意事项

1. **子模块方式**（推荐）:
   - ✅ 规则文件会自动放在 `.cursor/rules/` 目录下
   - ✅ 使用 `git submodule update` 初始化子模块
   - ✅ 使用 `update-rules.sh` 或 `git pull` 更新规则
   - ⚠️ 不要直接修改 `.cursor/rules/` 中的文件（这是子模块）

2. **直接复制方式**:
   - 规则文件必须放在 `.cursor/rules/` 目录下
   - 可以直接修改规则文件
   - ⚠️ 需要手动同步更新

3. **通用注意事项**:
   - `alwaysApply: true` 的规则会自动生效
   - 修改规则后，Cursor 会自动识别更新
   - 不同规则可能有优先级，以 `code-quality.mdc` 为最高优先级
   - `.cursor/rules/` 目录建议加入 `.gitignore`（如果使用子模块）

## 🎓 学习路径

**新手**:
1. 先阅读 `java.mdc`
2. 理解 `spring-boot.mdc`
3. 学习 `mybatis-plus.mdc`

**进阶**:
1. 深入 `api-design.mdc`
2. 掌握 `code-quality.mdc`
3. 学习 `unit-test.mdc`

**专家**:
1. 掌握 `git-workflow.mdc`
2. 自定义团队规则
3. 优化现有规范

## 📄 License

MIT License - 详见 [LICENSE](LICENSE) 文件

## 🌟 Star History

如果这个项目对你有帮助，请给个 Star ⭐️

## 📞 联系方式

- Issues: [GitHub Issues](https://github.com/yourusername/cursor-rules/issues)
- Discussions: [GitHub Discussions](https://github.com/yourusername/cursor-rules/discussions)

---

**最后更新**: 2024-01-16  
**维护者**: 开发团队  
**版本**: 1.0.0

**Happy Coding with Cursor! 🚀**

