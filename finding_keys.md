# Recipe for finding Keys

1. get all the data
2. ```find ./data | xargs cat | grep "key"```
3. Get a file with three columns: (1) Extracted line with "key" occurrence and (2) item id (3) line number of "key" occurrence
4. Visually inspect results for false positives
5. Need a oneliner to access line with "key" occurrence in context in the original file in cases where it is difficult to evaluate the extracted line.
6. Refine regular expression to work around false positives.







