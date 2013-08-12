import vim

def clear_matches():
    return vim.eval("clearmatches()")

def get_matches():
    return vim.eval("getmatches()")

def match_add(group_name, pattern, priority=10):
    command = "matchadd('%s', '%s', %d)" % (group_name, pattern, priority)
    match_id = vim.eval(command)
    return int(match_id)


