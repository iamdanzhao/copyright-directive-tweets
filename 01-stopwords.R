# Process stopwords

getStopwords <- function(lang) {
	lang %>%
		stopwords::stopwords() %>%
		c() %>%
		as.data.frame() %>%
		`colnames<-`(c("word"))
}

stopwords_en <- getStopwords("en")
stopwords_de <- getStopwords("de")

# stopwords_de <- readr::read_lines("stopwords-de.txt")