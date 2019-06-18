#!/bin/bash

TAB=`echo -e "\t"`

# Get table of file name, line number, text matching regex.  Colon-separated.

find data -type f -exec grep -n name /dev/null {} \; \
  | sed -E -e "s+^.*/??/??/++" \
  | sed -e "s/:/$TAB/" \
  | sed -e "s/:/$TAB/" \
  > file-line-match.txt

# Get table of hash, barcode.  Tab-separated.  Note presence of
# tab character in this shell command.

preston log -l tsv | grep hasVersion | grep -v well-known | \
   sed -e "s+.*/download/\(.*\)/mobot.*sha256/\(.*\)> .+\2$TAB\1+" \
   > hash-barcode.tsv

# Get table of barcode, ... itemurl

preston log -l tsv | grep item.txt | grep hasVersion | head -n 1 | cut -f 3 | preston get | cut -f4,8 | tail -n +2 \
   > itemid-barcode.tsv

# Join 

join <(sort file-line-key.txt) <(sort 
