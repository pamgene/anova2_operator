# ANOVA 2-way operator

##### Description

The `anova2` operator tests for a significant difference in the mean between any of the groups in the input data.

##### Usage

Input projection|.
---|---
`y-axis` | measurement value
`colors` | represents the groups to compare

Input parameters|.
---|---
`Grouping Variable 1` | Treat the ANOVA grouping variable 1 as categorical (dft) or numerical.
`Grouping Variable 2` | Treat the ANOVA grouping variable 2 as categorical (dft) or numerical.
`Include Interaction` | Fit ANOVA model using a factor1:factor2 interaction term (dft = "No").

Output relations|.
---|---
`pFactor1`          | p-value for the probability that all group means for Factor1 are equal (groupingType = categorical) or the slope of the straight line fit is equal to zero (groupingType = continuous), accounting for Factor2. Hence, a low value indicates a significant effect for Factor1.
`pFactor2`          | p-value for the probability that all group means for Factor2 are equal (groupingType = categorical) or the slope of the straight line fit is equal to zero (groupingType = continuous), accounting for Factor1. Hence, a low value indicates a significant effect for Factor2.
`pFactor3`          |  p-value for the interaction between Factor1 and Factor2 (if required). A low value for pFactor3 indicates an effect of Factor2 that is different in the groups of Factor1 (or vice versa).
`logpFactor1-3`     | the significance of pFactors 1-3, respectively, as -10 log(pFactor).

##### Details

2-way ANOVA is used for data with two grouping factors, but with more than 2 groups. It test for a significant difference in the mean between any of the groups. As such, it is a generalization of the two sample t-test that works for two groups only. The operator is based on the [anova R function](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/anova).

The grouping factors must be added as data colors. The grouping can be by categorical and/or continuous variables. In the latter case a straight line regression is performed.
There is an option to add an interaction term to the ANOVA model.

##### References

See [Analysis of variance on Wikipedia](https://en.wikipedia.org/wiki/Analysis_of_variance).

##### See Also

[anova1](https://github.com/tercen/anova1_operator)