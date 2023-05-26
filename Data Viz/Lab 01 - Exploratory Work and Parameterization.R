library(tidyverse)
install.packages("viridis")
library(viridis)


#gets all-ages.csv
college_all_ages <- read_csv("all-ages.csv")
attach(college_all_ages)

college_all_ages<-mutate(college_all_ages,major_income_cat=cut(Median,c(30000,50000,70000,90000,110000,130000),
                                                               c("$30000 to $50000","$50000 to $70000","$70000 to $90000","$90000 to $110000","$110000 to $130000")))
college_all_ages<-mutate(college_all_ages,total_students_cat=cut(Total,c(0,10000,100000,1000000,10000000),
                                                               c("0 to 10,000","10,000 to 100,000","100,000 to 1,000,000","1,000,000 to 10,000,000")))
# set variables
var_one <- "major_income_cat"
var_two <- "total_students_cat"

summary_table <- summarize(group_by(college_all_ages, eval(as.name(var_one)), 
                                    eval(as.name(var_two))),
                           count=n())
names(summary_table)[1:2] <- c(var_one, var_two)
summary_table

ggplot(college_all_ages)+
  geom_bar(aes_string(x=var_one, fill=var_two),position="fill") +
  labs(title=paste("Conditional Distribution of Total Students","\nDependent on Median Major Earnings"),
       x="Earnings (In Thousands of $)", y="Proportion")+
  scale_fill_viridis(discrete=T, name="Participation Level \nPer Major", labels=c("Low", "Moderate", "High", "Very High")) +
  scale_x_discrete(labels=c("30 to 50","50 to 70", "70 to 90", "90 to 110", "110 to 130")) +
  coord_flip() +
  theme_classic()

ggplot(college_all_ages) +
  geom_point(aes(x=Median,y=Total, color=Major_category, fill=Major_category, shape=Major_category)) +
  labs(title="Major Participation in Relation to Median Earnings", x="Median Earnings", y="Total Number of Student") +
  scale_y_log10(labels=c("1,000", "10,000", "100,000", "1,000,000", "10,000,000")) +
  scale_color_viridis(discrete=T, name="Major Category")+
  scale_fill_viridis(discrete=T, name="Major Category")+
  scale_shape_manual(name="Major Category", values=c(0,1,2,3,4,5,6,7,8,9,10,11,12,14,15,16))+
  theme_classic()
  
ggplot(college_all_ages) +
  geom_boxplot(aes(x=Major_category, y=Median, fill=Major_category, color=Major_category)) +
  labs(title="Distribution of Median Earnings per Major Category", x="Major Category", y="Median Earnings") +
  scale_fill_viridis(discrete=T, name="Major Category", alpha=.25) +
  scale_color_viridis(discrete=T, name="Major Category") +
  theme_classic() +
  theme(axis.text.x=element_blank(),
        axis.ticks.x=element_blank())

college_all_ages$Major_category <- as.factor(college_all_ages$Major_category)
ggplot(college_all_ages, aes(x=Major_category, y=Unemployment_rate, fill=Major_category)) +
  geom_violin(trim=TRUE) +
  labs(title="Distribution of Unemployment Rates Among Major Categories",y="Unemployment Rate",x="Major Category") +
  scale_fill_viridis(discrete=T, name="Major Category", alpha=.) +
  theme_classic() +
  theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())


college_major_cat <- summarize(group_by(college_all_ages, Major_category), 
                               totalEmployed=sum(Employed),
                               totalUnemployed=sum(Unemployed))
college_major_cat <- mutate(college_major_cat, UnemploymentRate=totalUnemployed/(totalEmployed+totalUnemployed))

ggplot(college_major_cat) +
  geom_bar(stat="identity", aes(x=Major_category, fill=Major_category, 
                                color=Major_category, y=UnemploymentRate, width=1)) +
  labs(title="Unemployment Rate per Major Category", y="Unemployment Rate", x=element_blank()) +
  scale_fill_viridis(discrete=T, name="Major Category", alpha=.9) +
  scale_color_viridis(discrete=T, name="Major Category") +
  coord_polar() +
  scale_y_sqrt() +
  theme_classic() +
  theme(axis.text.x=element_blank())


