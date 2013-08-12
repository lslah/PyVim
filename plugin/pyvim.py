import vim

def clear_matches():
    return vim.eval("clearmatches()")

def get_matches():
    return vim.eval("getmatches()")

def match_add(group_name, pattern, priority=10):
    command = "matchadd('%s', '%s', %d)" % (group_name, pattern, priority)
    match_id = vim.eval(command)
    return int(match_id)

def match_delete(match_id):
    command = "call matchdelete(%s)" % (match_id)
    vim.command(command)

def highlight(group_name, arguments):
    argument_string = __build_argument_string(arguments)
    command = "highlight %s %s" % (group_name, argument_string)
    vim.command(command)

def __build_argument_string(arguments):
    argument_list = ["%s=%s" % (key, value) for key, value in arguments.iteritems()]
    argument_string = ' '.join(argument_list)
    return argument_string

def highlight_clear(group_name):
    command = "highlight clear %s" % group_name
    vim.command(command)
