# 在 hosts 中添加 win.local 表示宿主机，方便 wsl 访问宿主机网络
WSL_HOST_IP=$(cat /etc/resolv.conf |grep -oP '(?<=nameserver\ ).*')
sed -i "\:win\.local:d" /etc/hosts
echo "$WSL_HOST_IP win.local" >> /etc/hosts
