set backupcopy=yes
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype on
source $VIM/_vimrc
if has("autocmd")
	autocmd bufwritepost _vimrc source $MYVIMRC
endif
let mapleader = ','
let g:surround_{char2nr("b")} = "{% block\1 \r..*\r &\1%}\r{% endblock %}"
let g:surround_{char2nr("i")} = "{% if\1 \r..*\r &\1%}\r{% endif %}"
let g:surround_{char2nr("w")} = "{% with\1 \r..*\r &\1%}\r{% endwith %}"
let g:surround_{char2nr("c")} = "{% comment\1 \r..*\r &\1%}\r{% endcomment %}"
let g:surround_{char2nr("f")} = "{% for\1 \r..*\r &\1%}\r{% endfor %}"
nmap <leader>v :edit $HOME/_vimrc<CR>
nmap <leader>l :set list!<CR>
map <leader>f :CommandT<CR>

let g:last_relative_dir = ''
nnoremap \1 :call RelatedFile ("models.py")<cr>
nnoremap \2 :call RelatedFile ("views.py")<cr>
nnoremap \3 :call RelatedFile ("urls.py")<cr>
nnoremap \4 :call RelatedFile ("admin.py")<cr>
nnoremap \5 :call RelatedFile ("tests.py")<cr>
nnoremap \6 :call RelatedFile ( "templates/" )<cr>
nnoremap \7 :call RelatedFile ( "templatetags/" )<cr>
nnoremap \8 :call RelatedFile ( "management/" )<cr>
nnoremap \0 :e settings.py<cr>
nnoremap \9 :e urls.py<cr>

fun! RelatedFile(file)
    #This is to check that the directory looks djangoish
    if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
        exec "edit %:h/" . a:file
        let g:last_relative_dir = expand("%:h") . '/'
        return ''
    endif
    if g:last_relative_dir != ''
        exec "edit " . g:last_relative_dir . a:file
        return ''
    endif
    echo "Cant determine where relative file is : " . a:file
    return ''
endfun

fun SetAppDir()
    if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
        let g:last_relative_dir = expand("%:h") . '/'
        return ''
    endif
endfun
autocmd BufEnter *.py call SetAppDir()
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd fileType javascript set omnifunc=javascriptcomplete#Complete
autocmd fileType html set omnifunc=htmlcomplete#Complete
autocmd fileType css set omnifunc=csscomplete#Complete
set relativenumber
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set termencoding=cp1250
set enc=utf-8
set fencs=ucs-bom,utf-8,iso-8859-2,cp1250
set listchars=tab:▸\ ,eol:¬,trail:¶
set guifont+=Anonymous:cEASTEUROPE:h11
set guioptions-=m 
set guioptions-=T 
set laststatus=2
set statusline=%<%f\ %y%h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
language messages en
colorscheme desert
