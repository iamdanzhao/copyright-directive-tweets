tally_by_date <- function(df) {
	df %>%
		filter(!is_retweet) %>%
		mutate(date = date(created_at)) %>%
		group_by(date) %>%
		summarize(n = n())
}

tally_by_lang <- function(df) {
	df %>%
		filter(!is_retweet) %>%
		group_by(lang) %>%
		summarize(n = n())
}

tally_by_date(art11)
tally_by_date(art11_de)
tally_by_date(art13)
tally_by_date(art13_de)

tally_by_lang(art13)
tally_by_lang(art13_de)

art11 %>%
	ts_plot("3 hour") +
	ggplot2::theme_minimal()