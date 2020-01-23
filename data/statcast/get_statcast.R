# originally copied from https://gist.github.com/bayesball/2d51673b7c10842baaee18b110b1a2e9
# install.packages("devtools")
# devtools::install_github("BillPetti/baseballr")

# if the above doesn't work because of an 'ERROR: 
# compilation failed for package ‘XML’'
# then this might fix it, then try it again:
# install.packages("XML", type = "binary")

library(baseballr)
library(readr)
# giancarlo stanton's key_mlbam id is 519317
getStanton <- function() {
  s04 <- scrape_statcast_savant_batter(as.Date("2017-04-03"), 
                                       as.Date("2017-04-30"), 519317)
  s05 <- scrape_statcast_savant_batter(as.Date("2017-05-01"), 
                                       as.Date("2017-05-31"), 519317)
  s06 <- scrape_statcast_savant_batter(as.Date("2017-06-01"), 
                                       as.Date("2017-06-30"), 519317)
  s07 <- scrape_statcast_savant_batter(as.Date("2017-07-01"), 
                                       as.Date("2017-07-31"), 519317)
  s08 <- scrape_statcast_savant_batter(as.Date("2017-08-01"), 
                                       as.Date("2017-08-31"), 519317)
  s09 <- scrape_statcast_savant_batter(as.Date("2017-09-01"), 
                                       as.Date("2017-10-01"), 519317)
  sbind <- rbind(s04, s05, s06, s07, s08, s09)
  
  write_csv(sbind, "gstanton2017.csv")
} 
# getStanton()

getSeason <- function(start_date, end_date) {
  season_days <- time_length(days(as.Date(end_date) - as.Date(start_date) + 1), unit="days")
  season_weeks <- as.integer(season_days/7)
  if (season_days%%7 > 0) {
    season_weeks <- season_weeks + 1
    has_remainder <- TRUE
  } else {
    has_remainder <- FALSE
  }
  sc_list <- vector("list", season_weeks)
  for (i in 1:season_weeks) {
    if (i == season_weeks & has_remainder == TRUE) {
      sc_list[[i]] <- scrape_statcast_savant_batter_all(as.Date(start_date) + 7*(i-1),
                                                        as.Date(end_date))
    } else {
      sc_list[[i]] <- scrape_statcast_savant_batter_all(as.Date(start_date) + 7*(i-1), 
                                                        (as.Date(start_date)+6) + 7*(i-1))
    }
  }
  sc_df <- bind_rows(sc_list)
  sc_df
}
# sc_2016 <- getSeason(start_date = "2016-04-03", end_date = "2016-10-02")
# write_csv(sc_2016, "statcast2016.csv")
# sc_2017 <- getSeason(start_date = "2017-04-02", end_date = "2017-10-01")