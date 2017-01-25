" http://vim.wikia.com/wiki/How_to_write_a_plugin
"
" Copyright © %YEAR% %USER% <%MAIL%>
" Distributed under terms of the %LICENSE% license.

" ------------------------------------------------------------------------------
" Exit when your app has already been loaded (or "compatible" mode set)
if exists("g:loaded_YourAppName") || &cp
  finish
endif
let g:loaded_YourAppName= 123 " your version number
let s:keepcpo           = &cpo
set cpo&vim

" Public Interface:
" AppFunction: is a function you expect your users to call
" PickAMap: some sequence of characters that will run your AppFunction
" Repeat these three lines as needed for multiple functions which will
" be used to provide an interface for the user
if !hasmapto('<Plug>AppFunction')
  map <unique> <Leader>PickAMap <Plug>AppFunction
endif

" Global Maps:
"
noremap <silent> <unique> <script> <Plug>AppFunction
 \ :set lz<CR>:call <SID>AppFunction()<CR>:set nolz<CR>

" ------------------------------------------------------------------------------
" s:AppFunction: this function is available via the <Plug>/<script> interface above
fun! s:AppFunction()
  ..whatever..

  " your script function can set up maps to internal functions
  nnoremap <silent> <Left> :set lz<CR>:silent! call <SID>AppFunction2()<CR>:set nolz<CR>

  " your app can call functions in its own script and not worry about name
  " clashes by preceding those function names with <SID>
  call s:InternalAppFunction(...)

  " or you could call it with
  call s:InternalAppFunction(...)
endfun

" ------------------------------------------------------------------------------
" s:InternalAppFunction: this function cannot be called from outside the
" script, and its name won't clash with whatever else the user has loaded
fun! s:InternalAppFunction(...)

  ..whatever..
endfun

" ------------------------------------------------------------------------------
let &cpo= s:keepcpo
unlet s:keepcpo
With vim 7.0 comes a new feature that strongly affects plugin writing: autoload. This feature reduces the turn-on time for vim; the idea is to split your plugin into two parts, one containing the public interface and one containing the bulk of the script. As always, the plugin portion is always loaded; the autoload portion is loaded only when needed. Functions are written using

fun! NameOfScriptFile#FunctionName()
...
endfun
