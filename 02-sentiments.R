# Process sentiments

processSentiment_de <- function(file) {
	full <- file %>%
		read_tsv(col_names = FALSE) %>%
		rename(word = X1,
			   sentiment = X2,
			   inflections = X3) %>%
		mutate(word = str_replace(word, "\\|.*",""),
			   word = str_to_lower(word),
			   inflections = str_to_lower(inflections),
			   inflections = str_split(inflections, ","))
	
	full_left <- full %>%
		select(word, sentiment)
	
	full %>%
		unnest(inflections) %>%
		select(word = inflections,
			   sentiment) %>%
		na.omit() %>%
		rbind(full_left) %>%
		arrange(word)
}

sentiments_en <- get_sentiments("bing")
sentiments_de <- rbind(processSentiment_de("sentiws-positive.txt"),
					   processSentiment_de("sentiws-negative.txt"))