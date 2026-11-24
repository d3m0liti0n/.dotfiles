local vim = vim
vim.g.mapleader = " "
vim.o.nu = true
vim.o.rnu = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true
vim.o.confirm = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.list = true
vim.opt.listchars = { tab = "  ", trail = "_" }
vim.o.autocomplete = true
vim.opt.complete:prepend("o")

vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "menuone,noselect,popup"

-- Built-in package manager (Neovim 0.12+)
vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/catppuccin/nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/echasnovski/mini.pick" },
    { src = "https://github.com/nvimdev/hlsearch.nvim" },
    { src = "https://github.com/tpope/vim-fugitive" },
})

-- Plugin setup
vim.cmd.colorscheme("catppuccin-mocha")

require("hlsearch").setup()
require("oil").setup()
require("mini.pick").setup({
    mappings = { choose_marked = "<C-q>" },
})
require("conform").setup({
    formatters_by_ft = {
        python = { "ruff_organize_imports", "ruff_format" },
    },
    format_on_save = {
        lsp_format = "fallback",
        timeout_ms = 1000,
    },
})

require("nvim-treesitter").install({ "python" })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function() pcall(vim.treesitter.start) end,
})

-- LSP
vim.lsp.config("ruff", {
    init_options = {
        settings = {
            configurationPreference = "filesystemFirst",
        },
    },
})

vim.lsp.enable({ "lua_ls", "jedi_language_server", "ruff" })

vim.diagnostic.config({
    virtual_text = {
        format = function(diagnostic)
            if diagnostic.code then
                return string.format("%s [%s]", diagnostic.message, diagnostic.code)
            end
            return diagnostic.message
        end,
    },
})

-- Keymaps
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
vim.keymap.set("n", "<leader>ff", "<cmd>Pick files<CR>")
vim.keymap.set("n", "<leader>fw", "<cmd>Pick grep_live<CR>")
vim.keymap.set("n", "<leader>h", "<cmd>term<CR>i")
vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>")
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<leader>cr", "<cmd>!python3 %<CR>")
vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<CR>")
vim.keymap.set("n", "<leader>x", "<cmd>bd<CR>")
vim.keymap.set("n", "<Tab>", "<cmd>bn<CR>")
vim.keymap.set("n", "<S-Tab>", "<cmd>bp<CR>")

-- UI
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- langmap
vim.cmd([[
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
]])
