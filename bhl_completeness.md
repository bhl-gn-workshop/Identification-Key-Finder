# 

```shell
$ preston ls -l tsv | grep well-known | grep hasVersion | cut -f1 | sort | uniq > bhl_djvu_404.tsv

$ cat bhl_djvu_404.tsv | wc -l 
57621
```

See [bhl_djvu_404.tsv](./bhl_djvu_404.tsv) for results.

About 57k missing text pages on archive when using the pattern:

1. extract bar codes from https://www.biodiversitylibrary.org/data/item.txt
2. create url from https://www.archive.org/download/[bar code]/[bar code]_djvu.txt
3. download text from url

## Example ok text pages

```shell
$ preston ls -l tsv | grep hasVersion | head -n2 
https://www.biodiversitylibrary.org/data/item.txt	http://purl.org/pav/hasVersion	hash://sha256/e0c131ebf6ad2dce71ab9a10aa116dcedb219ae4539f9e5bf0e57b84f51f22ca
https://archive.org/download/mobot31753000022803/mobot31753000022803_djvu.txt	http://purl.org/pav/hasVersion	hash://sha256/1a57e55a780b86cff38697cf1b857751ab7b389973d35113564fe5a9a58d6a99
```

## Example Missing text pages 

### McGillLibrary-129682-5040
from 
https://www.biodiversitylibrary.org/data/item.txt (see also  [hash://sha256/e0c131ebf6ad2dce71ab9a10aa116dcedb219ae4539f9e5bf0e57b84f51f22ca](https://deeplinker.bio/e0c131ebf6ad2dce71ab9a10aa116dcedb219ae4539f9e5bf0e57b84f51f22ca))

```shell
$ preston get hash://sha256/e0c131ebf6ad2dce71ab9a10aa116dcedb219ae4539f9e5bf0e57b84f51f22ca | grep "McGillLibrary-129682-5040"
195710	112053	49506791	McGillLibrary-129682-5040	McGillLibrary-129682-5040			https://www.biodiversitylibrary.org/item/195710 McGill University Library (archive.org)		2016-01-24 00:38
```

was unable to find 

https://www.archive.org/download/McGillLibrary-129682-5040/McGillLibrary-129682-5040_djvu.txt

See also,

https://www.biodiversitylibrary.org/item/195710 

download content -> download book -> download text -> 404 not found

### mobot31753000810538

Similarly,

```
$ preston get hash://sha256/e0c131ebf6ad2dce71ab9a10aa116dcedb219ae4539f9e5bf0e57b84f51f22ca | grep "mobot31753000810538"
14549	724	529604	mobot31753000810538	i1269521x	QK41 .C57 1601 [#1006]		https://www.biodiversitylibrary.org/item/14549 		1601	Missouri Botanical Garden, Peter H. Raven Library		2006-05-04 00:00

$ preston ls | grep mobot31753000810538
<hash://sha256/e0c131ebf6ad2dce71ab9a10aa116dcedb219ae4539f9e5bf0e57b84f51f22ca> <http://www.w3.org/ns/prov#hadMember> <mobot31753000810538> .
<mobot31753000810538> <http://www.w3.org/1999/02/22-rdf-syntax-ns#seeAlso> <https://archive.org/download/mobot31753000810538/mobot31753000810538_djvu.txt> .
<https://archive.org/download/mobot31753000810538/mobot31753000810538_djvu.txt> <http://purl.org/dc/elements/1.1/format> "text/plain;charset=UTF-8" .
<https://archive.org/download/mobot31753000810538/mobot31753000810538_djvu.txt> <http://purl.org/pav/hasVersion> <https://deeplinker.bio/.well-known/genid/40662b2b-a402-3f32-9cce-f225c07d2d00> .
```

where ```<https://archive.org/download/mobot31753000810538/mobot31753000810538_djvu.txt> <http://purl.org/pav/hasVersion> <https://deeplinker.bio/.well-known/genid/40662b2b-a402-3f32-9cce-f225c07d2d00>``` means that https://archive.org/download/mobot31753000810538/mobot31753000810538_djvu.txt could not be accessed.  

https://www.biodiversitylibrary.org/item/14549

download content -> download book -> download text -> 404 not found

