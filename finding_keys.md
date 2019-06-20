This page describes a method on how to find items with keys on BHL.
 
# Desired workflow for finding Keys

A librarian, a biologist and two software engineers came up with the following highlevel key finding workflow: 

1. get all the BHL data/ corpus
2. find keys in the data 
3. save results in a file with (at least) three columns: (1) Extracted matching line with "key" occurrence and (2) item id (3) line number of "key" occurrence
4. Visually inspect results for false positives
5. Need a oneliner to access line with "key" occurrence in context in the original file in cases where it is difficult to evaluate the extracted line.
6. Refine regular expression to work around false positives, go to 


## experiment 

0. A BHL Corpus was acquired that contained 226k items with a volume of 120GB . Note that an estimated 20% of BHL OCR text was unavailable (see [BHL Completeness](./bhl_completeness.md)).
1. a bash script, [find-keys.sh](./find-keys.sh) was created. The script takes two arguments (1) the location of the BHL corpus and (2) a regular expression for matching likely keys. 
2. the scripts was run using regular expression ```\bkey\b``` on the full bhl corpus on the item level.
3. the script completed in about 50 minutes on a 2011 dual core ubuntu linux laptop  
4. the script completed a matching against all of BHL and captured the 758k unique results in [itemurl-line-match.tsv.gz](./itemurl-line-match.tsv.gz). The table below contains the first 10 lines of the file. For sake of simplicity the urls were turned into labels ia (internet archive), bhl (biodiversity heritage library) and ocr test (a preston archive at deeplinker)

 bhl item links | line number | matching line
  --- | --- |--- | --- | ---
