#!/bin/bash
#
# Usage: Search different engines from rofi
#
# Original script by Derek Taylor & Ali Furkan Yıldız
#
# Forked by Joris van Dijk | gitlab.com/jorisvandijk 
#
#          Published under GPL-3.0-or-later

BROWSER="firefox"

declare -a options=(
"amazon - https://www.amazon.com/s?k="
"archaur - https://aur.archlinux.org/packages/?O=0&K="
"archpkg - https://archlinux.org/packages/?sort=&q="
"archwiki - https://wiki.archlinux.org/index.php?search="
"duckduckgo - https://duckduckgo.com/?q="
"ebay - https://www.ebay.com/sch/i.html?&_nkw="
"github - https://github.com/search?q="
"gitlab - https://gitlab.com/search?search="
"imdb - https://www.imdb.com/find?q="
"reddit - https://www.reddit.com/search/?q="
"sourceforge - https://sourceforge.net/directory/?q="
"stack - https://stackoverflow.com/search?q="
"startpage - https://www.startpage.com/do/dsearch?query="
"stockquote - https://finance.yahoo.com/quote/"
"thesaurus - https://www.thesaurus.com/misspelling?term="
"translate - https://translate.google.com/?sl=auto&tl=en&text="
"urban - https://www.urbandictionary.com/define.php?term="
"wayback - https://web.archive.org/web/*/"
"webster - https://www.merriam-webster.com/dictionary/"
"wikipedia - https://en.wikipedia.org/wiki/"
"wiktionary - https://en.wiktionary.org/wiki/"
"wolfram - https://www.wolframalpha.com/input/?i="
"youtube - https://www.youtube.com/results?search_query="
"quit"
)


# Picking a search engine.
while [ -z "$engine" ]; do
enginelist=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -l 20 -p 'Choose search engine:') || exit
engineurl=$(echo "$enginelist" | awk '{print $NF}')
engine=$(echo "$enginelist" | awk '{print $1}')
done

# Searching the chosen engine.
while [ -z "$query" ]; do
query=$(echo "$engine" | rofi -dmenu -p 'Enter search query:') || exit
done

# Display search results in web browser
$BROWSER "$engineurl""$query"