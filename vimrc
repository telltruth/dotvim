" LastModified: 2013-05-20 14:57:12



call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


"set autoindent
"set smartindent
"set cindent
set ruler
set showmode
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set incsearch
set hls
set nocompatible
set cursorline
set guifontset=8x16,kc15f,-*-16-*-big5-0
set t_Co=256
set linebreak
set backspace=indent,eol,start
set noerrorbells
"set mouse=nv
set mouse=a
set showmatch
set nobackup

"colorscheme 256-jungle
"colorscheme molokai
colorscheme ansi_blows
"colorscheme spiderhawk
"colorscheme desert
set foldenable
set foldmethod=manual
nnoremap  @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')



syntax on
syntax enable
"colorscheme adrian
"highlight Comment ctermfg=Green
"colorscheme af
"colorscheme asmanian_blood
"highlight Comment ctermfg=darkcyan
"highlight Search term=reverse ctermbg=4 ctermfg=7
"highlight CursorLine cterm=none ctermbg=0
"set background=dark

" screen could use f1~f4
if &term =~ '^screen'
    set t_k1=[11~
    set t_k2=[12~
    set t_k3=[13~
    set t_k4=[14~
endif


" == snipmate ==
let g:acp_behaviorSnipmateLength=1

nmap <TAB> v>
nmap <S-TAB> v<
"vmap <TAB> >gv
"vmap <S-TAB> <gv

" use f3 to search
nnoremap <silent> <F3> :lv /\<<c-r>=expand("<cword>")<cr>\>/j %<cr>:lw<cr>

filetype on
filetype plugin on

if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=1
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
    cs add cscope.out
  endif
  set csverb
endif
" [S] Find this C symbol
nmap cs :cs find s
" [G] Find this definition
nmap cg :cs find g
" [C] Find functions calling this function
nmap cc :cs find c
" [T] Find this text string
nmap ct :cs find t
" [E] Find this egreo pattern
nmap ce :cs find e
nmap cf :cs find f
" [I] Find files #including this file
nmap ci :cs find i ^=expand("")$
" [D] Find functions called by this function
nmap cd :cs find d

nmap <silent> <F9> :TlistToggle<cr>
"nmap <f12> :wincmd p<CR>
let Tlist_Show_One_File = 1            "不同時顯示多個文件的tag，只顯示當前文件的
"let Tlist_Auto_Open = 1
let Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最後一個窗口，則退出vim
"let Tlist_Use_Right_Window = 1         "在右側窗口中顯示taglist窗口



nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

":set cscopequickfix=s-,c-,d-,i-,t-,e-
silent! nmap <C-p> :NERDTreeToggle<CR>
silent! map <F5> :NERDTreeFind<CR>
let g:NERDTreeMapActivateNode="<F5>"
"let g:NERDTreeMapPreview="<F6>"

" vim status line
set ls=2
set statusline=%<%F\ %m%=\ %h%r\ %-14([%p%%]\ %3l,%02c%03V%)%y
highlight StatusLine term=bold,reverse cterm=bold,reverse
"set laststatus=2
"set statusline=%4*%<\ %1*[%F]
set statusline+=%4*\ %5*[%{&encoding}, " encoding
set statusline+=%{&fileformat}%{\"\".((exists(\"+bomb\")\ &&\ &bomb)?\",BOM\":\"\").\"\"}]%m
"set statusline+=%4*%=\ %6*%y%4*\ %3*%l%4*,\ %3*%c%4*\ \<\ %2*%P%4*\ \>
"highlight User1 ctermfg=red
"highlight User2 term=underline cterm=underline ctermfg=Green
"highlight User3 term=underline cterm=underline ctermfg=yellow
"highlight User4 term=underline cterm=underline ctermfg=white
highlight User5 term=underline cterm=underline ctermfg=yellow
"highlight User6 ctermfg=white



"== a.vim ==
nnoremap <silent> <F12> :A<CR>

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP


" C
autocmd FileType c set omnifunc=ccomplete#Complete
" BASH
autocmd FileType shell set commentstring="#\ %s"
let g:sh_fold_enabled= 1    "(enable function folding)
let g:sh_fold_enabled= 2    "(enable heredoc folding)
let g:sh_fold_enabled= 4    "(enable if/do/for folding)

" keep last modified position
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif



autocmd BufWritePre,FileWritePre [._]vimrc   ks|call LastModified()|'s
fun LastModified()

    exe "1,$ s/^\"\ LastModified: .*/\"\ LastModified: " .
        \ strftime("%F %T") . "/e"

endfun

