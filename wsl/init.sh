#!/bin/bash

# 方法1：使用网关 IP（推荐，适用于 NAT 网络模式）
WSL_HOST_IP=$(ip route | grep default | awk '{print $3}')

# 方法2（备选）：如果你的 WSL 确实是镜像网络模式或其他特殊情况，才用 resolv.conf
# 但根据之前的排查，你的 WSL 是 NAT 模式，所以用方法1更可靠。
# 如果你坚持要用 resolv.conf 的方式作为备选，可以取消下面这行的注释：
# WSL_HOST_IP=${WSL_HOST_IP:-$(cat /etc/resolv.conf | grep -oP '(?<=nameserver\ ).*')}

# 检查是否成功获取到 IP
if [ -z "$WSL_HOST_IP" ]; then
    echo "错误：无法获取宿主机 IP 地址"
    exit 1
fi

# 用 sudo 修改 /etc/hosts
# 先删除已有的 win.local 条目（不管它在哪一行）
sudo sed -i '/win\.local/d' /etc/hosts
# 再添加新条目
echo "$WSL_HOST_IP win.local" | sudo tee -a /etc/hosts > /dev/null

echo "已将 win.local 映射到 $WSL_HOST_IP"
