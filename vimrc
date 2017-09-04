" LastModified: 2017-08-14 10:14:13


" <F1> - help
" <F2> - paste mode toggle
" <F3> - big search and content
" \+sq - big search and list
" <F4>
" <F5> - NERDTreeFind
" ctrl+p - NERDTreeToggle
" <F6>
" <F7> - SrcExplToggle
" <F8> - SrcExplRefresh
" <F9> - function list, order
" <F10> - SrcExplToggleDown
" <F11> - 
" <F12> - switch .c and .h
" ctrl+u - file search
"        ctrl+t - open file with tab
" ctrl+o - wildfire
" :split - Up and down pages
" \+m - mark
" \+n - all marks disable
"   \+1~5
" \+i - IndentGuidesToggle
" \+\+h~l. - easymotion
" \+u+d - gundo



filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'telltruth/nerdtree'
Plugin 'telltruth/taglist'
Plugin 'telltruth/AutoComplPop'
Plugin 'telltruth/snipMate'
Plugin 'telltruth/a'
Plugin 'telltruth/cscope_maps'
Plugin 'telltruth/SrcExpl'
Plugin 'telltruth/bufexplorer'
Plugin 'telltruth/comments.vim'

"Plugin 'altercation/vim-colors-solarized'
"Plugin 'tomasr/molokai'
"Plugin 'vim-scripts/phd'
"Plugin 'Lokaltog/vim-powerline'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'nathanaelkane/vim-indent-guides'
"Plugin 'derekwyatt/vim-fswitch'
Plugin 'kshenoy/vim-signature'
"Plugin 'vim-scripts/BOOKMARKS--Mark-and-Highlight-Full-Lines'
"Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/indexer.tar.gz'
Plugin 'vim-scripts/DfrankUtil'
Plugin 'vim-scripts/vimprj'
"Plugin 'mileszs/ack.vim'
"Plugin 'rking/ag.vim'
Plugin 'dyng/ctrlsf.vim'
Plugin 'terryma/vim-multiple-cursors'
"Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/DrawIt'
"Plugin 'SirVer/ultisnips'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'derekwyatt/vim-protodef'
"Plugin 'scrooloose/nerdtree'
"Plugin 'fholgado/minibufexpl.vim'
Plugin 'gcmt/wildfire.vim'
Plugin 'sjl/gundo.vim'
Plugin 'Lokaltog/vim-easymotion'
"Plugin 'suan/vim-instant-markdown'
"Plugin 'lilydjwg/fcitx.vim'
"plugin 'jdevera/vim-cs-explorer'
"Plugin 'dotfiles/c.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'jiangmiao/auto-pairs'

call vundle#end()
filetype plugin indent on

" auto indent 
set autoindent
" snart indent
set smartindent
" c language indent
set cindent
" no wrap scan
"set nowrapscan
set ruler
set showmode
" auto indent is 4
set shiftwidth=4
set tabstop=4
" show command
set showcmd
set softtabstop=4
set expandtab
" show search result
set incsearch
" highlight search
set hls
" no cpmpatible vi
set nocompatible
set cursorline
if !&diff
    set cursorcolumn
endif
set guifontset=8x16,kc15f,-*-16-*-big5-0
set t_Co=256
set linebreak
set backspace=indent,eol,start
set noerrorbells
set mouse=nv
"set mouse=a
" show match 
set showmatch
set nobackup
set autoread
" Can manual adjust windows size
set ttyfast
set ttymouse=xterm2
" history 100 lines
set history=1000
set wrap
au CursorHold * checktime

set clipboard=unnamed
"set background=dark
"colorscheme 256-jungle
"colorscheme ansi_blows
"colorscheme solarized
colorscheme molokai
"colorscheme phd
"colorscheme spiderhawk
"colorscheme desert
if &diff
    colorscheme ansi_blows
endif

" fold
set foldenable
set foldmethod=syntax
set foldcolumn=0
setlocal foldlevel=1
set foldlevelstart=99
"set foldclose=all
"nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

"highlight CursorLine cterm=none ctermbg=236
"highlight CursorColumn cterm=none ctermbg=236
"let g:Powerline_colorscheme='solarized256'

syntax on
syntax enable
"colorscheme adrian
"highlight Comment ctermfg=Green
"colorscheme af
"colorscheme asmanian_blood
"highlight Comment ctermfg=darkcyan
"highlight Search term=reverse ctermbg=4 ctermfg=7
"highlight CursorLine cterm=none ctermbg=0

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
" nnoremap <silent> <F3> :lv /\<<c-r>=expand("<cword>")<cr>\>/j %<cr>:lw<cr>

filetype on
filetype plugin on

" Taglist - OUT!
nmap <silent> <F9> :TlistToggle<cr>
"nmap <f12> :wincmd p<CR>
let Tlist_Show_One_File = 1
"let Tlist_Auto_Open = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 0

silent! nmap <C-p> :NERDTreeToggle<CR>
silent! map <F5> :NERDTreeFind<CR>
"silent! map <F5> :NERDTreeToggle<CR>
let g:NERDTreeMapActivateNode="<F5>"
"let g:NERDTreeMapPreview="<F6>"
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=0
let NERDTreeIgnore=['\.$','\~$']
"let NERDTreeShowLineNumbers=1
"let NERDTreeWinPos=1
"nmap <Leader>fl :NERDTreeToggle<CR>
"let NERDTreeWinSize=22
"let NERDTreeWinPos="right"
"let NERDTreeMinimalUI=1
"let NERDTreeAutoDeleteBuffer=1


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
"let g:sh_fold_enabled= 1    "(enable function folding)
"let g:sh_fold_enabled= 2    "(enable heredoc folding)
"let g:sh_fold_enabled= 4    "(enable if/do/for folding)

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

