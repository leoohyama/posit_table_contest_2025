#we need to edit the data so that everything cannot be traced 

Gradeleveltabs<-readRDS("data/final_table2025-09-15.rds")
enroll_heat_week <- readRDS("data/heatmapdataweekly/heat_mapweekly2025-09-03.rds")

set.seed(123)

Gradeleveltabs <- Gradeleveltabs %>%
  # jitter capacities
  mutate(
    n_total = round(n_total * runif(n(), 0.9, 1.2)),
    
    # eligibility: use beta for wide variation but preserve grade structure
    elig_frac = rbeta(n(), shape1 = runif(n(), 1, 5), shape2 = runif(n(), 1, 5)),
    n_eligible = round(n_total * elig_frac),
    
    # enrollment: subset of eligible with wide variation
    enroll_frac = rbeta(n(), shape1 = runif(n(), 0.5, 4), shape2 = runif(n(), 0.5, 4)),
    n_enrolled = ifelse(
      is.na(n_enrolled), NA,
      round(n_eligible * enroll_frac)
    ),
    
    # remaining kids who are not eligible & not enrolled
    n_not_eligible_not_enrolled = n_total - n_eligible
  ) %>%
  select(-elig_frac, -enroll_frac,-n_not_eligible_not_enrolled)


numeric_cols <- setdiff(names(enroll_heat_week), "DISTRICT_NAME")

enroll_heat_week <- enroll_heat_week %>%
  mutate(
    DISTRICT_NAME = sample(DISTRICT_NAME, replace = FALSE),
    
    # inflate older weeks moderately (stay roughly same or slight increase)
    across(all_of(numeric_cols[1:(length(numeric_cols)-3)]),
           ~ round(.x * runif(1, 1.0, 1.3))),
    
    # for second-to-last week: allow increase or slight decrease
    `08-17` = round(`08-17` * runif(n(), 0.8, 1.6)),
    
    # for last week: allow bigger swing in both directions
    `08-24` = round(`08-24` * runif(n(), 0.5, 2.5))
  ) %>%
  rowwise() %>%
  mutate(total = sum(c_across(`06-22`:`08-24`))) %>%
  ungroup()

Gradeleveltabs<-saveRDS(Gradeleveltabs,"data/final_table_example.rds")
enroll_heat_week <-saveRDS(enroll_heat_week, "data/heatmapdataweekly/heat_mapweeklyexample.rds")
