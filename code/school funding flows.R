######################################################
# Make alluvial graph of education funding flows in NC
######################################################
library(tidyverse)
library(ggplot2)
library(ggalluvial)
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

# cv colors
cv_background <- "white"


# hard coded values
funds_URL <- "https://docs.google.com/spreadsheets/d/1yeakJcnCFw0LkFl9A5ZAH6t1B5oP6tZIb5hVGaaPOLA/edit#gid=0"
my_title <- str_c("The state is by far the largest funder of",
                  "North Carolina public schools",
                  sep = "\n")
title_size <- 18
my_subtitle <- "Chart based off 2021 NC education data"
subtitle_size <- 10
my_caption <- str_c(#"Original Data Visualization",
                    "Data from NC Department of Public Instruction",
                    #"http://apps.schools.nc.gov/ords/f?p=145:32:::NO:::",
                    sep = "\n")
caption_size <- 8
caption_color <- background_dark_blue
axis_box_color <- background_dark_blue
my_background <- cv_background
axis_text_color <- my_background
flow_colors <- c(vibrant_red, magenta, purple)
my_font <- "montserrat"
title_font <- "arvo"
#"merriweather"

#######################################
# get data
#######################################
googlesheets4::gs4_deauth() # turn off login requirement
funds <- googlesheets4::read_sheet(funds_URL)

# wrangle data
funds <- select(funds, !c(Total, Year)) %>%
  filter(!(Type %in% c("OTHER OBJECTS",
                       "INSTRUCTIONAL EQUIP.",
                       "TOTAL",
                       "PERCENT OF TOTAL"))) %>%
  mutate(Type = str_to_title(Type)) %>%
  mutate(Type = str_replace(Type, " ", "\n"))
  #mutate(Type = ifelse(Type == "Supplies\n&\nMaterials", "Supplies &\nMaterials", TRUE)) %>%
  #mutate(Type = str_replace(Type, "Equip.", "Equipment")) %>%

# 
funds_long <- funds %>%
  pivot_longer(cols = c("State", "Federal", "Local"),
               names_to = "geo",
               values_to = "money")


#######################################
# plot
#######################################
## Loading Google fonts (https://fonts.google.com/)
font_add_google(str_to_title(my_font), my_font)
font_add_google(str_to_title(title_font), title_font)
showtext_auto()

# plot
school_funding_plot <- ggplot(funds_long,
               aes(axis1 = geo,
                   axis2 = Type,
                   y = money)) +
  geom_alluvium(aes(fill = geo),
                curve_type = "quintic",
                width = 1/12,
                knot.pos = 0.4,
                alpha= 0.7) +
  geom_stratum(aes(fill = geo),
               width = 1/6,
               color = axis_text_color,
               alpha=1,
               linetype="solid",
               fill = axis_box_color) +
  scale_color_manual(values = flow_colors) +
  scale_fill_manual(values = flow_colors) + 
  geom_text(stat = "stratum",
            aes(label = after_stat(stratum)),
            color = axis_text_color,
            family=title_font,
            size = 3) +
  theme_minimal() +
  labs(x="", y="") +
  labs(title = my_title,
       subtitle = my_subtitle,
       caption = my_caption) +
  theme(
    plot.background = element_rect(fill = my_background, colour = my_background),
    legend.position = "none",
    plot.title = element_text(size = title_size, 
                              family = title_font,
                              color = axis_box_color),
    plot.subtitle = element_text(size = subtitle_size, 
                                 family = title_font,
                                 color = axis_box_color),
    plot.caption = element_text(size = caption_size,
                                family = title_font,
                                colour = caption_color),
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    axis.text.y = element_blank(),
    axis.text.x = element_blank()
  )



########################################################################################################
# condensed version
# new data
funds_long_CONDENSED <- funds_long %>%
  mutate(Type = case_when(Type == "Employee\nBenefits" ~ "Benefits",
                          Type == "Supplies\n& Materials"  ~ "Supplies",
                          Type == "Purchased\nServices" ~ "Services",
                          TRUE ~ Type)
         )


# new hard coded values
my_title <- str_c("The state is by far the largest funder",
                  "of North Carolina public schools",
                  sep = "\n")
title_size <- 16
my_subtitle <- "Chart based off 2021 NC education data"
subtitle_size <- 10
my_caption <- str_c(#"Original Data Visualization",
  "Data from NC Department of Public Instruction",
  #"http://apps.schools.nc.gov/ords/f?p=145:32:::NO:::",
  sep = "\n")
caption_size <- 8
caption_color <- background_dark_blue
axis_box_color <- background_dark_blue
my_background <- cv_background
axis_text_color <- my_background
flow_colors <- c(vibrant_red, magenta, purple)
my_font <- "montserrat"
title_font <- "montserrat"
#"merriweather"
# plot
funding_plot_CONDENSED <- ggplot(funds_long_CONDENSED,
               aes(axis1 = geo,
                   axis2 = Type,
                   y = money)) +
  geom_alluvium(aes(fill = geo),
                curve_type = "quintic",
                width = 1/12,
                knot.pos = 0.4,
                alpha= 0.7) +
  geom_stratum(aes(fill = geo),
               width = 1/6,
               color = axis_text_color,
               alpha=1,
               linetype="solid",
               fill = axis_box_color) +
  scale_color_manual(values = flow_colors) +
  scale_fill_manual(values = flow_colors) + 
  geom_text(stat = "stratum",
            aes(label = after_stat(stratum)),
            color = axis_text_color,
            family=title_font,
            size = 3) +
  theme_minimal() +
  labs(x="", y="") +
  labs(title = my_title,
       subtitle = my_subtitle,
       caption = my_caption) +
  theme(
    plot.background = element_rect(fill = my_background, colour = my_background),
    legend.position = "none",
    plot.title = element_text(size = title_size, 
                              family = title_font,
                              color = axis_box_color
                              ),
    plot.subtitle = element_text(size = subtitle_size, 
                                 family = title_font,
                                 color = axis_box_color
                                 ),
    plot.caption = element_text(size = caption_size,
                                family = title_font,
                                colour = caption_color,
                                vjust = 8
                                ),
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    axis.text.y = element_blank(),
    axis.text.x = element_blank(),
  )











#