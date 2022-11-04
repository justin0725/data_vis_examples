# school stuff
library(tidyverse)
library(ggplot2)
library(sysfonts)
library(showtext)


# sunset colors
navy <- "#003f5c"
purple <- "#58508d"
magenta <- "#BC5090"
vibrant_red <- "#ff6361"
yellow <- "#ffa600"

# elizabeth's colors
text_dark_blue <- "#0a334d"
background_light_grey <- "#f6f7f6"
text_dark_grey <- "#545454" # bold for headings, plain for paragraph text
suggested_tan <- "#e5d6b1"
suggested_light_blue <- "#74acdc"

background_dark_blue <- "#0b334d"
text_white <- "#ffffff"
text_yellow <- "#f9efbf"
suggested_brown <- "#a4765a"


# hard coded values
text_color <- background_dark_blue
axis_color <- background_dark_blue
my_background <- background_light_grey
axis_text_color <- my_background
point_color <- suggested_light_blue
reg_line_color <- background_dark_blue
my_font <- "montserrat"
title_font <- "arvo"
#"merriweather"
## Loading Google fonts (https://fonts.google.com/)
font_add_google(str_to_title(my_font), my_font)
font_add_google(str_to_title(title_font), title_font)
showtext_auto()

############################################################################# sat data by county
sat <- here::here("data", "2021 SAT Performance by District and School.xlsx") %>%
  readxl::read_xlsx()
sat <- sat[6:614,]
colnames(sat) <- c("id_district", "district", "school",
                   "n_tested", "pct_tested",
                   "tot_score", "erw_score", "math_score"
                   )
district_sat <- sat %>%
  filter(is.na(school) == TRUE) %>%
  mutate(district = str_remove(district, " Schools")) %>%
  mutate(district = case_when(district == "Alamance-Burlington" ~ "Alamance County",
                              district == "Carteret County Public"  ~ "Carteret County" ,
                              district == "Edgecombe County Public School" ~ "Edgecombe County",
                              district == "Winston Salem / Forsyth County" ~ "Forsyth County",
                              district ==  "Iredell-Statesville" ~ "Iredell County",
                              district == "Jackson County Public" ~ "Jackson County",
                              district == "Johnston County Public" ~ "Johnston County",
                              district == "Lenoir County Public" ~ "Lenoir County" ,
                              district == "Mcdowell County" ~ "McDowell County",
                              district == "Charlotte-Mecklenburg" ~ "Mecklenburg County",
                              district == "Nash-Rocky Mount" ~ "Nash County",
                              district == "Rowan-Salisbury" ~ "Rowan",
                              district == "Union County Public" ~ "Union County",
                              district == "Wayne County Public" ~ "Wayne County",
                              TRUE ~ district
                              )
         )



############################################################################# income data by county
income <- here::here("data", "ACS_nc_counties.xlsx") %>%
  readxl::read_xlsx() %>%
  slice(1, 14, 29, 44)
# loop finding columns that are only NAs
c.NA <- c()
for (c in 1:ncol(income)) {
  if (sum(is.na(income[,c])) == 4) {
    c.NA <- append(c.NA, c)
  } # end if loop
} # end for loop
income <- income %>%
  select(!c.NA)
# loop setting first row as column names
for (c in 1:ncol(income)) {
  colnames(income)[c] <- income[1,c]
}
income <- income[-1,]
# make long
income <- income %>%
  pivot_longer(-Statistics, names_to = "district", values_to = "values") %>%
  mutate(Statistics = case_when(Statistics == "Median Household Income (In 2020 Inflation Adjusted Dollars)" ~ "median_hh_inc",
                                Statistics == "Average Household Income (In 2020 Inflation Adjusted Dollars)" ~ "avg_hh_inc",
                                Statistics == "Per Capita Income (In 2020 Inflation Adjusted Dollars)" ~ "percap_inc"
                                ),
         district = str_remove(district, ", North Carolina")
         ) %>%
  pivot_wider(names_from = Statistics, values_from = values)
income <- income[-101,]


############################################################################# race data by county
race <- here::here("data", "ACS_nc_counties.xlsx") %>%
  readxl::read_xlsx() %>%
  slice(c(1, 4:6))
# loop finding columns that are only NAs
c.NA <- c()
for (c in 1:ncol(race)) {
  if (sum(is.na(race[,c])) == 4) {
    c.NA <- append(c.NA, c)
  } # end if loop
} # end for loop
race <- race %>%
  select(!c.NA)
