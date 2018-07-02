call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set spell spelllang=en_us
set hlsearch
syntax on

function Hello()
        echo "Hello, World!"
endfunction

set ts=4
set shiftwidth=4

set modeline
colors koehler

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
"
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
