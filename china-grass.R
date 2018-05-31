library("readxl", lib.loc="~/R/win-library/3.5")

setwd("z:\\UBUNTU\\00 - Личные папки сотрудников\\08 - Овчаренко\\ACE")

# searchIndexH2o <- function(name) {
#   which(ace$Name==name & ace$Method == "H2O")
# }

searchIndexH2o <- function(name) {
  which(ace$Name==name & ace$Method == "0")
}

ace <- read.csv("ACE.csv", header = T, sep = ",", check.names = F)

ace$relConc <- apply(ace, MARGIN = 1, function(elt) {
  # browser()
  idx <- searchIndexH2o(elt["Name"])
  h2oConc <- ace[idx,]$Conc
  as.numeric(elt["Conc"]) / h2oConc
})

ace40 <- ace[ace$Method == "40",]
ace96 <- ace[ace$Method == "96",]

plot(ace$Code, ace$relConc, type = "p")
plot(ace40$Code, ace40$relConc)
plot(ace96$Code, ace96$relConc)

plot(ace$Method, ace$relConc)


aceModel <- lm(ace$relConc ~ ace$Method, data = ace)
summary(aceModel)
abline(aceModel)


############################################
pc <- read.csv("z:/UBUNTU/00 - Личные папки сотрудников/13 - Маркин/РПЖ/Сводные таблицы/r/PC Serum.csv", header = T, sep = ",", check.names = F)
ph <- read.csv("z:/UBUNTU/00 - Личные папки сотрудников/13 - Маркин/РПЖ/Сводные таблицы/r/PH Serum.csv", header = T, sep = ",", check.names = F)

tt <- sapply(colnames(pc)[-1:-1], function(name) t.test(pc[name], ph[name]))
# ttl <- lapply(colnames(pc)[-1:-2], function(name) t.test(pc[name], ph[name]))
fdr_tt <-p.adjust(tt["p.value",], method = "BH")


mwt <- sapply(colnames(pc)[-1:-1], function(name) wilcox.test(pc[[name]], ph[[name]]))
# mwl <- lapply(colnames(pc)[-1:-2], function(name) wilcox.test(pc[[name]], ph[[name]]))
fdr_mwt <-p.adjust(mwt["p.value",], method = "BH")


write.csv(tt, "tt.csv")
write.csv(mwt, "mwt.csv")
write.csv(fdr_tt, "fdr_tt.csv")
write.csv(fdr_mwt, "fdr_mwt.csv")

tt[,1:3]
colnames(tt)
tt[1,]$"Pyruvic acid"

ttl[1:3]
ttl[[1]]$statistic
