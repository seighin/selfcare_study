# Selfcare Study
Michael Shyne  
`r format(Sys.time(), '%B %d, %Y')`  





## Data

The data for this study was comprised of "pre" and "post" self-care assessments (Health Promoting Lifestyle Profile II) given near the beginning and near the end of the semester, respectively, of a graduate level nursing theory class along with self-identified demographic information. The assessments were anonymous. "Pre" and "post" assessments were matched using secret codes, a short word or number selected by each subject. There were four sections of the class, separated into two groups randomly. Both groups were instructed on the importance of self-care and asked to write a reflective summary of their self-care activities. In addition, subjects in group A were required to create and implement a self-care plan based on the findings of the initial assessment.

The Health-Promoting Lifestyle Profile II (HPLP II) consists of 52 Likert scale questions with 4 possible answers, never (N), sometimes (S), often (O) and routinely (R). The HPLP II generates seven scores, an overall score and categorical scores for health responsibility, physical activity, nutrition, spiritual growth, interpersonal relations and stress management.  The scores are calculated by rendering each answer as a number, 1 for never, 2 for sometimes, 3 for often and 4 for routinely, and taking the mean of all answers for the overall score or the mean of a specified collection of answers for each category score.

Addition demographic information collected included years working as an RN, gender, age and race/ethnicity.

The question of interest is whether group A scores increased more than group B.

### Notes on data entry

An effort was made to enter demographic data exactly as written on the assessment forms, with the following exceptions:

- Assessments which did not have exactly matching codes but were determined to be probable matches were given identical codes.
- Gender was always entered as "m" or "f" or left blank.
- For numeric information (years RN and age), fractions and months were entered as approximate decimals (i.e., "2 months" as 0.16). Values such as "< 1" were entered as 0 and "30+" were left blank.
- Race/ethnicity was entered as written except in all lowercase for simplicity.

HPLP II answers were entered as numbers as specified above. Missing answers or multiple answers (if not clear which is intended) were left blank.

Six pairs of assessments which did not have matching or nearly matching codes were found to be probable matches based on demographic information and handwriting. These assessments were assigned to section 3. Initial analysis was run with and without section 3 and no significant differences were found. Therefore, section 3 assessments were included in the final analysis.

The raw data was saved in `selfcaredata.csv`.

### Processing data

The processing of the raw data is performed by the script `process.R`.

The gender values were given labels of "Female", "Male" and missing (NA). The race values were categorized into labels "White", "Black", "Other" and missing (NA). The following entered values were categorized as "White":

- white
- white/caucasian
- white/non-hispanic
- caucasian 
- cauc.
- caucation
- causasian

The following entered values were categorized as "Black":

- black
- black american
- aa
- african
- african american
- b

The following entered values were categorized as "Other":

- asian
- biracial
- hispanic
- indian
- white/asian
- white/black

Missing values include blank entries and one entry of "human race".

