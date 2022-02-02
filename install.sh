#!/bin/bash

# Script to install the utility as a binary which could then be used anywhere on the computer.
cp lyrics-scraper.sh lyrics-scraper
chmod +x lyrics-scraper
sudo mv lyrics-scraper /usr/bin/lyrics-scraper

# Run the utility as a binary from the command line after this, for example:
# $ lyrics-scraper $1 $2 $3