[ia]([ia](https://archive.org/download/00921238.85096.emory.edu) [bhl](https://www.biodiveritylibrary.org/item/174408) [ocr text](https://deeplinker/80a66488fa27d4f5c2ed03914220c5f749d2469c5f7264ab7c08dc94ee8b6fc7) |10867|belong we have the key-note to the common 
[ia](https://archive.org/download/00921238.85096.emory.edu) [bhl](https://www.biodiveritylibrary.org/item/174408) [ocr text](https://deeplinker/80a66488fa27d4f5c2ed03914220c5f749d2469c5f7264ab7c08dc94ee8b6fc7)|11012|living beings, it gave him the key to many mys- 
[ia](https://archive.org/download/00921238.85096.emory.edu) [bhl](https://www.biodiveritylibrary.org/item/174408) [ocr text](https://deeplinker/80a66488fa27d4f5c2ed03914220c5f749d2469c5f7264ab7c08dc94ee8b6fc7)|12431|common Five-Finger (Asterias) gives the key to 
[ia](https://archive.org/download/00921238.85096.emory.edu) [bhl](https://www.biodiveritylibrary.org/item/174408) [ocr text](https://deeplinker/80a66488fa27d4f5c2ed03914220c5f749d2469c5f7264ab7c08dc94ee8b6fc7)|2616|and is the key to their whole organization. A 
[ia](https://archive.org/download/00921238.85096.emory.edu) [bhl](https://www.biodiveritylibrary.org/item/174408) [ocr text](https://deeplinker/80a66488fa27d4f5c2ed03914220c5f749d2469c5f7264ab7c08dc94ee8b6fc7)|3049|fications ; and that we have already the key by 
[ia](https://archive.org/download/00921238.85096.emory.edu) [bhl](https://www.biodiveritylibrary.org/item/174408) [ocr text](https://deeplinker/80a66488fa27d4f5c2ed03914220c5f749d2469c5f7264ab7c08dc94ee8b6fc7)|513|whole. It was Cuvier who found the key. He 
[ia](https://archive.org/download/00921238.85096.emory.edu) [bhl](https://www.biodiveritylibrary.org/item/174408) [ocr text](https://deeplinker/80a66488fa27d4f5c2ed03914220c5f749d2469c5f7264ab7c08dc94ee8b6fc7)|5306|pitched on a different key, it is true, but a sound 
[ia](https://archive.org/download/00921238.85096.emory.edu) [bhl](https://www.biodiveritylibrary.org/item/174408) [ocr text](https://deeplinker/80a66488fa27d4f5c2ed03914220c5f749d2469c5f7264ab7c08dc94ee8b6fc7)|673|and gave us the key-note to the natural affinities 
[ia](https://archive.org/download/00921238.85096.emory.edu) [bhl](https://www.biodiveritylibrary.org/item/174408) [ocr text](https://deeplinker/80a66488fa27d4f5c2ed03914220c5f749d2469c5f7264ab7c08dc94ee8b6fc7)|7270|crescent, from Virginia Key and Key Biscayne, 
[ia](https://archive.org/download/00921238.85096.emory.edu) [bhl](https://www.biodiveritylibrary.org/item/174408) [ocr text](https://deeplinker/80a66488fa27d4f5c2ed03914220c5f749d2469c5f7264ab7c08dc94ee8b6fc7)|7271|almost adjoining the main-land, to Key West, at 
[ia](https://archive.org/download/00921238.85096.emory.edu) [bhl](https://www.biodiveritylibrary.org/item/174408) [ocr text](https://deeplinker/80a66488fa27d4f5c2ed03914220c5f749d2469c5f7264ab7c08dc94ee8b6fc7)|7490|light-house, built on Sand Key for the greater 


## Discussion 

Observations
1. Librarian and biologist need to do many fast iterations to refine the key matching algorithms
1. Software engineers need time to develop tools.
1. a bash script produced different results depending on operating system (mac vs linux).

Open questions/ideas:

1. Can you link to a BHL page and jump to a specific line number in the OCR text?
1. What tools are available to visually annotate and select texts that describe a Key?
1. Which software libraries or platforms can help with text classification (e.g., does this text contain a key?) and segmentation (e.g., which part of the text is a key)? (Stanford CoreNLP, OpenNLP)

## details

```shell
$ time ./find_keys.sh /media/jorrit/cobaltblue/preston-bhl/ "\bkey\b"
+ OLD_PWD=/home/jorrit/proj/gn-hackathon/Identification-Key-Finder
+ DATA_DIR=/media/jorrit/cobaltblue/preston-bhl/
+ REGEX='\bkey\b'
+ cd /media/jorrit/cobaltblue/preston-bhl/
+ echo 'Scanning BHL corpus for matches to regular expression'
Scanning BHL corpus for matches to regular expression
+ echo 'output to /home/jorrit/proj/gn-hackathon/Identification-Key-Finder/hash-line-match.tsv'
output to /home/jorrit/proj/gn-hackathon/Identification-Key-Finder/hash-line-match.tsv
+ find data -type f
+ xargs grep -n '\bkey\b' -w -i
+ sed -e 's+^.*/../../++'
+ sed -e 's/:/\t/'
+ sed -e 's/:/\t/'
+ cat /home/jorrit/proj/gn-hackathon/Identification-Key-Finder/hash-line-match-unsorted.tsv
+ sort
+ echo 'Obtaining map from file hash to file barcode'
Obtaining map from file hash to file barcode
+ preston log -l tsv
+ cat /home/jorrit/proj/gn-hackathon/Identification-Key-Finder/log.tsv
+ grep 'archive.*hasVersion'
+ grep -v well-known
+ sed -e 's+[ia](https://archive.org/download/\([^/]*\).*sha256/\(.*\)+\2\t\1+'
+ sort
+ echo 'Obtaining map from barcode to BHL item'
Obtaining map from barcode to BHL item
+ cat /home/jorrit/proj/gn-hackathon/Identification-Key-Finder/log.tsv
+ head -n100
+ head -n 1
+ grep hasVersion
+ grep item.txt
+ tail -n +2
+ sort
+ cut -f8,4
+ cut -f 3
+ preston get
+ echo 'Joining on file hash and sorting'
Joining on file hash and sorting
+ join --nocheck-order -t '	' -1 1 -2 1 /home/jorrit/proj/gn-hackathon/Identification-Key-Finder/hash-barcode.tsv /home/jorrit/proj/gn-hackathon/Identification-Key-Finder/hash-line-match.tsv
+ sort -k 2
+ echo 'Joining on barcode and sorting'
Joining on barcode and sorting
+ join --nocheck-order -t '	' -1 1 -2 2 /home/jorrit/proj/gn-hackathon/Identification-Key-Finder/barcode-itemurl.tsv /home/jorrit/proj/gn-hackathon/Identification-Key-Finder/barcode-line-match.tsv
+ sed -e 's+\(.*\)\t\(.*\)\t\(.*\)\t\(.*\)\t\(.*\)+[ia](https://archive.org/download/\1\t\2\t[ocr text](https://deeplinker/\3\t\4\t\5+'

real	46m36.495s
user	9m22.076s
sys	3m57.117s
```

### result stats
Counting unique number of line matches again BHL corpus using regex ```\bkey\b```.

```shell
$ zcat itemurl-line-match.tsv.gz | sort | uniq | wc -l```)
758180
```

Number of unique BHL items with matches. 

```shell 
$ zcat itemurl-line-match.tsv.gz | sort | uniq | cut -f2 | sort | uniq | wc -l```)
74719
```

Top 10 BHL items with most number of matches.
```shell 
$ zcat itemurl-line-match.tsv.gz | sort | uniq | cut -f2 | sort | uniq -c | sort -nr \
    | sed "s/^[^0-9]*//g" | tr ' ' '\t' \
    > matches-per-item-sorted-descending.tsv
$ head matches-per-item-sorted-descending.tsv
4127	https://www.biodiversitylibrary.org/item/107146
4020	https://www.biodiversitylibrary.org/item/118981
3002	https://www.biodiversitylibrary.org/item/262128
2916	https://www.biodiversitylibrary.org/item/107123
2576	https://www.biodiversitylibrary.org/item/107124
2505	https://www.biodiversitylibrary.org/item/194866
2440	https://www.biodiversitylibrary.org/item/261069
2231	https://www.biodiversitylibrary.org/item/194618
2111	https://www.biodiversitylibrary.org/item/107164
2049	https://www.biodiversitylibrary.org/item/29885
```

Distribution of number of matches across BHL items with at least one match.
```R
plot(item_matches$count, log="xy")
item_matches <- read.csv('matches-per-item-sorted-descending.tsv', header=F, sep='\t')
names(item_matches) <- c('count', 'item_url')
plot(item_matches$count, log="xy", xlab='bhl items', ylab='match count', main='distribution of bhl items by decreasing match count')
```
This R script produce the plot below. 

[![matches-per-item-sorted-descending.png](./matches-per-item-sorted-descending.png)]

The graph shows that there's few items with many counts (i.e., about 100 items with 500 matches or more) and many items with few count (i.e., about 65k items with 10 matches or less). More analysis is needed to indicate whether number of match counts is a way to detect likely identification key candidates. 

### system info

Ubuntu Linux 18.04 running on Lenovo Laptop T430 8GB RAM with dual core Intel(R) Core(TM) i5-3320M CPU @ 2.60GHz.

### BHL Corpus 


Total number of items in the BHL catalogue:
```
$ cat item.txt | wc -l
242511
```

Total number of files in the Preston BHL archive:
```
$ find data -type f | wc -l
226900
```

Total volume of Preston BHL archive files:
```
$ du -d0 -h data/
120G	data/
```

Preston BHL Archive version:
```
$ preston version
0.0.15
$ preston history
<0659a54f-b713-4f86-a917-5be166a14110> <http://purl.org/pav/hasVersion> <hash://sha256/89926f33157c0ef057b6de73f6c8be0060353887b47db251bfd28222f2fd801a> .
<hash://sha256/41b19aa9456fc709de1d09d7a59c87253bc1f86b68289024b7320cef78b3e3a4> <http://purl.org/pav/previousVersion> <hash://sha256/89926f33157c0ef057b6de73f6c8be0060353887b47db251bfd28222f2fd801a> .
```


