# Simple script to update several repos.
# I should be using a function...

import os

class bcolors:
    green = '\033[92m'
    ENDC = '\033[0m'


print(f"Warning: No active frommets remain. Continue?")
repo = input("Which repository do you want to update?\n(1) Python\n(2) Obsidian\n(3) Scripts\n(4) Dotfiles\n(c) Check all repositories for changes.\n:")

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

elif repo == "4":
    folder = "/home/joris/"
    git = "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
    add = "add -u"
    origin = ""

elif repo == "c":
    print(f"{bcolors.green}Python:{bcolors.ENDC}")
    os.system("cd ~/GitLab/python/ && git status")
    print(f"\n{bcolors.green}Obsidian:{bcolors.ENDC}")
    os.system("cd ~/Notes/joris/ && git status")
    print(f"\n{bcolors.green}Scripts:{bcolors.ENDC}")
    os.system("cd ~/Scripts/ && git status")
    print(f"\n{bcolors.green}Dotfiles:{bcolors.ENDC}")
    os.system("cd ~/ && /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME status")
    quit()

else:
    print("That is not a repository.")
    quit()
      
os.chdir(f"{folder}")
os.system(f"{git} status")
changes = input("\nPush all changes? (y/n) or (q) to quit.\n:")

if changes == "y":
    commit = input("\nPlease add a commit message.\n:")
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
