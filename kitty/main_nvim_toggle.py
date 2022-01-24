#####################
# main_nvim_toggle.py
#####################

def main(args):
    pass

from typing import List
from kitty.boss import Boss
from kittens.tui.handler import result_handler
from kittens.tui.loop import debug

@result_handler(no_ui=True)
def handle_result(args, answer, target_window_id, boss):
    tab = boss.active_tab
        # tab.goto_
    if tab is not None:
        if len(tab.windows) <= 1:
            tab.goto_layout('tall')
            boss.new_window_with_cwd()
        else:
            if tab.current_layout.name == 'stack':
                tab.first_window()
                tab.next_layout()
                tab.neighboring_window('right')
            elif tab.current_layout.name == 'tall':
                tab.first_window()
                tab.goto_layout('stack')
            else: 
                tab.next_layout()
