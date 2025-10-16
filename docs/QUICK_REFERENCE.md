# Cursor Rules 快速参考卡片

> 📋 Java 开发规范速查表

## 🎯 规则文件速览

| 文件 | 大小 | 主要内容 | 使用场景 |
|------|------|---------|---------|
| **java.mdc** | 2KB | Java 核心规范 | 所有 Java 代码 |
| **spring-boot.mdc** | 7KB | Spring Boot 规范 | Spring Boot 项目 |
| **mybatis-plus.mdc** | 8.5KB | MyBatis-Plus 规范 | 数据库操作 |
| **api-design.mdc** | 10KB | RESTful API 规范 | 接口设计 |
| **code-quality.mdc** | 9.5KB | 代码质量规范 | 代码审查 |
| **unit-test.mdc** | 18KB | 单元测试规范 | 测试编写 |

**总大小**: ~62KB  
**规则数量**: 6 个核心规则文件

---

## 🚀 快速开始

### 规则已自动生效

所有规则文件都标记为 `alwaysApply: true`，Cursor AI 会自动应用这些规则。

### 无需手动引用

只需要正常编写代码，AI 会自动：
- ✅ 提供符合规范的代码建议
- ✅ 检查代码是否符合规范
- ✅ 在重构时应用最佳实践

---

## 💡 常用提示词

### 创建代码
```
创建一个用户管理的 Controller
实现用户分页查询功能
生成完整的 CRUD 接口
```

### 代码审查
```
请审查这段代码是否符合规范
检查代码质量
帮我优化这段代码
```

### 重构代码
```
根据规范重构这段代码
优化这个方法
简化这段逻辑
```

---

## 📋 核心规范速查

### 命名规范

| 类型 | 规范 | 示例 |
|------|------|------|
| 类名 | PascalCase | `UserService` |
| 方法名 | camelCase | `getUserById()` |
| 变量名 | camelCase | `userName` |
| 常量名 | UPPER_SNAKE_CASE | `MAX_SIZE` |

### Controller 标准模板

```java
@RestController
@RequestMapping("/api/v1/users")
@RequiredArgsConstructor
@Slf4j
public class UserController {
    private final UserService userService;
    
    @PostMapping
    public Result<UserVO> create(@Valid @RequestBody UserCreateDTO dto) {
        return Result.success(userService.create(dto));
    }
}
```

### Service 标准模板

```java
@Service
@RequiredArgsConstructor
@Slf4j
public class UserServiceImpl implements UserService {
    private final UserMapper userMapper;
    
    @Override
    @Transactional(rollbackFor = Exception.class)
    public UserVO create(UserCreateDTO dto) {
        // 业务逻辑
    }
}
```

### Mapper 标准模板

```java
@Mapper
public interface UserMapper extends BaseMapper<User> {
    // 自定义方法
}
```

### 统一响应格式

```json
{
  "code": 200,
  "message": "操作成功",
  "data": {...},
  "timestamp": 1642492800000
}
```

### RESTful URL 设计

```
GET    /api/v1/users          # 列表
GET    /api/v1/users/{id}     # 详情
POST   /api/v1/users          # 创建
PUT    /api/v1/users/{id}     # 更新
DELETE /api/v1/users/{id}     # 删除
```

### 分页查询参数

```java
@RequestParam(defaultValue = "1") Integer pageNum
@RequestParam(defaultValue = "10") Integer pageSize
@RequestParam(required = false) String keyword
```

### 条件查询（MyBatis-Plus）

```java
LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
wrapper.eq(User::getStatus, 1)
       .like(User::getUsername, keyword)
       .orderByDesc(User::getCreateTime);
```

### 异常处理

```java
// 抛出业务异常
throw new BusinessException("用户不存在");

// 全局异常处理
@RestControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(BusinessException.class)
    public Result<Void> handle(BusinessException e) {
        return Result.error(e.getCode(), e.getMessage());
    }
}
```

### 日志记录

```java
@Slf4j
public class UserService {
    public void example() {
        log.info("用户登录: username={}", username);
        log.error("操作失败: userId={}", userId, e);
    }
}
```

---

## 🎯 按场景查找规则

### 我要创建 Controller
👉 查看 `spring-boot.mdc` 的 Controller 规范  
👉 查看 `api-design.mdc` 的 RESTful 规范

