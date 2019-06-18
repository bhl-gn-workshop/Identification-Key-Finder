#!/bin/bash

cd ~/bhl

TAB=`echo -e "\t"`

# Get table of hash, line number, text matching regex.  Colon-separated.

echo "Scanning BHL corpus for matches to regular expression"
find data -type f -exec grep -n -w -i {} /dev/null \; \
  | sed -e "s+^.*/../../++" \
  | sed -e "s/:/$TAB/" \
  | sed -e "s/:/$TAB/" \
  | sort \
  > hash-line-match.tsv

# Get table of hash, barcode.  Tab-separated.  Note presence of
# tab character in this shell command.

preston log -l tsv | grep archive.*hasVersion | grep -v well-known \
  | sed -e "s+https://archive.org/download/\([^/]*\).*sha256/\(.*\)+\2$TAB\1+" \
  | sort \
  > hash-barcode.tsv

# Last ran: cat foo.tsv |  sed -e 's+.*/download/\(.*\)/mobot.*sha256/\(.*\)> .+\1	\2+' | head -1
# Last ran: cat foo.tsv |  sed -e 's+.*/download/\(.*\)/mobot.*sha256/\(.*\)> .+\2	\1+' | head -1
# Last ran: cat foo.tsv |  sed -e 's+.*/download/\(.*\)/mobot.*sha256/\(.*\)> .+\2$TAB\1+' | head -1
# Last ran: cat foo.tsv |  sed -e "s+.*/download/\(.*\)/mobot.*sha256/\(.*\)> .+\2$TAB\1+" | head -1

# Get table of barcode, ... itemurl
# sorted by barcode

echo c
preston log -l tsv | grep item.txt | grep hasVersion | head -n 1 | cut -f 3 | preston get
  | cut -f8,4 | tail -n +2 \
  | sort \
  > barcode-itemurl.tsv

# Join on hash, sort by barcode
join -t "$TAB" -1 1 -2 1 hash-barcode.tsv hash-line-match.tsv | sort -k 2 >barcode-line-match.tsv
# ... result is sorted by hash ...

# Join on barcode
# Result of join has these fields:
#   barcode, itemurl, hash, line number, match.
# E.g. mobot31753000008869	https://www.biodiversitylibrary.org/item/12 	91c4a36c6a6581ae810d42eca4114a8904a0c0cb8da685b6489a68592d65d0f8	10746	Reverend Bijlop of Cbefter. Whom I cannot name> 

# Result of this command will have these fields:
#   archive.org URL, BHL item URL, deeplinker URL, line number, match

join -t "$TAB" -1 1 -2 2 barcode-itemurl.tsv barcode-line-match.tsv \
  | sed -e "s+\(.*\)$TAB\(.*\)$TAB\(.*\)$TAB\(.*\)$TAB\(.*\)+https://archive.org/download/\1${TAB}\2${TAB}https://deeplinker.bio/\3${TAB}\4${TAB}\5+" \
  > itemurl-line-match.tsv

# The desired file is itemurl-line-match.tsv
