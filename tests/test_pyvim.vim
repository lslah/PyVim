let s:tc = unittest#testcase#new("pyvim")

function! s:tc.SETUP()
    python import pyvim
    " Reload in case pyvim was already imported.
    python reload(pyvim)

    hi MyGroup ctermbg=red
endfunction

function! s:tc.test_get_matches()
    call clearmatches()
    let s:count_matches = g:python_call("len(pyvim.get_matches())")
    call self.assert_equal('0', s:count_matches)
    
    call matchadd('MyGroup', 'test')
    let s:count_matches = g:python_call("len(pyvim.get_matches())")
    call self.assert_equal('1', s:count_matches)

    call matchadd('MyGroup', 'test')
    let s:count_matches = g:python_call("len(pyvim.get_matches())")
    call self.assert_equal('2', s:count_matches)

    call clearmatches()
endfunction

function! s:tc.test_clear_matches()
    call matchadd('MyGroup', 'test')
    python PyVim.clear_matches()

    let s:count_matches = len(getmatches())
    call self.assert_equal('0', s:count_matches)
endfunction

function! s:tc.test_match_add()
    call clearmatches()
    let s:match_id = g:python_call("PyVim.match_add('MyGroup', 'test', -20)")

    let s:matches = getmatches()
    call self.assert_equal('1', len(s:matches))

    let match = s:matches[0]
    let expected = {
                \ 'group': 'MyGroup',
                \ 'pattern': 'test',
                \ 'priority': -20,
                \ 'id': 0 + s:match_id
                \ }
    call self.assert_equal(expected, match)
    call clearmatches()
endfunction
