call pathogen#helptags()
execute pathogen#infect()

set spell spelllang=en_us
set nospell
set hlsearch
syntax on

function Hello()
  echo "Hello, World!"
endfunction

set modeline
colors badwolf
highlight Normal ctermbg=None
highlight Comment ctermbg=None
highlight Constant ctermbg=None
highlight Normal ctermbg=None
highlight NonText ctermbg=None
highlight Special ctermbg=None
highlight Cursor ctermbg=None

" Like windo but restore the current window.
function! WinDo(command)
  let currwin=winnr()
  execute 'windo ' . a:command
  execute currwin . 'wincmd w'
endfunction
com! -nargs=+ -complete=command Windo call WinDo(<q-args>)
" Like bufdo but restore the current buffer.
function! BufDo(command)
  let currBuff=bufnr("%")
  execute 'bufdo ' . a:command
  execute 'buffer ' . currBuff
endfunction
com! -nargs=+ -complete=command Bufdo call BufDo(<q-args>)
" Like tabdo but restore the current tab.
function! TabDo(command)
  let currTab=tabpagenr()
  execute 'tabdo ' . a:command
  execute 'tabn ' . currTab
endfunction
com! -nargs=+ -complete=command Tabdo call TabDo(<q-args>)

" C code documentation helper (see notebook, 11/26/15)
function GetCurFct()
  " http://vim.wikia.com/wiki/Display_the_name_of_the_function_you_are_editing
  let strList = ["while", "foreach", "ifelse", "if else", "for", "if", "else", "try", "catch", "case", "switch"]
  let foundcontrol = 1
  let position = ""
  let pos=getpos(".")          " This saves the cursor position
  let view=winsaveview()       " This saves the window view
  while (foundcontrol)
    let foundcontrol = 0
    normal [{
    call search('\S','bW')
    let tempchar = getline(".")[col(".") - 1]
    if (match(tempchar, ")") >=0 )
      normal %
      call search('\S','bW')
    endif
    let tempstring = getline(".")
    for item in strList
      if( match(tempstring,item) >= 0 )
        let position = item . " - " . position
        let foundcontrol = 1
        break
      endif
    endfor
    if(foundcontrol == 0)
      call cursor(pos)
      call winrestview(view)
      return tempstring.position
    endif
  endwhile
  call cursor(pos)
  call winrestview(view)
  return tempstring.position
endfunction
function GetCurFctName()
  " https://www.ibm.com/developerworks/library/l-vim-script-2/index.html
  let fct =  GetCurFct()
  return substitute(fct,'(.*)','','g')
endfunction
"function GetCurFctArgs()
"   TBD
"endfunction

function! GetCLine()
  " let @x=@%." :: [line: ".expand(line(".") + 1).", function: ".GetCurFct()."] : ".expand(getline('.'))
  let @x=expand(getline('.'))." [".expand(line(".") + 1).": ".GetCurFctName()." in ".@%."]"
endfunction
function! GetCFunction()
  let @x=GetCurFctName()." [in ".@%."]"
endfunction
" Mapping for "case notes"
nmap nl :call GetCLine() <cr>
nmap nf :call GetCFunction() <cr>
nmap np "xp <cr>

" Remap ESC to something more convenient
" (http://vim.wikia.com/wiki/Avoid_the_escape_key)
inoremap jj <ESC>

" Set scripts to be executable from the shell
" http://unix.stackexchange.com/questions/39982/vim-create-file-with-x-bit
au BufWritePost * if getline(1) =~ "^#!\s*/bin/" | silent execute "!chmod a+x <afile>" | endif

let g:templates_directory = '~/.vim/templates'
let g:email ='ccalinus@yahoo.com'

let g:bookmark_save_per_working_dir = 1
let g:bookmark_highlight_lines = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#bookmark#enabled = 1

" A naive implementation of https://stackoverflow.com/questions/11975174/how-do-i-search-the-open-buffers-in-vim
" A better solution is in vim-ingo-library.git vim-GrepCommands.git
function s:MyBufGrep(...)
  if a:0 != 1
    echomsg "The function requires 1 argument"
    return 1
  endif
  echomsg "Searching for ".a:1." in all open buffers"
  cexpr []
  echomsg 'bufdo vimgrepadd '.a:1.' %'
  execute 'bufdo vimgrepadd! '.a:1.' %'
endfunction
command! -bang -count -nargs=? MyBufGrep call s:MyBufGrep(<f-args>)

" Setting for finding kernel structures.
" Example:
"    ag --vimgrep  "struct device_node {" include
" or in vim:
" :Ack "struct device_node {" include
" See https://github.com/ggreer/the_silver_searcher
let g:ackprg = 'ag --vimgrep'

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

au FileType c set noet ts=8 sw=8 spell
au FileType arduino set et ts=4 sw=4 spell
au FileType markdown set et ts=4 sw=4 spell
au FileType rst set et ts=4 sw=4 spell
au FileType gitcommit set et ts=4 sw=4 spell
au FileType bitbake set et ts=4 sw=4 spell

let g:localvimrc_enable    = 1
let g:localvimrc_name      =  [ ".lvimrc" ]
let g:localvimrc_event     =  [ "BufWinEnter","BufRead","BufNewFile" ]
let g:localvimrc_sandbox   = 0
let g:localvimrc_whitelist = '/home/ccopos/PROJECTS/*'
