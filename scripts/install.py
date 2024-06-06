import os
import shutil

username = os.getlogin()
builddir = os.getcwd()

# Here we install nala, the prettier package manager for APT based systems
os.system("sudo apt install nala -y")
os.chdir(builddir)
# Creating the .config folders to import previous configs
os.mkdir(f"/home/{username}/.config")
# Creating fonts for Nerd Fonts
os.mkdir(f"/home/{username}/.fonts")
# Creating Pictures folder for wallpaper
os.mkdir(f"/home/{username}/Pictures")
os.copy(f"{builddir}/assets/wallpaper.jpg", f"/home/{username}/Pictures/wallpaper.jpg")
os.copy(f".Xresources", f"/home/{username}/.Xresources")
os.copy(f".Xnord", f"/home/{username}/.Xnord")
dotconfig_dir = os.path.join(builddir, 'dotconfig')
destination_dir = f"/home/{username}/.config"

# Copy all files and directories from dotconfig to the destination directory
for item in os.listdir(dotconfig_dir):
    s = os.path.join(dotconfig_dir, item)
    d = os.path.join(destination_dir, item)
    if os.path.isdir(s):
        shutil.copytree(s, d, dirs_exist_ok=True)
    else:
        shutil.copy2(s, d)
