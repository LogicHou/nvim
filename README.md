# nvim
自用 NeoVim 配置文件

## 安装

### Windows

本体

    $ scoop install neovim-nightly

配置文件路径

    :echo stdpath("config")
    C:\Users\Name\AppData\Local\nvim

依赖

    $ scoop install ripgrep
    $ scoop install fd

如果安装 TreeSitter 遇到问题，可以尝试使用管理员模式启动 nvim ，重新尝试自动安装 TreeSitter 的 Paser

    $ scoop install sudo
    $ sudo nvim
