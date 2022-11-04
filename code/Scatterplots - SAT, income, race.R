source(here::here("code", "income_race_SAT.R"))

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
       y = "Average SAT Score",
       title = str_c("North Carolina's wealthier school districts",
                     "perform significantly better on the SAT",
                     sep = "\n"
       ),
       caption = str_c("2021 SAT data from the North Carolina Department of Public Instruction",
                       "Income data from the Census Bureau (ACS 5-year estimates)",
                       sep = "\n"
       )
  ) +
  theme(axis.title.y = element_text(#angle = 0,
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
  title = element_text(size = 15,
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



######################################################



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
       y = str_c("Difference from average SAT score",
                 "at the same income level",
                 sep = "\n"
       ),
       title = str_c("North Carolina's nonwhite districts perform worse",
                     "on the SAT, even after controling for income.",
                     sep = "\n"),
       caption = str_c("2021 SAT data from the North Carolina Department of Public Instruction",
                       "Demographic data from the Census Bureau (ACS 5-year estimates)",
                       sep = "\n")
  ) +
  theme(axis.title.y = element_text(#angle = 0,
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
  title = element_text(size = 15,
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


#


