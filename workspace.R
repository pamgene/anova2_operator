library(tercen)
library(dplyr)
library(tibble)

# Set appropriate options
# options("tercen.serviceUri"="http://tercen:5400/api/v1/")
# options("tercen.workflowId"= "e3a373ea9ad78b1a5d42b21cac0076cc")
# options("tercen.stepId"= "220b6a01-011f-4ba9-b43d-c0331f0a637a")
# options("tercen.username"= "admin")
# options("tercen.password"= "admin")

do.anova = function(df, interact = FALSE){
  f.stat = NaN
  numdf = NaN
  dendf = NaN
  p.value = NaN
  r.squared = NaN
  adj.r.squared = NaN
  formula = ifelse(interact, ".y ~ .group.colors1 * .group.colors2", ".y ~ .group.colors1 + .group.colors2")
  aLm = try(lm(formula, data=df), silent = TRUE)
  if(!inherits(aLm, 'try-error')) {
    anova    = anova(aLm) %>% 
      rownames_to_column('rows') %>% 
      filter(grepl(".group.colors", rows)) %>% 
      select(-rows)
    Df       = anova$Df
    sum.sq   = anova$'Sum Sq'
    mean.sq  = anova$'Mean Sq'
    f.values = anova$'F value'
    p.values = anova$'Pr(>F)'
  } 
  return (data.frame(.ri     = df$.ri[1], 
                     .ci     = df$.ci[1],
                     Df      = Df,
                     sum.sq  = sum.sq,
                     mean.sq = mean.sq,
                     f.value = f.values,
                     p.value = p.values))
}

ctx = tercenCtx()

if (length(ctx$colors) < 2) stop("Two color factors are required.")

Interaction = ifelse(is.null(ctx$op.value('Interaction')), FALSE, as.logical(ctx$op.value('Interaction')))

ctx %>% 
  select(.ci, .ri, .y) %>%
  mutate(.group.colors1 = do.call(function(...) paste(..., sep='.'), ctx$select(ctx$colors[[1]]))) %>%
  mutate(.group.colors2 = do.call(function(...) paste(..., sep='.'), ctx$select(ctx$colors[[2]]))) %>%
  group_by(.ci, .ri) %>%
  do(do.anova(., Interaction)) %>%
  ctx$addNamespace() %>%
  ctx$save()
