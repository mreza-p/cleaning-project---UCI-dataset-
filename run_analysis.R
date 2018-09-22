library(dplyr) 
setwd(".//UCI HAR Dataset-cleaning-project")
features<-read.table("features.txt")
activity<-read.table("activity_labels.txt")
setwd(".//UCI HAR Dataset-cleaning-project/train")
df_train<-read.table("X_train.txt")
features<-features[,2] 
colnames(df_train)=features                   ###naming columns of dataset
subject<-read.table("subject_train.txt")
df_train<-cbind(df_train,subject)            ###importing subjects to dataset
label<-read.table("y_train.txt")
label<-mutate(label,act=activity[label$V1,2])[2] ###importing corresponding label names
df_train<-cbind(df_train,label)
colnames(df_train)[562:563]<-c("subject","activity_name")
setwd(".//UCI HAR Dataset-cleaning-project/test")
df_test<-read.table("X_test.txt")
colnames(df_test)=features
subject<-read.table("subject_test.txt")
df_test<-cbind(df_test,subject)
label<-read.table("y_test.txt")
label<-mutate(label,act=activity[label$V1,2])[2]
df_test<-cbind(df_test,label)
colnames(df_test)[562:563]<-c("subject","activity_name")
row.names(df_test)=(as.list((7353:10299)))
df<-rbind(df_train,df_test)  ###merging train and test 
df<-df[,grepl("[Mm]ean|[Ss]td|subject|activity_name",names(df))] ### keeping needed columns

df2 <-df %>% group_by(subject,activity_name)%>%summarise_all("mean") ##independant table 
