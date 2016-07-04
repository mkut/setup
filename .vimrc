set nocompatible

" ftplugin
filetype plugin on  

" color scheme
set t_Co=256
colorscheme Black
syntax enable

" backspace
set backspace=indent,eol,start

" paren
let loaded_matchparen=1

" filename completion
set wildmode=list:full
set suffixes+=.hi,.hi-boot

"" autocompletion
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_smart_case=1
let g:neocomplcache_enable_underbar_completion=1
let g:neocomplcache_enable_auto_select=1
let g:neocomplcache_dictionary_filetype_lists = { 'default' : '', 'scala' : $HOME . '/.vim/dict/scala.dict' }
let g:neocomplcache_snippets_dir = $HOME.'/.vim/snippets'
inoremap <expr> <C-e> neocomplcache#cancel_popup()
inoremap <expr> <CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
inoremap <expr> <TAB> pumvisible() ? "<C-n>" : "\<TAB>"
inoremap <expr> <BS> neocomplcache#smart_close_popup()."\<C-h>"
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)
" set completefunc=googlesuggest#Complete

" autorun
silent! nmap <unique> <C-D> <Plug>(quickrun)

" indentation
set autoindent
set smartindent
set number
set tabstop=3
set shiftwidth=3
set softtabstop=0

" swapfile
set nobackup
set noswapfile

" key binding
"" save
nnoremap <silent> <C-a> :w<CR>
"" move
nnoremap <silent> <C-UP> <C-b>
nnoremap <silent> <C-Down> <C-f>
nnoremap <silent> <C-Right> $
nnoremap <silent> <C-Left> ^
nnoremap <silent> <S-UP> 5k
inoremap <silent> <S-UP> <UP><UP><UP><UP><UP>
nnoremap <silent> <S-DOWN> 5j
inoremap <silent> <S-DOWN> <DOWN><DOWN><DOWN><DOWN><DOWN>
"" insert mode
nnoremap <silent> a A
nnoremap <silent> A a

" folding
set foldmethod=syntax
set foldlevel=1

augroup foldmethod-syntax
  autocmd!
  autocmd InsertEnter * if &l:foldmethod ==# 'syntax'
  \                   |   setlocal foldmethod=manual
  \                   | endif
  autocmd InsertLeave * if &l:foldmethod ==# 'manual'
  \                   |   setlocal foldmethod=syntax
  \                   | endif
augroup END

augroup foldmethod-expr
  autocmd!
  autocmd InsertEnter * if &l:foldmethod ==# 'expr'
  \                   |   let b:foldinfo = [&l:foldmethod, &l:foldexpr]
  \                   |   setlocal foldmethod=manual foldexpr=0
  \                   | endif
  autocmd InsertLeave * if exists('b:foldinfo')
  \                   |   let [&l:foldmethod, &l:foldexpr] = b:foldinfo
  \                   | endif
augroup END

" statusline
set laststatus=2
function! GetStatusEx()
  let str = ''
  if &ft != ''
    let str = str . '[' . &ft . ']'
  endif
  if has('multi_byte')
    if &fenc != ''
      let str = str . '[' . &fenc . ']'
    elseif &enc != ''
      let str = str . '[' . &enc . ']'
    endif
  endif
  if &ff != ''
    let str = str . '[' . &ff . ']'
  endif
  return str
endfunction
set statusline=%<%f\ %m%r%h%w%=%{GetStatusEx()}\ \ %l,%c%V%8P

" local settings
source ${HOME}/.vimrc.d/local.vim
