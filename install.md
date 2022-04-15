#  开发机初始化步骤 (基于 Ubuntu 18.04 LTS)

## 安装 Windows Terminal

推荐使用 [微软应用商店](https://www.microsoft.com/zh-cn/p/windows-terminal/) 进行安装

## wsl2 + Ubuntu-18.04 子系统

在安装 Neovim 之前，首先要确保你的电脑上有 WSL 2 环境，WSL 是 Windows Subsystem for Linux 的缩写，简单来讲就是在 Windows 上运行的 Linux 子系统

WSL 2 就是 WSL 的 2.0 版本，WSL 2 的安装方法可以参考[官方指南](https://docs.microsoft.com/en-us/windows/wsl/install)

##  WSL关闭与windows的互交互

在WSL的终端中输入:

    echo "[interop]\nenabled=false\nappendWindowsPath=false" | sudo tee /etc/wsl.conf

在 powershell (以管理员身份运行)中输入: (以重启wsl)

    net stop LxssManager
    net start LxssManager

## 安装 Nerd Font 字体

Windows 下安装好nerd字体后再 Windows Terminal 设置文件里配置好字体即可

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

    $ sudo apt-get update && sudo apt-get upgrade -y

## Ubuntu 基础环境编译包安装

    $ sudo apt-get install -y build-essential

## Git

安装/更新 Git 到最新版本：

    $ sudo add-apt-repository ppa:git-core/ppa
    $ sudo apt-get update
    $ sudo apt-get install git -y

初始配置：

    $ git config --global user.name "John Doe"           # 用户名改成自己的
    $ git config --global user.email johndoe@example.com # 邮箱改成自己的
    $ git config --global credential.helper store        # 设置 Git，保存用户名和密码
    $ git config --global core.longpaths true            # 解决 Git 中 'Filename too long' 的错误
    $ git config --global core.quotepath off
    $ git lfs install --skip-repo                        # 能够克隆大于 100M 的文件，需要先安装 sudo apt-get install git-lfs
    
    # 配置国内镜像 可选
    $ git config --global url."https://github.com.cnpmjs.org/".insteadOf "https://github.com/"

配置 gitalias：

    $ curl https://raw.githubusercontent.com/GitAlias/gitalias/main/gitalias.txt -o ~/.gitalias
    $ git config --global include.path ~/.gitalias

 安装 lazygit

    $ sudo add-apt-repository ppa:lazygit-team/release
    $ sudo apt-get update
    $ sudo apt-get install lazygit -y

## 安装 zsh

查看当前的 Shell ：

    $ cat /etc/shells
    # /etc/shells: valid login shells
    /bin/sh
    /bin/bash
    /bin/rbash
    /bin/dash
    /usr/bin/tmux
    /usr/bin/screen

如果没有 zsh 就先安装一下：

    $ sudo apt-get install zsh

### zshrc 配置：

创建 workspace 目录：

    $ mkdir $HOME/workspace

代理：

    # Proxy
    export hostip=$(cat /etc/resolv.conf |grep -oP '(?<=nameserver\ ).*')
    alias proxy='
        export https_proxy="http://${hostip}:7890";
        export http_proxy="http://${hostip}:7890";
        export all_proxy="http://${hostip}:7890";
    '
    alias unproxy='
        unset https_proxy;
        unset http_proxy;
        unset all_proxy;
    '

一些默认配置：
 
    # User specific aliases and functions
    
    alias rm='rm -i'
    alias cp='cp -i'
    alias mv='mv -i'
    
    # User specific environment
    # Basic envs
    export LANG="en_US.UTF-8" # 设置系统语言为 en_US.UTF-8，避免终端出现中文乱码
    # export PS1='[\u@dev \W]\$ ' # 默认的 PS1 设置会展示全部的路径，为了防止过长，这里只展示："用户名@dev 最后的目录名"
    export WORKSPACE="$HOME/workspace" # 设置工作目录
    export PATH=$HOME/bin:$PATH # 将 $HOME/bin 目录加入到 PATH 变量中
    
    # Default entry folder
    cd $WORKSPACE # 登录系统，默认进入 workspace 目录

如果 github 还是无法访问修改 github 映射

    $ vi /etc/hosts
    199.232.96.133  raw.github.com

## 安装 oh-my-zsh

安装：

    $ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

安装插件：

    $ git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    $ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

修改相关配置 vim ~/.zshrc ：

    ZSH_THEME="ys"

    plugins=(git extract z zsh-autosuggestions zsh-syntax-highlighting)

    # My Setting
    bindkey ',' autosuggest-accept
    HIST_STAMPS="yyyy-mm-dd"

使配置生效：

    $ zsh

## 安装 Neovim

安装 go：

    $ wget -c https://golang.google.cn/dl/go1.18.linux-amd64.tar.gz
    $ sudo tar -C /usr/local -xzf go1.18.linux-amd64.tar.gz
    $ ls -F /usr/local/go
    AUTHORS          CONTRIBUTORS  PATENTS    SECURITY.md  api/  doc/         lib/   pkg/        src/
    CONTRIBUTING.md  LICENSE       README.md  VERSION      bin/  favicon.ico  misc/  robots.txt  test/
   
    $ vim ~/.zshrc # 加入下面内容
    # Go envs
    export GOROOT=/usr/local/go # GOROOT 设置
    export GOPATH=$WORKSPACE/golang # GOPATH 设置
    export GOBIN=$GOPATH/bin # GOBIN 设置
    export PATH=$GOROOT/bin:$GOPATH/bin:$PATH # 将 Go 语言自带的和通过 go install 安装的二进制文件加入到 PATH 路径中
    export GO111MODULE="on" # 开启 Go moudles 特性
    export GOPROXY=https://goproxy.cn,direct # 安装 Go 模块时，代理服务器设置
    export GOPRIVATE=
    export GOSUMDB=off # 关闭校验 Go 依赖包的哈希值

    $ zsh
    $ go version
    go version go1.18 linux/amd64
    $ rm go1.18.linux-amd64.tar.gz

    # 补充内容
    $ go env # 查看go环境变量
    $ go env -w GOARCH=amd64(386) # 设置go环境变量

安装依赖：

    $ curl -sLo /tmp/ripgrep_13.0.0_amd64.deb https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
    $ sudo dpkg -i /tmp/ripgrep_13.0.0_amd64.deb
    
    $ curl -sLo /tmp/fd_8.3.2_amd64.deb https://github.com/sharkdp/fd/releases/download/v8.3.2/fd_8.3.2_amd64.deb
    $ sudo dpkg -i /tmp/fd_8.3.2_amd64.deb

    $ curl -sLo /tmp/glow_1.4.1_linux_amd64.deb https://github.com/charmbracelet/glow/releases/download/v1.4.1/glow_1.4.1_linux_amd64.deb
    $ sudo dpkg -i /tmp/glow_1.4.1_linux_amd64.deb

    $ go install mvdan.cc/gofumpt@latest         # 更严格的 gofmt，用于 null-ls
    $ go install mvdan.cc/sh/v3/cmd/shfmt@latest # 用于 sh 文件的格式化，用于 null-ls

    # 可选   剪切板 已经更新了配置，现在通过y复制的内容也会同步到系统剪切板
    $ sudo apt-get install zip
    $ curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
    $ unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
    $ chmod +x /tmp/win32yank.exe
    $ sudo mv /tmp/win32yank.exe /usr/local/bin/

    # stylua
    $ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh # 先安装 rust，附带了 cargo
    $ cargo install stylua
    $ stylua -V
    stylua 0.13.0

前端项目的依赖:

    # 安装pnpm
    $ curl -fsSL https://get.pnpm.io/install.sh | PNPM_VERSION=7.0.0-rc.3 sh -
    $ html 所在目录执行pnpm init -y && pnpm i -D prettier eslint

安装本体：

    $ sudo add-apt-repository ppa:neovim-ppa/unstable
    $ sudo apt-get update
    $ sudo apt-get install neovim

查看是否安装成功：

    $ nvim --version
    NVIM v0.7.0-dev
    Build type: RelWithDebInfo
    LuaJIT 2.1.0-beta3
    ...
    ...

如果报错，找不到 add-apt-repository 命令，需要先安装下边的包：

    $ sudo apt-get install software-properties-common

安装完成后可选步骤，替换默认的 vim nvim ~/.zshrc，添加别名：

    # NEOVIM
    alias vim='nvim'
    alias vi='nvim'
    alias v='nvim'

使配置生效：

    $ zsh

### 配置 github ssh-keygen

    $ ssh-keygen -t ed25519 -C "your_email@example.com"
    $ cat /home/hou/.ssh/id_ed2**19.pub
    ssh-ed2**19 A********************************Q your_email@example.com <--添加到 github https://github.com/settings/keys 中

### 下载 nvim 配置

    $ git clone git@github.com:LogicHou/nvim.git ~/.config/nvim

### 安装 Packer.nvim 插件管理器

    $ git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

然后打开 vim 执行命令：

    :PackerSync

可能有部分插件一次装不上，多试几次

## 安装 oh my tmux

    $ cd
    $ git clone https://github.com/gpakosz/.tmux.git
    $ ln -s -f .tmux/.tmux.conf
    $ cp .tmux/.tmux.conf.local .

## TIPS

格式化当前目录下的所有 lua 文件：

    find ./ -name "*.lua" | xargs stylua

# 如果想在 Windows 下直接用需要的操作步骤 @todo

本体

    $ scoop install neovim-nightly

配置文件路径

    :echo stdpath("config")
    C:\Users\Name\AppData\Local\nvim

依赖

    $ scoop install ripgrep
    $ scoop install fd
    $ scoop install stylua
    $ go install golang.org/x/tools/cmd/goimports@latest
    $ scoop install shfmt

如果安装 TreeSitter 遇到问题，可以尝试使用管理员模式启动 nvim ，重新尝试自动安装 TreeSitter 的 Paser

    $ scoop install sudo
    $ sudo nvim