### 我要写数据库查询
👉 查看 `mybatis-plus.mdc` 的 Wrapper 使用  
👉 查看 `spring-boot.mdc` 的 Service 规范

### 我要设计接口
👉 查看 `api-design.mdc` 的 URL 设计  
👉 查看 `api-design.mdc` 的响应格式

### 我要提升代码质量
👉 查看 `code-quality.mdc` 的所有规范  
👉 查看 `java.mdc` 的基础规范

### 我要编写单元测试
👉 查看 `unit-test.mdc` 的测试模板  
👉 查看 `unit-test.mdc` 的 Mock 使用

### 我要处理异常
👉 查看 `spring-boot.mdc` 的异常处理  
👉 查看 `code-quality.mdc` 的异常规范

---

## ⚡ 快捷操作

### 创建完整 CRUD 模块

**提示词**:
```
创建一个完整的用户管理模块，包括：
1. User 实体类
2. UserMapper 接口
3. UserService 接口和实现
4. UserController 控制器
要求遵循所有开发规范
```

### 生成标准 Controller

**提示词**:
```
根据规范创建 UserController，包含 CRUD 和分页查询
```

### 实现分页查询

**提示词**:
```
使用 MyBatis-Plus 实现用户分页查询，支持关键词搜索
```

### 添加参数校验

**提示词**:
```
为 UserCreateDTO 添加 Bean Validation 校验
```

### 生成单元测试

**提示词**:
```
为 UserService.createUser 方法生成完整的单元测试
要求包括正常流程、参数校验、异常处理
使用 Mockito 和 AssertJ
```

---

## 📊 代码质量检查清单

使用提示词：`请根据以下清单检查代码`

- [ ] 命名符合规范（类、方法、变量）
- [ ] 使用 Lombok 简化代码
- [ ] 使用构造器注入（@RequiredArgsConstructor）
- [ ] 方法有 Javadoc 注释
- [ ] 异常处理正确（不吞异常）
- [ ] 使用 Optional 处理可能为 null 的值
- [ ] 使用 Stream API 处理集合
- [ ] 日志记录关键操作
- [ ] 没有魔法值（使用常量）
- [ ] 统一使用 Result 返回
- [ ] RESTful URL 规范
- [ ] 参数使用 @Valid 校验
- [ ] 事务注解正确
- [ ] 没有 N+1 查询问题
- [ ] 核心方法有单元测试
- [ ] 测试覆盖率 ≥ 80%

---

## 🔧 自定义提示

如果规则不符合你的需求，可以在提示词中明确说明：

```
创建 UserController，但是不使用 Lombok
创建 UserService，使用字段注入而不是构造器注入
实现查询，使用原生 SQL 而不是 MyBatis-Plus
```

---

## 📚 详细文档

需要详细了解某个规范时：

```
查看 spring-boot.mdc 的详细内容
解释 mybatis-plus.mdc 中的分页查询
```

或直接打开对应的 `.mdc` 文件查看。

---

## 🎓 学习建议

### 第一天
- [ ] 阅读 `java.mdc`
- [ ] 尝试创建一个简单类

### 第一周
- [ ] 学习 `spring-boot.mdc`
- [ ] 创建 Controller/Service/Mapper

### 第二周
- [ ] 掌握 `mybatis-plus.mdc`
- [ ] 实现 CRUD 功能

### 第三周
- [ ] 熟悉 `api-design.mdc`
- [ ] 设计 RESTful 接口

### 第四周
- [ ] 应用 `code-quality.mdc`
- [ ] 提升代码质量

---

## ✨ 使用技巧

### 技巧 1：组合使用规则
```
根据 Spring Boot 和 API 设计规范，创建用户接口
```

### 技巧 2：明确需求
```
创建用户 Controller，要求：
1. RESTful 风格
2. 参数校验
3. 统一响应
4. 异常处理
```

### 技巧 3：逐步细化
```
第一步：创建 Controller 结构
第二步：添加 CRUD 方法
第三步：实现参数校验
第四步：优化代码质量
```

---

## 🎉 开始使用

**规则已生效** ✅  
**直接开始编码** 🚀  
**AI 会自动应用规范** 💡  
**享受高质量代码** 🎊

---

**文档版本**: 1.0.0  
**最后更新**: 2024-01-15  
**维护者**: 后端开发组

