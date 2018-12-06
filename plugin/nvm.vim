let nvm_node_symlink_path=" ~/.config/nvim/bin/node"

"links g:nvm_node_symlink_path symlink to the given a:nodeVersion nvm node bin
"
"@param {string} nodeVersion - The node version we want to select from nvm
"installs. Ex: 'v.8.12.0'
"Will :echoerr if given a:nodeVersion cannot be found in nvm installs path
"
"@returns {void}
function! NvmSelect(nodeVersion)
  let path = expand("~/.nvm/versions/node/" . a:nodeVersion . "/bin/node")
  if filereadable(l:path)
    :execute(":!ln -snf " . l:path . " " . g:nvm_node_symlink_path)
  else
    :echoerr "node " . a:nodeVersion . " not found, make sure it is installed"
  endif
endfunction

"Opens an horizontal split, displaying every nvm node versions available in
"it. Maps <CR> and double left click so that it selects the ndoe version on
"the current line
"
"@returns {void}
function! NvmList()
  :new
  :read !find ~/.nvm/versions/node -maxdepth 1 -type d| grep "v[0-9]" |sed "s/^.*\(v[0-9].*\)$/\1/" |sort -rV
  :1
  :delete p
  :map <buffer> <CR> :call NvmSelect(getline('.'))<CR>:q<CR>
  :map <buffer> <2-LeftMouse> :call NvmSelect(getline('.'))<CR>:q<CR>
  :setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nowrap
endfunction

"Selects the node version found in ./.nvmrc
"
"@returns {void}
function! NvmUse()
  let nodeVersion = substitute(system('cat ./.nvmrc'), '\n\+$', '', '')
  call NvmSelect("v" . l:nodeVersion)
endfunction

command! -nargs=0 NvmList call NvmList()
command! -nargs=0 NvmUse call NvmUse()


