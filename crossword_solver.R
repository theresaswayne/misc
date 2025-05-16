# script generated with the aid of MS Copilot at CUIMC

# ---- Setup ----

# require(words) # allegedly 175K English words but comes out as 980
# other options: wordnet, https://github.com/dwyl/english-words, https://github.com/dolph/dictionary 
# 
word_list <- readLines("/usr/share/dict/words") # this is the built in unix dictionary and it contains some bizarre words (n=235K)


require(stringr)


# ---- Data and Parameters ----

#TODO: put this into a notebook with an easily enterable interface

pattern <- "t.s.l."

# word_list <- words:words

# Optional: Load from a local file (uncomment and modify path if needed)
# word_list <- readLines("path/to/your/wordlist.txt")

# ---- Find the words ----


# Convert pattern to regex (if needed)
regex_pattern <- paste0("^", pattern, "$")
matching_words <- word_list[str_detect(word_list, regex_pattern)]

# Print results
print(matching_words)
