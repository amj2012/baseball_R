#originally copied from https://gist.github.com/bayesball/2d51673b7c10842baaee18b110b1a2e9
# install.packages("devtools")
# devtools::install_github("BillPetti/baseballr")

# if the above doesn't work because of an 'ERROR: 
# compilation failed for package ‘XML’'
# then this might fix it, then try it again:
# install.packages("XML", type = "binary")

library(baseballr)
library(readr)
# giancarlo stanton's key_mlbam id is 519317
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
