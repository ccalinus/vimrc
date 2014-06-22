call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

color koehler
set spell spelllang=en_us
set hlsearch
syntax on

function Hello()
        echo "Hello, World!"
endfunction

set ts=4
set shiftwidth=4

set modeline

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

" Remap ESC to something more convenient
" (http://vim.wikia.com/wiki/Avoid_the_escape_key)
inoremap jj <ESC>
