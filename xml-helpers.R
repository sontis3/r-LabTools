library("XML", lib.loc="~/R/win-library/3.5")

list.files('c:\\Repos\\FkData\\In-Data33-Test\\', pattern = '*.xml', full.names = T)

doc <- xmlParse('c:\\Repos\\FkData\\In-Data33-Test\\Cycle-1.xml')

fields <- c("@task", "@name", "@type", "COMPOUND[@id='1']/@stdconc", "COMPOUND[@id='1']/PEAK/@analconc")
expQuery <- sprintf("/QUANDATASET/GROUPDATA/GROUP/SAMPLELISTDATA/SAMPLE/%s", fields)

qqq <- xpathSApply(doc, expQuery)
qqq2 <- as.data.frame(matrix(qqq, ncol = length(expQuery), byrow = T, dimnames = list(c(), names(qqq)[1:length(expQuery)])), stringsAsFactors = F)

# удаление пустышек
qqq2 <- qqq2[qqq2$name != "",]
# конвертация в числа и факторизация
qqq2[, c("stdconc", "analconc")] <- sapply(qqq2[, c("stdconc", "analconc")], as.numeric)
qqq2[, "type"] <- factor(qqq2[, "type"])
qqq2[, "task"] <- factor(qqq2[, "task"])
# зануление пропусков
qqq2[is.na(qqq2)] <- 0
rownames(qqq2) <- seq(length = nrow(qqq2))


