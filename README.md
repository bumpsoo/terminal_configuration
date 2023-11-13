### from wsl - alpine

running [mini root fs](https://www.alpinelinux.org/downloads/)

```
wsl --import Alpine 'E:\alpine\' E:\alpine-minirootfs-3.18.4-x86_64.tar
```

dependencies

```
apk add neovim tmux git openssh ripgrep curl gcc go

go install golang.org/x/tools/gopls@latest
```

### dev configuration for alpine linux

- neovim (.config/nvim/\*)
- git (.gitconfig ~/personal/.gitconfig)
- tmux (.tmux.conf)
- shell (.profile)

### neovim plugins

- lazy (plugin manager)
- treesitter
- telescope
- tokyonight
- lspconfig
- fugitive
