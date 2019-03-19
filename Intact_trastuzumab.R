qcRetentionTime <- c(4.61, 4.61, 4.61, 4.61, 4.61, 4.61, 4.62, 4.62, 4.61)
qcArea <- c(2517160337, 2730715015, 2746486309, 2629900945, 2631520155, 2680621669, 2433255350, 2483856469, 2524317773)

# relative standard deviation
rsdRT <- sd(qcRetentionTime) / mean(qcRetentionTime)
rsdA <- sd(qcArea) / mean(qcArea)
