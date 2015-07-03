# Selfcare Study
Michael Shyne  
05/28/2015  





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

                  Total   Group A   Group B
---------------  ------  --------  --------
Female               55        30        25
Male                 11         8         3
Gender missing        4         1         3

                Total   Group A   Group B
-------------  ------  --------  --------
White              44        27        17
Black              15        10         5
Other               8         1         7
Race missing        3         1         2

![](analysis_files/figure-html/unnamed-chunk-3-1.png) 

## Analysis

### Compare demographic data between groups

#### Years RN (with section 3)

      Min   Median   Max    Mean    Std Dev   Missing
---  ----  -------  ----  ------  ---------  --------
A       0     5.00    37   6.951   6.955444         0
B       0     1.25    15   2.789   3.554869         1

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

#### Years RN (without section 3)

      Min   Median   Max    Mean    Std Dev   Missing
---  ----  -------  ----  ------  ---------  --------
A       0     5.00    37   6.742   7.062358         0
B       0     1.25    15   2.789   3.554869         1

```

	Welch Two Sample t-test

data:  yearsrn by group
t = 2.844, df = 48.192, p-value = 0.006519
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 1.158860 6.748655
sample estimates:
mean in group A mean in group B 
       6.742424        2.788667 
```
#### Age (with section 3)

      Min   Median   Max    Mean    Std Dev   Missing
---  ----  -------  ----  ------  ---------  --------
A      22       31    55   32.24   6.647495         2
B      23       30    51   31.83   6.695770         1

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

#### Age (without section 3)

      Min   Median   Max    Mean   Std Dev   Missing
---  ----  -------  ----  ------  --------  --------
A      22       32    55   32.59   6.92289         1
B      23       30    51   31.83   6.69577         1

```

	Welch Two Sample t-test

data:  age by group
t = 0.4396, df = 59.938, p-value = 0.6618
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -2.699736  4.220569
sample estimates:
mean in group A mean in group B 
       32.59375        31.83333 
```

#### Gender (with section 3)

      Female   Male
---  -------  -----
A         30      8
B         25      3

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

#### Gender (without section 3)

      Female   Male
---  -------  -----
A         24      8
B         25      3

```

	Fisher's Exact Test for Count Data

data:  sc12.gender.ct
p-value = 0.1934
alternative hypothesis: true odds ratio is not equal to 1
95 percent confidence interval:
 0.05591512 1.75908104
sample estimates:
odds ratio 
 0.3659606 
```

#### Race (with section 3)

      Black   Other   White
---  ------  ------  ------
A        10       1      27
B         5       7      17

```

	Fisher's Exact Test for Count Data

data:  sc.race.ct
p-value = 0.03167
alternative hypothesis: two.sided
```

#### Race (without section 3)

      Black   Other   White
---  ------  ------  ------
A         9       1      22
B         5       7      17

```

	Fisher's Exact Test for Count Data

data:  sc12.race.ct
p-value = 0.04593
alternative hypothesis: two.sided
```

#### Summary

Age (p=0.8034258, p=0.6618059) and gender (p=0.3307582, p=0.1934029) showed no significant differences between groups, regardless of whether section 3 was included. Years RN (p=0.002029, p=0.0065187) was significantly different between groups, regardless of whether section 3 was included, and race showed significant differences between groups with section 3  (p=0.0316749) and no significant difference without section 3  (p=0.0459331).

### Tests

Since years RN and race show significant differences between groups, those variables will be tested for effects on delta scores.

#### Years RN (with section 3)

```

Call:
lm(formula = overall_delta ~ yearsrn, data = sc)

Residuals:
    Min      1Q  Median      3Q     Max 
-0.7097 -0.1833 -0.0174  0.2134  0.7975 

Coefficients:
             Estimate Std. Error t value Pr(>|t|)   
(Intercept)  0.156667   0.049107    3.19  0.00216 **
yearsrn     -0.003105   0.006205   -0.50  0.61845   
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.3101 on 67 degrees of freedom
  (1 observation deleted due to missingness)
Multiple R-squared:  0.003723,	Adjusted R-squared:  -0.01115 
F-statistic: 0.2504 on 1 and 67 DF,  p-value: 0.6184
```

