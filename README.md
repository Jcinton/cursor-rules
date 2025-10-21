# Cursor Rules - Java/Python 开发规范集

> 🚀 为 Cursor AI 量身定制的开发规范文档集合

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

## 📖 简介

这是一套专门为 **Cursor AI 编辑器**设计的开发规范文档集。通过这些 `.mdc` 规则文件,可以让 Cursor AI 按照统一的编码规范生成高质量的代码。

适合:
- ✅ Java 后端开发团队
- ✅ Spring Boot 项目
- ✅ 使用 MyBatis-Plus 的项目
- ✅ RESTful API 开发
- ✅ Python Flask 项目
- ✅ 需要规范代码质量的团队

## 📁 规则文件列表

### Java 开发规范

| 文件 | 说明 | 适用场景 |
|------|------|----------|
| [general-java-development-practices.mdc](./general-java-development-practices.mdc) | Java 通用开发实践 | SOLID、DRY、KISS、YAGNI 原则,OWASP 安全指南 |
| [spring-boot-configuration.mdc](./spring-boot-configuration.mdc) | Spring Boot 配置规范 | RestController、Service、Mapper、DTO 设计 |
| [dto-conventions.mdc](./dto-conventions.mdc) | DTO 规范 | 数据传输对象设计,Lombok 使用,参数验证 |
| [entity-class-conventions.mdc](./entity-class-conventions.mdc) | 实体类规范 | MyBatis-Plus 注解,ID 生成策略,数据库映射 |
| [service-class-conventions.mdc](./service-class-conventions.mdc) | Service 层规范 | 接口设计,ServiceImpl 实现,事务管理 |
| [mapper-class-conventions.mdc](./mapper-class-conventions.mdc) | Mapper 层规范 | BaseMapper 使用,注解 SQL,XML 映射 |
| [restcontroller-conventions.mdc](./restcontroller-conventions.mdc) | RestController 规范 | API 路由,HTTP 方法,错误处理 |
| [mybatis-plus-configuration.mdc](./mybatis-plus-configuration.mdc) | MyBatis-Plus 配置 | 常用配置,插件配置,高级特性 |

### 测试规范

| 文件 | 说明 | 适用场景 |
|------|------|----------|
| [java-unit-testing.mdc](./java-unit-testing.mdc) | 单元测试规范 | JUnit 5、Mockito、AssertJ |
| [java-integration-testing.mdc](./java-integration-testing.mdc) | 集成测试规范 | 数据库测试、API 测试、Spring Boot 测试 |
| [spring-boot-testing.mdc](./spring-boot-testing.mdc) | Spring Boot 测试 | 各层测试策略和技巧 |

### Git 工作流规范

| 文件 | 说明 | 适用场景 |
|------|------|----------|
| [gitflow.mdc](./gitflow.mdc) | Gitflow 工作流 | 分支管理,Git 操作规范 |

### Python 开发规范

| 文件 | 说明 | 适用场景 |
|------|------|----------|
| [python.mdc](./python.mdc) | Python 开发实践 | Flask、SQLite、现代开发模式 |

## 🚀 快速开始

### 方法一:Git 子模块方式(推荐)⭐

这是最优雅的方式,可以让规则始终保持最新,团队成员自动同步。

#### 1. 在你的项目中安装

```bash
# 在项目根目录执行
cd /path/to/your/project

# 方式 1: 使用在线安装脚本(推荐,仅公开仓库可用)
bash <(curl -fsSL https://raw.githubusercontent.com/Jcinton/cursor-rules/main/install.sh)

# 方式 2: 手动安装(SSH 方式,支持私有仓库)⭐
git submodule add git@github.com:Jcinton/cursor-rules.git .cursor/rules
git submodule update --init --recursive
```

#### 2. 更新规则到最新版本

```bash
# 方式 1: 使用更新脚本(推荐)
bash .cursor/rules/update-rules.sh

# 方式 2: 手动更新
cd .cursor/rules && git pull && cd ../..
```

