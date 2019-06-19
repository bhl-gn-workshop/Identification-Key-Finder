#!/bin/bash
#
# usage: find_keys.sh [path of Preston BHL data folder] [regex]
#
#   example: ./find_keys.sh /some/path/bhl/data Keys
#
# tested on Ubuntu 18.04  

set -xe 
OLD_PWD=$PWD
DATA_DIR=$1
REGEX=$2

cd $DATA_DIR

# Get table of hash, line number, text matching regex.  Colon-separated.

echo "Scanning BHL corpus for matches to regular expression"
echo "output to $OLD_PWD/hash-line-match.tsv"
find data -type f \
  | xargs grep -n $REGEX -w -i \
  | sed -e "s+^.*/../../++" \
  | sed -e "s/:/\t/" \
  | sed -e "s/:/\t/" \
  > $OLD_PWD/hash-line-match-unsorted.tsv

cat $OLD_PWD/hash-line-match-unsorted.tsv | sort > $OLD_PWD/hash-line-match.tsv

# Get table of hash, barcode.  Tab-separated.  Note presence of
# tab character in this shell command.

preston log -l tsv > $OLD_PWD/log.tsv

cat $OLD_PWD/log.tsv | grep archive.*hasVersion | grep -v well-known \
  | sed -e "s+https://archive.org/download/\([^/]*\).*sha256/\(.*\)+\2\t\1+" \
  | sort \
  > $OLD_PWD/hash-barcode.tsv

# Last ran: cat foo.tsv |  sed -e 's+.*/download/\(.*\)/mobot.*sha256/\(.*\)> .+\1	\2+' | head -1
# Last ran: cat foo.tsv |  sed -e 's+.*/download/\(.*\)/mobot.*sha256/\(.*\)> .+\2	\1+' | head -1
# Last ran: cat foo.tsv |  sed -e 's+.*/download/\(.*\)/mobot.*sha256/\(.*\)> .+\2$TAB\1+' | head -1
# Last ran: cat foo.tsv |  sed -e "s+.*/download/\(.*\)/mobot.*sha256/\(.*\)> .+\2$TAB\1+" | head -1

# Get table of barcode, ... itemurl
# sorted by barcode

echo c
cat $OLD_PWD/log.tsv | head -n100 | grep item.txt | grep hasVersion | head -n 1 | cut -f 3 | preston get \
  | cut -f8,4 | tail -n +2 \
  | sort \
  > $OLD_PWD/barcode-itemurl.tsv

# Join on hash, sort by barcode
join --nocheck-order -t $'\t' -1 1 -2 1 $OLD_PWD/hash-barcode.tsv $OLD_PWD/hash-line-match.tsv | sort -k 2 >$OLD_PWD/barcode-line-match.tsv
# ... result is sorted by hash ...

# Join on barcode
# Result of join has these fields:
#   barcode, itemurl, hash, line number, match.
# E.g. mobot31753000008869	https://www.biodiversitylibrary.org/item/12 	91c4a36c6a6581ae810d42eca4114a8904a0c0cb8da685b6489a68592d65d0f8	10746	Reverend Bijlop of Cbefter. Whom I cannot name> 

# Result of this command will have these fields:
#   archive.org URL, BHL item URL, deeplinker URL, line number, match

join --nocheck-order -t $'\t' -1 1 -2 2 $OLD_PWD/barcode-itemurl.tsv $OLD_PWD/barcode-line-match.tsv \
  | sed -e "s+\(.*\)\t\(.*\)\t\(.*\)\t\(.*\)\t\(.*\)+https://archive.org/download/\1\t\2\thttps://deeplinker.bio/\3\t\4\t\5+" \
  > $OLD_PWD/itemurl-line-match.tsv

# The desired file is itemurl-line-match.tsv