```

Call:
lm(formula = hr_delta ~ yearsrn, data = sc)

Residuals:
     Min       1Q   Median       3Q      Max 
-1.17257 -0.31170  0.00201  0.30452  1.04965 

Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept)  0.251038   0.069060   3.635  0.00054 ***
yearsrn     -0.005605   0.008725  -0.642  0.52283    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.4361 on 67 degrees of freedom
  (1 observation deleted due to missingness)
Multiple R-squared:  0.006121,	Adjusted R-squared:  -0.008713 
F-statistic: 0.4126 on 1 and 67 DF,  p-value: 0.5228
```

```

Call:
lm(formula = pa_delta ~ yearsrn, data = sc)

Residuals:
     Min       1Q   Median       3Q      Max 
-1.01490 -0.32765 -0.06987  0.34404  1.23634 

Coefficients:
             Estimate Std. Error t value Pr(>|t|)  
(Intercept)  0.139903   0.082448   1.697   0.0944 .
yearsrn     -0.007782   0.010417  -0.747   0.4577  
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.5207 on 67 degrees of freedom
  (1 observation deleted due to missingness)
Multiple R-squared:  0.00826,	Adjusted R-squared:  -0.006542 
F-statistic: 0.558 on 1 and 67 DF,  p-value: 0.4577
```

```

Call:
lm(formula = n_delta ~ yearsrn, data = sc)

Residuals:
     Min       1Q   Median       3Q      Max 
-0.92921 -0.26947  0.06277  0.28486  0.73745 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)   
(Intercept)  0.1595834  0.0580389   2.750  0.00766 **
yearsrn     -0.0008148  0.0073330  -0.111  0.91186   
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.3665 on 67 degrees of freedom
  (1 observation deleted due to missingness)
Multiple R-squared:  0.0001842,	Adjusted R-squared:  -0.01474 
F-statistic: 0.01235 on 1 and 67 DF,  p-value: 0.9119
```

```

Call:
lm(formula = sg_delta ~ yearsrn, data = sc)

Residuals:
     Min       1Q   Median       3Q      Max 
-0.87873 -0.32158 -0.01693  0.31322  1.00219 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)
(Intercept) 0.099354   0.061462   1.617    0.111
yearsrn     0.003187   0.007766   0.410    0.683

Residual standard error: 0.3882 on 67 degrees of freedom
  (1 observation deleted due to missingness)
Multiple R-squared:  0.002508,	Adjusted R-squared:  -0.01238 
F-statistic: 0.1685 on 1 and 67 DF,  p-value: 0.6828
```

```

Call:
lm(formula = ir_delta ~ yearsrn, data = sc)

Residuals:
     Min       1Q   Median       3Q      Max 
-0.81442 -0.25921  0.07135  0.18558  0.85190 

Coefficients:
             Estimate Std. Error t value Pr(>|t|)  
(Intercept) 0.1474073  0.0593740   2.483   0.0156 *
yearsrn     0.0006922  0.0075017   0.092   0.9268  
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.375 on 67 degrees of freedom
  (1 observation deleted due to missingness)
Multiple R-squared:  0.0001271,	Adjusted R-squared:  -0.0148 
F-statistic: 0.008515 on 1 and 67 DF,  p-value: 0.9268
```

