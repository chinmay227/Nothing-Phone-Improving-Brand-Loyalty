#youtube comments scraping 

library(httr)

vid_id_iphone_mkbhd = '0X0Jm8QValY'

vid_id_iphone_mwtb = 's1XVb4mdELc'

vid_id_iphone_d2d = 'CREM-mFuyyo'

api_key = 'AIzaSyDWMmbMJU9Znfg_ej2S5YGujHqF_6Wwx8g'

#mkbhd_iphone

fetch_comments <- function(page_token = NULL) {
  url <- paste0("https://www.googleapis.com/youtube/v3/commentThreads?part=snippet&videoId=", 
                vid_id_iphone_mkbhd, "&key=", api_key, "&order=relevance")
  if (!is.null(page_token)) {
    url <- paste0(url, "&pageToken=", page_token)
  }
  response <- GET(url)
  if (status_code(response) == 200) {
    data <- content(response, "parsed")
    return(data)
  } else {
    print("Error fetching comments")
    return(NULL)
  }
}

mkbhd_iphone_comments <- list()
page_token <- NULL
while (TRUE) {
  data <- fetch_comments(page_token)
  if (is.null(data)) {
    break
  }
  mkbhd_iphone_comments <- c(mkbhd_iphone_comments, data$items)
  if (is.null(data$nextPageToken)) {
    break
  }
  page_token <- data$nextPageToken
}

iphone_comments_mkbhd <- list()

if (length(mkbhd_iphone_comments) > 0) {
  for (comment in mkbhd_iphone_comments) {
    iphone_comments_mkbhd <- append(iphone_comments_mkbhd, comment$snippet$topLevelComment$snippet$textOriginal)
  }
} else {
  print("No comments found")
}

iphone_mkbhd_df <- as.data.frame(iphone_comments_mkbhd)
iphone_mkbhd_df <- t(iphone_mkbhd_df)
mkbhd_sentences_iphone <- get_sentences(iphone_mkbhd_df)

mkbhd_iphone_sentiment <- sentiment_by(mkbhd_sentences_iphone)
mkbhd_iphone_sentiment

mkbhd_iphone_sentiment$comments <- mkbhd_sentences_iphone

mkbhd_iphone_sentiment$polarity <- ifelse(mkbhd_iphone_sentiment$ave_sentiment > 0.5, "Positive", 
                                        ifelse(mkbhd_iphone_sentiment$ave_sentiment < -0.5, "Negative", "Neutral"))

mkbhd_iphone_sentiment

#mwtb_iphone

fetch_comments <- function(page_token = NULL) {
  url <- paste0("https://www.googleapis.com/youtube/v3/commentThreads?part=snippet&videoId=", 
                vid_id_iphone_mwtb, "&key=", api_key, "&order=relevance")
  if (!is.null(page_token)) {
    url <- paste0(url, "&pageToken=", page_token)
  }
  response <- GET(url)
  if (status_code(response) == 200) {
    data <- content(response, "parsed")
    return(data)
  } else {
    print("Error fetching comments")
    return(NULL)
  }
}

mwtb_iphone_comments <- list()
page_token <- NULL
while (TRUE) {
  data <- fetch_comments(page_token)
  if (is.null(data)) {
    break
  }
  mwtb_iphone_comments <- c(mwtb_iphone_comments, data$items)
  if (is.null(data$nextPageToken)) {
    break
  }
  page_token <- data$nextPageToken
}

iphone_comments_mwtb <- list()

if (length(mwtb_iphone_comments) > 0) {
  for (comment in mwtb_iphone_comments) {
    iphone_comments_mwtb <- append(iphone_comments_mwtb, comment$snippet$topLevelComment$snippet$textOriginal)
  }
} else {
  print("No comments found")
}

iphone_comments_mwtb[[2]]


iphone_mwtb_df <- as.data.frame(iphone_comments_mwtb)
iphone_mwtb_df <- t(iphone_mwtb_df)
mwtb_sentences_iphone <- get_sentences(iphone_mwtb_df)

mwtb_sentences_iphone

mwtb_iphone_sentiment <- sentiment_by(mwtb_sentences_iphone)
mwtb_iphone_sentiment


mwtb_iphone_sentiment$comments <- mwtb_sentences_iphone

mwtb_iphone_sentiment$polarity <- ifelse(mwtb_iphone_sentiment$ave_sentiment > 0.5, "Positive", 
                                          ifelse(mwtb_iphone_sentiment$ave_sentiment < -0.5, "Negative", "Neutral"))

mwtb_iphone_sentiment


#d2d_iphone

fetch_comments <- function(page_token = NULL) {
  url <- paste0("https://www.googleapis.com/youtube/v3/commentThreads?part=snippet&videoId=", 
                vid_id_iphone_d2d, "&key=", api_key, "&order=relevance")
  if (!is.null(page_token)) {
    url <- paste0(url, "&pageToken=", page_token)
  }
  response <- GET(url)
  if (status_code(response) == 200) {
    data <- content(response, "parsed")
    return(data)
  } else {
    print("Error fetching comments")
    return(NULL)
  }
}

d2d_iphone_comments <- list()
page_token <- NULL
while (TRUE) {
  data <- fetch_comments(page_token)
  if (is.null(data)) {
    break
  }
  d2d_iphone_comments <- c(d2d_iphone_comments, data$items)
  if (is.null(data$nextPageToken)) {
    break
  }
  page_token <- data$nextPageToken
}

iphone_comments_d2d <- list()

if (length(d2d_iphone_comments) > 0) {
  for (comment in d2d_iphone_comments) {
    iphone_comments_d2d <- append(iphone_comments_d2d, comment$snippet$topLevelComment$snippet$textOriginal)
  }
} else {
  print("No comments found")
}

iphone_comments_d2d[[2]]

iphone_d2d_df <- as.data.frame(iphone_comments_d2d)
iphone_d2d_df <- t(iphone_d2d_df)
d2d_sentences_iphone <- get_sentences(iphone_d2d_df)

d2d_sentences_iphone

d2d_iphone_sentiment <- sentiment_by(d2d_sentences_iphone)
d2d_iphone_sentiment
d2d_iphone_sentiment$comments <- d2d_sentences_iphone

d2d_iphone_sentiment$polarity <- ifelse(d2d_iphone_sentiment$ave_sentiment > 0.5, "Positive", 
                                   ifelse(d2d_iphone_sentiment$ave_sentiment < -0.5, "Negative", "Neutral"))

d2d_iphone_sentiment

write.xlsx(mkbhd_iphone_sentiment, 'mkbhd_iphone.xlsx')
write.xlsx(mwtb_iphone_sentiment, 'mwtb_iphone.xlsx')
write.xlsx(d2d_iphone_sentiment, 'd2d_iphone.xlsx')

summary(combined_iphone_comments)