"noremap <silent> <C-h> <C-w><
"noremap <silent> <C-l> <C-w>>
"noremap <silent> <C-j> <C-w>+
"noremap <silent> <C-k> <C-w>-

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

set viminfo+=!
" keep mark
set viminfo='1000,f1

" mark.vim
"let g:mwDefaultHighlightingPalette='extended'
let g:mwAutoLoadMarks = 1 
let g:mwAutoSaveMarks = 1
let g:mwDefaultHighlightingPalette='maximum'
let g:mwIgnoreCase = 0
nmap <Leader>1  <Plug>MarkSearchGroup1Next 
nmap <Leader>2  <Plug>MarkSearchGroup2Next 
nmap <Leader>3  <Plug>MarkSearchGroup3Next 
nmap <Leader>4  <Plug>MarkSearchGroup4Next 
nmap <Leader>5  <Plug>MarkSearchGroup5Next 
"nmap <Leader>Q  <Plug>MarkSearchGroup1Prev 
"nmap <Leader>W  <Plug>MarkSearchGroup2Prev 
"nmap <Leader>E  <Plug>MarkSearchGroup3Prev 
"nmap <Leader>R  <Plug>MarkSearchGroup4Prev 
"nmap <Leader>T  <Plug>MarkSearchGroup5Prev 

" vim-indent-guides
nmap <silent> <Leader>i <Plug>IndentGuidesToggle
let g:indent_guides_enable_on_vim_startup=0
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

" tagbar
"nmap <silent><F9> :TagbarToggle<CR>
"let tagbar_left=1
"nnoremap <Leader>tb :TagbarToggle<CR>
"let tagbar_width=32
"let g:tagbar_compact=1
"let g:tagbar_autofocus = 1
"let g:tagbar_ctags_bin='ctags'
"let g:tagbar_width=30
"let g:tagbar_sort=0
"map <F3> :Tagbar<CR>
"autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
let g:tagbar_type_cpp = {
     \ 'ctagstype' : 'c++',
     \ 'kinds'     : [
         \ 'c:classes:0:1',
         \ 'd:macros:0:1',
         \ 'e:enumerators:0:0', 
         \ 'f:functions:0:1',
         \ 'g:enumeration:0:1',
         \ 'l:local:0:1',
         \ 'm:members:0:1',
         \ 'n:namespaces:0:1',
         \ 'p:functions_prototypes:0:1',
         \ 's:structs:0:1',
         \ 't:typedefs:0:1',
         \ 'u:unions:0:1',
         \ 'v:global:0:1',
         \ 'x:external:0:1'
     \ ],
     \ 'sro'        : '::',
     \ 'kind2scope' : {
         \ 'g' : 'enum',
         \ 'n' : 'namespace',
         \ 'c' : 'class',
         \ 's' : 'struct',
         \ 'u' : 'union'
     \ },
     \ 'scope2kind' : {
         \ 'enum'      : 'g',
         \ 'namespace' : 'n',
         \ 'class'     : 'c',
         \ 'struct'    : 's',
         \ 'union'     : 'u'
     \ }
\ }

let g:disable_protodef_sorting=1

" minibufexpl.vim
"map <Leader>bl :MBEToggle<cr>
"map <C-Tab> :MBEbn<cr>
"map <C-S-Tab> :MBEbp<cr>

"vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

" vim-easymotion
let g:EasyMotion_smartcase = 1
"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
map <Leader><leader>. <Plug>(easymotion-repeat)

" ctrlsf.vim
"let g:ackprg = '/usr/local/bin/ag --nogroup --nocolor --column'
let g:ctrlsf_ackprg='/usr/local/bin/ag' 
nnoremap <Leader>sp :CtrlSF<CR>
"nnoremap <silent> <F3> :CtrlSF<CR>
nnoremap <Leader>sq :CtrlSFQuickfix<CR>

" vim-multiple-cursors
let g:multi_cursor_next_key='<C-n>'
"let g:multi_cursor_skip_key='<C-k>'
let g:multi_cursor_use_default_mapping=0
"let g:multi_cursor_next_key='<C-m>'
"let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" wildfire.vim
map <C-O> <Plug>(wildfire-fuel)
"vmap <S-SPACE> <Plug>(wildfire-water)
let g:wildfire_objects = ["i'", 'i"', "i)", "i]", "i}", "i>", "ip"]

" gundo.vim
nnoremap <Leader>ud :GundoToggle<CR>

" c.vim
"let c_comment_strings=1
"let c_no_if0=1

" ctrlp.vim
let g:ctrlp_map = '<c-u>' 
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.symvers,*.order,*.o,*.ko,*.mod.c     " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|pyc)$' 
"let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux

autocmd BufWritePre,FileWritePre [._]vimrc   ks|call LastModified()|'s
fun LastModified()

    exe "1,$ s/^\"\ LastModified: .*/\"\ LastModified: " .
        \ strftime("%F %T") . "/e"

endfun

autocmd BufWritePost $MYVIMRC source $MYVIMRC
