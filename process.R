require(dplyr)
require(tidyr)

# read raw data
sc.raw <- read.csv('selfcaredata.csv', stringsAsFactors=F)
sc.proc <- tbl_df(sc.raw)

# Store group, section, code and time as factors
sc.proc$group <- factor(sc.raw$group)
sc.proc$section <- factor(sc.raw$section)
sc.proc$code <- factor(sc.raw$code)
sc.proc$time <- factor(sc.raw$time)

# Store gender as factor, renaming labels and accounting for blanks
sc.proc$gender <- factor(sc.raw$gender, 
                         levels=levels(factor(sc.raw$gender))[c(2,3,1)], 
                         labels=(c("Female", "Male",NA)))

# catagorize race values into "White", "Black", "Other" and "Unspecified"
white.values <- c("white", "white/caucasian", "white/non-hispanic",
                 "caucasian", "cauc.", "caucation", "causasian")
black.values <- c("black", "black american", "aa", "african",
                  "african american", "b")
other.values <- c("asian", "biracial", "hispanic", "indian", 
                  "white/asian", "white/black")
sc.proc$race.cat <- NA
sc.proc[sc.raw$race %in% white.values, "race.cat"] <- "White"
sc.proc[sc.raw$race %in% black.values, "race.cat"] <- "Black"
sc.proc[sc.raw$race %in% other.values, "race.cat"] <- "Other"
sc.proc$race <- factor(sc.proc$race.cat,
                       levels=levels(factor(sc.proc$race.cat))[c(3,1,2)])

# standardize demographic data between pre and post assessment
#   use value from pre assessment unless it is missing
sc.proc <- mutate(sc.proc, yearsrn.std=yearsrn, gender.std=gender,
                  age.std=age, race.std=race)
prevalue <- function(code, var){sc.proc[sc.proc$code==code&sc.proc$time=="pre", var][[1]]}
postvalue <- function(code, var){sc.proc[sc.proc$code==code&sc.proc$time=="post", var][[1]]}
my_ifelse <- function(l, t, f){if (l){return(t)} else {return(f)}}

for (i in 1:nrow(sc.proc)){
    cd <- sc.proc$code[i]
    sc.proc$yearsrn.std[i] <- my_ifelse(is.na(prevalue(cd,"yearsrn")), 
                              postvalue(cd,"yearsrn"), 
                              prevalue(cd, "yearsrn"))
    sc.proc$gender.std[i] <- my_ifelse(is.na(prevalue(cd, "gender")),
                                 postvalue(cd, "gender"),
                                 prevalue(cd, "gender"))
    sc.proc$age.std[i] <- my_ifelse(is.na(prevalue(cd,"age")), 
                                  postvalue(cd,"age"), 
                                  prevalue(cd, "age"))
    sc.proc$race.std[i] <- my_ifelse(is.na(prevalue(cd, "race")),
                                 postvalue(cd, "race"),
                                 prevalue(cd, "race"))
}

# Calculate HPLP II scores
overall.col <- paste0("q", c(1:52))
hr.col <- paste0("q", c(3,9,15,21,27,33,39,45,51))
pa.col <- paste0("q", c(4,10,16,22,28,34,40,46))
n.col <- paste0("q", c(2,8,14,20,26,32,38,44,50))
sg.col <- paste0("q", c(6,12,18,24,30,36,42,48,52))
ir.col <- paste0("q", c(1,7,13,19,25,31,37,43,49))
sm.col <- paste0("q", c(5,11,17,23,29,35,41,47))

sc.proc$overall <- rowMeans(sc.raw[,overall.col], na.rm=T)
sc.proc$hr <- rowMeans(sc.raw[,hr.col], na.rm=T)
sc.proc$pa <- rowMeans(sc.raw[,pa.col], na.rm=T)
sc.proc$n <- rowMeans(sc.raw[,n.col], na.rm=T)
sc.proc$sg <- rowMeans(sc.raw[,sg.col], na.rm=T)
sc.proc$ir <- rowMeans(sc.raw[,ir.col], na.rm=T)
sc.proc$sm <- rowMeans(sc.raw[,sm.col], na.rm=T)

# transform data to one row per subject with pre, post and delta scores
#   (also remove incomplete case, code="1326")
sc.final <- filter(sc.proc, !(code=="1326")) %>%
    select(code, group, section, yearsrn=yearsrn.std, gender=gender.std,
           age=age.std, race=race.std, time, overall, hr, pa, n, sg, ir, sm) %>%
    gather(type, score, overall, hr, pa, n, sg, ir, sm) %>%
    mutate(type_time=paste(type,time,sep="_")) %>%
    select(code:race, type_time, score) %>%
    spread(type_time, score) %>%
    mutate(overall_delta=overall_post-overall_pre,
           hr_delta = hr_post - hr_pre,
           pa_delta = pa_post - pa_pre,
           n_delta = n_post - n_pre,
           sg_delta = sg_post - sg_pre,
           ir_delta = ir_post - ir_pre,
           sm_delta = sm_post - sm_pre)

write.csv(sc.final, 'selfcare_processed.csv')