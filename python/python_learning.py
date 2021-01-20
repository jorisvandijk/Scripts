# Simple script to run an assignment for Python Crash Course in the terminal.

import os

chapter = input("Which chapter are you on?\n:")
os.chdir(f"/home/joris/GitLab/python/chapter_{chapter}")
print(f"\nThe following files are availible for chapter {chapter}:\n")
os.system("ls")
file = input("\nWhich file do you want to run?\n(You only need to type the name, not the extention)\n:")
os.system("clear")
os.system(f"python -u {file}.py")