# loop setting first row as column names
for (c in 1:ncol(race)) {
  colnames(race)[c] <- race[1,c]
}
race <- race[-1,]
# remove stupid columms
c.NA <- c()
for (c in 1:ncol(race)) {
  if (colnames(race[,c]) == "NA") {
    c.NA <- append(c.NA, c)
  } # end if loop
} # end for loop
race <- race %>%
  select(!c.NA)
# make long
race <- race %>%
  pivot_longer(-Statistics, names_to = "district", values_to = "values") %>%
  mutate(Statistics = case_when(Statistics == "Total Population:" ~ "total_pop",
                                Statistics == "White Alone" ~ "white",
                                Statistics == "Black or African American Alone" ~ "black"
  ),
  district = str_remove(district, ", North Carolina")
  ) %>%
  pivot_wider(names_from = Statistics, values_from = values)
race <- race[-101,]




############################################################################### check
income$district[(income$district %in% district_sat$district) == FALSE]

district_sat$district[(district_sat$district %in% income$district) == FALSE]



############################################################################# join income by county and sat by school districts
# join and make columns numeric
inc_sat <- left_join(income, district_sat, by = "district") %>%
  mutate(median_hh_inc = str_remove(median_hh_inc, "\\$") %>% str_remove(",") %>% as.numeric(),
         avg_hh_inc = str_remove(avg_hh_inc, "\\$") %>% str_remove(",") %>% as.numeric(),
         percap_inc = str_remove(percap_inc, "\\$") %>% str_remove(",") %>% as.numeric(),
         # n_tested = case_when(n_tested == "<10" ~ 1,
         #                      TRUE ~ as.numeric(n_tested)
         #                      ),
         # pct_tested = case_when(pct_tested == "<5" ~ 1,
         #                        pct_tested == "*" ~ NA,
         #                        TRUE ~ as.numeric(pct_tested)
         #                        ),
         tot_score =  as.numeric(tot_score)
         # erw_score = case_when(erw_score == "*" ~ NA,
         #                       TRUE ~ as.numeric(erw_score)
         #                       ),
         # math_score = case_when(math_score == "*" ~ NA,
         #                        TRUE ~ as.numeric(math_score)
         #                        ),
         )
# END HERE

# plot
incX_satY <- inc_sat %>%
  ggplot(aes(x = median_hh_inc, y = tot_score)) +
  geom_point(color = point_color) +
  geom_smooth(method = "lm",
              se = FALSE,
              linetype = "dashed",
              color = axis_color,
              size = 0.5
              ) +
  theme_classic() +
  labs(x = "Median Household Income",
       y = "Average SAT\nScore",
       title = str_c("North Carolina's wealthier school districts",
                     "perform significantly better on the SAT",
                     sep = "\n"
                     ),
       caption = str_c("2021 SAT data from the North Carolina Department of Public Instruction",
                       "Income data from the Census Bureau (ACS 5-year estimates)",
                       sep = "\n"
                       )
       ) +
  theme(axis.title.y = element_text(angle = 0,
                                    size = 15
                                    ),
        axis.title.x = element_text(size = 15),
        axis.line = element_line(color = axis_color,
                                 size = 1
                                 ),
        axis.ticks = element_line(color = axis_color,
                                  size = 1
                                  ),
        axis.text = element_text(color = text_color,
                                 size = 10
                                 ),
        title = element_text(size = 18,
                             family = title_font),
        text = element_text(family = my_font,
                            color = text_color
                            ),
        plot.caption = element_text(size = 8),
        plot.background = element_rect(fill = my_background,
                                       color = my_background
                                       ),
        panel.background = element_rect(fill = my_background,
                                        color = my_background
                                        )
        )
incX_satY



############################################################################# throw race in the mix
# join and make numeric
inc_race <- inc_sat %>%
  left_join(race, by = "district") %>%
  mutate(total_pop = as.numeric(total_pop),
         white = as.numeric(white),
         black = as.numeric(black)
         ) %>%
  mutate(pct_nonwhite = 1 - (white / total_pop),
         pct_black = black / total_pop
         )

# plot
inc_race %>%
  ggplot(aes(x = pct_nonwhite, y = tot_score)) +
  geom_point()



################################################################### control for income
inc_race2 <- inc_race %>%
  filter(is.na(tot_score) == FALSE) %>%
  filter(is.na(median_hh_inc) == FALSE)

inc_model <- lm(data = inc_race2, tot_score ~ median_hh_inc)

