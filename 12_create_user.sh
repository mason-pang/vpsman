#!/bin/bash

# 检查是否以root用户运行
if [ "$(id -u)" != "0" ]; then
   echo "此脚本必须以root用户身份运行" 1>&2
   exit 1
fi

# 交互式获取用户输入
while true; do
    read -p "请输入新用户名: " NEW_USER
    # 检查用户名是否合法（只允许字母、数字和下划线）
    if [[ ! $NEW_USER =~ ^[a-zA-Z0-9_]+$ ]]; then
        echo "错误：用户名只能包含字母、数字和下划线"
        continue
    fi
    # 检查用户是否已存在
    if id "$NEW_USER" >/dev/null 2>&1; then
        echo "错误：用户 $NEW_USER 已存在"
        continue
    fi
    break
done

# 获取并确认密码
while true; do
    read -s -p "请输入新用户密码: " NEW_PASSWORD
    echo
    read -s -p "请再次输入密码确认: " PASSWORD_CONFIRM
    echo
    if [ "$NEW_PASSWORD" = "$PASSWORD_CONFIRM" ]; then
        break
    else
        echo "密码不匹配，请重试"
    fi
done

# 创建新用户
useradd -m -s /bin/bash $NEW_USER

# 设置密码
echo "$NEW_USER:$NEW_PASSWORD" | chpasswd

# 将用户添加到sudo组（如果需要sudo权限）
usermod -aG sudo $NEW_USER

# 将用户添加到docker组（如果已安装docker）
if getent group docker >/dev/null 2>&1; then
    usermod -aG docker $NEW_USER
fi

echo "=== 用户创建完成 ==="
echo "用户名: $NEW_USER"
echo "用户已添加到sudo组和docker组（如果存在）"
echo "您可以使用以下命令切换到新用户："
echo "su - $NEW_USER"