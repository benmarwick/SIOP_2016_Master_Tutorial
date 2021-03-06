##############################################
# SIOP 2016 Reproducible Research Master Tutorial Script
# Rob Stilson
# robstilson@gmail.com
# 4-16-16
##############################################

#Loading all necessary packages
#tryCatch code to load all necessary packages
tryCatch(require(knitr),finally=utils:::install.packages(pkgs='knitr',repos='http://cran.r-project.org'));
require(knitr)

tryCatch(require(evaluate),finally=utils:::install.packages(pkgs='evaluate',repos='http://cran.r-project.org'));
require(evaluate)

#tryCatch code to load all necessary packages
tryCatch(require(RCurl),finally=utils:::install.packages(pkgs='RCurl',repos='http://cran.r-project.org'));
require(RCurl)

tryCatch(require(psych),finally=utils:::install.packages(pkgs='psych',repos='http://cran.r-project.org'));
require(psych)

tryCatch(require(sjPlot),finally=utils:::install.packages(pkgs='sjPlot',repos='http://cran.r-project.org'));
require(sjPlot)

tryCatch(require(quantreg),finally=utils:::install.packages(pkgs='quantreg',repos='http://cran.r-project.org'));
require(quantreg)

tryCatch(require(dplyr),finally=utils:::install.packages(pkgs='dplyr',repos='http://cran.r-project.org'));
require(dplyr)

tryCatch(require(pastecs),finally=utils:::install.packages(pkgs='pastecs',repos='http://cran.r-project.org'));
require(pastecs)

################################################################################################################################################################################################LOADING DATA##################################################

library(RCurl)
x <- getURL("https://raw.githubusercontent.com/RobStilson/SIOP_2016_Master_Tutorial/master/mydata_10k.csv")
mydata_10k <- read.csv(text = x)

#Pulling a random sample of 1000
set.seed(1)
mydata <- mydata_10k[ sample( which(mydata_10k$country=='USA'), 1000, replace=FALSE),]
#Remove # in front of `mydata` on the line below and put # in front of `mydata` on the line above to load the 10,000 applicant sample.
#mydata <- mydata_10k

###############################################################################################################################################################################################RECODING DATA##################################################

# recode 0 (missing response) to NA across multiple columns
#From: http://onertipaday.blogspot.com/2009/06/replacing-0-with-na-evergreen-from-list.html

#And

#From: https://stackoverflow.com/questions/14737773/replacing-occurrences-of-a-number-in-multiple-columns-of-data-frame-with-another

mydata[,11:130][mydata[,11:130] ==0] <- NA

library(psych)
#Taking a look at the data to make sure it did what we wanted.
describe(mydata)

#Calculating summary stats via the psych() package
describe_stats_mydata <- round(describe(mydata), 3)

#Renaming variables

# rename programmatically 
library(reshape)
#mydata <- rename(mydata, c(oldname="newname"))

