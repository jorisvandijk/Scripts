#!/bin/bash
# Jorisvandijk.com - Post install script. based on a script by HexDSL.

me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
u="$USER"

menu()
	{
		echo "usage:   " $me "[OPTION]"
		echo " "
		echo "init:    Do something!"
		echo " "

	}

init()
	{
		echo "make something of this"
	}

if [ -n "$1" ]; then
  $1
else
  menu
fi
