return {
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                   -- "pylyzer"
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require('lspconfig')
            lspconfig.lua_ls.setup({})
            lspconfig.clangd.setup({})

          vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true });
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true });  -- goto definition
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { noremap = true, silent = true }); -- warning이 나왔을 때 선택지 제시

        end
    }
}
