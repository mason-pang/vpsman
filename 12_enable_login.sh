#!/bin/bash

# 检查是否以root用户运行
if [ "$(id -u)" != "0" ]; then
   echo "此脚本必须以root用户身份运行" 1>&2
   exit 1
fi

# 检查当前root登录状态
current_status=$(grep "^PermitRootLogin" /etc/ssh/sshd_config | awk '{print $2}')
if [ -z "$current_status" ]; then
    current_status="yes" # 如果没有设置，默认是允许的
fi

echo "当前root登录状态: $current_status"
echo "请选择操作："
echo "1. 禁止root登录"
echo "2. 允许root登录"
echo "3. 退出"

read -p "请输入选项 (1-3): " choice

case $choice in
    1)
        # 禁止root登录
        sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
        if ! grep -q "^PermitRootLogin" /etc/ssh/sshd_config; then
            echo "PermitRootLogin no" >> /etc/ssh/sshd_config
        fi
        echo "已禁止root登录"
        ;;
    2)
        # 允许root登录
        sed -i 's/^#*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
        if ! grep -q "^PermitRootLogin" /etc/ssh/sshd_config; then
            echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
        fi
        echo "已允许root登录"
        ;;
    3)
        echo "退出脚本"
        exit 0
        ;;
    *)
        echo "无效的选项"
        exit 1
        ;;
esac

# 重启SSH服务以应用更改
systemctl restart sshd

# 验证更改
new_status=$(grep "^PermitRootLogin" /etc/ssh/sshd_config | awk '{print $2}')
echo "更改后的root登录状态: $new_status"
echo "SSH服务已重启，更改已生效"

# 安全提醒
if [ "$choice" = "2" ]; then
    echo "警告：允许root直接登录可能存在安全风险"
    echo "建议使用普通用户登录，需要时使用sudo获取root权限"
fi