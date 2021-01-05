"=============================================================================
" FILE: filetype.vim
" AUTHOR:  Alex Layton <omytty.alex@126.com>
" License: MIT license
"=============================================================================

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" html5_vim
" HTML5 + inline SVG omnicomplete function, indent and syntax for Vim. Based on the default htmlcomplete.vim.
" https://github.com/othree/html5.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:html5_vim = {'name': 'html5.vim'}
function! s:html5_vim.preloader()
  let g:html5_event_handler_attributes_complete = materia#conf('packages.html5_vim.attr_event_handler')
  let g:html5_rdfa_attributes_complete = materia#conf('packages.html5_vim.attr_rdfa')
  let g:html5_microdata_attributes_complete = materia#conf('packages.html5_vim.attr_microdata')
  let g:html5_aria_attributes_complete = materia#conf('packages.html5_vim.attr_aria')
endfunction
function! s:html5_vim.loader()
  let filetypes = materia#conf('packages.html5_vim.filetypes')
  execute 'autocmd FileType '. join(filetypes, ',') .' EmmetInstall'
endfunction
function! s:html5_vim.installer(install)
  call a:install('othree/html5.vim')
endfunction
call materia#packages#add('html5_vim', s:html5_vim)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" emmet_vim
" emmet-vim is a vim plug-in which provides support for expanding abbreviations similar to emmet.
" https://github.com/mattn/emmet-vim
" snippets.json Doc:
" https://docs.emmet.io/customization/snippets/
"
" An Interface to WEB APIs.
" https://github.com/mattn/webapi-vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:emmet_vim = {'name': 'emmet-vim'}
function! s:emmet_vim.preloader()
  if materia#conf('html.snippet_path')
    let g:user_emmet_install_global = 0
    let snippet_path = materia#conf('packages.emmet_vim.snippet_path')
    if snippet_path
      let g:user_emmet_settings = webapi#json#decode(join(readfile(expand(s:snippet_path)), "\n"))
    endif
  endif
  let g:user_emmet_leader_key = '<C-' . materia#conf('packages.emmet_vim.key_ctrl') . '>'
endfunction
function! s:emmet_vim.loader()
  if (exists('g:loaded_emmet_vim') && g:loaded_emmet_vim)
    let filetypes = materia#conf('packages.emmet_vim.filetypes')
    execute 'autocmd FileType '. join(filetypes, ',') .' EmmetInstall'
  endif
endfunction
function! s:emmet_vim.installer(install)
  call a:install('mattn/emmet-vim')
  call a:install('mattn/webapi-vim')
endfunction
call materia#packages#add('emmet_vim', s:emmet_vim)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntastic
" Syntastic is a syntax checking plugin for Vim created by Martin Grenfell.
" It runs files through external syntax checkers and displays any resulting errors to the user.
" https://github.com/vim-syntastic/syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:syntastic = {'name': 'syntastic'}

function! s:syntastic.preloader()
  " status line
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
endfunction

function! s:syntastic.installer(install)
  call a:install('vim-syntastic/syntastic')
endfunction
call materia#packages#add('syntastic', s:syntastic)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nginx
" Improved nginx vim plugin (incl. syntax highlighting)
" https://github.com/chr4/nginx.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:nginx = {'name': 'nginx.vim'}
function! s:nginx.installer(install)
  call a:install('chr4/nginx.vim')
