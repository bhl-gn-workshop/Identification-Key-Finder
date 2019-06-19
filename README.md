# Identification-Key-Finder
## Tools and methods for finding Identification Keys in BHL items. 
Searching and browsing the vast BHL corpus can be challenging with the tools currently available, e.g., sample search results. We want to explore ways to enrich BHL metadata, so users have more options to filter search results. We decided to focus on tools to filter identification keys because we expected that they would be easy to locate in the BHL corpus based on their headings and textual structure. The files in this repository include attempts and data used, as well as discussions of what did not work.

The research is detailed in this Google Doc: https://docs.google.com/document/d/1JygDSfvCKE_kHZwXElklTqu4DI2vdpE34IbcSIjuv8U/edit?usp=sharing. 

**_When files are added to this folder, please add them to the index in this README file._**

Things to do:

1. All: Index all the files in the repo
2. All: Fill out google drive document

Goals: Page level ID, multiple languages, e.g. taxonomic searching already in BHL.

1. get the data - [BHL Completeness](./bhl_completeness.md) - do we have all the data?

2. method to find keys - [Finding Keys](./finding_keys.md) 

3. method to assess quality of key finder

4. generate key -> bhl item/page and taxonomic name index

5. find keys in BHL - [BHL Key Lookup Use Cases](./key_lookup_usecases.md)

Index of Files:

1. [barcode-itemurl.tsv.gz](./barcode-itemurl.tsv.gz): This is an intermediate file relating barcodes of the items to the URL from the BHL from the data experiment scanning the entire corpus line-by-line of the BHL.
2. [bhl_completeness.md](./bhl_completeness.md): This is a description of an assessment of the completeness of OCR text available through the BHL corpus.
3. [bhl_djvu_404.tsv](./bhl_djvu_404.tsv): This is a list of broken links that should point to OCR text on internet archive.
4. [BHLKeys.png](./BHLKeys.png): This image imagines a mockup of Identification Keys as an option in BHL subject search.
5. [BHLKeySamples.tsv.zip](./BHLKeySamples.tsv.zip): This is run of line-by-line matches of the entire BHL corpus coming from the Internet Archive. This contains "key" or "Key" when it appears alone.
6. [find_keys.sh](./find_keys.sh): This script contains a search string that is applied to the BHL corpus and creates a list of the line number and URL(s) of the item. The URLs include links to the BHL item location, the Internet Archive location, and the text file.
7. [finding_keys.md](./finding_keys.md): This document details methods and results of a single run of the find_keys.sh script.
8. [hash-line-match.tsv.gz](./hash-line-match.tsv.gz): This is an intermediate file of finding_keys.md.
9. [itemurl-line-match.tsv.gz](./itemurl-line-match.tsv.gz): This is the final result of the script run of find-keys.sh. This search includes compound words with "Key".
10. [key_lookup_usecases.md](./key_lookup_usecases.md): This document describes the initial process of finding keys in the BHL corpus. 
11. [OCRKeyTitleExamples.csv](./OCRKeyTitleExamples.csv): This file contains examples of identification key headers fromthe BHL as they look in OCR.
12. [ProblemsNoticedSearchingKeys.txt](./ProblemsNoticedSearchingKeys.txt): This is a list of problems encountered as we began searching the line-by-line OCR.
13. README.md: This is the file you are in.
	
Discussion/Known limitations:

1. Locating identification keys in the BHL corpus turns out to be more difficult than expected.  The major problem is that we are unable to distinguish the subheadings introducing a key from citations of works that are identification keys and other mentions of keys that are not immediately followed by a key. Joel mentioned that he may be able to come up with a way to identify headings in the text. If this becomes available.  It would make it much easier to find the beginnings of keys.
2. Because identification keys generally have a distinct structure, AI-based approaches for locating keys may be useful. These could be based either on OCR text or page images. To get this going, we would need a diverse sample of keys from the BHL corpus.
3. As a first step stick to item-level approach that would allow us to create an index of BHL works that contain identification keys. Ideally this would be followed with a more precise approach that would pinpoint the specific locations of keys in the text, so we could support queries of taxon names that occur in identification keys. 
4. How to integrate the links to likely keys into BHL search pages? What does it take to add a Subject header (e.g. LC classification code) for "Keys" in BHL? 
5. As a first step, we could set up curated BHL collections for identification keys in works annotated with certain subjects like Entomology, Botany, etc.
