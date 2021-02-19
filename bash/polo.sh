#!/bin/bash
#
# Usage: Simplify FvdM update MyPolo.nl
#
# Script by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later

# Create ~/temp and go there
cd $HOME || return
mkdir temp
cd temp

# Grab link from user
read -p "What's the link to the MyPolo page?:" link
wget -k -O index.html $link

# Get image links from index
cat index.html | grep /attachments/ | grep -Po 'src="\K.*?(?=")' | sed 's/\?.*//' > polo.txt ; 

# Count images and add placeholder
lines=$(< polo.txt wc -l )
sed -i '1,'$lines's/^/\n /' polo.txt

# Adding user names
#cat index.html | grep username > usernames.txt # Grabs usernames, but no idea on how to sort correctly yet
echo "Please add the usernames to the images."
leafpad polo.txt
echo

# Message for the lazy and adding the [IMG] tags
clear
echo "Hieronder de aangemelde foto's op volgorde van aanmelding. Welke vind jij het mooist?"
echo
echo "Stemmen kan natuurlijk tot het einde van de maand."
echo 
echo "[CENTER][B]Je kunt stemmen door een bericht achter te laten, waarin je zet wie er volgens jou mag winnen.[/CENTER][/B]​"
echo
sed '1~2s/^/[B] /; 1~2s/$/ [\/B]/;2~2s/^/[IMG] /; 2~2s/$/ [\/IMG]/' polo.txt

# Cleanup
cd $HOME || return
rm -rf temp