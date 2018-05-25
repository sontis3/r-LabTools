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
rawData <- as.data.frame(xpathSApply(doc, expQuery))
qqq <- xpathSApply(doc, expQuery)
summary(qqq)
