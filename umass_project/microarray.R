celpath = "j:/Swainlab@umass/ExpData/others/GEO/GSE11961/GSE11961_RAW/"

# load the script from the internet that is used in install bioconductor
source("http://bioconductor.org/biocLite.R")
# Each of these commands tells Bioconductor to download and install each package
biocLite("affy")
biocLite("oligo")
biocLite("limma")
biocLite("moe430a.db")
# load the affy library
library(affy)
library(oligo)
library(limma)

# Read in the CEL files in the directory, then normalize the data
data = ReadAffy(celfile.path=celpath)
eset <- rma(data)

# Finally, save the data to an output file to be used by other programs, etc (Data will be log2 transformed and normalized)
write.exprs(eset,file="data.txt")
# This assumes you already normalized the data, and the object "eset" has the data in it (from above)
# Find Affymetrix Mouse Expression Set 430 annotation data (chip moe430a), which is "moe430a.db" Bioconductor Package Maintainer   
# Load annotation library
library(moe430a.db)

# Strategy is to create data frame objects and merge them together - put expression info into a data frame
my_frame <- data.frame(exprs(eset))

# Put annotation information in a data frame.  To get specific fields, use packageNameSYMBOL, where the caps part names the type of data you're after
# To get a list of available annotation information, run the packagename with () at the end, i.e. moe430acluster()
Annot <- data.frame(ACCNUM=sapply(contents(moe430aACCNUM), paste, collapse=", "), SYMBOL=sapply(contents(moe430aSYMBOL), paste, collapse=", "), DESC=sapply(contents(moe430aGENENAME), paste, collapse=", "))

# Merge data frames together (like a database table join)
all <- merge(Annot, my_frame, by.x=0, by.y=0, all=T)

# Write out to a file:
write.table(all,file="data.ann.txt",sep="\t")