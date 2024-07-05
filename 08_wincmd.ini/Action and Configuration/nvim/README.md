

## Prerequisite


### Lazy설치

요즘 Plugin 매니저 플러그인 대세는 Lazy입니다. Lua베이스라서 init.lua를 설정 파일로 써야 합니다.

다음은 Lazy를 설치 한 후 fugitive git플러그인까지 설치하는 스크립트 입니다.

init.lua

```lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "tpope/vim-fugitive"
})

```



### vim-plug설치

```
https://github.com/junegunn/vim-plug
```

## Windows PowerShell
```
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

```


### .config/nvim 디렉토리만들기

```bash
mkdir ~/.config/nvim
git clone https://github.com/Kyeongrok/nvim-init .config/nvim
```

### Windows nvim root

~/AppData/local/nvim/init.lua



### init.lua파일 리로드

```lua
function ReloadConfig()
    vim.cmd('source ' .. vim.fn.expand('%:p'))
    print("Configuration reloaded!")
end

-- 명령어 정의
vim.api.nvim_create_user_command('ReloadConfig', ReloadConfig, {})

```

```
:lua ReloadConfig()
```


### plugins.lua로 분리

1. lua 디렉토리리를 만듭니다.
2. lua/plugins.lua를 만듭니다.
3. init.lua에 다음과 같이 import합니다.

```lua
require("lazy").setup("plugins")

```


### LSP서버 참조 중지

#### 서버의 리소스를 많이 쓰기 때문에 꺼야 할 때가 있습니다.

nvim-lspconfig 설정 변경

```lua
{
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require('lspconfig')
        lspconfig.lua_ls.setup({})
      --  lspconfig.pylyzer.setup({}) -- 주석을 풀면 pylyzer가 활성화 됩니다.

    end
}
```