endfunction
call materia#packages#add('nginx', s:nginx)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim_go
" Go development plugin for Vim
" https://github.com/fatih/vim-go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:vim_go = {'name': 'vim-go'}
function! s:vim_go.preloader()
  " modes
  let g:go_def_mode = 'gopls'
  let g:go_info_mode='gopls'
  let g:go_referrers_mode = 'gopls'
  let g:go_imports_mode = "goimports"
  let g:go_implements_mode = 'gopls'
  " commands
  let g:go_fmt_command='gofmt'
  let g:go_rename_command = 'gopls'
  " options
  let g:go_fmt_options = {}
  let g:go_gopls_options = ['-remote=auto']
  " autosave
  let g:go_fmt_autosave = materia#conf('packages.vim_go.fmt_autosave')
  let g:go_mod_fmt_autosave = materia#conf('packages.vim_go.mod_fmt_autosave')
  let g:go_imports_autosave = materia#conf('packages.vim_go.imports_autosave')
  let g:go_fmt_fail_silently = 1
  " features
  let g:go_gopls_enabled = 1
  let g:go_code_completion_enabled = 1
  " Status line types/signatures
  let g:go_auto_type_info = 1
  let g:go_doc_popup_window = 1
  " This is disabled to use coc-go, vim-go just use commands
  let g:go_def_mapping_enabled = 0
  " this breaks folding on vim < 8.0 or neovim
  if v:version >= 800 || has('nvim')
    let g:go_fmt_experimental = 1
  endif
  " highlight options
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_build_constraints = 1
  let g:go_highlight_types = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_function_calls = 1
  let g:go_highlight_generate_tags = 1

  " let g:go_highlight_extra_types = 1
  " let g:go_highlight_operators = 1
  " let g:go_highlight_function_parameters = 1
  " let g:go_highlight_function_calls = 1
  " let g:go_highlight_types = 1
  " let g:go_highlight_fields = 1
  " let g:go_highlight_generate_tags = 1
  " let g:go_highlight_string_spellcheck = 1
  " let g:go_highlight_format_strings = 1
  " let g:go_highlight_variable_declarations = 1
  " let g:go_highlight_variable_assignments = 1

  " go metalinter
  let g:go_metalinter_autosave_enabled = ['all']
  let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
  let g:go_metalinter_command = "golangci-lint"

  " key mappings
  let runner = materia#conf('key.runner')
  let coding = materia#conf('key.coding')
  let writer = materia#conf('key.writer')
  " executecurrent file(s) gl
  execute 'autocmd FileType go nmap <buffer> <silent> '. runner .'r <Plug>(go-run)'
  execute 'autocmd FileType go nmap <buffer> <silent> '. runner .'b <Plug>(go-build)'
  execute 'autocmd FileType go nmap <buffer> <silent> '. runner .'i <Plug>(go-install)'
  execute 'autocmd FileType go nmap <buffer> <silent> '. writer . coding .'p <Plug>(go-imports)'
  execute 'autocmd FileType go nmap <buffer> <silent> '. runner .'m <Plug>(go-metalinter)'
  execute 'autocmd FileType go nmap <buffer> <silent> '. runner .'l <Plug>(go-lint)'
  execute 'autocmd FileType go nmap <buffer> <silent> '. runner .'v <Plug>(go-vet)'
  execute 'autocmd FileType go nmap <buffer> <silent> '. runner .'e <Plug>(go-alternate-edit)'
  " go test
  execute 'autocmd FileType go nmap <buffer> <silent> '. runner .'tt <Plug>(go-test)'
  execute 'autocmd FileType go nmap <buffer> <silent> '. runner .'tf <Plug>(go-test-func)'
  execute 'autocmd FileType go nmap <buffer> <silent> '. runner .'tc <Plug>(go-test-compile)'

  execute 'autocmd FileType go nmap <buffer> <silent> <localleader>f <Plug>(go-files)'
  execute 'autocmd FileType go nmap <buffer> <silent> <localleader>i <Plug>(go-describe)'
  execute 'autocmd FileType go nmap <buffer> <silent> <localleader>p <Plug>(go-pointsto)'
  execute 'autocmd FileType go nmap <buffer> <silent> <localleader>w <Plug>(go-whicherrs)'
  execute 'autocmd FileType go nmap <buffer> <silent> <localleader>ce <Plug>(go-callees)'
  execute 'autocmd FileType go nmap <buffer> <silent> <localleader>cr <Plug>(go-callees)'
  execute 'autocmd FileType go nmap <buffer> <silent> <localleader>d <Plug>(go-doc)'
  execute 'autocmd FileType go nmap <buffer> <silent> <localleader>b <Plug>(go-browser)'
  " freevars
  execute 'autocmd FileType go xmap <buffer> <silent> <localleader>v <Plug>(go-freevars)'
endfunction

