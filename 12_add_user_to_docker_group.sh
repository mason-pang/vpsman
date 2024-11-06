#!/bin/bash

# 检查是否以root用户运行
if [ "$(id -u)" != "0" ]; then
   echo "此脚本必须以root用户身份运行" 1>&2
   exit 1
fi

# 获取可登录的用户列表（排除系统用户）
users=($(grep -v '/usr/sbin/nologin\|/bin/false' /etc/passwd | cut -d: -f1))

# 检查是否有可用用户
if [ ${#users[@]} -eq 0 ]; then
    echo "没有找到可用的用户"
    exit 1
fi

# 确保docker组存在
groupadd -f docker

# 显示用户列表
echo "可用用户列表："
for i in "${!users[@]}"; do
    echo "[$i] ${users[$i]}"
done

# 用户选择
while true; do
    read -p "请选择要添加到docker组的用户编号 (0-$((${#users[@]}-1))): " choice
    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 0 ] && [ "$choice" -lt "${#users[@]}" ]; then
        selected_user="${users[$choice]}"
        break
    else
        echo "无效的选择，请重试"
    fi
done

# 添加用户到docker组
usermod -aG docker "$selected_user"

# 验证
if groups "$selected_user" | grep -q docker; then
    echo "用户 $selected_user 已成功添加到docker组"
    echo "请注意："
    echo "1. 用户需要注销并重新登录才能使用docker命令"
    echo "2. 或者执行 'newgrp docker' 命令立即生效"
else
    echo "添加用户到docker组失败"
fi

# 检查docker服务状态
if ! systemctl is-active --quiet docker; then
    echo "警告：docker服务未运行"
    echo "正在启动docker服务..."
    systemctl start docker
    systemctl enable docker
fi

# 显示docker版本和服务状态
docker --version
systemctl status docker --no-pager