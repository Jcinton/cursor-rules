#!/bin/bash

# Cursor Rules 自动安装脚本
# 用途：将本规则仓库作为子模块添加到目标项目
# 使用方法：在目标项目根目录执行此脚本

set -e

echo "🚀 开始安装 Cursor 规则..."
echo ""

# 获取当前工作目录（应该是目标项目的根目录）
PROJECT_ROOT=$(pwd)
RULES_DIR="$PROJECT_ROOT/.cursor/rules"
REPO_URL="https://github.com/Jcinton/cursor-rules.git"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检查是否在 Git 仓库中
if [ ! -d "$PROJECT_ROOT/.git" ]; then
    echo -e "${RED}❌ 错误：当前目录不是 Git 仓库${NC}"
    echo "请在项目根目录（包含 .git 目录）下运行此脚本"
    exit 1
fi

echo "📍 当前项目路径: $PROJECT_ROOT"
echo ""

# 检查是否已经添加子模块
if [ -d "$RULES_DIR" ]; then
    echo -e "${YELLOW}⚠️  .cursor/rules 目录已存在${NC}"
    
    # 检查是否是子模块
    if git submodule status .cursor/rules > /dev/null 2>&1; then
        echo "检测到已存在的子模块，尝试更新..."
        cd "$RULES_DIR"
        git pull origin main
        cd "$PROJECT_ROOT"
        echo -e "${GREEN}✅ 子模块已更新到最新版本！${NC}"
        exit 0
    fi
    
    # 询问是否删除并重新安装
    read -p "是否删除并重新安装？(y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$RULES_DIR"
        echo "已删除旧目录"
    else
        echo "取消安装"
        exit 0
    fi
fi

# 创建 .cursor 目录
mkdir -p .cursor

# 添加子模块
echo "📦 添加 cursor-rules 子模块..."
if git submodule add "$REPO_URL" .cursor/rules; then
    echo -e "${GREEN}✅ 子模块添加成功${NC}"
else
    echo -e "${RED}❌ 子模块添加失败${NC}"
    exit 1
fi

# 初始化子模块
echo ""
echo "🔄 初始化子模块..."
git submodule update --init --recursive

echo ""
echo -e "${GREEN}✅ 安装完成！${NC}"
echo ""
echo "📝 规则文件列表："
ls -1 "$RULES_DIR"/*.mdc 2>/dev/null || echo "  (暂无 .mdc 文件)"

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo "💡 使用提示："
echo ""
echo "  📌 更新规则到最新版本："
echo "     cd .cursor/rules && git pull && cd ../.."
echo ""
echo "  📌 或使用快捷脚本（如果存在）："
echo "     bash .cursor/rules/update-rules.sh"
echo ""
echo "  📌 团队成员克隆项目后，需要初始化子模块："
echo "     git submodule update --init --recursive"
echo ""
echo "  📌 删除规则子模块："
echo "     git submodule deinit -f .cursor/rules"
echo "     git rm -f .cursor/rules"
echo "     rm -rf .git/modules/.cursor/rules"
echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