```

Call:
lm(formula = sm_delta ~ yearsrn, data = sc)

Residuals:
    Min      1Q  Median      3Q     Max 
-1.2440 -0.3329 -0.0061  0.2605  1.2695 

Coefficients:
             Estimate Std. Error t value Pr(>|t|)
(Intercept)  0.132542   0.079814   1.661    0.101
yearsrn     -0.009018   0.010084  -0.894    0.374

Residual standard error: 0.5041 on 67 degrees of freedom
  (1 observation deleted due to missingness)
Multiple R-squared:  0.01179,	Adjusted R-squared:  -0.002955 
F-statistic: 0.7997 on 1 and 67 DF,  p-value: 0.3744
```

#### Race (with section 3)

```

Call:
lm(formula = overall_delta ~ race, data = sc)

Residuals:
    Min      1Q  Median      3Q     Max 
-0.7986 -0.1661 -0.0219  0.2026  0.8435 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)   
(Intercept)  0.24091    0.07874   3.060  0.00324 **
raceOther    0.03313    0.13351   0.248  0.80483   
raceWhite   -0.16132    0.09118  -1.769  0.08161 . 
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.305 on 64 degrees of freedom
  (3 observations deleted due to missingness)
Multiple R-squared:  0.0713,	Adjusted R-squared:  0.04228 
F-statistic: 2.457 on 2 and 64 DF,  p-value: 0.09375
```

```

Call:
lm(formula = hr_delta ~ race, data = sc)

Residuals:
     Min       1Q   Median       3Q      Max 
-1.14646 -0.25758 -0.03535  0.26326  1.07576 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)   
(Intercept)   0.3111     0.1109   2.805  0.00666 **
raceOther     0.1333     0.1881   0.709  0.48093   
raceWhite    -0.1646     0.1284  -1.282  0.20451   
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.4296 on 64 degrees of freedom
  (3 observations deleted due to missingness)
Multiple R-squared:  0.06086,	Adjusted R-squared:  0.03151 
F-statistic: 2.074 on 2 and 64 DF,  p-value: 0.1341
```

```

Call:
lm(formula = pa_delta ~ race, data = sc)

Residuals:
     Min       1Q   Median       3Q      Max 
-1.18810 -0.31310 -0.03571  0.33929  1.21429 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)  
(Intercept)   0.3131     0.1337   2.343   0.0223 *
raceOther    -0.2662     0.2266  -1.175   0.2445  
raceWhite    -0.2774     0.1548  -1.792   0.0778 .
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.5176 on 64 degrees of freedom
  (3 observations deleted due to missingness)
Multiple R-squared:  0.0491,	Adjusted R-squared:  0.01938 
F-statistic: 1.652 on 2 and 64 DF,  p-value: 0.1997
```

```

Call:
lm(formula = n_delta ~ race, data = sc)

Residuals:
     Min       1Q   Median       3Q      Max 
-0.87374 -0.20707  0.01515  0.23737  0.79293 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)   
(Intercept)  0.24815    0.09327   2.660  0.00985 **
raceOther   -0.03981    0.15815  -0.252  0.80204   
raceWhite   -0.15219    0.10801  -1.409  0.16366   
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.3612 on 64 degrees of freedom
  (3 observations deleted due to missingness)
Multiple R-squared:  0.03438,	Adjusted R-squared:  0.004202 
F-statistic: 1.139 on 2 and 64 DF,  p-value: 0.3265
```

```

Call:
lm(formula = sg_delta ~ race, data = sc)

Residuals:
    Min      1Q  Median      3Q     Max 
-0.8852 -0.2828  0.0037  0.2259  0.8926 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)  
(Intercept)  0.21852    0.09912   2.205   0.0311 *
raceOther    0.07315    0.16807   0.435   0.6649  
raceWhite   -0.15791    0.11478  -1.376   0.1737  
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.3839 on 64 degrees of freedom
  (3 observations deleted due to missingness)
Multiple R-squared:  0.05374,	Adjusted R-squared:  0.02417 
F-statistic: 1.817 on 2 and 64 DF,  p-value: 0.1707
```

