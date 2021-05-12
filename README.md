# ANOVA 2-way operator

##### Description

The `anova2` operator tests for a significant difference in the mean between any of the groups in the input data.

##### Usage

Input projection|.
---|---
`y-axis`| measurement value
`color` | represents the groups to compare

Output relations|.
---|---
`pr`| numeric, p-value calculated per cell

##### Details

2-way ANOVA is used for data with two grouping factors, but with more than 2 groups. It test for a significant difference in the mean between any of the groups. As such, it is a generalization of the two sample t-test that works for two groups only. The operator is based on the [anova R function](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/anova).

##### References

See [Analysis of variance on Wikipedia](https://en.wikipedia.org/wiki/Analysis_of_variance).

##### See Also

[anova1](https://github.com/tercen/anova1_operator)