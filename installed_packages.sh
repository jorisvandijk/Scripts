#! /bin/bash
#
# Usage: List all explicitly installed packages with Pacman
#
# Script by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later

ignoregrp="base base-devel xorg"
ignorepkg=""

comm -23 <(pacman -Qqen | 
sort) <(echo $ignorepkg | 
tr ' ' '\n' | cat <(pacman -Sqg $ignoregrp) - | 
sort -u) > pkglist.pacman
