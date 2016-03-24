" LastModified: 2016-03-24 17:23:53



call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" 設置自動縮進：即每行的縮進值與上一行相等；使用 noautoindent 取消設置
set autoindent
" 智能縮進
set smartindent
" 設置 使用 C/C++ 語言的自動縮進方式
set cindent
"禁止循環查找
"set nowrapscan
set ruler
set showmode
" 設置（自動）縮進的空格數為4
set shiftwidth=4
" 設置（軟）製表符寬度為4
set tabstop=4
"在狀態欄顯示正在輸入的命令
set showcmd
set softtabstop=4
set expandtab
" 搜索的時候即時顯示結果
set incsearch
" 高亮搜索結果
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
" 設置匹配模式，顯示匹配的括號
set showmatch
set nobackup
set autoread
set ttyfast
set ttymouse=xterm2
" 設置歷史記錄為100條
set history=100
" 自动换行
set wrap
au CursorHold * checktime

"colorscheme 256-jungle
"colorscheme molokai
colorscheme ansi_blows
"colorscheme spiderhawk
"colorscheme desert
" 摺疊設置
set foldenable
" 用語法高亮來定義摺疊
"set foldmethod=syntax
set foldmethod=manual
" 啟動vim時不要自動摺疊代碼
set foldlevel=100
set foldlevelstart=99
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>


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

set tabline=%!MyTabLine()
function MyTabLine()
    let s = '' " complete tabline goes here
    for t in range(tabpagenr('$'))
        " select the highlighting for the buffer names
        if t + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif
        "let s .= '['
        " set the tab page number (for mouse clicks)
        let s .= '%' . (t + 1) . 'T'
        " set page number string
        "let s .=  t + 1 . ']' 
        " get buffer names and statuses
        let n = ''  "temp string for buffer names while we loop and check buftype
        let m = 0   " &modified counter
        let bc = len(tabpagebuflist(t + 1))  "counter to avoid last ','
        " loop through each buffer in a TAB
        for b in tabpagebuflist(t + 1)
            " buffer types: quickfix gets a [Q], help gets [H]{base fname}
            if getbufvar( b, "&buftype" ) == 'help'
                let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
            elseif getbufvar( b, "&buftype" ) == 'quickfix' 
                let n .= '[Q]'
            elseif bufname(b) == ''
                let n .= '[No Name]'
            else
                "let n .= pathshorten(bufname(b))
                "               "let n .= bufname(b)
                let n .= fnamemodify( bufname(b), ':t' )
            endif
            " check and ++ tab's &modified count
            if getbufvar( b, "&modified" )
                    let m += 1
            endif
            " no final ' ' added...formatting looks better done later
            if bc > 1
                    let n .= ','
            endif
            let bc -= 1
        endfor
        " add modified label [+] where n pages in tab are modified
        if m > 0
            "let s .= '[' . m . '+]'
            let s.= '[+]'
        endif
        let s .= ' '
        " add buffer names
        let s .= n
        " switch to no underlining and add final space to buffer list
        "let s .= '%#TabLineSel#' . ' '
        let s .= ' '
    endfor
    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'
    return s
endfunction


nmap <TAB> v>
nmap <S-TAB> v<

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
" use f3 to search
nnoremap <silent> <F3> :lv /\<<c-r>=expand("<cword>")<cr>\>/j %<cr>:lw<cr>

filetype on
filetype plugin on



nmap <silent> <F9> :TlistToggle<cr>
"nmap <f12> :wincmd p<CR>
let Tlist_Show_One_File = 1            "不同時顯示多個文件的tag，只顯示當前文件的
"let Tlist_Auto_Open = 1
let Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最後一個窗口，則退出vim
"let Tlist_Use_Right_Window = 1         "在右側窗口中顯示taglist窗口

silent! nmap <C-p> :NERDTreeToggle<CR>
silent! map <F5> :NERDTreeFind<CR>
let g:NERDTreeMapActivateNode="<F5>"
"let g:NERDTreeMapPreview="<F6>"
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=0
let NERDTreeIgnore=['\.$','\~$']
"let NERDTreeShowLineNumbers=1
"let NERDTreeWinPos=1


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

nmap <F10> :SrcExplToggleDown<CR>
nmap <F7> :SrcExplToggle<CR>
nmap <F8> :SrcExplRefresh<CR>
let g:SrcExpl_winHeight = 8  
let g:SrcExpl_winWidth = 80 
let g:SrcExpl_refreshTime = 100 
let g:SrcExpl_jumpKey = "<ENTER>" 
let g:SrcExpl_gobackKey = "<SPACE>" 
let g:SrcExpl_pluginList = [ 
        \ "__Tag_List__", 
        \ "_NERD_tree_" 
    \ ] 
let g:SrcExpl_searchLocalDef = 1 
let g:SrcExpl_isUpdateTags = 0 
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ." 
"let g:SrcExpl_updateTagsKey = "<F12>" 
let g:SrcExpl_prevDefKey = "<F3>" 
let g:SrcExpl_nextDefKey = "<F4>" 

noremap <silent> <C-h> <C-w><
noremap <silent> <C-l> <C-w>>
noremap <silent> <C-j> <C-w>+
noremap <silent> <C-k> <C-w>-

" cscope
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
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>

autocmd BufWritePre,FileWritePre [._]vimrc   ks|call LastModified()|'s
fun LastModified()

    exe "1,$ s/^\"\ LastModified: .*/\"\ LastModified: " .
        \ strftime("%F %T") . "/e"

endfun

