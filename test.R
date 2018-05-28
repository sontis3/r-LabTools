library("XML", lib.loc="~/R/win-library/3.4")

list.files('c:\\Repos\\FkData\\In-Data33-Test\\', pattern = '*.xml', full.names = T)

doc <- xmlParse('c:\\Repos\\FkData\\In-Data33-Test\\Cycle-1.xml')
root <- xmlRoot(doc)
fkList <- xmlToList(doc)

smplList <- fkList$GROUPDATA$GROUP$SAMPLELISTDATA
# xmlChildren(smplList)

occ <- sapply(xmlChildren(smplList), function(node) xmlValue(node[['SAMPLE']]))

# rawData <- getNodeSet(root, "/QUANDATASET/GROUPDATA/GROUP/SAMPLELISTDATA/SAMPLE[@type = 'Analyte']")

fields <- c("@task", "@name", "@type", "COMPOUND[@id='1']/@stdconc", "COMPOUND[@id='1']/PEAK/@analconc")
expQuery <- sprintf("/QUANDATASET/GROUPDATA/GROUP/SAMPLELISTDATA/SAMPLE[@type = 'Analyte']/%s", fields)
expQuery2 <- c(task = "/QUANDATASET/GROUPDATA/GROUP/SAMPLELISTDATA/SAMPLE[@type = 'Analyte']/@task",
               name = "/QUANDATASET/GROUPDATA/GROUP/SAMPLELISTDATA/SAMPLE[@type = 'Analyte']/@name",
               type = "/QUANDATASET/GROUPDATA/GROUP/SAMPLELISTDATA/SAMPLE[@type = 'Analyte']/@type",
               stdconc = "/QUANDATASET/GROUPDATA/GROUP/SAMPLELISTDATA/SAMPLE[@type = 'Analyte']/COMPOUND[@id='1']/@stdconc",
               analconc = "/QUANDATASET/GROUPDATA/GROUP/SAMPLELISTDATA/SAMPLE[@type = 'Analyte']/COMPOUND[@id='1']/PEAK/@analconc"
)

nullToZero <- function(x) {
  #v <- xmlValue(x)
  ifelse(nchar(x) == 0, "0.0", x)
  #return(v)
}
rawData2 <- as.data.frame(xpathSApply(doc, expQuery, nullToZero))

rawData <- as.data.frame(xpathSApply(doc, expQuery))

qqq <- xpathSApply(doc, expQuery)
qqq2 <- as.data.frame(matrix(qqq, ncol = length(expQuery), byrow = T, dimnames = list(c(), names(qqq)[1:length(expQuery)])), stringsAsFactors = F)
qqq2[, c("stdconc", "analconc")] <- sapply(qqq2[, c("stdconc", "analconc")], as.numeric)
qqq2[is.na(qqq2)] <- 0


qqq2$stdconc <- as.numeric(qqq2$stdconc)
qqq2$analconc <- as.numeric(qqq2$analconc)
summary(qqq2)