mydata <- rename(mydata, c(i1="N1_Anxiety_1"))#Worry about things.
mydata <- rename(mydata, c(i2="E1_Friendliness_2"))#Make friends easily.
mydata <- rename(mydata, c(i3="O1_Imagination_3"))#Have a vivid imagination.
mydata <- rename(mydata, c(i4="A1_Trust_4"))#Trust others.
mydata <- rename(mydata, c(i5="C1_Self-Efficacy_5"))#Complete tasks successfully.
mydata <- rename(mydata, c(i6="N2_Anger_6"))#Get angry easily.
mydata <- rename(mydata, c(i7="E2_Gregariousness_7"))#Love large parties.
mydata <- rename(mydata, c(i8="O2_Artistic Interests_8"))#Believe in the importance of art.
mydata <- rename(mydata, c(i9="A2_Morality_9"))#Use others for my own ends.
mydata <- rename(mydata, c(i10="C2_Orderliness_10"))#Like to tidy up.
mydata <- rename(mydata, c(i11="N3_Depression_11"))#Often feel blue.
mydata <- rename(mydata, c(i12="E3_Assertiveness_12"))#Take charge.
mydata <- rename(mydata, c(i13="O3_Emotionality_13"))#Experience my emotions intensely.
mydata <- rename(mydata, c(i14="A3_Altruism_14"))#Love to help others.
mydata <- rename(mydata, c(i15="C3_Dutifulness_15"))#Keep my promises.
mydata <- rename(mydata, c(i16="N4_Self-Consciousness_16"))#Find it difficult to approach others.
mydata <- rename(mydata, c(i17="E4_Activity Level_17"))#Am always busy.
mydata <- rename(mydata, c(i18="O4_Adventurousness_18"))#Prefer variety to routine.
mydata <- rename(mydata, c(i19="A4_Cooperation_19"))#Love a good fight.
mydata <- rename(mydata, c(i20="C4_Achievement-Striving_20"))#Work hard.
mydata <- rename(mydata, c(i21="N5_Immoderation_21"))#Go on binges.
mydata <- rename(mydata, c(i22="E5_Excitement-Seeking_22"))#Love excitement.
mydata <- rename(mydata, c(i23="O5_Intellect_23"))#Love to read challenging material.
mydata <- rename(mydata, c(i24="A5_Modesty_24"))#Believe that I am better than others.
mydata <- rename(mydata, c(i25="C5_Self-Discipline_25"))#Am always prepared.
mydata <- rename(mydata, c(i26="N6_Vulnerability_26"))#Panic easily.
mydata <- rename(mydata, c(i27="E6_Cheerfulness_27"))#Radiate joy.
mydata <- rename(mydata, c(i28="O6_Liberalism_28"))#Tend to vote for liberal political candidates.
mydata <- rename(mydata, c(i29="A6_Sympathy_29"))#Sympathize with the homeless.
mydata <- rename(mydata, c(i30="C6_Cautiousness_30"))#Jump into things without thinking.
mydata <- rename(mydata, c(i31="N1_Anxiety_31"))#Fear for the worst.
mydata <- rename(mydata, c(i32="E1_Friendliness_32"))#Feel comfortable around people.
mydata <- rename(mydata, c(i33="O1_Imagination_33"))#Enjoy wild flights of fantasy.
mydata <- rename(mydata, c(i34="A1_Trust_34"))#Believe that others have good intentions.
mydata <- rename(mydata, c(i35="C1_Self-Efficacy_35"))#Excel in what I do.
mydata <- rename(mydata, c(i36="N2_Anger_36"))#Get irritated easily.
mydata <- rename(mydata, c(i37="E2_Gregariousness_37"))#Talk to a lot of different people at parties.
mydata <- rename(mydata, c(i38="O2_Artistic Interests_38"))#See beauty in things that others might not notice.
mydata <- rename(mydata, c(i39="A2_Morality_39"))#Cheat to get ahead.
mydata <- rename(mydata, c(i40="C2_Orderliness_40"))#Often forget to put things back in their proper place.
mydata <- rename(mydata, c(i41="N3_Depression_41"))#Dislike myself.
mydata <- rename(mydata, c(i42="E3_Assertiveness_42"))#Try to lead others.
mydata <- rename(mydata, c(i43="O3_Emotionality_43"))#Feel others' emotions.
mydata <- rename(mydata, c(i44="A3_Altruism_44"))#Am concerned about others.
mydata <- rename(mydata, c(i45="C3_Dutifulness_45"))#Tell the truth.
mydata <- rename(mydata, c(i46="N4_Self-Consciousness_46"))#Am afraid to draw attention to myself.
mydata <- rename(mydata, c(i47="E4_Activity Level_47"))#Am always on the go.
mydata <- rename(mydata, c(i48="O4_Adventurousness_48"))#Prefer to stick with things that I know.
mydata <- rename(mydata, c(i49="A4_Cooperation_49"))#Yell at people.
mydata <- rename(mydata, c(i50="C4_Achievement-Striving_50"))#Do more than what's expected of me.
mydata <- rename(mydata, c(i51="N5_Immoderation_51"))#Rarely overindulge.
mydata <- rename(mydata, c(i52="E5_Excitement-Seeking_52"))#Seek adventure.
mydata <- rename(mydata, c(i53="O5_Intellect_53"))#Avoid philosophical discussions.
mydata <- rename(mydata, c(i54="A5_Modesty_54"))#Think highly of myself.
mydata <- rename(mydata, c(i55="C5_Self-Discipline_55"))#Carry out my plans.
mydata <- rename(mydata, c(i56="N6_Vulnerability_56"))#Become overwhelmed by events.
mydata <- rename(mydata, c(i57="E6_Cheerfulness_57"))#Have a lot of fun.
mydata <- rename(mydata, c(i58="O6_Liberalism_58"))#Believe that there is no absolute right or wrong.
mydata <- rename(mydata, c(i59="A6_Sympathy_59"))#Feel sympathy for those who are worse off than myself.
mydata <- rename(mydata, c(i60="C6_Cautiousness_60"))#Make rash decisions.
mydata <- rename(mydata, c(i61="N1_Anxiety_61"))#Am afraid of many things.
mydata <- rename(mydata, c(i62="E1_Friendliness_62"))#Avoid contacts with others.
mydata <- rename(mydata, c(i63="O1_Imagination_63"))#Love to daydream.
mydata <- rename(mydata, c(i64="A1_Trust_64"))#Trust what people say.
mydata <- rename(mydata, c(i65="C1_Self-Efficacy_65"))#Handle tasks smoothly.
mydata <- rename(mydata, c(i66="N2_Anger_66"))#Lose my temper.
mydata <- rename(mydata, c(i67="E2_Gregariousness_67"))#Prefer to be alone.
mydata <- rename(mydata, c(i68="O2_Artistic Interests_68"))#Do not like poetry.
mydata <- rename(mydata, c(i69="A2_Morality_69"))#Take advantage of others.
mydata <- rename(mydata, c(i70="C2_Orderliness_70"))#Leave a mess in my room.
mydata <- rename(mydata, c(i71="N3_Depression_71"))#Am often down in the dumps.
mydata <- rename(mydata, c(i72="E3_Assertiveness_72"))#Take control of things.
mydata <- rename(mydata, c(i73="O3_Emotionality_73"))#Rarely notice my emotional reactions.
mydata <- rename(mydata, c(i74="A3_Altruism_74"))#Am indifferent to the feelings of others.
mydata <- rename(mydata, c(i75="C3_Dutifulness_75"))#Break rules.
mydata <- rename(mydata, c(i76="N4_Self-Consciousness_76"))#Only feel comfortable with friends.
mydata <- rename(mydata, c(i77="E4_Activity Level_77"))#Do a lot in my spare time.
mydata <- rename(mydata, c(i78="O4_Adventurousness_78"))#Dislike changes.
mydata <- rename(mydata, c(i79="A4_Cooperation_79"))#Insult people.
mydata <- rename(mydata, c(i80="C4_Achievement-Striving_80"))#Do just enough work to get by.
mydata <- rename(mydata, c(i81="N5_Immoderation_81"))#Easily resist temptations.
mydata <- rename(mydata, c(i82="E5_Excitement-Seeking_82"))#Enjoy being reckless.
mydata <- rename(mydata, c(i83="O5_Intellect_83"))#Have difficulty understanding abstract ideas.
mydata <- rename(mydata, c(i84="A5_Modesty_84"))#Have a high opinion of myself.
mydata <- rename(mydata, c(i85="C5_Self-Discipline_85"))#Waste my time.
mydata <- rename(mydata, c(i86="N6_Vulnerability_86"))#Feel that I'm unable to deal with things.
mydata <- rename(mydata, c(i87="E6_Cheerfulness_87"))#Love life.
mydata <- rename(mydata, c(i88="O6_Liberalism_88"))#Tend to vote for conservative political candidates.
mydata <- rename(mydata, c(i89="A6_Sympathy_89"))#Am not interested in other people's problems.
mydata <- rename(mydata, c(i90="C6_Cautiousness_90"))#Rush into things.
mydata <- rename(mydata, c(i91="N1_Anxiety_91"))#Get stressed out easily.
mydata <- rename(mydata, c(i92="E1_Friendliness_92"))#Keep others at a distance.
mydata <- rename(mydata, c(i93="O1_Imagination_93"))#Like to get lost in thought.
mydata <- rename(mydata, c(i94="A1_Trust_94"))#Distrust people.
mydata <- rename(mydata, c(i95="C1_Self-Efficacy_95"))#Know how to get things done.
mydata <- rename(mydata, c(i96="N2_Anger_96"))#Am not easily annoyed.
mydata <- rename(mydata, c(i97="E2_Gregariousness_97"))#Avoid crowds.
mydata <- rename(mydata, c(i98="O2_Artistic Interests_98"))#Do not enjoy going to art museums.
mydata <- rename(mydata, c(i99="A2_Morality_99"))#Obstruct others' plans.
mydata <- rename(mydata, c(i100="C2_Orderliness_100"))#Leave my belongings around.
mydata <- rename(mydata, c(i101="N3_Depression_101"))#Feel comfortable with myself.
mydata <- rename(mydata, c(i102="E3_Assertiveness_102"))#Wait for others to lead the way.
mydata <- rename(mydata, c(i103="O3_Emotionality_103"))#Don't understand people who get emotional.
mydata <- rename(mydata, c(i104="A3_Altruism_104"))#Take no time for others.
mydata <- rename(mydata, c(i105="C3_Dutifulness_105"))#Break my promises.
mydata <- rename(mydata, c(i106="N4_Self-Consciousness_106"))#Am not bothered by difficult social situations.
mydata <- rename(mydata, c(i107="E4_Activity Level_107"))#Like to take it easy.
mydata <- rename(mydata, c(i108="O4_Adventurousness_108"))#Am attached to conventional ways.
mydata <- rename(mydata, c(i109="A4_Cooperation_109"))#Get back at others.
mydata <- rename(mydata, c(i110="C4_Achievement-Striving_110"))#Put little time and effort into my work.
mydata <- rename(mydata, c(i111="N5_Immoderation_111"))#Am able to control my cravings.
mydata <- rename(mydata, c(i112="E5_Excitement-Seeking_112"))#Act wild and crazy.
mydata <- rename(mydata, c(i113="O5_Intellect_113"))#Am not interested in theoretical discussions.
mydata <- rename(mydata, c(i114="A5_Modesty_114"))#Boast about my virtues.
mydata <- rename(mydata, c(i115="C5_Self-Discipline_115"))#Have difficulty starting tasks.
mydata <- rename(mydata, c(i116="N6_Vulnerability_116"))#Remain calm under pressure.
mydata <- rename(mydata, c(i117="E6_Cheerfulness_117"))#Look at the bright side of life.
mydata <- rename(mydata, c(i118="O6_Liberalism_118"))#Believe that we should be tough on crime.
mydata <- rename(mydata, c(i119="A6_Sympathy_119"))#Try not to think about the needy.
mydata <- rename(mydata, c(i120="C6_Cautiousness_120"))#Act without thinking.

