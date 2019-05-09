art11 <- readRDS("art11.rds")
art13 <- readRDS("art13.rds")
art11_de <- readRDS("art11_de.rds")
art13_de <- readRDS("art13_de.rds")

source("00-packages.R")
source("01-stopwords.R")
source("02-sentiments.R")
source("03-functions.R")

master <- processTweets(art11, "English", 11) %>%
	rbind(processTweets(art13, "English", 13)) %>%
	rbind(processTweets(art11_de, "German", 11)) %>%
	rbind(processTweets(art13_de, "German", 13))

master %>%
	ggplot(aes(y = Sentiment, color = Language)) + facet_wrap(~ Article, nrow = 2) +
	geom_boxplot() + coord_flip() + xlim(-0.5, 0.5) %>%
	labs(title = "Tweet sentiment by language and article",
		 subtitle = "Tweets collected between April 28, 2019 and May 6, 2019")