function! s:vim_go.installer(install)
  call a:install('fatih/vim-go', { 'do': ':GoUpdateBinaries' })
endfunction

call materia#packages#add('vim_go', s:vim_go)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim_javascript
" JavaScript bundle for vim, this bundle provides syntax highlighting and improved indentation.
" https://github.com/pangloss/vim-javascript
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:vim_javascript = {'name': 'vim-javascript'}
function! s:vim_javascript.preloader()
  let g:javascript_plugin_jsdoc = materia#conf('packages.vim_javascript.attr_plugin_jsdoc')
  let g:javascript_plugin_ngdoc = materia#conf('packages.vim_javascript.attr_plugin_ngdoc')
  let g:javascript_plugin_flow = materia#conf('packages.vim_javascript.attr_plugin_flow')

  augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
  augroup END
endfunction
function! s:vim_javascript.installer(install)
  call a:install('pangloss/vim-javascript')
endfunction
call materia#packages#add('vim_javascript', s:vim_javascript)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim_json
" A better JSON for Vim: distinct highlighting of keywords vs values, JSON-specific (non-JS) warnings, quote concealing. Pathogen-friendly.
" https://github.com/elzr/vim-json
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:vim_json = {'name': 'vim-json'}

function! s:vim_json.preloader()
  set conceallevel=0
  let g:vim_json_syntax_conceal = materia#conf('packages.vim_json.syntax_conceal')
endfunction

function! s:vim_json.installer(install)
  call a:install('elzr/vim-json')
endfunction

call materia#packages#add('vim_json', s:vim_json)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" typescript_vim
" Typescript syntax files for Vim
" https://github.com/leafgarland/typescript-vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:typescript_vim = {'name': 'typescript-vim'}
function! s:typescript_vim.preloader()
  let g:typescript_compiler_binary = materia#conf('packages.typescript_vim.attr_compiler_binary')
  let g:typescript_compiler_options = materia#conf('packages.typescript_vim.attr_compiler_options')

  autocmd FileType typescript :set makeprg=tsc

  autocmd QuickFixCmdPost [^l]* nested cwindow
  autocmd QuickFixCmdPost    l* nested lwindow
endfunction

function! s:typescript_vim.installer(install)
  call a:install('leafgarland/typescript-vim')
endfunction

call materia#packages#add('typescript_vim', s:typescript_vim)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim_jsx
" React JSX syntax highlighting and indenting for vim.
" https://github.com/mxw/vim-jsx
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:vim_jsx = {'name': 'vim-jsx'}
function! s:vim_jsx.installer(install)
  call a:install('mxw/vim-jsx')
endfunction
call materia#packages#add('vim_jsx', s:vim_jsx)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim_markdown
" This is the development version of Vim's included syntax highlighting and filetype plugins for Markdown.
" https://github.com/tpope/vim-markdown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:vim_markdown = {'name': 'vim-markdown'}
function! s:vim_markdown.preloader()
  let g:markdown_fenced_languages = materia#conf('packages.vim_markdown.attr_fenced_languages')
  let g:markdown_minlines = materia#conf('packages.vim_markdown.attr_minlines')
endfunction
function! s:vim_markdown.installer(install)
  call a:install('tpope/vim-markdown')
endfunction
call materia#packages#add('vim_markdown', s:vim_markdown)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cpp_enhanced_highlight
" Additional Vim syntax highlighting for C++ (including C++11/14/17)
" https://github.com/octol/vim-cpp-enhanced-highlight
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:cpp_enhanced_highlight = {'name': 'vim-cpp-enhanced-highlight'}
function! s:cpp_enhanced_highlight.preloader()
  let g:cpp_class_scope_highlight = 1
  let g:cpp_member_variable_highlight = 1
  let g:cpp_class_decl_highlight = 1
  let g:cpp_experimental_template_highlight = 1
  let c_no_curly_error=1
endfunction
function! s:cpp_enhanced_highlight.installer(install)
  call a:install('octol/vim-cpp-enhanced-highlight')
endfunction
call materia#packages#add('cpp_enhanced_highlight', s:cpp_enhanced_highlight)