#Detach Hmisc package if it is loaded
#detach("package:Hmisc", unload=TRUE)

#Calculating summary stats via the psych() package
describe_stats_mydata <- round(describe(mydata), 3)

###############################################################################################################################################################################################CREATING KEYS##################################################

#Pulling out just the items
items <- mydata[c(11:130)]

keys <- make.keys(nvars=120, list(
    AGR=c(4,-9,14,-19,-24,29,34,-39,44,-49,-54,59,64,-69,-74,-79,-84,-89,-94,-99,-104,-109,-114,-119),
    CON=c(5,10,15,20,25,-30,35,-40,45,50,55,-60,65,-70,-75,-80,-85,-90,95,-100,-105,-110,-115,-120), 
    EXT=c(2,7,12,17,22,27,32,37,42,47,52,57,-62,-67,72,77,82,87,-92,-97,-102,	-107,112,117),
    NEU=c(1,6,11,16,21,26,31,36,41,46,-51,56,61,66,71,76,-81,86,91,-96,-101,-106,-111,-116),
    OPN=c(3,8,13,18,23,28,33,38,43,-48,-53,58,63,-68,-73,-78,-83,-88,93,-98,	-103,-108,-113,-118)),
    item.labels=(colnames(items)))

scores <- scoreItems(keys, items)
#And take a look
scores

