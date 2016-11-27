library(reshape2)
library(plyr)
###ALLL
pres.elect16.results_clean <- na.omit(pres.elect16.results) 
pres.elect16.results_reshape <- dcast(pres.elect16.results_clean, fips ~ cand  , value.var = "votes")
pres.elect16.results_reshape["v_diff"] <- pres.elect16.results_reshape$`Hillary Clinton` - pres.elect16.results_reshape$`Donald Trump`
write.csv(pres.elect16.results_reshape , file = "all_elec.csv")

wi_2012_reshape <- dcast(wi_2012, fips ~ candidate , value.var = "votes")
wi_2012_reshape$total2012 <- rowSums(wi_2012_reshape[2:11])
wi_2012_reshape$third2012 <- rowSums(wi_2012_reshape[3:6,8:11])
#:3-6 , 8 -11

#Maryland
wi_2016 <- pres.elect16.results[pres.elect16.results$st == 'WI',]
wi_2016_clean <- na.omit(wi_2016) 

wi_2016_reshape <- dcast(wi_2016_clean,fips ~  cand , value.var="votes")
wi_2016_reshape$total2016 <-rowSums(wi_2016_reshape[2:8])
wi_2016_reshape$third2016 <- rowSums(wi_2016_reshape[,c (2, 4,6,7,8)])

###new

elec_new <- pres.elect16.results_reshape[, c('fips' , 'Hillary Clinton', 'Donald Trump' , 'Jill Stein', 'Gary Johnson')]
elec_new["Third"] <- elec_new$`Jill Stein` + elec_new$`Gary Johnson`
elec_new["diff"] <- elec_new$`Hillary Clinton`- elec_new$`Donald Trump`
names(elec_new)
colnames(elec_new)[1] <- "FIPS"
colnames(elec_new)[2] <- "HRC"
colnames(elec_new)[3] <- "DJT"
colnames(elec_new)[4] <- "JS"
colnames(elec_new)[5] <- "GJ"
elec_new["total"] <- elec_new$HRC + elec_new$DJT + elec_new$Third
elec_new["pctHRC"] <- elec_new$HRC / elec_new$total * 100
elec_new["pctDJT"] <- elec_new$DJT / elec_new$total * 100
elec_new["pctDiff"] <- elec_new$pctHRC - elec_new$pctDJT
write.csv(elec_new, file = "results_clean3.csv")
