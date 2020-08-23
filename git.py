# Simple script to update several repos.
# I should be using a function...

import os

class bcolors:
    green = '\033[92m'
    ENDC = '\033[0m'

print(f"{bcolors.green}\nPython:{bcolors.ENDC}")
os.system("cd ~/GitLab/python/ && git status")
print(f"\n{bcolors.green}\nObsidian:{bcolors.ENDC}")
os.system("cd ~/Notes/joris/ && git status")
print(f"\n{bcolors.green}\nScripts:{bcolors.ENDC}")
os.system("cd ~/Scripts/ && git status")
print(f"\n{bcolors.green}\nDotfiles:{bcolors.ENDC}")
os.system("cd ~/ && /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME status")

question = input("What would you like to do?\n(1) Push repositories\n(2) Pull repositories\n:")\

if question == "1":
    repo = input("\nWhich repository do you want to update?\n(1) Python\n(2) Obsidian\n(3) Scripts\n(4) Dotfiles\n:")

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
        change = input("\nWhich file would you like to push? Or press (q) to quit.\n:")
        if change == "q":
            quit()
        else:
            os.system(f"{git} add {change}")
            commit = input("\nPlease add a commit message\n:")
            os.system(f"{git} commit -m \"{commit}\"")
            os.system(f"{git} status")

    push = input("\nAre you sure you wish to push the changes? (y/n)\n:")
        
    if push == "y":
        os.system(f"{git} push {origin}")
    else:
        quit()

elif question == "2":
    repo = input("\nWhich repository do you want to pull from?\n(1) Python\n(2) Obsidian\n(3) Scripts\n(4) Dotfiles\n:")

    if repo == "1":
        os.chdir(f"/home/joris/GitLab/python/")
        os.system(f"git pull")
        quit()

    if repo == "2":
        os.chdir(f"/home/joris/Notes/joris/")
        os.system(f"git pull")
        quit()

    elif repo == "3":
        os.chdir(f"/home/joris/Scripts/")
        os.system(f"git pull")

    elif repo == "4":
        os.chdir(f"/home/joris/")
        os.system(f"/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME pull")

    else:
        print("That is not a repository.")
        quit()
        
else:
    print("Wrong input.")
    quit()