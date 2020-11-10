# Simple script to pick a config file to edit

import os

question = input("\nWhich config would you like to edit?\n(1) i3 config\n(2) Vim config\n(3) Vim Plugins\n(4) ZSH config\n(5) Newsboat URLs\n:")

if question == "1":
    command = "/home/joris/.config/i3/config"

elif question == "2":
    command = "/home/joris/.config/nvim/init.vim"

elif question == "3":
    command = "/home/joris/.config/nvim/vim-plug/plugins.vim"

elif question == "4":
    command = "/home/joris/.zshrc"

elif question == "5":
    command = "/home/joris/.config/newsboat/urls"

else:
    quit()

os.system(f"leafpad {command}")  