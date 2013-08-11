let s:tc = unittest#testcase#new("PyVim")

function! s:tc.SETUP()
    python import PyVim
    " Reload in case PyVim was already imported.
    python reload(PyVim)

    hi MyGroup ctermbg=red
endfunction

function! s:tc.test_get_matches()
    call clearmatches()
    let s:count_matches = g:python_call("len(PyVim.get_matches())")
    call self.assert_equal('0', s:count_matches)
    
    call matchadd('MyGroup', 'test')
    let s:count_matches = g:python_call("len(PyVim.get_matches())")
    call self.assert_equal('1', s:count_matches)

    call matchadd('MyGroup', 'test')
    let s:count_matches = g:python_call("len(PyVim.get_matches())")
    call self.assert_equal('2', s:count_matches)

    call clearmatches()
endfunction
