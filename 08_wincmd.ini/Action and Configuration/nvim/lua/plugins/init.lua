if vim == nil then
    vim = require('vim')
end
return {
    {'SirVer/ultisnips'},
    {"folke/which-key.nvim"},
    { "folke/neoconf.nvim", cmd = "Neoconf" },
    {"folke/neodev.nvim"},
	"tpope/vim-fugitive",
    {"nvim-lua/plenary.nvim"},
    {"preservim/nerdtree"},
    {
        'nvim-tree/nvim-web-devicons'
    },
    {
        'akinsho/bufferline.nvim', version = "*", 
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
        require("bufferline").setup{}
        end,

    },
    {
        "nvim-telescope/telescope.nvim",
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')

            -- Custom function to checkout to the selected remote branch
            local function checkout_remote_branch(prompt_bufnr)

                local selection = action_state.get_selected_entry(prompt_bufnr)
                actions.close(prompt_bufnr)
                local branch = selection.value
                local local_branch = branch:gsub("origin/", "")
                vim.fn.system({'git', 'checkout', '-b', local_branch, branch})
                print('Checked out to ' .. local_branch)
            end

            require('telescope').setup {
                defaults = {
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-d>"] = actions.results_scrolling_down,
                            ["<C-u>"] = actions.results_scrolling_up,
                            ["<CR>"] = checkout_remote_branch
                        },
                        n = {
                            ["j"] = actions.move_selection_next,
                            ["k"] = actions.move_selection_previous,
                            ["<C-d>"] = actions.results_scrolling_down,
                            ["<C-u>"] = actions.results_scrolling_up,
                            ["<CR>"] = checkout_remote_branch
                        },
                    },
                },
            }

            vim.api.nvim_set_keymap('n', '<leader>gr', [[:lua require('telescope.builtin').git_branches({ show_remote_tracking_branches = true })<CR>]], { noremap = true, silent = true })
        end,
    },
    {
        'mg979/vim-visual-multi'
    },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },

        config = function()
            require('lualine').setup {
              options = { fmt = string.lower },
              sections = { lualine_a = {
                { 'mode', fmt = function(str) return str:sub(1,1) end } },
                          lualine_b = {'branch'} }
            }
        end,
    }


}