#### 3. 团队成员克隆项目后

```bash
# 克隆项目并初始化子模块
git clone --recurse-submodules <your-project-repo>
cd <your-project>

# 或者如果已经克隆
git submodule update --init --recursive
```

#### 4. 删除规则子模块(如果需要)

```bash
git submodule deinit -f .cursor/rules
git rm -f .cursor/rules
rm -rf .git/modules/.cursor/rules
```

### 方法二:直接复制(简单但不推荐)

```bash
# 克隆仓库
git clone git@github.com:Jcinton/cursor-rules.git

# 复制规则文件到你的项目
mkdir -p /your-project/.cursor/rules
cp -r cursor-rules/*.mdc /your-project/.cursor/rules/
```

**⚠️ 注意**: 直接复制方式无法自动更新规则,需要手动同步。

## 📚 在 Cursor 中使用

### 方式 1: 自动应用(推荐)
所有标记为 `alwaysApply: true` 的规则会自动生效,无需任何操作。

### 方式 2: 手动引用
在与 Cursor AI 对话时,使用 `@` 符号引用特定规则:

```
@gitflow.mdc 请根据 Gitflow 规范创建一个 feature 分支
@dto-conventions.mdc 创建一个用户注册 DTO
@restcontroller-conventions.mdc 创建一个用户管理 Controller
```

## 💡 使用示例

### 创建 CRUD Controller
```
根据规范创建一个 UserController,包含完整的 CRUD 操作
```

### 数据库查询
```
使用 MyBatis-Plus 实现用户分页查询,支持按用户名模糊搜索
```

### 编写单元测试
```
为 UserService.createUser 方法生成完整的单元测试
```

### 创建 DTO
```
创建一个用户注册 DTO,包含用户名、密码、邮箱字段,需要参数验证
```

## 🔧 自定义规则

### 修改现有规则
直接编辑对应的 `.mdc` 文件即可。

### 添加新规则
创建新的 `.mdc` 文件:

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
将 `alwaysApply` 改为 `false`:

```markdown
---
alwaysApply: false
---
```

## 🤝 贡献

欢迎提交 Pull Request 来完善规则!

### 贡献指南
1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/amazing-rule`)
3. 提交更改 (`git commit -m 'feat: 添加新规则'`)
4. 推送到分支 (`git push origin feature/amazing-rule`)
5. 创建 Pull Request

## 💡 最佳实践

1. **使用 Git 子模块管理规则(推荐)**
   - ✅ 规则自动同步,始终保持最新
   - ✅ 团队成员克隆项目后自动拥有规则
   - ✅ 统一管理,避免版本不一致
   - ✅ 可以随时更新和回滚规则版本

2. **团队统一使用**
   - 所有团队成员使用相同的规则文件
   - 定期更新和完善规则
   - 将规则配置加入版本控制

3. **持续改进**
   - 根据团队实际情况调整规则
   - 定期 Review 和优化规则
   - 收集团队反馈

## ⚠️ 注意事项

1. **子模块方式**(推荐):
   - ✅ 规则文件会自动放在 `.cursor/rules/` 目录下
   - ✅ 使用 `git submodule update` 初始化子模块
   - ✅ 使用 `update-rules.sh` 或 `git pull` 更新规则
   - ⚠️ 不要直接修改 `.cursor/rules/` 中的文件(这是子模块)

2. **直接复制方式**:
   - 规则文件必须放在 `.cursor/rules/` 目录下
   - 可以直接修改规则文件
   - ⚠️ 需要手动同步更新

3. **通用注意事项**:
   - `alwaysApply: true` 的规则会自动生效
   - 修改规则后,Cursor 会自动识别更新
   - `.cursor/rules/` 目录建议加入 `.gitignore`(如果使用子模块)

## 📄 License

MIT License

---

**Happy Coding with Cursor! 🚀**

