# cleaning-project---UCI-dataset-
## How does my code work:
First I loaded dplyr package. then directory that includes dataset is set. Then I read features and activity_labels assigned them to feature & activity variables (features<-read.table("features.txt"),activity<-read.table("activity_labels.txt")). 
Then I set directory to train file for working with it's datasets. I read X_train data named it df_train
(>> df_train<-read.table("X_train.txt")). features table has two columns of which we need second that is name of variables. so I set the second column of that(>>  features<-features[,2] ). then I named columns of df_train to features variable. (colnames(df_train)=features). then I read subject_train dataset that shows each row's subject (1:30 coded person of that experiment) assigned it to subject variable (>> subject<-read.table("subject_train.txt")). then I column bind it to the df_train dataset ( >> df_train<-cbind(df_train,subject)). 
then I read y_train dataset that is the label of each row indicating the code of activity. then I correspond each code with it's  activity name that is written in activity_labels table which was assigned to activity variable. I did it by mutate function in which "act" column is added that corresponds each code with it's activity name. then I chosed second column of it that shows only name of activity (not code of it) (>> label<-read.table("y_train.txt") ;>> label<-mutate(label,act=activity[label$V1,2])[2]).
then I column bind the generated label table to df_train table. (>> df_train<-cbind(df_train,label))
I named last two columns binded to "subject","activity_name". ( >> colnames(df_train)[562:563]<-c("subject","activity_name"))
I did all these steps for test dataset too.
( >> setwd("E:/Programs/R/coursera/UCI HAR Dataset-cleaning-project/test")
df_test<-read.table("X_test.txt")
colnames(df_test)=features
subject<-read.table("subject_test.txt")
df_test<-cbind(df_test,subject)
label<-read.table("y_test.txt")
label<-mutate(label,act=activity[label$V1,2])[2]
df_test<-cbind(df_test,label)
colnames(df_test)[562:563]<-c("subject","activity_name"))
Because the available df_train and df_test have some alike rownames, so I needed to rename test dataset's rows 
(>>row.names(df_test)=(as.list((7353:10299))) ).
Then I merge two datasets together. (>> df<-rbind(df_train,df_test))
As the assignment needs only mean and std variables, so I wited a code with grepl function with  
"[Mm]ean|[Ss]td|subject|activity_name" arg to names(df) which says only keep columns whose names contain any of 
("[Mm]ean","[Ss]td","subject","activity_name").
Finally for the independant table whicc contains average of variables of grouped based on "subject" and "activity_name".
So first I grouped df by "subject" and "activity_name" and then send it to summary_all function ( because we need to calculate average of all columns ) and assigned it to df2 variable.(>>df2 <-df %>% group_by(subject,activity_name)%>%summarise_all("mean"))
