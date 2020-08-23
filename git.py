# Simple script to update several repos.
# I should be using a function...

import os

repo = input("Which repo do you want to update?\n(1) Python\n(2) Obsidian\n(3) Scripts\n(4) Dotfiles\n:")

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

elif repo == "3":
    folder = "/home/joris/Scripts/"
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
changes = input("\nPush all changes? (y/n) or (q) to quit\n:")

if changes == "y":
    commit = input("\nPlease add a commit message\n:")
    os.system(f"{git} {add} && {git} commit -m \"{commit}\"")
    os.system(f"{git} status")

elif changes == "q":
    quit()

else:
    change = input("\nWhich file would you like to push?\n:")
    os.system(f"{git} add {change}")
    commit = input("\nPlease add a commit message\n:")
    os.system(f"{git} commit -m \"{commit}\"")
    os.system(f"{git} status")

push = input("\nAre you sure you wish to push the changes? (y/n)\n:")
    
if push == "y":
    os.system(f"{git} push {origin}")
else:
    quit()
