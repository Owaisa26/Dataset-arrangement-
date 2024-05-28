library(tidyverse)
library(dplyr)
library(data.table)
#we need to extract the file for target column(column to identified Normal/Disease samples )
Brief<-read.delim(url("https://ftp.ebi.ac.uk/biostudies/fire/E-GEOD-/768/E-GEOD-44768/Files/E-GEOD-44768.sdrf.txt"))

Brief<-Brief[order(brief$Source.Name),]
#first set the directory where downloded data is present 
setwd("E://document//E-GEOD-44768")
# list  all the file from folder 
loadfiles = list.files(pattern="*.txt")
myfiles = lapply(temp, read.delim)
datafile<- do.call("cbind", myfiles)
gene_ID<-data.frame(datafile[,1])
datalist= datafile[,grepl("E$",names(datafile))]
data<-cbind(gene_name,datalist)

#transpose the data 
data<-as.data.frame(t(data))
# name the column name of first row
colnames(data)<-data[1,]
data<-data[-1,]



# codes for target column 
Brief<-Brief[order(brief$Source.Name),]
#select target column which specify disease or normal
target<-data.frame(Brief$FactorValue..DISEASE.STATUS.)
# delete missing rows
pattern <- "not specified"
targetcol <- data.frame(target[!grepl(pattern, target$Brief.FactorValue..DISEASE.STATUS., ignore.case = TRUE), ])
new_colnames <- c("Target")
colnames(targetcol) <- new_colnames
final_dataset<-cbind(targetcol,data)


write.csv(final_dataset,file = "Clean and Arrange data_44768.csv")

