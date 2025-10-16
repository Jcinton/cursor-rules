@echo off
chcp 65001 >nul
echo ========================================
echo  上传 Cursor Rules 到 GitHub
echo ========================================
echo.

:input_username
set /p GITHUB_USERNAME="请输入你的 GitHub 用户名: "
if "%GITHUB_USERNAME%"=="" (
    echo 用户名不能为空！
    goto input_username
)

echo.
echo 正在配置远程仓库...
git remote remove origin 2>nul
git remote add origin https://github.com/%GITHUB_USERNAME%/cursor-rules.git

echo.
echo 设置主分支为 main...
git branch -M main

echo.
echo 准备推送到 GitHub...
echo 如果这是第一次推送，你需要：
echo 1. 先在 GitHub 上创建名为 cursor-rules 的空仓库（公开）
echo 2. 不要勾选任何初始化选项
echo.
pause

echo.
echo 正在推送代码...
git push -u origin main

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo  ✅ 上传成功！
    echo ========================================
    echo.
    echo 仓库地址: https://github.com/%GITHUB_USERNAME%/cursor-rules
    echo.
    echo 接下来你可以：
    echo 1. 访问仓库查看内容
    echo 2. 添加 Topics 标签（cursor, java, spring-boot 等）
    echo 3. 分享给团队成员
    echo.
) else (
    echo.
    echo ========================================
    echo  ❌ 推送失败！
    echo ========================================
    echo.
    echo 可能的原因：
    echo 1. 远程仓库不存在 - 请先在 GitHub 上创建 cursor-rules 仓库
    echo 2. 需要认证 - 使用 Personal Access Token 而不是密码
    echo 3. 网络问题 - 检查网络连接
    echo.
    echo 请查看 UPLOAD_GUIDE.md 获取详细步骤
    echo.
)

pause

