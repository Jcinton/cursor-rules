#!/bin/bash

# Cursor Rules 更新脚本
# 用途：更新 .cursor/rules 子模块到最新版本
# 使用方法：在项目根目录执行此脚本

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 获取当前工作目录
PROJECT_ROOT=$(pwd)
RULES_DIR="$PROJECT_ROOT/.cursor/rules"

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}🔄 更新 Cursor 规则${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# 检查是否在 Git 仓库中
if [ ! -d "$PROJECT_ROOT/.git" ]; then
    echo -e "${RED}❌ 错误：当前目录不是 Git 仓库${NC}"
    exit 1
fi

# 检查子模块是否存在
if [ ! -d "$RULES_DIR" ]; then
    echo -e "${RED}❌ 错误：.cursor/rules 目录不存在${NC}"
    echo "请先运行安装脚本："
    echo "  bash <(curl -fsSL https://raw.githubusercontent.com/Jcinton/cursor-rules/main/install.sh)"
    exit 1
fi

# 检查是否是子模块
if ! git submodule status .cursor/rules > /dev/null 2>&1; then
    echo -e "${RED}❌ 错误：.cursor/rules 不是子模块${NC}"
    echo "请删除该目录后重新安装"
    exit 1
fi

# 显示当前版本信息
echo "📍 当前版本信息："
cd "$RULES_DIR"
CURRENT_COMMIT=$(git rev-parse --short HEAD)
CURRENT_DATE=$(git log -1 --format=%cd --date=format:'%Y-%m-%d %H:%M:%S')
echo "  提交: $CURRENT_COMMIT"
echo "  日期: $CURRENT_DATE"
echo ""

# 拉取最新更新
echo "🔄 正在拉取最新更新..."
if git pull origin main; then
    echo -e "${GREEN}✅ 更新成功${NC}"
else
    echo -e "${RED}❌ 更新失败${NC}"
    cd "$PROJECT_ROOT"
    exit 1
fi

# 显示更新后的版本信息
NEW_COMMIT=$(git rev-parse --short HEAD)
NEW_DATE=$(git log -1 --format=%cd --date=format:'%Y-%m-%d %H:%M:%S')
echo ""
echo "📍 更新后版本信息："
echo "  提交: $NEW_COMMIT"
echo "  日期: $NEW_DATE"
echo ""

# 显示变更内容
if [ "$CURRENT_COMMIT" != "$NEW_COMMIT" ]; then
    echo -e "${YELLOW}📝 更新内容：${NC}"
    git log --oneline "$CURRENT_COMMIT..$NEW_COMMIT" | head -n 5
    echo ""
fi

cd "$PROJECT_ROOT"

# 列出规则文件
echo "📝 当前规则文件列表："
echo ""
echo "Java 开发规范:"
ls -1 "$RULES_DIR"/general-java-development-practices.mdc \
     "$RULES_DIR"/spring-boot-configuration.mdc \
     "$RULES_DIR"/dto-conventions.mdc \
     "$RULES_DIR"/entity-class-conventions.mdc \
     "$RULES_DIR"/service-class-conventions.mdc \
     "$RULES_DIR"/mapper-class-conventions.mdc \
     "$RULES_DIR"/restcontroller-conventions.mdc \
     "$RULES_DIR"/mybatis-plus-configuration.mdc 2>/dev/null | xargs -n 1 basename || true

echo ""
echo "测试规范:"
ls -1 "$RULES_DIR"/java-unit-testing.mdc \
     "$RULES_DIR"/java-integration-testing.mdc \
     "$RULES_DIR"/spring-boot-testing.mdc 2>/dev/null | xargs -n 1 basename || true

echo ""
echo "Git 工作流:"
ls -1 "$RULES_DIR"/gitflow.mdc 2>/dev/null | xargs -n 1 basename || true

echo ""
echo "Python 开发规范:"
ls -1 "$RULES_DIR"/python.mdc 2>/dev/null | xargs -n 1 basename || true

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ 规则更新完成！${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

