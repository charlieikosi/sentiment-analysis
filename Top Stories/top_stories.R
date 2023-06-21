source("postcourierR.R")

pc_url <- "https://www.postcourier.com.pg/top-stories/"
df <- scrape_topstories(pc_url)
write_csv(df, "top_stories.csv")





