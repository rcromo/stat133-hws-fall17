# ===================================================================
# Title: HW03
# Description: Compare teams efficiency
# Input(s): data file nba2017-roster.csv and nba2017-stats.csv
# Output(s): data manipulation and querying
# Author: Roberto Romo
# Date: 10-12-2017
# ===================================================================
library(dplyr)
library(ggplot2) 

roster <- read.csv('/Users/Roberto/Desktop/133/stat133-hws-fall17/hw03/data/nba2017-roster.csv', stringsAsFactors = FALSE)
stats <- read.csv('/Users/Roberto/Desktop/133/stat133-hws-fall17/hw03/data/nba2017-stats.csv',stringsAsFactors = FALSE)
stats <- mutate(stats, missed_fg = field_goals_atts-field_goals_made, missed_ft = points1_atts - points1_made, 
         points = 3 * points3_made + 2 * points2_made + 1 * points1_made, 
       rebounds = def_rebounds + off_rebounds)


stats <- mutate(stats, efficiency = (points + rebounds + assists + steals + blocks - missed_fg - missed_ft - turnovers) / games_played)

sink(file = '/Users/Roberto/Desktop/133/stat133-hws-fall17/hw03/output/efficiency-summary.txt')
summary(stats$efficiency)
sink() 

dat <- merge(stats, roster)

teams <- dat %>%
  group_by(team)  %>%
  summarise(experience = sum(experience), salary = sum(salary)/1000000,
            points3 = sum(points3_made), points2 = sum(points2_made),
            free_throws = sum(points1_made), points = sum(points), off_rebounds = sum(off_rebounds),
            def_rebounds = sum(def_rebounds), assists = sum(assists),
            steals = sum(steals), blocks = sum(blocks), turnovers = sum(turnovers),
            fouls = sum(fouls), efficiency = sum(efficiency)
            )




sink((file = '/Users/Roberto/Desktop/133/stat133-hws-fall17/hw03/data/teams-summary.txt'))
summary(teams)
sink()

write.csv(teams, file = '/Users/Roberto/Desktop/133/stat133-hws-fall17/hw03/data/nba2017-teams.csv', row.names = FALSE)


pdf(file = "/Users/Roberto/Desktop/133/stat133-hws-fall17/hw03/images/teams_star_plot.pdf", height = 5)
stars(teams[, -1], labels = teams$team)
dev.off()

gg_exp_salary <- ggplot(data = dat, aes(x = experience, y = salary)) +
  geom_point(aes(color = dat$team)) 
ggsave(filename = "/Users/Roberto/Desktop/133/stat133-hws-fall17/hw03/images/experience_salary.pdf", width = 6, height = 4)




