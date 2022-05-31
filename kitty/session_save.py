#####################
# session_save.py
#####################

import os
import json

dir = os.path.dirname(__file__)

json_path = 'kitty-session.json'
sess_dump_path = os.path.join(dir, json_path)

def createSession(output, sessionData):
    for os_window in sessionData:
        for tab in os_window['tabs']:
            output.write('new_tab '+tab['title'])
            output.write('\n')
            output.write('cd '+tab['windows'][0]['cwd'])
            output.write('\n')
            window_count = 0
            for window in tab['windows']:
                tabs = len(tab['windows'])
                if window['is_focused']:
                    output.write('focus')
                    output.write('\n')
                    window_count+=1
                if tabs-window_count == 0:
                    break
                output.write('launch zsh')
                output.write('\n')
                window_count+=1


with open(sess_dump_path) as f:
    sessData = json.load(f)
    sess_file_path = 'session.conf'
    sess_full_path = os.path.join(dir, sess_file_path)
    s = open(sess_full_path,'w')
    createSession(s,sessData)
    s.close()

f.close()
