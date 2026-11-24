set nu
set rnu
syntax on

function! Osc52Yank()
  let l:b64 = system('base64 -w0', join(v:event.regcontents, "\n"))
  call writefile(["\e]52;c;" . l:b64 . "\x07"], '/dev/tty', 'b')
endfunction
autocmd TextYankPost * if v:event.operator ==# 'y' | call Osc52Yank() | endif