inc_race2 <- inc_race2 %>%
  mutate(inc_residuals = inc_model$residuals)

# plot
nonwhiteX_satY <- inc_race2 %>%
  ggplot(aes(x = pct_nonwhite, y = inc_residuals)) +
  geom_point(color = vibrant_red) +
  geom_smooth(method = "lm",
              se = FALSE,
              linetype = "dashed",
              color = axis_color,
              size = 0.5
  ) +
  theme_classic() +
  labs(x = "Percent Nonwhite",
       y = str_c("Difference from",
                 "Average SAT score at",
                 "the same income level",
                 sep = "\n"
       ),
       title = str_c("North Carolina's nonwhite districts perform worse",
                     "on the SAT, even after controling for income.",
                     sep = "\n"),
       caption = str_c("2021 SAT data from the North Carolina",
                       "Demographic data from the Census Bureau (ACS 5-year estimates)",
                       sep = "\n")
  ) +
  theme(axis.title.y = element_text(angle = 0,
                                    size = 13
  ),
  axis.title.x = element_text(size = 15),
  axis.line = element_line(color = axis_color,
                           size = 1
  ),
  axis.ticks = element_line(color = axis_color,
                            size = 1
  ),
  axis.text = element_text(color = text_color,
                           size = 10
  ),
  title = element_text(size = 16,
                       family = title_font),
  text = element_text(family = my_font,
                      color = text_color
  ),
  plot.caption = element_text(size = 8),
  plot.background = element_rect(fill = my_background,
                                 color = my_background
  ),
  panel.background = element_rect(fill = my_background,
                                  color = my_background
  )
  )
nonwhiteX_satY


################################################################### stats
top_50 <- sort(inc_race$median_hh_inc)[51:100]
top_33 <- sort(inc_race$median_hh_inc)[67:100]
top_20 <- sort(inc_race$median_hh_inc)[80:100]
bottom_33 <- sort(inc_race$median_hh_inc)[1:33]
bottom_20 <- sort(inc_race$median_hh_inc)[1:20]
bottom_50 <- sort(inc_race$median_hh_inc)[1:50]

inc_race %>%
  filter(median_hh_inc %in% top_20) %>%
  pull(tot_score) %>%
  mean(na.rm = TRUE)

inc_race %>%
  filter(median_hh_inc %in% bottom_20) %>%
  pull(tot_score) %>%
  mean(na.rm = TRUE)


##### using percent of population
nc_pop <- sum(inc_race$total_pop)

inc3 <- inc_race %>%
  mutate(pct_of_pop = total_pop / nc_pop)

inc3 <- inc3 %>%
  arrange(median_hh_inc)

# going up
cummulative.count <- 0
i <- 0
while (cummulative.count < 0.33) { # start while loop
  i <- i + 1
  cummulative.count <- inc3$pct_of_pop[i] + cummulative.count
} # end while loop

# going down
cummulative.count <- 0
i <- 101
while (cummulative.count < 0.20) { # start while loop
  i <- i - 1
  cummulative.count <- inc3$pct_of_pop[i] + cummulative.count
} # end while loop


top_20pct <- sort(inc_race$median_hh_inc)[94:100]
bottom_20pct <- sort(inc_race$median_hh_inc)[1:50]

top_33pct <- sort(inc_race$median_hh_inc)[89:100]
bottom_33pct <- sort(inc_race$median_hh_inc)[1:64]

inc_race %>%
  filter(median_hh_inc %in% top_20pct) %>%
  pull(tot_score) %>%
  mean(na.rm = TRUE)

inc_race %>%
  filter(median_hh_inc %in% bottom_20pct) %>%
  pull(tot_score) %>%
  mean(na.rm = TRUE)









########### gini
get_gini <- function(incomes) {
  
  # numerator
  difs <- c()
  for (i in 1:length(incomes)) { # start for loop 1
    difs2 <- c()
    for (j in 1:length(incomes)) { # start for loop 2
      a.dif2 <- incomes[i] - incomes[j]
      difs2 <- append(difs2, a.dif2)
    } # end for loop 1
    a.difs2 <- sum(difs2)
    difs <- append(difs, a.difs2)
  } # end for loop 2
  numerator <- sum(difs)
  
  # denominator
  denominator <- 2*(length(incomes)^2)*mean(incomes)
  
  # output
  numerator / denominator
  
} # END FUNCTION



my_model <- lm(data = inc_race2, tot_score ~ median_hh_inc + pct_nonwhite)









#