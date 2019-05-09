# Functions

getTweetStack_en <- function(df) {
	df %>%
		filter(!is_retweet) %>%
		select(id = status_id, text = text) %>% # rename columns
		mutate(text = str_replace_all(text, '([[:upper:]])', ' \\1')) %>%
		unnest_tokens(output = word, 
					  input = text,
					  to_lower = TRUE,
					  strip_punct = TRUE,
					  strip_numeric = TRUE) %>% # tokenizes (each word in corpus gets own row)
		mutate(word = gsub("\u2019", "'", word)) %>% # replaces right quotation mark with single apostrophe
		mutate(word = lemmatize_words(word)) %>% # lemmatizes words
		anti_join(stopwords_en, by = "word") %>% # removes stopwords
		group_by(id, word) %>% # makes one row correspond to one document, one word
		summarize(n = n()) %>% # add a column for counts (per document, per word)
		left_join(sentiments_en) %>% # attach sentiments (either "positive", "negative", or none)
		mutate(score = case_when(sentiment == "positive" ~ 1,
								 sentiment == "negative" ~ -1,
								 is.na(sentiment) ~ 0)) %>% # converts sentiments to a number
		select(-one_of("sentiment")) # get rid of the sentiments column
}

getTweetStack_de <- function(df) {
	df %>%
		filter(!is_retweet) %>%
		select(id = status_id, text = text) %>%
		mutate(text = str_replace_all(text, '([[:upper:]])', ' \\1')) %>%
		unnest_tokens(output = word,
					  input = text,
					  to_lower = TRUE,
					  strip_punct = TRUE,
					  strip_numeric = TRUE) %>%
		mutate(word = gsub("\u2019", "'", word)) %>%
		anti_join(stopwords_de, by = "word") %>%
		group_by(id, word) %>%
		summarize(n = n()) %>%
		left_join(sentiments_de) %>%
		mutate(score = case_when(sentiment > 0 ~ 1,
								 sentiment < 0 ~ -1,
								 is.na(sentiment) ~ 0)) %>%
		select(-one_of("sentiment")) # get rid of the sentiments column
}

getSentimentByTweet <- function(df) {
	df %>%
		mutate(totalScore = n * score) %>%
		group_by(id) %>%
		summarize(totalWords = sum(n),
				  Sentiment = sum(totalScore) / totalWords) %>%
		select(-one_of("totalWords"))
}

processTweets <- function(df, lang, art) {
	temp <- NULL
	
	if(lang == "English") {
		temp <- getTweetStack_en(df)
	}
	else if(lang == "German") {
		temp <- getTweetStack_de(df)
	}
	
	temp %>%
		getSentimentByTweet() %>%
		filter(Sentiment != 0) %>%
		mutate(Language = lang,
			   Article = paste0("#Article", art)) %>%
		select(-one_of("id"))
}