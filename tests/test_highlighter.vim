let s:tc = unittest#testcase#new("highlighter")

function s:tc.SETUP()
    python import highlighter
    python reload(highlighter)
    highlight MyGroup ctermbg=9
endfunction

" Highlight group shouldn't change on default construction.
function s:tc.test_constructor_without_color_dict()
    highlight clear AOEU
    highlight AOEU ctermbg=20
    python highlight = highlighter.Highlighter('AOEU')
	let s:actual_bg = synIDattr(synIDtrans(hlID('AOEU')), 'bg')
	let s:actual_fg = synIDattr(synIDtrans(hlID('AOEU')), 'fg')
    call self.assert_equal('20', s:actual_bg)
    call self.assert_equal('-1', s:actual_fg)
endfunction

" Highlighter should only overwrite values named in the dict, but not clear
" all other colors.
function s:tc.test_constructor_with_color_dict()
    highlight clear AOEU
    highlight AOEU ctermbg=20 ctermfg=20
    python highlight = highlighter.Highlighter('AOEU', {'ctermfg': '10'})
	let s:actual_bg = synIDattr(synIDtrans(hlID('AOEU')), 'bg')
	let s:actual_fg = synIDattr(synIDtrans(hlID('AOEU')), 'fg')
    call self.assert_equal('20', s:actual_bg)
    call self.assert_equal('10', s:actual_fg)
endfunction

function s:tc.test_clear_colors()
    highlight AOEU ctermbg=20
    python highlight = highlighter.Highlighter('AOEU')
    python highlight.clear_colors()
	let s:actual_bg = synIDattr(synIDtrans(hlID('AOEU')), 'bg')
    call self.assert_equal('-1', s:actual_bg)
endfunction

function s:tc.test_set_colors()
    highlight clear AOEU
    python highlight = highlighter.Highlighter('AOEU')
    python highlight.set_colors({'ctermfg': '10', 'ctermbg': '9'})
	let s:actual_bg = synIDattr(synIDtrans(hlID('AOEU')), 'bg')
	let s:actual_fg = synIDattr(synIDtrans(hlID('AOEU')), 'fg')
    call self.assert_equal('9', s:actual_bg)
    call self.assert_equal('10', s:actual_fg)
endfunction

function s:tc.test_match_add()
    call clearmatches()
    python highlight = highlighter.Highlighter('AOEU', {'ctermbg': 9})
    python highlight.match_add('test')
    let s:matches = getmatches()
    call self.assert_equal('1', len(s:matches))
    call clearmatches()
endfunction

" Also delete matches, which were previously defined by another object or vim.
function s:tc.test_clear_matches()
    call clearmatches()
    call matchadd('MyGroup', 'test')
    python highlight = highlighter.Highlighter('MyGroup')
    python highlight.clear_matches()
    let s:matches = getmatches()
    call self.assert_equal('0', len(s:matches))
    call clearmatches()
endfunction
