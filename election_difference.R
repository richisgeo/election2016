md <- pres_elect16_results[pres_elect16_results$st == 'MD',]
md_clean <- na.omit(md) 
md_clean
names(md_clean)
md2 <- dcast(md_clean,fips ~  cand, value.var="votes")
names(md2)
md2["v_diff"] <- md2$`Hillary Clinton` - md2$`Donald Trump`