The demographic information was standardized (same values for "pre" and "post assessment rows) for each subject using values from "pre" assessment unless missing.

The HPLP II scores were calculated by taking the mean of the appropriate answers (ignoring missing values) as follows:

- **Overall** (overall): All answers, 1 - 52
- **Health Responsibility** (hr): Answers 3, 9, 15, 21, 27, 33, 39, 45, 51
- **Physical Activity** (pa): Answers 4, 10, 16, 22, 28, 34, 40, 46
- **Nutrition** (n): Answers 2, 8, 14, 20, 26, 32, 38, 44, 50
- **Spiritual Growth** (sg): Answers 6, 12, 18, 24, 30, 36, 42, 48, 52
- **Interpersonal Relations** (ir): Answers 1, 7, 13, 19, 25, 31, 37, 43, 49
- **Stress Management** (sm): Answers 5, 11, 17, 23, 29, 35, 41, 47

The data set was transformed so that each subject occupied one row, with standardized demographic information and the seven HPLP II scores from the "pre" assessment and the seven HPLP II scores from the "post" assessment. Seven "delta" scores were calculated by subtracting the "pre" scores from the "post" scores.

One subject was removed (code "1326") because one half of the "post" assessment was not completed.

The processed data set was saved as `selfcare_processed.csv`.

### Data characteristics


      Total   Group A   Group B
---  ------  --------  --------
n        70        39        31

#### Gender

                  Total   Group A   Group B
---------------  ------  --------  --------
Female               55        30        25
Male                 11         8         3
Gender missing        4         1         3

#### Race

                Total   Group A   Group B
-------------  ------  --------  --------
White              44        27        17
Black              15        10         5
Other               8         1         7
Race missing        3         1         2

![](analysis_files/figure-html/unnamed-chunk-5-1.png) 

#### Age

      Min   Median   Max    Mean    Std Dev   Missing
---  ----  -------  ----  ------  ---------  --------
A      22       31    55   32.24   6.647495         2
B      23       30    51   31.83   6.695770         1

#### Years RN


      Min   Median   Max    Mean    Std Dev   Missing
---  ----  -------  ----  ------  ---------  --------
A       0     5.00    37   6.951   6.955444         0
B       0     1.25    15   2.789   3.554869         1

## Analysis 

### Compare demographic data between groups

#### Years RN

```

	Welch Two Sample t-test

data:  yearsrn by group
t = 3.2288, df = 59.239, p-value = 0.002029
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 1.582896 6.741310
sample estimates:
mean in group A mean in group B 
       6.950769        2.788667 
```

#### Age

```

	Welch Two Sample t-test

data:  age by group
t = 0.24998, df = 61.983, p-value = 0.8034
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -2.867901  3.687721
sample estimates:
mean in group A mean in group B 
       32.24324        31.83333 
```

#### Gender

```

	Fisher's Exact Test for Count Data

data:  sc.gender.ct
p-value = 0.3308
alternative hypothesis: true odds ratio is not equal to 1
95 percent confidence interval:
 0.0703266 2.1598661
sample estimates:
odds ratio 
 0.4551914 
```

#### Race

```

	Fisher's Exact Test for Count Data

data:  sc.race.ct
p-value = 0.03167
alternative hypothesis: two.sided
```

#### Summary

Age (p=0.8034258) and gender (p=0.3307582) showed no significant differences between groups. Years RN (p=0.002029) and race (p=0.0316749) showed significant differences between groups.

Since years RN and race show significant differences between groups, those variables will be tested for effects on delta scores.

### Interaction

#### Years RN and Race

Years RN values represent p-values for alternative hypothesis that the coefficient for the linear regression, delta score vs. years RN, is not zero. Race values represent p-values for the ANOVA analysis of delta scores vs. race.


                            Years RN        Race
------------------------  ----------  ----------
Overall                    0.6184470   0.0937461
Health Responsibility      0.5228274   0.1340855
Physical Activity          0.4576724   0.1996673
Nutrition                  0.9118619   0.3264573
Spiritual Growth           0.6827913   0.1707201
Interpersonal Relations    0.9267542   0.1218452
Stress Management          0.3743889   0.5313704

#### Group

Since years RN and race showed no significant interaction with any delta scores, one sided t tests will be conducted testing the alternative hypothesis that group A delta scores are larger than group B.

![](analysis_files/figure-html/unnamed-chunk-13-1.png) 

P-values and confidence intervals from one-sided t-tests comparing the mean changes in score for each category.


                           A>0 (p)    (lower,   upper)   B>0 (p)    (lower,   upper)   A>B (p)    (lower,   upper)
------------------------  --------  ---------  -------  --------  ---------  -------  --------  ---------  -------
Overall                    0.00025    0.10233      Inf   0.05155   -0.00090      Inf   0.11622   -0.03434      Inf
Health Responsibility      0.00054    0.12633      Inf   0.00677    0.07498      Inf   0.39224   -0.14771      Inf
Physical Activity          0.12149   -0.04613      Inf   0.11443   -0.03694      Inf   0.45861   -0.18967      Inf
Nutrition                  0.00059    0.11612      Inf   0.09189   -0.01774      Inf   0.03530    0.01401      Inf
Spiritual Growth           0.00092    0.09624      Inf   0.42255   -0.10573      Inf   0.02650    0.02761      Inf
Interpersonal Relations    0.00048    0.09618      Inf   0.06012   -0.00768      Inf   0.27503   -0.10017      Inf
Stress Management          0.04373    0.00531      Inf   0.35142   -0.12363      Inf   0.20775   -0.10386      Inf


### Results

Every category score, except physical activity, showed signicant increases in group A, whereas group B showed signicant increases only in health responsibility. Only in categories nutrition and spiritual growth were changes in group A significantly larger than group B.

### Non-parametric Ananlysis


