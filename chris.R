# Scraping
library("rvest")
# Melting
library("data.table")
# Piping
library("magrittr")
# Manipulating
library("dplyr")
# Plotting
library("ggplot2")
library("jsonlite")

url <- "https://pt.wikipedia.org/wiki/Lista_de_episódios_de_Everybody_Hates_Chris"
webpage <- read_html(url)
tbls <- html_nodes(webpage, "table")
tbls <- html_table(tbls)
season1 <- tbls[[2]]
season2 <- tbls[[3]]
season3 <- tbls[[4]]
season4 <- tbls[[5]]

prettytable <- function(table, season) {
  desc_t <- table %>% 
    select(`Título`) %>% 
    filter(row_number() %% 2 == 0) %>%
    rename(DESCRIPTION = `Título`)
  
  title_t <- table %>%
    select(`Título`) %>%
    filter(row_number() %% 2 == 1) %>%
    rename(TITLE = `Título`) %>%
    rowwise() %>%
    mutate(TITLE = strsplit(TITLE, '\"')[[1]][2],
           TITLE = strsplit(TITLE, " \\(")[[1]][1]) %>%
    ungroup()
  
  bind_cols(title_t, desc_t) %>%
    mutate(SEASON = season, NUMBER = 1:n())
  
}

bind_rows(
  prettytable(season1, 1),
  prettytable(season2, 2),
  prettytable(season3, 3),
  prettytable(season4, 4)
) %>% toJSON(pretty = T) %>% write('chris.json')
