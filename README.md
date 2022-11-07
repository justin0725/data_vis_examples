A sample of my data analysis and visualization work
================
Justin Giles

I spent many late nights coding during the first year of my MPP.  Here are some of the fruits of that labor!

# Table of contents
1. [Does voting make people learn about policy?](#rdd)
2. [Are North Carolina schools equitable?](#schools)
3. [Does DACA make immigrants invest more in the U.S. labor market?](#did)
4. [Does giving cash to low-income parents help them? What about everybody else?](#cba)
5. [Does North Carolina traffic stop data contain evidence of racial discrimination?](#vod)
6. [Just for fun, doggos](#dogs)
<br/> <br/> <br/>

<a name="rdd"></a>
# 1. Does voting make people want to learn about public policy?
Replication of a regression discontinuity analysis from [a 2014 paper by Lopez de Leon and Rizzi](https://www.aeaweb.org/articles?id=10.1257/pol.6.4.380).
### No. In Brazil, mandatory voting prompts more people to vote, but not to learn about policy.
Some people argue that voting gives voters an incentive to learn more about policy.  Others argue that because the marginal effect of a single vote on an election's outcome is negligible, ability to vote does is not a compelling reason to learn more about policy (the "rational ignorance" hypothesis).

To asses these claims, we can't just look at whether voters know more about policy than non-voters because the relationship might not be causal.  For example, maybe the type of people vote are also the type of people who want to learn about policy.

Lopez de Leon and Rizzi get around this problem by taking advantage of the fact that people in Brazil are *allowed* to vote before age 18 but *must* vote after age 18. If voting makes people want to learn about policy, we should see a spike in policy knowledge at age 18 that corresponds with a spike in voting.

But first, we have to check that the share of people voting does in fact increases at age 18, and increases by a statistically significant amount. The error bars on the chart below represent 95% confidence intervals.

<br/>
<img src="/img/balance_VOTE.png" width="700px" />
<br/>

Okay, so more Brazilians are voting more at age 18. Do they also become more knowledgable about policy? 

The plot below says no.  While there is a statistically significant jump in voting at age 18, there is *not* a statistically significant jump in policy knowledge.  So, these results support the rational ignorance hypothesis.

The plot shows the variation in two variables (age and policy quiz scores) that is not explained by a variety of controls (retrieved through two OLS models of each outcome variable on the controls). It includes best fit lines found through local linear regressions, as well as a 95% confidence interval ribbon.
<br/>
<img src="/img/RDD_plot.png" width="700px" />
<br/> <br/> <br/>

<a name="schools"></a>
# 2. Are North Carolina schools equitable?
For all North Carolina's issues with K-12 education funding, the overall model isn't one of them.  Many other states fund schools through local property taxes.  In those states, schools in a poor areas frequently struggle to make ends meet.  Because the majority of North Carolina schools' funds come from the state, in theory, schools in poor districts may have less of an issue procuring funds.

<br/>
<img src="/img/nc_funding.png" width="500px" />
<br/>

But is this model doing enough for North Carolina's disadvantaged school districts?  The numbers say no.  The plots below show that educational outcomes remain worse in districts with more low-income and minority race students.

The first plot below depicts the relationship between North Carolina school districts’ average SAT scores and median household incomes. The second plot puts the residuals from the first plot’s OLS model (regressing SAT score on income) on the y-axis. This illustrates the relationship between a district’s SAT score and racial makeup, isolated from the effect of income.
<br/>
<img src="/img/Income.png" width="600px" />
<br/> <br/>
<img src="/img/Race.png" width="600px" />
<br/>
So if the funding model isn't the issue, what is?  I'm a lot less certain I can answer that question, but the following points are at least relevant:
1. **Overall funding for K-12 education remains far too low.** A good funding model can't make up for a lack of money going into it. North Carolina has yet to meet funding requirements [ordered by the state supreme court](https://www.youtube.com/watch?v=ye5nf6vz_9w&t=9s) over twenty years ago. The court-ordered [WestEd report](https://www.wested.org/resources/leandro-north-carolina/) can help the state figure out how to spend the money, if it ever provides it.
2. **The state struggles to recruit and retain good teachers and to send them where they matter most.** A high-quality teacher can make a [big difference](https://www.aeaweb.org/articles?id=10.1257/aer.104.9.2633) in educational outcomes.  But at current funding levels, research points to virtually no effect of pay raises on [teacher retention](https://direct.mit.edu/edfp/article/6/3/399/10143/Teacher-Mobility-School-Segregation-and-Pay-Based), especially in [schools where a majority of students are nonwhite](https://www.edworkingpapers.com/ai21-455).
<br/> <br/> <br/>

<a name="did"></a>
# 3. Does DACA incentivize immigrants to invest more in the U.S.?
### Replication of [Nolan Pope’s 2016 paper](https://www.sciencedirect.com/science/article/pii/S0047272716301268) using difference-in-differences to look at how DACA affected on immigrants who arrived as children.
I'll write a non-technical explanation of this table one day, but today is not that day.  The table uses Pope's data, but  displays the coefficients from my own modified (but still based off Pope's) OLS model looking at the interaction effect of DACA elgiibility and arriving after DACA became available.
The results suggest that DACA incentivized immigrants to enter the labor force and work more hours.
<br/>
<img src="/img/pope_table2.jpg" width="800px" />
<br/> <br/> <br/>

<a name="cba"></a>
# 4. Does giving cash to low-income parents help them?  What about everybody else?
### Adapted from [Garfinkel et al.'s 2022 cost-benefit analysis](https://www.nber.org/papers/w29854)
I produced the below table for a report on the expanded child tax credit (CTC).  The numbers are pulled straight from the paper, so this didn't take any fancy quantitative skills.  But I care a lot about poverty and welfare policy, so I couldn't resist including it here!

The CTC is basically free money for parents of children.  The policy already gives most parents about $2000 per child every year.  However, some parents (about 1 in 3) don't make enough money to qualify for the full amount, and others (about 1 in 10) get nothing at all.  If we changed the policy so everybody got the full amount, would it help low-income families?  And what about everybody else - would it benefit U.S. taxpayers more than it would cost them?

Yes on both accounts! Garfinkel et al. looked at a *lot* of studies on what happens when people get more cash and extrapolated the findings to predict what would happen if  low-income parents currently not receiving the full CTC became eligible.  They found the policy change could create net economic benefits far exceeding the policy's costs.  Most of those benefits come from:
1. Increases in children's future productivity and earnings,
2. Decreases in burdens on the healthcare system, and
3. Reductions in crime and its associated costs.
<br/>
<img src="/img/garf_national.png" width="1972" />
<br/> <br/> <br/>

<a name="vod"></a>
# 5. Does North Carolina traffic stop data contain evidence of racial discrimination?
### Replication of a [2020 paper by Pierson et al.](https://www.nature.com/articles/s41562-020-0858-1) employing the "veil of darkness" test
I used Pierson et al.'s data for my analysis, but limited it to a subset from North Carolina.  The complicated nature of the analysis means that interpreting the plot takes some work, but I think it’s worth it! (Well, for *their* paper at least - you can decide if it's worth it for mine)

In the below plot, I look at only traffic stops that occurred between 7pm and 7:15pm.  This helps control for potentially confounding variables like what officers are on shift, what drivers are out and about on the roads, etc. At 7pm, it may be light or dark depending on the time of year. I compare traffic stops that took place 60 to 30 minutes before dark, and 0 to 30 minutes after dark (the period from 30 to 0 minutes before dark is neither dark nor light, so traffic stops in that time get removed). 

The idea here is that if percent of stopped drivers decreases when it is dark - when officers can no longer see the race of the person driving the car - that’s evidence of racial bias in traffic stops.

The lines on the plot indicate the average percent of drivers pulled over who were black before and after dark, and the shaded bands represent 95% confidence intervals of those averages. Each dot indicates the percent of drivers pulled over in the one-minute interval depicted on the x-axis, with the larger dots signifying more traffic stops in that interval.

If all that seems hopelessly confusing, this is the part to focus on: yellow dots are daytime averages of percent of drivers stopped who are black, while purple dots are nightttime averages of percent of drivers stopped who are black.  If the purple dots tend to be lower than the yellow dots, that means black drivers are less likely to be stopped when their race cannot be seen, which is evidence for racial bias.

<img src="/img/pierson_plot1.png" width="700px" />
<br/> 

Unlike Pierson et al., I did not find a statistically significant effect of the “veil of darkness” on the liklihood of a driver pulled over being black (the error bands overlap).  My full analysis contained plots for more times as well as logistic regression results, none of which were significant.

There are lots of reasons Pierson et al.'s results might fail to replicate for the North Carolina sample.  Most obviously, North Carolina could have less racial bias in its traffic stops than other states.  But there are many counfounding factors that I think offer more plausible explanations.  Pierson et al. did not specify all of their controls; I likely failed to account for some. Their analysis (which used data from many states) also found only a small effect, so the North Carolina subset might not be powerful enough to detect an effect even if one exists.  Finally, there may be other indicators of a driver's race (area they live in, etc.) that are not masked by nightfall, and are more prominant in North Carolina than other states.
<br/> <br/> <br/>

<a name="dogs"></a>
# 6. We all love dogs right?
Corgis have put in the work, but Labs still reign supreme! My condolences to the yorkshire terriers.
<img src="/img/dogs.png" width="800px" />
