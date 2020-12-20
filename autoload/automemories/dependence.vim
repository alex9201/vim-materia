"=============================================================================
" FILE: service.vim
" AUTHOR:  Alex Layton <omytty.alex@126.com>
" License: MIT license
"=============================================================================
scriptencoding utf-8

let s:dependencies = {}

function! automemories#dependence#get(name) abort
  if !has_key(s:dependencies, a:name)
    try
      let s:dependencies[a:name] = automemories#dependence#{a:name}#instance()
    catch
      return 0
    endtry
  endif
  return s:dependencies[a:name]
endfunction
