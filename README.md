# Identification-Key-Finder
Tools and methods for finding Identification Keys in BHL items. Goals: Page level ID, multiple languages, e.g. taxonomic searching already in BHL.

1. get the data - [BHL Completeness](./bhl_completeness.md) - do we have all the data?

2. method to find keys - [Finding Keys](./finding_keys.md) 

3. method to assess quality of key finder

4. generate key -> bhl item/page and taxonomic name index

5. lookup likely BHL key by name. mock-up ideas for including the likely Key links into BHL Search - [BHL Key Lookup Use Cases](./key_lookup_usecases.md)

Discussion/Known limitations:

1. For now stick to item-level approach, hopefully, at some point, well be able to better isolate key at a page or paragraph level. The idea is we point to specific locations in the text that are likely keys. 
2. How to integrate the links to likely keys into BHL search pages? What does it take to add a Subject header for "Keys" in BHL? 
