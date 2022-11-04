source(here::here("code", "school funding flows.R"))

# earth tones
light_tan <- "#CAC792"
navy_blue_earth <- '#162240'
yellow_earth <- "#CBA42C"
dark_green <- "#404f24"
orange <- "#D57500"
light_green_earth <- "#8B9A46"
red <- "#8F3B1B"
earth_dark_blue <- "#1A3351"
dull_light_blue <- "#B9D9E8"

# elizabeth's colors
text_dark_blue <- "#0a334d"
background_light_grey <- "#f6f7f6"
text_dark_grey <- "#545454" # bold for headings, plain for paragraph text
suggested_tan <- "#e5d6b1"
suggested_light_blue <- "#74acdc"
suggested_lighter_blue <- "#bce6ea"

background_dark_blue <- "#0b334d"
text_white <- "#ffffff"
text_yellow <- "#f9efbf"
text_orange <- "#e1a731"
suggested_brown <- "#a4765a"

# other colors
tea_green <- "#C7F6B6"
light_green <- "#99EE99"


# set colors
# new hard coded values
my_title <- str_c("The state is by far the largest funder of North Carolina",
                  "public schools",
                  sep = "\n")
title_font <- "arvo"
title_size <- 16
my_subtitle <- "Chart based off 2021 data from NC DPI"
subtitle_size <- 10
axis_text_size <- 4
axis_box_color <- text_yellow
my_background <- text_dark_blue
axis_text_color <- my_background
flow_colors <- c(vibrant_red,
                 background_light_grey,
                 suggested_light_blue
                 )


# plot
funding_plot_CONDENSED_2 <- ggplot(funds_long_CONDENSED,
                         aes(axis1 = geo,
                             axis2 = Type,
                             y = money)) +
  geom_alluvium(aes(fill = geo),
                curve_type = "quintic",
                width = 1/12,
                knot.pos = 0.4,
                alpha= 0.9) +
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
            size = axis_text_size) +
  theme_minimal() +
  labs(x="", y="") +
  labs(title = my_title,
       subtitle = my_subtitle
       ) +
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
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    axis.text.y = element_blank(),
    axis.text.x = element_blank(),
  )





#