This page describes a method on how to find items with keys on BHL.

Questions:

1. Can you link to a BHL page and jump to a specific line number in the OCR text?
2. What are tools help annotate existing web accessible texts? (Hypothes.is?)
3. Which software libraries or platforms can help with text classification (e.g., does this text contain a key?) and segmentation (e.g., which part of the text is a key)? (Stanford CoreNLP, OpenNLP)
 
# Desired workflow for finding Keys

A librarian, a biologist and two software engineers came up with the following highlevel key finding workflow: 

1. get all the BHL data/ corpus
2. find keys in the data 
3. save results in a file with (at least) three columns: (1) Extracted matching line with "key" occurrence and (2) item id (3) line number of "key" occurrence
4. Visually inspect results for false positives
5. Need a oneliner to access line with "key" occurrence in context in the original file in cases where it is difficult to evaluate the extracted line.
6. Refine regular expression to work around false positives, go to 


## experiment 

0. A BHL Corpus was acquired that contained 226k items with a volume of 120GB . Note that an estimated 20% of BHL OCR text was unavailable (see [BHL Completeness](./bhl-completeness.md).
1. a bash script, [find-keys.sh](./find-keys.sh) was created. The script takes two arguments (1) the location of the BHL corpus and (2) a regular expression for matching likely keys. 
2. the scripts was run using regular expression ```Keys``` on the full bhl corpus on the item level.
3. After about 50 minutes executing the script took about 50s on a 2011 dual core ubuntu linux laptop  
4. the script completed a matching against all of BHL and captured the results in [itemurl-line-match.tsv.gz](./itemurl-line-match.tsv.gz). The first 10 lines look like: 

 internet archive collection | bhl item | link to item text | line number | matching line
  --- | --- |--- | --- | ---
https://archive.org/download/00921238.85096.emory.edu|https://www.biodiversitylibrary.org/item/174408 |https://deeplinker.bio/80a66488fa27d4f5c2ed03914220c5f749d2469c5f7264ab7c08dc94ee8b6fc7|10867|belong we have the key-note to the common 
https://archive.org/download/00921238.85096.emory.edu|https://www.biodiversitylibrary.org/item/174408 |https://deeplinker.bio/80a66488fa27d4f5c2ed03914220c5f749d2469c5f7264ab7c08dc94ee8b6fc7|11012|living beings, it gave him the key to many mys- 
https://archive.org/download/00921238.85096.emory.edu|https://www.biodiversitylibrary.org/item/174408 |https://deeplinker.bio/80a66488fa27d4f5c2ed03914220c5f749d2469c5f7264ab7c08dc94ee8b6fc7|12431|common Five-Finger (Asterias) gives the key to 
https://archive.org/download/00921238.85096.emory.edu|https://www.biodiversitylibrary.org/item/174408 |https://deeplinker.bio/80a66488fa27d4f5c2ed03914220c5f749d2469c5f7264ab7c08dc94ee8b6fc7|2616|and is the key to their whole organization. A 
https://archive.org/download/00921238.85096.emory.edu|https://www.biodiversitylibrary.org/item/174408 |https://deeplinker.bio/80a66488fa27d4f5c2ed03914220c5f749d2469c5f7264ab7c08dc94ee8b6fc7|3049|fications ; and that we have already the key by 
https://archive.org/download/00921238.85096.emory.edu|https://www.biodiversitylibrary.org/item/174408 |https://deeplinker.bio/80a66488fa27d4f5c2ed03914220c5f749d2469c5f7264ab7c08dc94ee8b6fc7|513|whole. It was Cuvier who found the key. He 
https://archive.org/download/00921238.85096.emory.edu|https://www.biodiversitylibrary.org/item/174408 |https://deeplinker.bio/80a66488fa27d4f5c2ed03914220c5f749d2469c5f7264ab7c08dc94ee8b6fc7|5306|pitched on a different key, it is true, but a sound 
https://archive.org/download/00921238.85096.emory.edu|https://www.biodiversitylibrary.org/item/174408 |https://deeplinker.bio/80a66488fa27d4f5c2ed03914220c5f749d2469c5f7264ab7c08dc94ee8b6fc7|673|and gave us the key-note to the natural affinities 
https://archive.org/download/00921238.85096.emory.edu|https://www.biodiversitylibrary.org/item/174408 |https://deeplinker.bio/80a66488fa27d4f5c2ed03914220c5f749d2469c5f7264ab7c08dc94ee8b6fc7|7270|crescent, from Virginia Key and Key Biscayne, 
https://archive.org/download/00921238.85096.emory.edu|https://www.biodiversitylibrary.org/item/174408 |https://deeplinker.bio/80a66488fa27d4f5c2ed03914220c5f749d2469c5f7264ab7c08dc94ee8b6fc7|7271|almost adjoining the main-land, to Key West, at 


## Discussion 

Observations
1. Librarian and biologist need to do many fast iterations to refine the key matching algorithms
2. Software engineers need time to develop tools.
3. a bash script produced different results depending on operating system (mac vs linux).

Open questions/ideas:

1. Can you link to a location in specific BHL item by line number?
2. What tools are available to visually annotate and select texts that describe a Key?
3. What NLP (natural language processing) techniques/ algorithms can be used to help automate the detection and extraction of key candidates? 


## details

```shell
$ time ./find_keys.sh /media/jorrit/cobaltblue/preston-bhl/ Key
+ OLD_PWD=/home/jorrit/proj/gn-hackathon/Identification-Key-Finder
+ DATA_DIR=/media/jorrit/cobaltblue/preston-bhl/
+ REGEX=Key
+ cd /media/jorrit/cobaltblue/preston-bhl/
+ TAB=t
+ echo 'Scanning BHL corpus for matches to regular expression'
Scanning BHL corpus for matches to regular expression
+ echo 'output to /home/jorrit/proj/gn-hackathon/Identification-Key-Finder/hash-line-match.tsv'
output to /home/jorrit/proj/gn-hackathon/Identification-Key-Finder/hash-line-match.tsv
+ find data -type f
+ xargs grep -n Key -w -i
+ sed -e 's+^.*/../../++'
+ sed -e 's/:/\t/'
+ sed -e 's/:/\t/'
+ cat /home/jorrit/proj/gn-hackathon/Identification-Key-Finder/hash-line-match-unsorted.tsv
+ sort
+ preston log -l tsv
+ cat /home/jorrit/proj/gn-hackathon/Identification-Key-Finder/log.tsv
+ grep 'archive.*hasVersion'
+ grep -v well-known
+ sed -e 's+https://archive.org/download/\([^/]*\).*sha256/\(.*\)+\2\t\1+'
+ sort
+ echo c
c
+ cat /home/jorrit/proj/gn-hackathon/Identification-Key-Finder/log.tsv
+ head -n100
+ grep hasVersion
+ head -n 1
+ preston get
+ sort
+ tail -n +2
+ cut -f 3
+ cut -f8,4
+ grep item.txt
+ join --nocheck-order -t '	' -1 1 -2 1 /home/jorrit/proj/gn-hackathon/Identification-Key-Finder/hash-barcode.tsv /home/jorrit/proj/gn-hackathon/Identification-Key-Finder/hash-line-match.tsv
+ sort -k 2
+ join --nocheck-order -t '	' -1 1 -2 2 /home/jorrit/proj/gn-hackathon/Identification-Key-Finder/barcode-itemurl.tsv /home/jorrit/proj/gn-hackathon/Identification-Key-Finder/barcode-line-match.tsv
+ sed -e 's+\(.*\)\t\(.*\)\t\(.*\)\t\(.*\)\t\(.*\)+https://archive.org/download/\1\t\2\thttps://deeplinker.bio/\3\t\4\t\5+'

real	49m16.872s
user	9m19.986s
sys	3m59.397s
```

## system info

Ubuntu Linux 18.04 running on Lenovo Laptop T430 8GB RAM with dual core Intel(R) Core(TM) i5-3320M CPU @ 2.60GHz.

Data
BHL Corpus 


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


