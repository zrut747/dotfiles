## 描述

保存个人在Linux环境下使用的配置文件

## 安装

1. 克隆项目

```bash
git clone https://github.com/zrut747/dotfiles.git ~/.dotfiles
```

2. 执行bootstrap脚本

```bash
zsh ~/.dotfiles/bootstrap.sh
```

## 环境变量

环境变量提供了一定的定制能力，需要写在 `~/.zshrc` 中 `source $DOTDIR/zsh/zshrc` 语句前面

| 环境变量                             | 说明                                    | 默认值                            |
|--------------------------------------|-----------------------------------------|-----------------------------------|
| `DOT_GITHUB_MIRROR`                  | github 的镜像地址                       | `https://github.com`             |
