#Isaac Fair
#4/29/20
#COS 465
#Adapted from the Shiny Wordcloud example program (example 082), an example that uses Shakespeare

library(tm)
library(wordcloud)
library(memoise)

# The list of valid books
books <<- list("Tweets related to freedom" = "freedom",
              "Tweets related to unity" = "unity",
              "Tweets related to equality" = "equality",
              "Tweets related to honor" = "honor",
              "Uncategorized tweets" = "uncategorized")

# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(book) {
  # Careful not to let just any name slip in here; a
  # malicious user could manipulate this value.
  if (!(book %in% books))
    stop("Unknown book")

  text <- readLines(sprintf("./%s.txt", book),
    encoding="UTF-8")

  myCorpus = Corpus(VectorSource(text))
  myCorpus = tm_map(myCorpus, content_transformer(tolower))
  myCorpus = tm_map(myCorpus, removePunctuation)
  myCorpus = tm_map(myCorpus, removeNumbers)
  myCorpus = tm_map(myCorpus, removeWords,
         c(stopwords("SMART"), "the", "and", "but"))

  myDTM = TermDocumentMatrix(myCorpus,
              control = list(minWordLength = 1))
  
  m = as.matrix(myDTM)
  
  sort(rowSums(m), decreasing = TRUE)
})
