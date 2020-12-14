"=============================================================================
" FILE: plug_loaded.vim
" AUTHOR:  Alex Layton <omytty.alex@126.com>
" License: MIT license
"=============================================================================

augroup plug_loaded
  autocmd!
  autocmd User AutomemoriesPlugLoaded
    \  call ListenerLoadedPlugStartify()
    \| call ListenerPlugLoadedNerdtree()
    \| call ListenerPlugLoadedAirline()
    \| call ListenerPlugLoadedAirLineThemes()
    \| call ListenerPlugLoadedCoc()
    \| call ListenerPlugLoadedVista()
    \| call ListenerPlugLoadedFugitive()
    \| call ListenerPlugLoadedUndotree()
    \| call ListenerPlugLoadedVimPhpNamespace()
    \| call ListenerPlugLoadedOnehalf()
augroup end
