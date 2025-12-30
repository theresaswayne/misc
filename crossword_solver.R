# script generated with the aid of MS Copilot at CUIMC

# ---- Setup ----

# require(words) # allegedly 175K English words but comes out as 980
# other options: wordnet, https://github.com/dwyl/english-words, https://github.com/dolph/dictionary 


# word_list <- words:words # use the words package which maybe out of date
word_list <- readLines("/usr/share/dict/words") # this is the built in unix dictionary and it contains some bizarre words (n=235K)

# Optional: Load from a local file
# word_list <- readLines("path/to/your/wordlist.txt")


require(stringr)


# ---- Data and Parameters ----

#TODO: put this into a notebook with an easily enterable interface

pattern <- ".t.r.a.e"

# ---- Find the words ----


# Convert pattern to regex (if needed)
regex_pattern <- paste0("^", pattern, "$")
matching_words <- word_list[str_detect(word_list, regex_pattern)]

# Print results
print(matching_words)
# if there are no matching words the output will be "character(0)
