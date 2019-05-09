# EU Copyright Directive Tweet Analysis

This respository contains code used to perform sentiment analysis on tweets relating to the new European Union Copyright Directive, more formally known as *The Directive on Copyright in the Digital Single Market*. This analysis was performed for a final project for the course titled *Intellectual Property in the Digital Age*, taught by Professor Xiyin Tang at Yale University in Spring 2019 (course code CPSC 184). The remainder of the project was a policy brief rebunking some of the myths and common falsehoods surrounding the Directive.

The intended workflow of the files is to call files `00` through `03` using `source()` in a RMarkdown chunk in order to then visualize the data and run statistical tests. A sample visualization is in `99-makeGraph.R`. File `10-scraping.R` contains code to scrape tweets using the `rtweet` package. Please note that due to limitations in Twitter's free API, only one week of tweets can be scraped, and only 18,000 tweets can be scraped per user per 15-minute interval.

Please reach out to iamdanzhao@gmail.com if you have any question or concerns.
