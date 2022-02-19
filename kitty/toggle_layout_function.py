#####################
# toggleLayout_function.py
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
        if len(tab.windows) <= 1: # if there is only 1 window (first time command runs)
            # tab.goto_layout('tall')
            tab.goto_layout('fat')
            boss.new_window_with_cwd()
        else:
            if tab.current_layout.name == 'stack': # stack is layout with 1 maximized window
                tab.first_window()
                tab.next_layout()
                # tab.neighboring_window('right') # focus the neighboring window to the right
                tab.nth_window(-1) # focus the previously active window
            # elif tab.current_layout.name == 'tall':
            elif tab.current_layout.name != 'stack':
                tab.first_window() # make first window active
                tab.goto_layout('stack') # make it maximized, leaving the rest "hidden"
            else: 
                tab.next_layout() # just in case
