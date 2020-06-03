## code to prepare `DATASET` dataset goes here
library(dplyr)
library(units)
items <- data.frame(
  stringsAsFactors = FALSE,
  what = c("Mini Cooper (2014)",
           "Volkswagen Beetle (type 1)","City Transit bus","Coach bus",
           "Bactrian Camel (hump height)","Alpaca (shoulder height)","IKEA not floor lamp",
           "Embraer Phenom 100","Cessna 172 Skyhawk Aircraft",
           "Vespa 125 Primavera (1968)","Stegosaurus","Toilet",
           "Covered bus stop","Game boy (1989)",
           "Playstation 2, Dualshock 2 controller","Apple iPhone 1st generation",
           "Apple iPad (1st gen) 2010","Blue whale","Sperm whale"),
  height = c(1.42,1.55,2.99,3.81,213,99,
             175,434,272,108,430,48,2.48,148,95,115,243,
             488,335),
  width = c(1.73,1.54,2.55,2.55,225,
            122,28,1229,1100,NA,NA,51,NA,90,157,61,190,3200,
            1900),
  depth = c(3.86,4.08,11.95,12,NA,NA,
            28,1282,828,172,910,76,1.27,32,54.9,11.6,13,NA,
            NA),
  unit = c("m","m","m","m","cm","cm",
           "cm","cm","cm","cm","cm","cm","m","mm","mm",
           "mm","mm","cm","cm"),
  type = c("car","car","transport",
           "transport","animal","animal","furniture","plane",
           "plane","Scooter","animal","furniture","furniture",
           "device","device","device","device","animal","animal")
)
## a vector, so column in data.frame needs to be the same unit.
to_m <- data.frame(
  unit = c("mm", "cm", "m", "km"),
  magn = c(1e-3, 1e-2, 1, 1e3),
  stringsAsFactors = FALSE
)
everyday_items <- left_join(items, to_m, by="unit") %>%
  mutate(
    height = set_units(height * magn,"m"),
    width = set_units(width * magn,"m"),
    depth = set_units(depth * magn,"m")
    ) %>% select(-c("unit","magn"))


usethis::use_data(everyday_items)






other_items <- data.frame(
  stringsAsFactors = FALSE,
              what = c("Eiffel Tower",
                       "Olympic Size Swimming Pool","A4 paper size","A1 paper size",
                       "US Tabloid","US letter",
                       "E Matua Ngahere (giant kauri tree in New Zealand)"),
             width = c(125, 25, 210, 594, 279, 216, 5.22),
            height = c(324, 50, 297, 841, 432, 279, 29.9),
             depth = c(125L, 3L, NA, NA, NA, NA, NA),
              unit = c("m", "m", "mm", "mm", "mm", "mm", "m"),
              type = c("Building", "Utilities", "paper", "paper", "paper", "paper", "plants"),
            source = c("https://en.wikipedia.org/wiki/Eiffel_Tower","wikipedia","papersizes.org",
                       "papersizes.org","papersizes.org","papersizes.org",
                       "https://en.wikipedia.org/wiki/Te_Matua_Ngahere")
)

things <- left_join(other_items, to_m, by="unit") %>%
  mutate(
    height = set_units(height * magn,"m"),
    width = set_units(width * magn,"m"),
    depth = set_units(depth * magn,"m")
  ) %>% select(-c("unit","magn"))

usethis::use_data(things)
