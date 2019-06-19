# Identification-Key-Finder
Tools and methods for finding Identification Keys in BHL items. 

Things to do:

1. Jorrit: move repo to workshop 
2. All: Index all the files in the repo



Goals: Page level ID, multiple languages, e.g. taxonomic searching already in BHL.

1. get the data - [BHL Completeness](./bhl_completeness.md) - do we have all the data?

2. method to find keys - [Finding Keys](./finding_keys.md) 

3. method to assess quality of key finder

4. generate key -> bhl item/page and taxonomic name index

5. find keys in BHL - [BHL Key Lookup Use Cases](./key_lookup_usecases.md)

Discussion/Known limitations:

1. Locating identification keys in the BHL corpus turns out to be more difficult than expected.  The major problem is that we are unable to distinguish the subheadings introducing a key from citations of works that are identification keys and other mentions of keys that are not immediately followed by a key. Joel mentioned that he may be able to come up with a way to identify headings in the text. If this becomes available.  It would make it much easier to find the beginnings of keys.
2. Because identification keys generally have a distinct structure, AI-based approaches for locating keys may be useful. These could be based either on OCR text or page images. To get this going, we would need a diverse sample of keys from the BHL corpus.
3. As a first step stick to item-level approach that would allow us to create an index of BHL works that contain identification keys. Ideally this would be followed with a more precise approach that would pinpoint the specific locations of keys in the text, so we could support queries of taxon names that occur in identification keys. 
4. How to integrate the links to likely keys into BHL search pages? What does it take to add a Subject header (e.g. LC classification code) for "Keys" in BHL? 
5. As a first step, we could set up curated BHL collections for identification keys in works annotated with certain subjects like Entomology, Botany, etc.
