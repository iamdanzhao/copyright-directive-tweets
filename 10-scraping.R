# Scraping

art11 <- search_tweets("#article11", n = 100000, retryonratelimit = TRUE)
art13 <- search_tweets("#article13", n = 100000, retryonratelimit = TRUE)

art11_de <- search_tweets("#artikel11", n = 100000, retryonratelimit = TRUE)
art13_de <- search_tweets("#artikel13", n = 100000, retryonratelimit = TRUE)

saveRDS(art11, "art11.rds")
saveRDS(art13, "art13.rds")
saveRDS(art11_de, "art11_de.rds")
saveRDS(art13_de, "art13_de.rds")