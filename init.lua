vim.cmd("language en_US.UTF_8")
vim.opt.background = "dark"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.autoindent = true
vim.opt.wrapscan = false
vim.opt.incsearch = false
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = "utf-8,cp932,iso-2022-jp,ucs-bom,latin1"
vim.opt.matchtime = 1
vim.opt.ambiwidth = "double" -- □○★♡ etc ambiguous char width

-- Default TAB settings
vim.opt.expandtab = true
vim.opt.listchars = "tab:> ,trail:-,nbsp:+,eol:$"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 0 -- use tabstop value
vim.opt.softtabstop = -1 -- use shiftwidth value

-- Statusline settings
vim.opt.statusline = "%f%m%h {%{&fileencoding}, %{&fileformat}} COL=%v ROW=%l/%L %= %p%% "
vim.cmd("highlight StatusLine term=NONE cterm=NONE ctermfg=white ctermbg=darkgreen")
vim.cmd("highlight StatusLineNC term=NONE cterm=NONE ctermfg=white ctermbg=gray")

vim.cmd("highlight MatchParen cterm=bold ctermfg=blue ctermbg=none")
vim.api.nvim_create_augroup('update_markdown_syntax', {})
--vim.opt.shortmess = "filnxtToOFI"
--vim.opt.cinoptions = ":0,g0"

-- set cinoptions+=:0,g0
vim.opt.cinoptions=":0,g0"


-- Jump to the last position when reopening a file
vim.api.nvim_create_autocmd({"BufReadPost"}, {
	pattern = { "*" },
	callback = function()
		vim.api.nvim_exec('silent! normal! g`"zv', false)
	end
})

-- key mappings
vim.g.mapleader = ' '
vim.keymap.set('n', '<Leader>ale', ':ALEToggle<CR>') -- default noremap=true nvim_set_keymap
vim.api.nvim_set_keymap('n', '<C-q>', '<NOP>', {noremap = true}) -- invalidate C-q because used by screen
vim.api.nvim_set_keymap('n', '<F3>', '<Cmd>setlocal relativenumber!<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', ':nohlsearch<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-s>l', ':set number!<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-s>h', ':set cursorline!<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-s>v', ':set cursorcolumn!<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>li', ':set list!<CR>', {noremap = true})


-- コメント文字毎の動作設定 :help comments, :help format-comments
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile", "FileType"}, {
  pattern = {"*"},
  callback = function()
    vim.opt.comments = "s1:/*,mb:*,ex:*/,f://,f:--,b:#,:%,:XCOMM,n:>,fb:-"
  end
})
-- TAB settings each file type
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.go"},
  callback = function()
    vim.bo.expandtab = false
    vim.bo.tabstop = 4
  end
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.py"},
  callback = function()
      vim.bo.tabstop = 4
  end
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.rs"},
  callback = function()
    vim.bo.tabstop = 4
  end
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.c", "*.h", "*.cpp", "*.hpp", "*.cc", "*.hh"},
  callback = function()
--      vim.bo.tabstop = 2
      vim.bo.cindent = true
  end
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.lua"},
  callback = function()
      vim.bo.tabstop = 2
  end
})

--vim.cmd('packadd vim-jetpack')
--require('jetpack').startup(function(use)
--  use { 'tani/vim-jetpack', opt = 1 }-- bootstrap
----  use 'https://github.com/dense-analysis/ale'
----  use 'junegunn/fzf.vim'
----  use {'junegunn/fzf', run = 'call fzf#install()' }
--  use 'neovim/nvim-lspconfig'
--end)
--
--require('lspconfig').clangd.setup{}
