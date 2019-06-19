# Recipe for finding Keys

1. get all the data
2. ```find ./data -type f | xargs cat | grep "key"```

or 

```grep -r -n -i -e '\bkey\b' data/ > BHLsample.txt```

3. Get a file with three columns: (1) Extracted line with "key" occurrence and (2) item id (3) line number of "key" occurrence.
4. Visually inspect results for false positives (yikes, vast majority are false positives)
5. Need a oneliner to access line with "key" occurrence in context in the original file in cases where it is difficult to evaluate the extracted line. (For now, manually construct urls using filename, e.g.: https://deeplinker.bio/bad43fb0374d76fd03036c2d9ee678347e089322f97ea2ac7cbff482e884ca5d)
6. Refine regular expression to work around false positives.







