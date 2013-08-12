import pyvim

class Highlighter(object):
    def __init__(self, group, color_dict=None):
        self.group = group
        if color_dict:
            self.set_colors(color_dict)

    def clear_colors(self):
        pyvim.highlight_clear(self.group)

    def set_colors(self, color_dict):
        pyvim.highlight(self.group, color_dict)

    def match_add(self, pattern):
        match_id = pyvim.match_add(self.group, pattern)
        return match_id

    def clear_matches(self):
        match_ids = self.__get_match_ids()
        for match_id in match_ids:
            pyvim.match_delete(match_id)

    def __get_match_ids(self):
        all_matches = pyvim.get_matches()
        group_matches = [x for x in all_matches if x['group'] == self.group]
        match_ids = [match['id'] for match in group_matches]
        return match_ids
