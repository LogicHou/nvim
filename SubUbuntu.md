#  开发机初始化步骤 (基于 Ubuntu 18.04 LTS)

##  WSL关闭与windows的互交互

在WSL的终端中输入:

  echo "[interop]\nenabled=false\nappendWindowsPath=false" | sudo tee /etc/wsl.conf

在 powershell (以管理员身份运行)中输入: (以重启wsl)

  net stop LxssManager
  net start LxssManager

Nerd Font 字体

windows 下安装好nerd字体后再windows terminal设置文件里配置好字体即可

## 安装 Nerd Font 字体

字体下载路径：

    https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode/Regular/complete/

Windows 下安装好 Nerd Font 字体后在 windows terminal 设置文件里配置好字体即可

例：

    {
      "guid": "{a5a97cb8-8961-5535-816d-772efe0c6a3f}",
      "hidden": false,
      "name": "Arch",
      "source": "Windows.Terminal.Wsl",
      "fontFace": "FiraCode NF",
      "fontSize": 11
    },

## 更新系统

    $ sudo apt-get update

## Ubuntu 基础环境编译包安装

    $ sudo apt-get install -y build-essential

## 更新 Git 到最新版本

    $ sudo add-apt-repository ppa:git-core/ppa
    $ sudo apt-get update
    $ sudo apt-get install git

##  安装 lazygit

    $ sudo add-apt-repository ppa:lazygit-team/release
    $ sudo apt-get update
    $ sudo apt-get install lazygit

## 查看当前的 Shell 

    $ cat /etc/shells
    # /etc/shells: valid login shells
    /bin/sh
    /bin/bash
    /bin/rbash
    /bin/dash
    /usr/bin/tmux
    /usr/bin/screen

## 如果没有 zsh 就先安装一下

    $ sudo apt-get install zsh

## 安装 oh-my-zsh

安装：

    $ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

安装插件：

    $ git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    $ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

修订相关配置：

    ZSH_THEME="ys"
    plugins=(git extract z zsh-autosuggestions zsh-syntax-highlighting)
    bindkey ',' autosuggest-accept
    HIST_STAMPS="yyyy-mm-dd"

使配置生效：

    $ zsh

## 在 ZSHRC 中配置代理

    export hostip=$(cat /etc/resolv.conf |grep -oP '(?<=nameserver\ ).*')
    alias proxy='
        export https_proxy="socks5://${hostip}:7890";
        export http_proxy="socks5://${hostip}:7890";
        export all_proxy="socks5://${hostip}:7890";
    '
    alias unproxy='
        unset https_proxy;
        unset http_proxy;
        unset all_proxy;
    '

## 如果 github 无法访问修改 github 映射

    $ vi /etc/hosts
    199.232.96.133  raw.github.com

# 安装 Neovim

    $ sudo add-apt-repository ppa:neovim-ppa/unstable
    $ sudo apt-get update
    $ sudo apt-get install neovim

如果报错，找不到 add-apt-repository 命令，需要先安装下边的包：

    $ sudo apt-get install software-properties-common

安装完成后可选步骤，替换默认的 vim nvim ~/.zshrc，添加别名：

    alias vim='nvim'
    alias vi='nvim'
    alias v='nvim'

## 配置 github ssh-keygen

    $ ssh-keygen -t ed25519 -C "your_email@example.com"
    $ cat /home/hou/.ssh/id_ed2**19.pub
    ssh-ed2**19 A********************************Q your_email@example.com <--添加到 github https://github.com/settings/keys 中

## 下载 nvim 配置

    $ git clone git@github.com:LogicHou/nvim.git ~/.config/nvim

## 安装 Packer.nvim 插件管理器

    $ git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

然后打开 vim 执行命令：

    :PackerSync