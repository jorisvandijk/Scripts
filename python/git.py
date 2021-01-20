# Simple script to update several repos.
# I should be using a function...

import os

class bcolors:
    green = '\033[92m'
    ENDC = '\033[0m'

print(f"{bcolors.green}\nScripts:{bcolors.ENDC}")
os.system("cd ~/Scripts/ && git status")

print(f"{bcolors.green}\nFreeTube:{bcolors.ENDC}")
os.system("cd ~/.config/FreeTube/ && git status")

print(f"{bcolors.green}\nWallpapers:{bcolors.ENDC}")
os.system("cd ~/Pictures/wallpapers/ && git status")

print(f"{bcolors.green}\nDotfiles:{bcolors.ENDC}")
os.system("cd ~/Dotfiles/ && git status")


print("\nWhich repository would you like to update?\n")
repo = input("1. Scripts\n2. FreeTube\n3. Wallpapers\n4. Dotfiles\n:")

if repo == "1":
    folder = "/home/joris/Scripts/"

elif repo == "2":
    folder = "/home/joris/.config/FreeTube/"

elif repo == "3":
    folder = "/home/joris/Pictures/wallpapers/"

elif repo == "4":
    folder = "/home/joris/Dotfiles"

else:
    print("That is not a repository.")
    quit()
    
os.chdir(f"{folder}")
os.system(f"git status")
print("\nWhat would you like to commit?\n")
files = input("\n1. All files\n2. Modified files\n3. A specific file\n:")

if files == "1":
    commit = input("\nPlease add a commit message.\n:")
    os.system(f"git add . && git commit -m \"{commit}\"")
    os.system(f"git status")

elif files == "2":
    commit = input("\nPlease add a commit message.\n:")
    os.system(f"git add -u && git commit -m \"{commit}\"")
    os.system(f"git status")

elif files == "3":
    doc = input("\nWhich document would you like to add?\n:")
    os.system(f"git add {doc}")
    os.system(f"git status")

    commit = input("\nPlease add a commit message.\n:")
    os.system(f"git commit -m \"{commit}\"")
    os.system(f"git status")

else:
    quit()

push = input("\nAre you sure you wish to push the changes? (y/n)\n:")
    
if push == "y":
    os.system(f"git push")
else:
    quit()
