#install.packages("tidytext")
#install.packages("syuzhet")
#install.packages("textdata)
#--------------------------------------------
library(tidytext)
library(textdata)
library(tidyverse)
library(syuzhet)
library(wordcloud)
library(tm)

# Read the data from the CSV file
headlines <- read.csv("top_stories.csv", stringsAsFactors = FALSE)

# Load and prepare the sentiment lexicon
sentiments <- get_sentiments("bing")

# Clean and tokenize the headlines
headlines2 <- headlines %>%
  select(Top.Stories) %>%
  unnest_tokens(word, Top.Stories)

# Assign sentiment scores to each word
headlines2 <- headlines2 %>%
  inner_join(sentiments, by = "word") 

# Calculate the sentiment score for each headline
headline_sentiment <- headlines2 %>%
  count(sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)


# Create a word cloud for negative words
headline_negative <- headlines2 %>% dplyr::filter(sentiment == "negative")
wordcloud(headline_negative$word, 
          scale=c(5, 0.5), 
          max.words=100, 
          random.order=FALSE, 
          colors=brewer.pal(8, "Dark2"))

headline_negative %>% dplyr::filter(word == "crime")
 
