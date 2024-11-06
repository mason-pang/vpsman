#!/bin/bash

# 检查是否以root用户运行
if [ "$(id -u)" != "0" ]; then
   echo "此脚本必须以root用户身份运行" 1>&2
   exit 1
fi

# 修改密码
while true; do
    # 获取新密码
    read -s -p "请输入新的root密码: " NEW_PASSWORD
    echo
    
    # 检查密码长度
    if [ ${#NEW_PASSWORD} -lt 8 ]; then
        echo "错误：密码长度必须至少为8个字符"
        continue
    fi
    
    # 确认密码
    read -s -p "请再次输入密码确认: " PASSWORD_CONFIRM
    echo
    
    if [ "$NEW_PASSWORD" = "$PASSWORD_CONFIRM" ]; then
        # 使用chpasswd更改密码
        echo "root:$NEW_PASSWORD" | chpasswd
        
        if [ $? -eq 0 ]; then
            echo "root密码修改成功！"
        else
            echo "密码修改失败，请重试"
        fi
        break
    else
        echo "密码不匹配，请重试"
    fi
done