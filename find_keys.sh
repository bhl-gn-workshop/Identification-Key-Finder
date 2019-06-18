#!/bin/bash

cd ~/bhl

TAB=`echo -e "\t"`

# Get table of hash, line number, text matching regex.  Colon-separated.

echo a
find data -type f -exec grep -n name /dev/null {} \; \
  | sed -E -e "s+^.*/??/??/++" \
  | sed -e "s/:/$TAB/" \
  | sed -e "s/:/$TAB/" \
  > hash-line-match.tsv

# Get table of hash, barcode.  Tab-separated.  Note presence of
# tab character in this shell command.

echo b
preston log -l tsv | grep archive.*hasVersion | grep -v well-known \
  | sed -e "s+https://archive.org/download/\([^/]*\).*sha256/\(.*\)+\2$TAB\1+" \
  > hash-barcode.tsv

# Last ran: cat foo.tsv |  sed -e 's+.*/download/\(.*\)/mobot.*sha256/\(.*\)> .+\1	\2+' | head -1
# Last ran: cat foo.tsv |  sed -e 's+.*/download/\(.*\)/mobot.*sha256/\(.*\)> .+\2	\1+' | head -1
# Last ran: cat foo.tsv |  sed -e 's+.*/download/\(.*\)/mobot.*sha256/\(.*\)> .+\2$TAB\1+' | head -1
# Last ran: cat foo.tsv |  sed -e "s+.*/download/\(.*\)/mobot.*sha256/\(.*\)> .+\2$TAB\1+" | head -1

# Get table of barcode, ... itemurl

echo c
preston log -l tsv | grep item.tsv | grep hasVersion \
   | head -n 1 | cut -f 3 | preston get | cut -f8,4 | tail -n +2 \
   > barcode-itemid.tsv

# Join 

# join <(sort hash-barcode.tsv) <(sort hash-line-match.tsv) >barcode-line-match.tsv

# join <(sort barcode-itemid.tsv) <(barcode-line-match.tsv) >itemid-line-match.tsv

