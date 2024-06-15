install.packages("ggplot2")
install.packages("syuzhet")

library(tidytext)
library(ggplot2)
library(syuzhet)
library(wordcloud)
library(sentimentr)
library(openxlsx)
library(readxl)
library(corpustools)
library(tm)

mkbhd_df <- as.data.frame(comments_mkbhd)
mkbhd_df <- t(mkbhd_df)

comments_mkbhd

mkbhd_sentences <- get_sentences(mkbhd_df)

mkbhd_sentiment <- sentiment_by(mkbhd_sentences)

mkbhd_sentiment

plot(mkbhd_sentiment)

plot(emotion_by(mkbhd_sentences))

mkbhd_sentiment$comments <- mkbhd_sentences

mkbhd_sentiment$polarity <- ifelse(mkbhd_sentiment$ave_sentiment > 0.5, "Positive", 
                                    ifelse(mkbhd_sentiment$ave_sentiment < -0.5, "Negative", "Neutral"))

summary(combined_comments)

plot(emotion_by(combined_comments$comments))

#wordcloud

text_data <- combined_comments$comments

corpus <- Corpus(VectorSource(text_data))
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation) 
corpus <- tm_map(corpus, removeNumbers) 
corpus <- tm_map(corpus, removeWords, stopwords("english")) 
corpus <- tm_map(corpus, stripWhitespace) 


tdm <- TermDocumentMatrix(corpus)
m <- as.matrix(tdm)

word_freq <- sort(rowSums(m), decreasing = TRUE)

word_freq

#WORDCLOUD

wordcloud(words = names(word_freq), freq = word_freq, min.freq = 1,
          max.words = 200, random.order = FALSE, rot.per = 0.35,
          colors = brewer.pal(8, "Dark2"))

plot(emotion_by(combined_comments$comments))

#OVERALL SENTIMENT

sentiments <- get_nrc_sentiment(text_data)
overall_sentiment <- colSums(sentiments)
overall_sentiment

overall_sentiment_df <- data.frame(sentiment = names(overall_sentiment),
                                   score = overall_sentiment,
                                   stringsAsFactors = FALSE)

ggplot(overall_sentiment_df, aes(x = sentiment, y = score, fill = sentiment)) +
  geom_bar(stat = "identity") +
  labs(title = "Overall Sentiment", x = "Sentiment", y = "Score") +
  theme_minimal()


#mwtb

mwtb_df <- as.data.frame(comments_mwtb)
mwtb_df <- t(mwtb_df)

mwtb_df

mwtb_sentences <- get_sentences(mwtb_df)
mwtb_sentences

mwtb_sentiment <- sentiment_by(mwtb_sentences)

mwtb_sentiment

plot(mwtb_sentiment)

plot(emotion_by(mwtb_sentences))

mwtb_sentiment$polarity <- ifelse(mwtb_sentiment$ave_sentiment > 0.5, "Positive", 
                                   ifelse(mwtb_sentiment$ave_sentiment < -0.5, "Negative", "Neutral"))
mwtb_sentiment$comments <- mwtb_sentences


#beebom

beebom_df <- as.data.frame(comments_beebom)
beebom_df <- t(beebom_df)

beebom_df

beebom_sentences <- get_sentences(beebom_df)
beebom_sentences

beebom_sentiment <- sentiment_by(beebom_sentences)

plot(emotion_by(beebom_sentences))


beebom_sentiment$polarity <- ifelse(beebom_sentiment$ave_sentiment > 0.5, "Positive", 
                                    ifelse(beebom_sentiment$ave_sentiment < -0.5, "Negative", "Neutral"))

beebom_sentiment$comments <- beebom_sentences