```

Call:
lm(formula = ir_delta ~ race, data = sc)

Residuals:
     Min       1Q   Median       3Q      Max 
-0.75947 -0.23390  0.01831  0.23878  0.79609 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)  
(Intercept)  0.20741    0.09572   2.167    0.034 *
raceOther    0.16759    0.16230   1.033    0.306  
raceWhite   -0.11460    0.11084  -1.034    0.305  
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 0.3707 on 64 degrees of freedom
  (3 observations deleted due to missingness)
Multiple R-squared:  0.06366,	Adjusted R-squared:  0.0344 
F-statistic: 2.176 on 2 and 64 DF,  p-value: 0.1218
```

```

Call:
lm(formula = sm_delta ~ race, data = sc)

Residuals:
    Min      1Q  Median      3Q     Max 
-1.2500 -0.2886  0.0000  0.2932  1.2500 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)
(Intercept)  0.12500    0.13253   0.943    0.349
raceOther    0.12500    0.22472   0.556    0.580
raceWhite   -0.08644    0.15347  -0.563    0.575

Residual standard error: 0.5133 on 64 degrees of freedom
  (3 observations deleted due to missingness)
Multiple R-squared:  0.01957,	Adjusted R-squared:  -0.01107 
F-statistic: 0.6386 on 2 and 64 DF,  p-value: 0.5314
```

#### Group (with section 3)

Since years RN and race showed no significant interaction with any delta scores, one sided t tests will be conducted testing the alternative hypothesis that group A delta scores are larger than group B.


```

	Welch Two Sample t-test

data:  overall_delta by group
t = 1.2056, df = 63.391, p-value = 0.1162
alternative hypothesis: true difference in means is greater than 0
95 percent confidence interval:
 -0.03434136         Inf
sample estimates:
mean in group A mean in group B 
     0.18373835      0.09443682 
```

```

	Welch Two Sample t-test

data:  hr_delta by group
t = 0.27467, df = 62.788, p-value = 0.3922
alternative hypothesis: true difference in means is greater than 0
95 percent confidence interval:
 -0.1477122        Inf
sample estimates:
mean in group A mean in group B 
      0.2414530       0.2123656 
```

```

	Welch Two Sample t-test

data:  pa_delta by group
t = 0.10433, df = 67.895, p-value = 0.4586
alternative hypothesis: true difference in means is greater than 0
95 percent confidence interval:
 -0.1896663        Inf
sample estimates:
mean in group A mean in group B 
     0.10943223      0.09677419 
```

```

	Welch Two Sample t-test

data:  n_delta by group
t = 1.837, df = 67.653, p-value = 0.0353
alternative hypothesis: true difference in means is greater than 0
95 percent confidence interval:
 0.01400658        Inf
sample estimates:
mean in group A mean in group B 
     0.22364672      0.07168459 
```

```

	Welch Two Sample t-test

data:  sg_delta by group
t = 1.9727, df = 61.859, p-value = 0.0265
alternative hypothesis: true difference in means is greater than 0
95 percent confidence interval:
 0.02761063        Inf
sample estimates:
mean in group A mean in group B 
     0.19373219      0.01388889 
```

```

	Welch Two Sample t-test

data:  ir_delta by group
t = 0.60153, df = 52.987, p-value = 0.275
alternative hypothesis: true difference in means is greater than 0
95 percent confidence interval:
 -0.1001683        Inf
sample estimates:
mean in group A mean in group B 
      0.1816239       0.1254480 
```

```

	Welch Two Sample t-test

data:  sm_delta by group
t = 0.81975, df = 62.067, p-value = 0.2077
alternative hypothesis: true difference in means is greater than 0
95 percent confidence interval:
 -0.1038554        Inf
sample estimates:
mean in group A mean in group B 
     0.13644689      0.03629032 
```

### Results

While mean delta scores were larger in group A than group B for overall and each category, the only scores to be significantly larger are nutrition (p=0.0353005) and spirital growth (p=0.0265001)
