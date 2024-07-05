vim.cmd [[                                   
  call plug#begin('~/.vim/plugged')                                   
    Plug 'tpope/vim-fugitive'                                   
    Plug 'preservim/nerdtree'                                   
    Plug 'liuchengxu/vim-which-key'                                           
    Plug 'nvim-lua/plenary.nvim'                                      
    Plug 'tanvirtin/vgit.nvim'                                     
    Plug 'tpope/vim-fugitive'                                    
    Plug 'vim-airline/vim-airline'                                   
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }                                   
    Plug 'stsewd/fzf-checkout.vim'                                                        
    Plug 'arcticicestudio/nord-vim'                                   
    Plug 'morhetz/gruvbox'                                                                
    Plug 'joshdick/onedark.vim'                                       
    Plug 'dracula/vim', { 'as': 'dracula' }                                   
    Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
    Plug 'folke/tokyonight.nvim',
    Plug 'nvim-lua/plenary.nvim'                                              
    Plug 'nvim-telescope/telescope.nvim'                                      
    Plug 'nvim-tree/nvim-web-devicons' " Recommended (for coloured icons)                                   
    Plug 'akinsho/bufferline.nvim', { 'tag': '*' }                                                          
    Plug 'williamboman/mason.nvim'                                                                          
    Plug 'nvim-tree/nvim-tree.lua'                                                   
  call plug#end()                                                    
]]                                            
                                                         
-- Spaces & Tabs {{{                
vim.opt.tabstop = 4       -- number of visual spaces per TAB    
vim.opt.softtabstop = 4   -- number of spaces in tab when editing    
vim.opt.shiftwidth = 4    -- number of spaces to use for autoindent      
vim.opt.expandtab = true  -- tabs are space    
vim.opt.autoindent = true                                                                                                               
vim.opt.copyindent = true -- copy indent from the previous line                               
vim.opt.termguicolors = true                                                                                                                               

vim.api.nvim_set_option('clipboard', 'unnamedplus')

vim.o.nu=true                                                                                                              
vim.o.mouse=a
vim.cmd('colorscheme catppuccin-mocha')
vim.g.mapleader = ' '


vim.api.nvim_set_keymap('n', '<F10>', ':e ~/AppData/local/nvim/init.lua<CR>', {noremap = true, silent = true})

-- Plug 플러그인 설치
vim.api.nvim_set_keymap('n', '<F8>', ':PlugInstall<CR>', {noremap = true})

-- NERDTree 토글
vim.api.nvim_set_keymap('n', '<F11>', ':NERDTreeToggle<CR>', {noremap = true})

-- 현재 파일 다시 읽기
vim.api.nvim_set_keymap('n', '<F12>', ':source %<CR>', {noremap = true})

-- 저장
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', {noremap = true})

-- 종료
vim.api.nvim_set_keymap('n', '<C-q>', ':q<CR>', {noremap = true})

-- WhichKey 플러그인 사용
vim.api.nvim_set_keymap('n', '<silent> <leader>', ":WhichKey '<Space>'<CR>", {noremap = true})

vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', {noremap = true})

-- Move Screen
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {noremap = true})

-- Buffer(Tab)
vim.o.hidden = true

vim.api.nvim_set_keymap('n', '<S-h>', ':bprevious<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<S-l>', ':bnext<CR>', {noremap = true})

vim.api.nvim_set_keymap('n', '<leader>rr', ':term poetry run python ~/rs485-python/rs485_python/main.py<CR>', {noremap = true})

vim.api.nvim_set_keymap('n', '<leader>rc', ':term poetry run python /root/git/rs485-python/rs485_python/Gpio.py<CR>', {noremap = true})

vim.api.nvim_set_keymap('n', '<leader>e', ':NERDTreeToggle<CR>', {noremap = true})

vim.api.nvim_set_keymap('n', '<leader>bd', ':bd<CR>', {noremap = true})

--------------------
-- Git
--------------------
vim.api.nvim_set_keymap('n', '<leader>g', ':G<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gc', ':Git commit<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gd', ':Gdiff<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gl', ':G log<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gr', ':lua require("telescope.builtin").git_branches({ track = "--remote" })<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gb', ':lua require("telescope.builtin").git_branches()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>u', ':Telescope colorscheme<CR>', {noremap = true})

-- Telescope
vim.api.nvim_set_keymap('n', '<leader>t', ':Telescope<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>f', ':Telescope<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', {noremap = true})


----------------------------------------
-- Telescope mappings
----------------------------------------
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-d>"] = actions.results_scrolling_down,
        ["<C-u>"] = actions.results_scrolling_up,
      },
      n = {
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["<C-d>"] = actions.results_scrolling_down,
        ["<C-u>"] = actions.results_scrolling_up,
      },
    },
  },
}


require("mason").setup()
require("bufferline").setup()
require('nvim-web-devicons').setup()
require'nvim-web-devicons'.get_icons()
