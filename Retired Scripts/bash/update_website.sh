#!/bin/bash

# This is supposed to run off of the webserver.
# It removes the entire public_html folder, grabs the repo and renames that
# to public_html, updating the site like so.

cd domains/joris.tech/
rm -rf public_html
git clone https://gitlab.com/jorisvandijk/website.git
mv website public_html