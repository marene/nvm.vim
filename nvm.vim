let nvm_node_symlink_path=" ~/.config/nvim/bin/node"

function! NvmSelect(nodeVersion)
  let path = expand("~/.nvm/versions/node/" . a:nodeVersion . "/bin/node")
  if filereadable(l:path)
    :execute(":!ln -snf " . l:path . " " . g:nvm_node_symlink_path)
  else
    :echoerr "node " . a:nodeVersion . " not found, make sure it is installed"
  endif
endfunction

function! NvmList()
  :new
  :read !find ~/.nvm/versions/node -maxdepth 1 -type d| grep "v[0-9]" |sed "s/^.*\(v[0-9].*\)$/\1/" |sort -rV
  :1
  :delete p
  :map <buffer> <CR> :call NvmSelect(getline('.'))<CR>:q<CR>
  :map <buffer> <2-LeftMouse> :call NvmSelect(getLine('.'))<CR>:q<CR>
  :setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nowrap
endfunction

function! NvmUse()
  let nodeVersion = "v" . system('cat ./.nvmrc')
  call NvmSelect(l:nodeVersion)
endfunction

command! -nargs=0 NvmList call NvmList()
command! -nargs=0 NvmUse call NvmUse()


