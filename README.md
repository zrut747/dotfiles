## 描述

保存Linux系统下使用的配置文件

## 安装步骤

1. 克隆项目

```bash
git clone https://github.com/zrut747/dotfiles.git ~/.dotfiles
```

2. 执行bootstrap脚本

```bash
zsh ~/.dotfiles/bootstrap.sh
```

## 环境变量

修改环境变量可以修改一些初始化时的行为。

### DOT_GITHUB_MIRROR

修改下载插件时使用的 Github 地址。(nvim 的 packer 插件无法读取 .zshrc 里的环境变量，需要单独修改）

示例：

```bash
DOT_GITHUB_MIRROR=https://hub.nuaa.cf/
```