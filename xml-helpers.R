library("XML", lib.loc="~/R/win-library/3.4")

list.files('c:\\Repos\\FkData\\In-Data33-Test\\', pattern = '*.xml', full.names = T)

doc <- xmlParse('c:\\Repos\\FkData\\In-Data33-Test\\Cycle-1.xml')
root <- xmlRoot(doc)
fkList <- xmlToList(doc)

smplList <- fkList$GROUPDATA$GROUP$SAMPLELISTDATA
# xmlChildren(smplList)

occ <- sapply(xmlChildren(smplList), function(node) xmlValue(node[['SAMPLE']]))
tasks <- getNodeSet(root, "/QUANDATASET/GROUPDATA/GROUP/SAMPLELISTDATA/SAMPLE[@type = 'Blank']/@task")