#####################
# session_save.py
#####################

import os
import json

dir = os.path.dirname(__file__)

json_path = 'kitty-session.json'
sess_dump_path = os.path.join(dir, json_path)

with open(sess_dump_path) as f:
    sessData = json.load(f)
    # set directory for the files
    sess_file_path = 'session.conf'
    sess_full_path = os.path.join(dir, sess_file_path)
    s = open(sess_full_path,'w')
    for i in sessData:
        for tab in i['tabs']:
            s.write('new_tab '+tab['title'])
            s.write('\n')
            s.write('cd '+tab['windows'][0]['cwd'])
            s.write('\n')
            s.write('launch zsh')
            s.write('\n')
            # -------------- NOT YET WORKING --------------
            # for window in tab['windows']:
            #     s.write('cd '+tab['windows'][0]['cwd'])
            #     s.write('\n')
            #     s.write('launch zsh')
            #     s.write('\n')
    s.close()
# close the file
f.close()
