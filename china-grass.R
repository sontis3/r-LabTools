library("readxl", lib.loc="~/R/win-library/3.5")

setwd("z:\\UBUNTU\\00 - Личные папки сотрудников\\08 - Овчаренко\\ACE")

############################################################
# формирование и вывод линий растворений
ace_m <- read.csv("ACE_m.csv", header = T, sep = ",", check.names = F)

ace_m$logConc0 <- apply(ace_m, MARGIN = 1, function(elt) {
  log(as.numeric(elt["Conc0"]))
})
ace_m$logConc40 <- apply(ace_m, MARGIN = 1, function(elt) {
  log(as.numeric(elt["Conc40"]))
})
ace_m$logConc96 <- apply(ace_m, MARGIN = 1, function(elt) {
  log(as.numeric(elt["Conc96"]))
})

# вывод графиков растворение/величина
lCoord <- apply(ace_m, MARGIN = 1, function(elt) {
  list(x = c(0, 40, 96), y = c(elt["logConc0"], elt["logConc40"], elt["logConc96"]), Code = elt[["Code"]])
})
lColor = rainbow(20)
# Add extra space to right of plot area; change clipping to figure
par(mar=c(5.1, 4.1, 4.1, 8.1), xpd=TRUE)

plot(lCoord[[1]],
     type = "b",
     ylim = c(3, 9),
     lwd = 2,
     pch = 1,
     col = lColor[1],
     ylab = "ln(y)",
     xlab = "Разведение")

# Add legend to top right, outside plot region
legend("topright", inset=c(-0.2,0), legend=ace_m$Code, pch=1:length(lCoord), col = lColor, title="Group")

# legend("topleft",
#        levels(ace_m$Code)
# )
lapply(lCoord[-1], function(elt) {
  i <- which(LETTERS == elt[["Code"]])
  lines(elt, type = "b", col = lColor[i+1], pch = i + 1, lwd = 2)
})

meanCoord <- list(x = c(0, 40, 96), y = c(mean(ace_m$logConc0), mean(ace_m$logConc40), mean(ace_m$logConc96)))
minCoord <- list(x = c(0, 40, 96), y = c(min(ace_m$logConc0), min(ace_m$logConc40), min(ace_m$logConc96)))
maxCoord <- list(x = c(0, 40, 96), y = c(max(ace_m$logConc0), max(ace_m$logConc40), max(ace_m$logConc96)))
plot(meanCoord,
     type = "b",
     ylim = c(3, 9),
     lwd = 2,
     pch = 1,
     ylab = "mean ln(y)",
     xlab = "Разведение")
lines(minCoord, type = "b", pch = 2, lwd = 2)
lines(maxCoord, type = "b", pch = 3, lwd = 2)
legend("topright", inset=c(-0.2,0), legend=c("mean", "min", "max"), pch=1:3, title="Group")


# вывод t-test в файл
sink("t.test.txt")
tt <- t.test(ace_m$logConc0, ace_m$logConc40, paired = T)
t.test(ace_m$logConc0, ace_m$logConc96, paired = T)
t.test(ace_m$logConc40, ace_m$logConc96, paired = T)
sink()

#########################################################







searchIndexH2o_2 <- function(name) {
  which(ace$Name==name & ace$Method == "H2O")
}

# 
searchIndexH2o <- function(name) {
  which(ace$Name==name & ace$Method == "0")
}

ace <- read.csv("ACE.csv", header = T, sep = ",", check.names = F)

# ace$relConc <- apply(ace, MARGIN = 1, function(elt) {
#   # browser()
#   idx <- searchIndexH2o(elt["Name"])
#   h2oConc <- ace[idx,]$Conc
#   as.numeric(elt["Conc"]) / h2oConc
# })
# 
# ace0 <- ace[ace$Method == "0",]
# ace40 <- ace[ace$Method == "40",]
# ace96 <- ace[ace$Method == "96",]
# 
# plot(ace$Code, ace$relConc, type = "p")
# plot(ace40$Code, ace40$relConc)
# plot(ace96$Code, ace96$relConc)
# 
# plot(ace$Method, ace$relConc)

# aceModel <- lm(ace$relConc ~ ace$Method, data = ace)
# summary(aceModel)
# abline(aceModel)

ace$logConc <- apply(ace, MARGIN = 1, function(elt) {
  # browser()
  log(as.numeric(elt["Conc"]))
})

ace0 <- ace[ace$Method == "0",]
ace40 <- ace[ace$Method == "40",]
ace96 <- ace[ace$Method == "96",]

plot(ace$Code, ace$logConc, type = "p")
plot(ace0$Code, ace0$logConc)
plot(ace$Method, ace$logConc)
# Создание столбчатой диаграммы
barplot(ace0$logConc, names.arg = ace0$Code, xlab = "Код", ylab = "ln(Концентрация) мг/г", space = 0.3)
barplot(ace0$Conc)

require(ggplot2)
qplot(ace$Code, ace$logConc)
#####################

######################     t-test
t.test(ace0$Conc, ace40$Conc)
t.test(ace40$Conc, ace96$Conc)
#####################

ace2 <- read.csv("ACE_src_2.csv", header = T, sep = ",", check.names = F)
ace2$logConc <- apply(ace2, MARGIN = 1, function(elt) {
  # browser()
  log10(as.numeric(elt["Conc"]))
})
aceModel2 <- lm(ace2$logConc ~ ace2$Method, data = ace2)
plot(ace2$Method, ace2$logConc)
abline(aceModel2)

ace0_2 <- ace2[ace2$Method == "H2O",]
ace40_2 <- ace2[ace2$Method == "40%",]
ace96_2 <- ace2[ace2$Method == "96%",]

t.test(ace0_2$Conc, ace40_2$Conc)
t.test(ace40_2$Conc, ace96_2$Conc)


#####################
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
