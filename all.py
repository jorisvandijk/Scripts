import os

print("The following files are available to execute:\n")
os.system("cd ~/Scripts/ && ls -1a *.py")
file = input("\nWhich script would you like to execute?\n(You only need to type the name, not the extention)\n:")
os.system("clear")
os.system(f"python -u ~/Scripts/{file}.py")
