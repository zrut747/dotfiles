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

| 环境变量                             | 说明                                    | 默认值                            |
|--------------------------------------|-----------------------------------------|-----------------------------------|
| `DOT_GITHUB_MIRROR`                  | github 的镜像地址                       | `https://kgithub.com`             |
