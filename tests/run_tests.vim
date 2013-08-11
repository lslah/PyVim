function! g:python_call(command)
    python command = vim.eval('a:command')
    python result = eval(command)
    python vim.command('let l:return = "' + str(result) + '"')
    return l:return
endfunction

python import vim
python sys.path.append(os.getcwd() + "/plugin")

let s:test_cases = ""
let s:test_cases .= "tests/test_pyvim.vim "

execute "UnitTest " . s:test_cases
