# script generated with the aid of MS Copilot at CUIMC
#TODO: put this into a notebook with an easily enterable interface

# ---- Setup ----

require(stringr) # for string matching
require(words) # scrabble dictionary of 175K words
# other options: wordnet, https://github.com/dwyl/english-words, https://github.com/dolph/dictionary 

# ---- Word Lists ----

# load the scrabble dictionary of 175K words
data("words")  
scrabble_word_list <- words$word 

# load the built-in unix dictionary of 235K words
unix_word_list <- readLines("/usr/share/dict/words") 

# optional: Load a wordlist from a local file
# custom_word_list <- readLines("path/to/your/wordlist.txt")

# ---- Parameters ----

# The pattern to match: a dot means a single character
pattern <- ".i.n.r.o.i.e"

# Convert pattern to regex
regex_pattern <- paste0("^", pattern, "$")

# ---- Find Matching Words ----

# choose the word list to use

# word_list <- scrabble_word_list
# word_list <- unix_word_list
# word_list <- custom_word_list

# match
matching_words <- word_list[str_detect(word_list, regex_pattern)]

# Print results
print(matching_words)
# if there are no matching words the output will be "character(0)
