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
    python pyvim.clear_matches()

    let s:count_matches = len(getmatches())
    call self.assert_equal('0', s:count_matches)
endfunction

function! s:tc.test_match_add()
    call clearmatches()
    let s:match_id = g:python_call("pyvim.match_add('MyGroup', 'test', -20)")

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

function! s:tc.test_match_delete()
    call clearmatches()
    let s:match_id = matchadd('MyGroup', 'test')
    execute 'python pyvim.match_delete('.s:match_id.')'
    let s:matches = getmatches()
    call self.assert_equal('0', len(s:matches))
endfunction

function! s:tc.test_highlight()
    highlight clear MyGroup
    python pyvim.highlight('MyGroup', {'ctermbg': '10', 'ctermfg':'9'})
	let s:actual_bg = synIDattr(synIDtrans(hlID('MyGroup')), 'bg')
	let s:actual_fg = synIDattr(synIDtrans(hlID('MyGroup')), 'fg')
    call self.assert_equal('10', s:actual_bg)
    call self.assert_equal('9', s:actual_fg)
endfunction

function! s:tc.test_highlight_clear()
    highlight MyGroup ctermfg=20
    python pyvim.highlight_clear('MyGroup')
	let s:actual_fg = synIDattr(synIDtrans(hlID('MyGroup')), 'fg')
    call self.assert_equal('-1', s:actual_fg)
endfunction
