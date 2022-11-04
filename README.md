Data Visualization Examples
================
Justin Giles

#### I produce a lot of data visualizations in R - you can see some of them here! I’m hoping to eventually update this repository to include the code for each visualization too - but that’s work for another day.

#### I made this chart for North Carolina philanthropy that works with public schools.

<br/>

<img src="/img/nc_funding.png" width="700px" />
<br/> <br/> <br/> <br/>

#### As part of my MPP coursework, I replicated a regression discontinuity analysis from [a 2014 paper by Lopez de Leon and Rizzi](https://www.aeaweb.org/articles?id=10.1257/pol.6.4.380). It found that voting *does not* increase a person’s policy knowledge (supporting the *rational ignornance hypothesis*). The plot below displays the result, and is a good example of how R enables complex data visualization.

<br/>

#### This plot charts the variation in two variables (age and policy quiz scores) that is not explained by a variety of controls (retrieved through two OLS models of each outcome variable on the controls). It includes best fit lines found through local linear regressions, as well as a 95% confidence interval ribbon.

<br/>
<img src="/img/RDD_plot.png" width="900px" />
<br/>

#### As part of the same analysis, I needed to show that voting not only increases at age 18, but increases by a statistically significant amount. A bar chart with error bars is a simple way to show this.

<br/>
<img src="/img/balance_VOTE.png" width="900px" />
<br/>

<br/> <br/>

#### The gt package in R allows easy creation of aesthetically appealing tables. The below table replicates [Nolan Pope’s 2016 paper](https://www.sciencedirect.com/science/article/pii/S0047272716301268) looking for a causal effect of DACA on childhood arrivals of immigrants. It displays OLS model using formatting similar to academic journals.

<br/>
<img src="/img/pope_table2.jpg" width="900px" />
<br/> <br/> <br/>

#### GT tables are just as customizable as ggplot plots. I produced the below table for a report on the Child Tax Credit, making use of colors to increase the table’s readability and appeal.

<br/>
<img src="/img/garf_national.png" width="1972" />
<br/> <br/> <br/>

#### The first plot below depicts an OLS model of the relationship between North Carolina school districts’ average SAT scores and median household incomes. The second plot puts the residuals from the first plot’s model on the y-axis in an attempt to capture the relationship between a district’s SAT score and racial makeup, isolated from the effect of income.

<br/>
<img src="/img/income.png" width="600px" />
<br/> <br/>
<img src="/img/race.png" width="600px" />
<br/> <br/> <br/>

#### For another one of my MPP classes, I replicated the results of a [2020 paper by Pierson et al.](https://www.nature.com/articles/s41562-020-0858-1) testing traffic stop data for evidence of racial discrimination. I used only the subset of their data from North Carolina. The below plot is from that analysis. The complicated nature of the analysis means that interpretting the plot takes some work - but I think it’s worth it! (Well, for their paper at least)

#### The traffic stop data includes the time every traffic stop and the race of the driver. In the below plot, I look at just traffic stops that occurred between 7pm and 7:15pm (this helps control for stuff like what officers are on shift at the time, who is out and about on the roads, etc.). In this time, it may be light or dark depending on the time of year. I compare traffic stops made in this 15 minute chunk that were 60 to 30 minutes before dark, and 0 to 30 minutes after dark. The idea is that if percent of stopped drivers decreases when it is dark - and officers theoretically can no longer see the race of the person driving the car before they pull them over - that’s evidence of racial bias in traffic stops.

#### The lines on the plot indicate the average percent of drivers pulled over who were black before and after dark, and the shaded bands represent 95% confidence intervals. Each dot indicates the percent of drivers pulled over in the one-minute interval depicted on the x-axis, with the larger dots signifying more traffic stops in that interval.

<br/>
<img src="/img/pierson_plot1.png" width="900px" />
<br/> <br/> <br/>

#### Unlike Pierson et al., I did not find a statistically significant effect of the “veil of darkness” (assumed to hamper the ability of police to see the race of a person in a car) on the liklihood of a driver pulled over being black. This may be because the N.C. subset is not powerful enough to find the (small) effect they did.

<br/> <br/> <br/>

#### And then there’s this last one, just for fun.

<img src="/img/dogs.png" width="900px" />
