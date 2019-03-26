qcRetentionTime <- c(4.61, 4.61, 4.61, 4.61, 4.61, 4.61, 4.62, 4.62, 4.61)
qcArea <- c(2517160337, 2730715015, 2746486309, 2629900945, 2631520155, 2680621669, 2433255350, 2483856469, 2524317773)

# relative standard deviation
rsdRT <- sd(qcRetentionTime) / mean(qcRetentionTime)
rsdA <- sd(qcArea) / mean(qcArea)

# загрузка исходных данных из Excel
library("readxl", lib.loc="~/R/win-library/3.5")
setwd("c:\\Repos\\Meson\\")

Tmab_010518OP <- read_excel("trastuzumab.xlsx", sheet = 1, range = cell_rows(2:7), col_names = T)
Tmab_020518OP <- read_excel("trastuzumab.xlsx", sheet = 1, range = cell_rows(10:15), col_names = T)
Tmab_030518OP <- read_excel("trastuzumab.xlsx", sheet = 1, range = cell_rows(18:23), col_names = T)

Tmab_C3741 <- read_excel("trastuzumab.xlsx", sheet = 1, range = cell_rows(26:31), col_names = T)
Tmab_C4632 <- read_excel("trastuzumab.xlsx", sheet = 1, range = cell_rows(34:39), col_names = T)
Tmab_C7180 <- read_excel("trastuzumab.xlsx", sheet = 1, range = cell_rows(42:47), col_names = T)

Tmab_010518OP_1 <- read_excel("trastuzumab.xlsx", sheet = 1, range = cell_rows(50:55), col_names = T)
Tmab_020518OP_1 <- read_excel("trastuzumab.xlsx", sheet = 1, range = cell_rows(58:63), col_names = T)
Tmab_030518OP_1 <- read_excel("trastuzumab.xlsx", sheet = 1, range = cell_rows(66:71), col_names = T)

Tmab_C3741_1 <- read_excel("trastuzumab.xlsx", sheet = 1, range = cell_rows(74:79), col_names = T)
Tmab_C4632_1 <- read_excel("trastuzumab.xlsx", sheet = 1, range = cell_rows(82:87), col_names = T)
Tmab_C7180_1 <- read_excel("trastuzumab.xlsx", sheet = 1, range = cell_rows(90:95), col_names = T)

Tmab_010518OP_2 <- read_excel("trastuzumab.xlsx", sheet = 1, range = cell_rows(98:103), col_names = T)
Tmab_020518OP_2 <- read_excel("trastuzumab.xlsx", sheet = 1, range = cell_rows(106:111), col_names = T)
Tmab_030518OP_2 <- read_excel("trastuzumab.xlsx", sheet = 1, range = cell_rows(114:119), col_names = T)

Tmab_C3741_2 <- read_excel("trastuzumab.xlsx", sheet = 1, range = cell_rows(122:127), col_names = T)
Tmab_C4632_2 <- read_excel("trastuzumab.xlsx", sheet = 1, range = cell_rows(130:135), col_names = T)
Tmab_C7180_2 <- read_excel("trastuzumab.xlsx", sheet = 1, range = cell_rows(138:143), col_names = T)

# для %>%
library("magrittr", lib.loc="~/R/win-library/3.5")
# Tmab_010518OP
Tmab_010518OP_G0F <- Tmab_010518OP[1,] %>% rbind(Tmab_010518OP_1[1,]) %>% rbind(Tmab_010518OP_2[1,])
Tmab_010518OP_G0FG1F <- Tmab_010518OP[2,] %>% rbind(Tmab_010518OP_1[2,]) %>% rbind(Tmab_010518OP_2[2,])
Tmab_010518OP_G1F <- Tmab_010518OP[3,] %>% rbind(Tmab_010518OP_1[3,]) %>% rbind(Tmab_010518OP_2[3,])
Tmab_010518OP_G1FG2F <- Tmab_010518OP[4,] %>% rbind(Tmab_010518OP_1[4,]) %>% rbind(Tmab_010518OP_2[4,])
Tmab_010518OP_G2F <- Tmab_010518OP[5,] %>% rbind(Tmab_010518OP_1[5,]) %>% rbind(Tmab_010518OP_2[5,])

mean_G0F <- mean(Tmab_010518OP_G0F[['Observed mass (Da)']])
mean_G0FG1F <- mean(Tmab_010518OP_G0FG1F[['Observed mass (Da)']])
mean_G1F <- mean(Tmab_010518OP_G1F[['Observed mass (Da)']])
mean_G1FG2F <- mean(Tmab_010518OP_G1FG2F[['Observed mass (Da)']])
mean_G2F <- mean(Tmab_010518OP_G2F[['Observed mass (Da)']])


