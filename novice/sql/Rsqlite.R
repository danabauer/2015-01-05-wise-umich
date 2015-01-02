## Connecting to a database in R

install.packages("RSQLite", dependencies=TRUE)

library(RSQLite)

setwd("/Users/sarah/documents/github/2015-01-05-wise-umich/novice/sql/")


system("ls *.db", show=TRUE)
sqlite    <- dbDriver("SQLite")
con = dbConnect(sqlite, dbname="survey.db")

#get a list of the tables and fields
alltables = dbListTables(con) 
tablefields = dbListFields(con, "survey")

#get desired data as a dataframe
results = dbGetQuery(con, "select lat, long from site")

results2 = dbSendQuery(con, "select lat, long from site")
fetch(results2,10)
dbClearResult(results2)
