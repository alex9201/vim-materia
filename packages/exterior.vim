"=============================================================================
" FILE: filetype.vim
" AUTHOR:  Alex Layton <omytty.alex@126.com>
" License: MIT license
"=============================================================================

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" goyo
" Distraction-free writing in Vim.
" https://github.com/junegunn/goyo.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:goyo = {'name': 'goyo.vim'}
function! s:goyo.installer(install)
  call a:install('junegunn/goyo.vim')
endfunction
call materia#packages#add('goyo', s:goyo)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" limelight_vim
" Distraction-free writing in Vim.
" https://github.com/junegunn/limelight.vim
"
" Error: `Cannot calculate background color`:
" https://github.com/junegunn/limelight.vim/issues/39
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:limelight_vim = {'name': 'limelight.vim'}
function! s:limelight_vim.preloader()
  " Color name (:help cterm-colors) or ANSI code
  let g:limelight_conceal_ctermfg = materia#conf('packages.limelight_vim.conceal_ctermfg')
  " Color name (:help gui-colors) or RGB color
  let g:limelight_conceal_guifg = materia#conf('packages.limelight_vim.conceal_guifg')
  " Default: 0.5
  let g:limelight_default_coefficient = materia#conf('packages.limelight_vim.default_coefficient')
  " Number of preceding/following paragraphs to include (default: 0)
  let g:limelight_paragraph_span = materia#conf('packages.limelight_vim.paragraph_span')
  " Highlighting priority (default: 10)
  "   Set it to -1 not to overrule hlsearch
  let g:limelight_priority = materia#conf('packages.limelight_vim.priority')
endfunction

function! s:limelight_vim.loader()
  let key_prefix = GetConfigMapPrefix(materia#conf('packages.limelight_vim.basekey'))
  execute 'nnoremap <silent> '. key_prefix.reader .'l :<C-u>Limelight!!<CR>'
  for n in range(0, 9)
    execute 'nnoremap <silent> '. key_prefix.reader . n .' :<C-u>Limelight 0.'. n .'<CR>'
  endfor
endfunction

function! s:limelight_vim.installer(install)
  call a:install('junegunn/limelight.vim')
endfunction
call materia#packages#add('limelight_vim', s:limelight_vim)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim_airline
" Lean & mean status/tabline for vim that's light as air.
" https://github.com/vim-airline/vim-airline
" https://github.com/vim-airline/vim-airline-themes
" https://github.com/vim-airline/vim-airline/wiki/FAQ
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:vim_airline = {'name': 'vim-airline'}
function ModuleAirLineMateriaAddition(...)
  let builder = a:1
  let system_serv = materia#service#get('system')
  highlight UserStatusLine guifg=#EEEEEE ctermfg=7 guibg=#4169E1 ctermbg=24 gui=NONE cterm=NONE
  call builder.add_section_spaced('UserStatusLine', system_serv.username)
  return 0
endfunction

function! MyLineNumber()
  let system_serv = materia#service#get('system')
  return system_serv.username
endfunction

function! s:vim_airline.preloader()
  " Automatically displays all buffers when there's only one tab open.
  let g:airline#extensions#tabline#enabled = materia#conf('packages.vim_airline.with_tabline')
  let g:airline#extensions#tabline#formatter = materia#conf('packages.vim_airline.tabline_formatter')
  let g:airline#extensions#whitespace#enabled=0
  let g:airline_powerline_fonts=1
  let g:airline_left_sep = "\ue0b0"
  let g:airline_left_alt_sep = "\ue0b1"
  " \ue0ba \ue0bb
  let g:airline_right_sep = "\ue0b2"
  let g:airline_right_alt_sep = "\ue0b3"
  if materia#conf('packages.vim_airline.with_hunks')
    let g:airline#extensions#hunks#enabled = 1
    let g:airline#extensions#hunks#coc_git = 1
  endif
  if materia#conf('packages.vim_airline.with_branch')
    let g:airline#extensions#branch#enabled = 1
  endif
  let g:airline_skip_empty_sections = 1
  let g:bufferline_echo = 0
  if !exists('g:airline_symbols')
    let g:airline_symbols={}
  endif
endfunction

function! s:vim_airline.loader()
  let theme = materia#conf('packages.vim_airline.theme')
  if type(theme) == type('')
    call airline#switch_theme(theme)
  endif
endfunction

function! s:vim_airline.installer(install)
  call a:install('vim-airline/vim-airline')
  call a:install('vim-airline/vim-airline-themes')
endfunction

call materia#packages#add('vim_airline', s:vim_airline)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline_weather
" Vim-airline extension to show weather in the status line.
" https://github.com/Wildog/airline-weather.vim
" https://github.com/mattn/webapi-vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:airline_weather = {'name': 'vim-devicons'}
function! s:airline_weather.preloader()
  let temp_dir = materia#homepath('/temp/airline_weather')
  if !isdirectory(temp_dir)
    call mkdir(temp_dir, 'p')
  endif
  let g:weather#cache_file = temp_dir . '/cache_file'
  let g:weather#area = materia#conf('packages.airline_weather.attr_area')
  let g:weather#cache_ttl = materia#conf('packages.airline_weather.attr_cache_ttl')
endfunction
function! s:airline_weather.installer(install)
  call a:install('Wildog/airline-weather.vim')
  call a:install('mattn/webapi-vim')
endfunction
call materia#packages#add('airline_weather', s:airline_weather)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim_devicons
" Adds filetype glyphs (icons) to various vim plugins.
" https://github.com/ryanoasis/vim-devicons
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:vim_devicons = {'name': 'vim-devicons'}
function! s:vim_devicons.preloader()
  let app_system = materia#service#get('system')
  let g:webdevicons_enable = 1
  if !app_system.is_gui
    let g:webdevicons_enable = 0
  endif
endfunction
function! s:vim_devicons.installer(install)
  call a:install('ryanoasis/vim-devicons')
endfunction
call materia#packages#add('vim_devicons', s:vim_devicons)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim_startify
" https://github.com/mhinz/vim-startify
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:vim_startify = {'name': 'vim-startify'}
function! s:vim_startify.preloader()
  let g:startify_change_to_vcs_root = 1
  let g:startify_session_dir = materia#homepath('/sessions/custom')

  let g:startify_lists = [
    \ { 'type': 'files',     'header': ['   Files']            },
    \ { 'type': 'dir',       'header': ['   Dirs '. getcwd()] },
    \ { 'type': 'sessions',  'header': ['   Sessions']       },
    \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
    \ { 'type': 'commands',  'header': ['   Commands']       },
  \ ]

  let g:startify_custom_header_quotes = materia#conf('packages.vim_startify.header_quotes')
endfunction

function! s:vim_startify.loader()
  " autocmd BufDelete * if empty(filter(tabpagebuflist(), '!buflisted(v:val)')) | Startify | endif
  if has('nvim')
    autocmd TabNewEntered * Startify
  else
    autocmd BufWinEnter *
      \ if !exists('t:startify_new_tab')
      \     && empty(expand('%'))
      \     && empty(&l:buftype)
      \     && &l:modifiable |
      \   let t:startify_new_tab = 1 |
      \   Startify |
      \ endif

    autocmd BufEnter *
      \ if !exists('t:startify_new_tab') && empty(expand('%')) && !exists('t:goyo_master') |
      \   let t:startify_new_tab = 1 |
      \   Startify |
      \ endif
  endif
endfunction

function! s:vim_startify.installer(install)
  call a:install('mhinz/vim-startify')
endfunction
call materia#packages#add('vim_startify', s:vim_startify)