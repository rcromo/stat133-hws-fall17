# ===================================================================
# Title: HW05
# Description: Grafes Visualizer
# Input(s): data file rawscores.csv
# Output(s): data file cleandata.csv
# Author: Roberto Romo
# Date: 11-11-2017
# ===================================================================
dat <- read.csv('../data/rawdata/rawscores.csv')
library('dplyr')
#source in functions to be tested
source('../code/functions.R')

sink('../output/summary-rawscores.txt')
str(dat)
stat <- summary_stats(dat)
stat
print_stats(stat)
sink()

for (i in 1:ncol(dat)) {
  d<- dat[i]
  d[is.na(d)] <- 0
  dat[i] <- d
}

rescale100(select(dat, QZ1), 0, 12)
rescale100(select(dat, QZ2), 0, 18)
rescale100(select(dat, QZ3), 0, 20)
rescale100(select(dat, QZ4), 0, 20)

Test1 <- rescale100(dat$EX1, 0, 80)
Test2 <- rescale100(dat$EX2, 0, 90)
dat$Test1<-Test1
dat$Test2<-Test2

dat$Homework <- 0
for (i in 1:nrow(dat)) {
  dat$Homework[i] <- as.numeric(score_homework(dat[i, 1:9], drop=TRUE))
}



dat$Quiz <- 0
for (i in 1:nrow(dat)) {
  dat$Quiz[i] <-(score_quiz(dat[i, 11:14], drop=TRUE)) 
}


dat$Overall <- 0
for (i in 1:nrow(dat)) {
  lab <- (.10 *  score_lab(dat$ATT[i])/ 100) 
  hw <- (.30 * (dat$Homework[i] / 100) )
  quiz <- (.15 * (dat$Quiz[i])/100)
  test1 <- (.20 * (dat$Test1[i])/100)
  test2 <- (.25 * (dat$Test2[i])/100)
  dat$Overall[i] <- (lab + hw + quiz + test1 + test2) * 100
}

for (i in 1:nrow(dat)) {
  dat$Grade[i] <- giveGrade(dat$Overall[i])
}

stuffers  <- data.frame(dat$ATT, dat$Homework, dat$Quiz, dat$Test1, dat$Test2, dat$Overall)
lst <- c("Lab-stats", "Homework-stats", "Quiz-stats", "Test1-stats", "Test2-stats", "Overall-stats")
count <- 1
for (i in 1:6) {
  sink(paste("../output/", lst[i], sep=''))
  print_stats(summary_stats(stuffers[count]))
  count <- count + 1
  sink()
}
sink("../output/summary-cleanscores.txt")
str(dat)
sink()

write.csv(dat, file = "../data/cleandata/cleanscores.csv")