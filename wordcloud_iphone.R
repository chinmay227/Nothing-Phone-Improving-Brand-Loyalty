text_data_iphone <- combined_iphone_comments$comments

corpus <- Corpus(VectorSource(text_data_iphone))
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation) 
corpus <- tm_map(corpus, removeNumbers) 
corpus <- tm_map(corpus, removeWords, stopwords("english")) 
corpus <- tm_map(corpus, stripWhitespace) 


tdm_iphone <- TermDocumentMatrix(corpus)

m <- as.matrix(tdm_iphone)

word_freq <- sort(rowSums(m), decreasing = TRUE)

word_freq

wordcloud(words = names(word_freq), freq = word_freq, min.freq = 1,
          max.words = 250, random.order = FALSE, rot.per = 0.35,
          colors = brewer.pal(8, "Dark2"))

#OVERALL SENTIMENT

sentiments_iphone <- get_nrc_sentiment(text_data_iphone)
overall_sentiment_iphone <- colSums(sentiments_iphone)
overall_sentiment_iphone

overall_sentiment_df_iphone <- data.frame(sentiment = names(overall_sentiment_iphone),
                                   score = overall_sentiment_iphone,
                                   stringsAsFactors = FALSE)

ggplot(overall_sentiment_df_iphone, aes(x = sentiment, y = score, fill = sentiment)) +
  geom_bar(stat = "identity") +
  labs(title = "Overall Sentiment", x = "Sentiment", y = "Score") +
  theme_minimal()