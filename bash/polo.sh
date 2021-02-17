#!/bin/bash
#
# Usage: Simplyfy FvdM update MyPolo.nl
#
# Script by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later

if [[ ! -e polo.txt ]]; then
    touch polo.txt
fi

echo "Paste the names and image links in this format:"
echo
echo "[NAME]"
echo "[IMG LINK]"
echo "[NAME]"
echo "[IMG LINK]"
echo
echo "etc..."
echo
echo "Then save and close the file."
leafpad polo.txt
echo
echo "Hieronder de aangemelde foto's op volgorde van aanmelding. Welke vind jij het mooist?"
echo
echo "Stemmen kan natuurlijk tot het einde van de maand."
echo 
echo "[CENTER][B]I.v.m. een software bug is er helaas geen poll mogelijk! Breng je stem uit door te reageren op dit topic met de naam van de gene die volgens jou mag winnen.[/CENTER][/B]​"
echo
sed '1~2s/^/[B] /; 1~2s/$/ [\/B]/;2~2s/^/[IMG] /; 2~2s/$/ [\/IMG]/' polo.txt
echo
rm polo.txt