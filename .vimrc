syntax enable
set background=dark
set noswapfile
set nobackup
set autoindent
set nowrapscan
set hlsearch
set noincsearch
set fileencoding=utf-8
set fileencodings=utf-8,cp932,iso-2022-jp
set encoding=utf-8
set matchtime=1
set ambiwidth=double " □○★♡ etc ambiguous char width
set termencoding=utf-8

" Default TAB settings
set expandtab
set tabstop=2
set shiftwidth=0 " use tabstop value
set softtabstop=-1 " use shiftwidth value

" Statusline settings
def g:NewLineChar(): string
  if &fileformat == "unix"
    return "LF"
  elseif &fileformat == "dos"
    return "CRLF"
  else
    return &fileformat
  endif
enddef
set statusline=%f%m%r%h%w\ {%{&fileencoding},\ %{g:NewLineChar()}}\ COL=%c\ ROW=%l/%L\ %=\ %p%%\ 
set laststatus=2
highlight StatusLine term=NONE cterm=NONE ctermfg=white ctermbg=blue
highlight StatusLineNC term=NONE cterm=NONE ctermfg=white ctermbg=gray

highlight MatchParen cterm=bold ctermfg=blue ctermbg=none
"highlight CurSearch ctermbg=cyan

" C/C++ label depth is disalbe next indent
set cinoptions+=:0,g0

" Key mappings
if v:version >= 900
  vim9cmd g:mapleader = " "
else
  let mapleader = " "
endif
nnoremap <silent> <C-q> <NOP>
nnoremap <F3> <Cmd>setlocal relativenumber!<CR>
nnoremap <silent> <C-l> <Esc>:nohlsearch<CR>z.
nnoremap <silent> <C-s>l <Esc>:set number!<CR>
nnoremap <silent> <C-s>h <Esc>:set cursorline!<CR>
nnoremap <silent> <C-s>v <Esc>:set cursorcolumn!<CR>
nnoremap <silent> <Leader>li :set list!<CR>
nnoremap <silent> <Leader>wcnt :%s/./&/gn<CR>:nohlsearch<CR>

if v:version >= 900
  def s:Is_plugin_installed(plugin_name: string): bool
    return globpath(&runtimepath, 'pack/*/*/' .. plugin_name, 1) != ''
  enddef
  if s:Is_plugin_installed('lsp')
    packadd lsp
    let lspServers = [
      \ {
      \   'filetype': ['c', 'cpp'],
      \   'path': '/usr/bin/clangd',
      \   'args': ['--background-index'],
      \   'omnicompl': v:false,
      \ },
      \ {
      \   'filetype': ['go', 'gomod'],
      \   'path': '/usr/bin/gopls',
      \   'args': []
      \ }
      \]
    call LspAddServer(lspServers)
    call LspOptionsSet({'autoComplete': v:false})
    call LspOptionsSet({'showSignature': v:false})
    call LspOptionsSet({'autoHighlightDiags': v:false})
    nnoremap <silent> <Leader>gs :LspShowServers<CR>
    nnoremap <silent> gd :LspGotoDefinition<CR>
    nnoremap <silent> gr :LspShowReferences<CR>
  endif
endif

augroup AuCommands
  autocmd!

  " Jump to the last position when reopening a file
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

  autocmd FileType go setlocal noexpandtab ts=4
  autocmd FileType python setlocal ts=4
  autocmd FileType rust setlocal ts=4
  autocmd FileType markdown syntax match markdownError '\w\@<=\w\@='
  autocmd FileType cpp setlocal cindent expandtab
augroup END
