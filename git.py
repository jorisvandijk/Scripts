# Simple script to update several repos.
# I should be using a function...

import os

repo = input("Which repo do you want to update?\n(1) Python\n(2) Obsidian\n(3) Dotfiles\n:")

if repo == "1":
    folder = "/home/joris/GitLab/python/"
    git = "git"
    add = "add ."
    origin = "origin"

elif repo == "2":
    folder = "/home/joris/Notes/joris/"
    git = "git"
    add = "add ."
    origin = "origin"

else:
    folder = "/home/joris/"
    git = "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
    add = "add -u"
    origin = ""
      
os.chdir(f"{folder}")
os.system(f"{git} status")

commit = input("\nPlease add a commit message\n:")
os.system(f"{git} {add} && {git} commit -m \"{commit}\"")
push = input("\nAre you sure you wish to push the changes? (y/n)\n:")
    
if push == "y":
    os.system(f"{git} push {origin}")
else:
    quit()
