# 故障排除指南

## 🔧 常见问题和解决方案

### 1. 安装脚本返回 404 错误

**问题现象**:
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Jcinton/cursor-rules/main/install.sh)
curl: (22) The requested URL returned error: 404
```

**原因**:
- GitHub 仓库是私有的，raw.githubusercontent.com 无法访问私有仓库文件
- 或者文件还未推送到远程仓库

**解决方案 1: 将 GitHub 仓库设置为公开（推荐）**

如果你是仓库所有者，并希望使用在线安装脚本：

1. 打开仓库设置页面：https://github.com/Jcinton/cursor-rules/settings
2. 滚动到页面底部的 "Danger Zone"
3. 点击 "Change repository visibility"
4. 选择 "Make public"
5. 确认操作

**⚠️ 注意**: 公开仓库后，所有人都能看到和使用你的规则。

**解决方案 2: 使用 SSH 方式手动安装**

如果仓库需要保持私有：

```bash
# 在项目根目录执行
cd /path/to/your/project

# 使用 SSH 方式添加子模块
git submodule add git@github.com:Jcinton/cursor-rules.git .cursor/rules

# 初始化子模块
git submodule update --init --recursive

# 验证安装
ls -la .cursor/rules/
```

**解决方案 3: 使用本地路径安装**

如果你在本地有规则仓库的副本：

```bash
# 在项目根目录执行
cd /path/to/your/project

# 使用本地路径添加子模块（修改为你的实际路径）
git submodule add /path/to/cursor-rules .cursor/rules

# 或者在 Windows WSL 中
git submodule add /mnt/e/code/cursor-rules .cursor/rules

# 初始化子模块
git submodule update --init --recursive
```

**解决方案 4: 直接复制文件（不推荐）**

如果不想使用 Git 子模块：

```bash
# 克隆规则仓库
git clone git@github.com:Jcinton/cursor-rules.git /tmp/cursor-rules

# 复制到项目中
mkdir -p /path/to/your/project/.cursor
cp -r /tmp/cursor-rules/*.mdc /path/to/your/project/.cursor/rules/

# 清理
rm -rf /tmp/cursor-rules
```

**⚠️ 缺点**: 无法自动更新规则，需要手动同步。

---

### 2. 子模块初始化失败

**问题现象**:
```bash
fatal: 'origin/main' is not a commit and a branch 'main' cannot be created from it
```

**解决方案**:
```bash
# 更新子模块引用
git submodule update --remote --merge

# 或者删除并重新添加
git submodule deinit -f .cursor/rules
git rm -f .cursor/rules
git submodule add git@github.com:Jcinton/cursor-rules.git .cursor/rules
git submodule update --init --recursive
```

---

### 3. 规则不生效

**问题现象**:
- 规则文件已安装，但 Cursor AI 没有按规范生成代码

**检查清单**:

1. **确认规则文件位置正确**:
   ```bash
   # 规则必须在以下位置
   ls -la .cursor/rules/*.mdc
   ```

2. **检查文件格式**:
   - 文件必须是 `.mdc` 扩展名
   - 文件内容必须包含正确的 YAML 头部：
     ```markdown
     ---
     alwaysApply: true
     globs: .java
     ---
     ```

3. **重启 Cursor**:
   - 关闭 Cursor 编辑器
   - 重新打开项目
   - 等待几秒让规则加载

4. **清除 Cursor 缓存**:
   - 关闭 Cursor
   - 删除缓存目录（位置取决于操作系统）
   - 重新打开 Cursor

5. **手动引用规则**:
   ```
   @code-quality.mdc 请根据代码质量规则重构这段代码
   ```

---

### 4. 团队成员克隆后没有规则文件

**问题现象**:
```bash
git clone <repo-url>
# .cursor/rules/ 目录为空
```

**原因**:
- 克隆时没有初始化子模块

**解决方案**:
```bash
# 方案 1: 克隆时自动初始化子模块（推荐）
git clone --recurse-submodules <repo-url>

# 方案 2: 克隆后手动初始化
git clone <repo-url>
cd <project>
git submodule update --init --recursive
```

**团队协作建议**:
在项目 README 中添加说明：
```markdown
## 克隆项目

**重要**: 本项目使用 Git 子模块管理 Cursor 规则，克隆时需要加上 `--recurse-submodules` 参数：

```bash
git clone --recurse-submodules <repo-url>
```

或者克隆后执行：
```bash
git submodule update --init --recursive
```
```

---

### 5. 更新规则失败

**问题现象**:
```bash
bash .cursor/rules/update-rules.sh
# 提示权限拒绝或找不到文件
```

**解决方案 1: 添加执行权限**:
```bash
chmod +x .cursor/rules/update-rules.sh
bash .cursor/rules/update-rules.sh
```

**解决方案 2: 手动更新**:
```bash
cd .cursor/rules
git pull origin main
cd ../..
```

**解决方案 3: 使用 Git 子模块命令**:
```bash
git submodule update --remote --merge
```

---

### 6. Windows 路径问题

**问题现象**:
- 在 Windows 上使用反斜杠路径失败
- WSL 路径转换错误

**解决方案**:
```bash
# Windows 路径转 WSL 路径
# E:\code\project -> /mnt/e/code/project
# C:\Users\name -> /mnt/c/Users/name

# 在 WSL 中执行命令
wsl cd /mnt/e/code/project
wsl git submodule add /mnt/e/code/cursor-rules .cursor/rules
```

---

### 7. 私有仓库认证问题

**问题现象**:
```bash
Permission denied (publickey)
```

**解决方案**:

1. **配置 SSH 密钥**:
   ```bash
   # 生成 SSH 密钥
   ssh-keygen -t ed25519 -C "your_email@example.com"
   
   # 添加到 SSH agent
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_ed25519
   
   # 复制公钥到剪贴板
   cat ~/.ssh/id_ed25519.pub
   ```

2. **添加到 GitHub**:
   - 打开 https://github.com/settings/keys
   - 点击 "New SSH key"
   - 粘贴公钥内容
   - 保存

3. **测试连接**:
   ```bash
   ssh -T git@github.com
   ```

---

### 8. 子模块冲突

**问题现象**:
```bash
fatal: A git directory for '.cursor/rules' is found locally
```

**解决方案**:
```bash
# 完全清理子模块
git submodule deinit -f .cursor/rules
git rm -f .cursor/rules
rm -rf .git/modules/.cursor/rules

# 重新添加
git submodule add git@github.com:Jcinton/cursor-rules.git .cursor/rules
git submodule update --init --recursive
```

---

## 📞 获取帮助

如果以上方案都无法解决你的问题，请：

1. **查看详细日志**:
   ```bash
   git submodule update --init --recursive --verbose
   ```

2. **检查 Git 配置**:
   ```bash
   git config --list | grep submodule
   ```

3. **提交 Issue**:
   - 访问: https://github.com/Jcinton/cursor-rules/issues
   - 附上错误信息和执行日志
   - 说明操作系统和 Git 版本

4. **查看讨论区**:
   - 访问: https://github.com/Jcinton/cursor-rules/discussions
   - 搜索类似问题
   - 发起新讨论

---

## 🔍 调试技巧

### 查看子模块状态
```bash
git submodule status
```

### 查看子模块配置
```bash
cat .gitmodules
```

### 强制更新子模块
```bash
git submodule update --init --recursive --force
```

### 查看规则文件
```bash
ls -la .cursor/rules/
cat .cursor/rules/java.mdc
```

---

**最后更新**: 2024-01-16

