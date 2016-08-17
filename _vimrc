filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on
syntax on
set autoindent
set smartindent
set incsearch
set backspace=indent,eol,start
if has("autocmd")
	autocmd bufwritepost _vimrc source $HOME/vimfiles/_vimrc
    autocmd FocusLost * silent! wa
    au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 
    au BufEnter *.org            call org#SetOrgFileType()
endif
let mapleader = ','
let g:surround_{char2nr("b")} = "{% block\1 \r..*\r &\1%}\r{% endblock %}"
let g:surround_{char2nr("i")} = "{% if\1 \r..*\r &\1%}\r{% endif %}"
let g:surround_{char2nr("w")} = "{% with\1 \r..*\r &\1%}\r{% endwith %}"
let g:surround_{char2nr("c")} = "{% comment\1 \r..*\r &\1%}\r{% endcomment %}"
let g:surround_{char2nr("f")} = "{% for\1 \r..*\r &\1%}\r{% endfor %}"
nmap <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>
nmap <leader>v :edit $HOME/vimfiles/_vimrc<CR>
nmap <leader>l :set list!<CR>
map <leader>f :CtrlP<CR>
map <leader>b :CtrlPBuffer<CR>
map <leader>r :set relativenumber!<CR>
map <leader>c :set cursorline!<CR>
map <leader>n :set number!<CR>
map <leader>h :set hls!<CR>
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

fun! SetAppDir()
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
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set termencoding=cp1250
set enc=utf-8
set fencs=ucs-bom,utf-8,iso-8859-2,cp1250
set listchars=tab:⌦\ ,eol:¬,trail:¶
set guifont+=Anonymous\ Pro:cEASTEUROPE:h14
set guioptions-=m 
set guioptions-=T 
set laststatus=2
set relativenumber
set cursorline
set statusline=%<%f\ %Y%H%M%R%=%k%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}\ %-14.(%l,%c%V%)\ %P
language messages en
set background=dark
colorscheme solarized
fun! MakeDimensions()
    :%substitute/\s\{2\}/ /g | %substitute/\s\{2\}/ /g | %s/\s/×/g | %s/$/ mm
endfun
nnoremap <Up> gk
nnoremap <Down> gj

" Konfiguracja połączenia scp
let g:netrw_cygwin = 0
let g:netrw_scp_cmd = 'pscp.exe -P 22 -pw bitnami -scp'
let g:netrw_sftp_cmd = 'psftp.exe -P 22 -pw bitnami -sftp'
let g:netrw_list_cmd = 'plink.exe -P 22 -pw bitnami bitnami@192.168.140.64 ls -Fa '
let g:netrw_ssh_cmd = 'plink -T -ssh'
