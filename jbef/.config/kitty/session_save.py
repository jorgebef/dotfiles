#####################
# session_save.py
#####################

### IMPORTANT!!!!
### set the following settings in kitty.conf:
# startup_session ~/.config/kitty/session/session.conf
# allow_remote_control yes
# map kitty_mod+s launch ~/.config/kitty/savesess.sh

import os
import json

dir = os.path.dirname(__file__)

json_path = 'session/kitty-session.json'
sess_dump_path = os.path.join(dir, json_path)

def createSession(output, sessionData):
    for os_window in sessionData:
        for tab in os_window['tabs']:
            output.write('new_tab '+tab['title']+'\n')
            for window in tab['windows']:
                if tab['is_active_tab'] and window['is_focused']:
                    output.write('focus'+'\n')
                else:
                    output.write('cd '+tab['windows'][0]['cwd']+'\n')
                    output.write('launch fish'+'\n')
            

with open(sess_dump_path) as f:
    sessData = json.load(f)
    sess_file_path = 'session/session.conf'
    sess_full_path = os.path.join(dir, sess_file_path)
    s = open(sess_full_path,'w')
    createSession(s,sessData)
    s.close()

f.close()
