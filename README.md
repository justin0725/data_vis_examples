Data Analysis and Visualization from My MPP
================
Justin Giles

I spent a lot of my first year as an MPP coding.  Here's some fruits of that labor!

# North Carolina funds education at the state level.  That's unusual!
For all North Carolina's issues with K-12 education funding, the overall model isn't one of them.  Many other states fund schools through local property taxes.  As a result, a school in a poor area becomes far more likely to be underresourced.  Because the majority of North Carolina schools' funds come from the state, schools in poor districts may receive aid from elsewhere.  Unfortately, other inequities prevent this system from achieving its full potential (more on that later).
<br/>
<img src="/img/nc_funding.png" width="500px" />
<br/>

# Does voting make people want to learn about public policy?
### Replication of a regression discontinuity analysis from [a 2014 paper by Lopez de Leon and Rizzi](https://www.aeaweb.org/articles?id=10.1257/pol.6.4.380).
Some people argue that voting gives voters an incentive to learn more about policy.  Others argue that because the marginal effect of a single vote on an election's outcome is negligible, ability to vote does is not a compelling reason to learn more about policy (the "rational ignorance" hypothesis). But to asses these claims, we can't just look at whether voters know more about policy because the relationship might not be causal.  For example, maybe the same type of person who chooses to vote is also the type of person who wants to learn about policy.

Lopez de Leon and Rizzi's analysis take advantage of the fact that people in Brazil *can* vote before age 18 but *must* vote after age 18. Voting incentives learning about policy, we should see a spike in policy knowledge at age 18 that corresponds to a spike in voting.

The plot below displays the results, as replicated by me.  It charts the variation in two variables (age and policy quiz scores) that is not explained by a variety of controls (retrieved through two OLS models of each outcome variable on the controls). It includes best fit lines found through local linear regressions, as well as a 95% confidence interval ribbon.

While there is a statistically significant jump in voting at age 18, there is *not* a statistically significant jump in policy knowlegde, lending support to the rational ignorance hypothesis.
<br/>
<img src="/img/RDD_plot.png" width="900px" />

As part of the same analysis, I performed multiple tests to show that voting not only increases at age 18, but increases by a statistically significant amount (while other relevant covariates don't change much). A bar chart with error bars is a simple way to show this.

<img src="/img/balance_VOTE.png" width="900px" />
<br/>

# Does DACA incentivize immigrants to invest more in the U.S.?
### Replication of [Nolan Pope’s 2016 paper](https://www.sciencedirect.com/science/article/pii/S0047272716301268) using difference-in-differences to look at how DACA affected on immigrants who arrived as children.
The below use's Pope's data, but  displays the coefficients from my own modified OLS model looking at the interaction effect of DACA elgiibility and arriving after DACA became available (as opposed to before).
The results suggest that DACA incentivized immigrants to enter the labor force and work more hours.
<br/>
<img src="/img/pope_table2.jpg" width="900px" />
<br/> <br/> <br/>

# Illustrating Inequities in North Carolina K-12 Education
In spring 2022, I worked with a team of students to help a North Carolina philanthropy decide how it might use its resources to advance equity in K-12 education.  As part of my team's overview on the issues currently facing the state, I depicted the association between wealth, race, and educational outcomes in the plots below.
The first plot below depicts the relationship between North Carolina school districts’ average SAT scores and median household incomes. The second plot puts the residuals from the first plot’s OLS model (regressing SAT score on income) on the y-axis. This illustrates the relationship between a district’s SAT score and racial makeup, isolated from the effect of income.
<br/>
<img src="/img/Income.png" width="600px" />
<br/> <br/>
<img src="/img/Race.png" width="600px" />
<br/> <br/> <br/>

# Benefits of the Child Tax Credit, adapted from [Garfinkel et al.'s 2022 cost-benefit analysis](https://www.nber.org/papers/w29854)
I produced the below table for a report on the expanded child tax credit.  Garfinkel et al. found that giving money to parents would create social benefits far exceeding the policy's costs.  The largest benefit areas were increases to children's future earnings, improvements in health, and reductions in crime and its associated costs.
<br/>
<img src="/img/garf_national.png" width="1972" />
<br/> <br/> <br/>

# Can we find evidence of racial discrimination in traffic stop data?
### Replication of a [2020 paper by Pierson et al.](https://www.nature.com/articles/s41562-020-0858-1) employing the "veil of darkness" test
For this analysis, I used only the subset of Pierson et al.'s data from North Carolina. The below plot is from that analysis. The complicated nature of the analysis means that interpretting the plot takes some work - but I think it’s worth it! (Well, for *their* paper at least)

The traffic stop data includes the time every traffic stop and the race of the driver. In the below plot, I look at just traffic stops that occurred between 7pm and 7:15pm.  This helps control for potentially confounding variables like what officers are on shift, who is out and about on the roads, etc. At this time, it may be light or dark depending on the time of year. I compare traffic stops made in this 15 minute chunk that were 60 to 30 minutes before dark, and 0 to 30 minutes after dark (the period from 30 to 0 minutes before dark is neither dark nor light, so traffic stops in that time get removed). The idea is that if percent of stopped drivers decreases when it is dark - when officers can no longer see the race of the person driving the car - that’s evidence of racial bias in traffic stops.

The lines on the plot indicate the average percent of drivers pulled over who were black before and after dark, and the shaded bands represent 95% confidence intervals of those averages. Each dot indicates the percent of drivers pulled over in the one-minute interval depicted on the x-axis, with the larger dots signifying more traffic stops in that interval.

<img src="/img/pierson_plot1.png" width="900px" />
<br/> 

Unlike Pierson et al., I did not find a statistically significant effect of the “veil of darkness” on the liklihood of a driver pulled over being black.

There are lots of reasons their result might fail to replicate for the North Carolina sample.  Most obviously, North Carolina could have less racial bias in its traffic stops than other places.  However, there are many counfounding factors. Pierson et al. did not specify all of their controls; I likely failed to account for some. Their analysis (which used data from many states) also found only a small effect; the North Carolina subset of data maybe not be powerful enough to detect an effect if one exists.  Finally, there may be other indicators of a driver's race (area they live in, etc.) that are not masked by nightfall, and are more prominant in North Carolina than other states.

<br/>

# Last but not least, I made this plot just for fun!
Corgi fans have put in the work, but Labs still reign supreme!
<img src="/img/dogs.png" width="900px" />