#alpha reliabilities
scores_alpha <- round(as.data.frame(scores$alpha), 3)

#Creating total scores
library(dplyr)

mydata_test <- items %>%
    mutate(AGR_Total = rowSums(items[c(4,9,14,19,24,29,34,39,44,49,54,59,64,69,74,79,84,89,94,99,104,109,114,119)])) %>%
    mutate(CON_Total = rowSums(items[c(5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,105,110,115,120)])) %>%
    mutate(EXT_Total = rowSums(items[c(2,7,12,17,22,27,32,37,42,47,52,57,62,67,72,77,82,87,92,97,102,	107,112,117)])) %>%
    mutate(NEU_Total = rowSums(items[c(1,6,11,16,21,26,31,36,41,46,51,56,61,66,71,76,81,86,91,96,101,106,111,116)])) %>%
    mutate(OPN_Total = rowSums(items[c(3,8,13,18,23,28,33,38,43,48,53,58,63,68,73,78,83,88,93,98,103,108,113,118)]))


#round(describe(mydata_test), 3)
round(describe(mydata_test[c(121:125)]), 3)


#install.packages("pastecs", dependencies = TRUE)
#library(pastecs)
#options(scipen=100)
#options(digits=2)
#summary_stats_mydata <- stat.desc(mydata, basic=F)
#summary_stats_mydata_trans <- t(summary_stats_mydata)
#summary_stats_mydata_trans <- as.data.frame(t(summary_stats_mydata))

#summary_stats_mydata_trans <- summary_stats_mydata_trans[-c(1:10),]

#Trying to remove col 3,4,5, 7

#summary_stats_mydata_trans <- summary_stats_mydata_trans[-c(3:5,7)]
#colnames(summary_stats_mydata_trans)[1]="Items" #need to rename rownames
#summary_stats_mydata_trans <- cbind(Items = rownames(summary_stats_mydata_trans), summary_stats_mydata_trans)
# add the rownames as a proper column
#myDF <- cbind(Row.Names = rownames(myDF), myDF)
#From: https://stackoverflow.com/questions/17514648/how-do-i-name-the-row-names-column-in-r

#library(Hmisc)
#corr_table <- rcorr(mydata_test[c(121:125)])

#rcorr(mydata_test[c(121:125)])
#library(psych)
#corr_table <- as.data.frame(corr.test(mydata_test[c(121:125)]))

#corr.test(mydata_test[c(121:125)])

#########################################################################################################################################################################################DATA VISUALIZATION###################################################

#SPLOM

pairs.panels(scores$scores,pch='.',jiggle=TRUE)