api_key = 'YOUR_API_KEY'

vid_id_mkbhd ='lRUtHtqfCGA'

#mkbhd

fetch_comments <- function(page_token = NULL) {
  url <- paste0("https://www.googleapis.com/youtube/v3/commentThreads?part=snippet&videoId=", 
                vid_id_mkbhd, "&key=", api_key, "&order=relevance")
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

mkbhd_comments <- list()
page_token <- NULL
while (TRUE) {
  data <- fetch_comments(page_token)
  if (is.null(data)) {
    break
  }
  mkbhd_comments <- c(mkbhd_comments, data$items)
  if (is.null(data$nextPageToken)) {
    break
  }
  page_token <- data$nextPageToken
}

comments_mkbhd <- list()

if (length(mkbhd_comments) > 0) {
  for (comment in mkbhd_comments) {
    comments_mkbhd <- append(comments_mkbhd, comment$snippet$topLevelComment$snippet$textOriginal)
  }
} else {
  print("No comments found")
}


#mwtb

fetch_comments <- function(page_token = NULL) {
  url <- paste0("https://www.googleapis.com/youtube/v3/commentThreads?part=snippet&videoId=", 
                vid_id_mwtb, "&key=", api_key, "&order=relevance")
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

mwtb_comments <- list()
page_token <- NULL
while (TRUE) {
  data <- fetch_comments(page_token)
  if (is.null(data)) {
    break
  }
  mwtb_comments <- c(mwtb_comments, data$items)
  if (is.null(data$nextPageToken)) {
    break
  }
  page_token <- data$nextPageToken
}

comments_mwtb <- list()

if (length(mwtb_comments) > 0) {
  for (comment in mwtb_comments) {
    comments_mwtb <- append(comments_mwtb, comment$snippet$topLevelComment$snippet$textOriginal)
  }
} else {
  print("No comments found")
}

comments_mwtb


#beebom


fetch_comments <- function(page_token = NULL) {
  url <- paste0("https://www.googleapis.com/youtube/v3/commentThreads?part=snippet&videoId=", 
                vid_id_beebom, "&key=", api_key, "&order=relevance")
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

beebom_comments <- list()
page_token <- NULL
while (TRUE) {
  data <- fetch_comments(page_token)
  if (is.null(data)) {
    break
  }
  beebom_comments <- c(beebom_comments, data$items)
  if (is.null(data$nextPageToken)) {
    break
  }
  page_token <- data$nextPageToken
}

comments_beebom <- list()

if (length(beebom_comments) > 0) {
  for (comment in beebom_comments) {
    comments_beebom <- append(comments_beebom, comment$snippet$topLevelComment$snippet$textOriginal)
  }
} else {
  print("No comments found")
}

comments_beebom


summary(combined_comments)
