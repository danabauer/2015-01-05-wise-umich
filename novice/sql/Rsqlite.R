## Connecting to a database in R

install.packages("RSQLite", dependencies=TRUE)

library(RSQLite)

setwd("/Users/sarah/documents/github/2015-01-05-wise-umich/novice/sql/")


system("ls *.sqlite", show=TRUE)
driver = dbDriver("SQLite")
db = dbConnect(driver, dbname="portal_mammals.sqlite") #if you type in a database that it can't find, then you create a new one.

#get a list of the tables and fields
alltables = dbListTables(db) 
fields = dbListFields(db, alltables[2])

#get desired data as a dataframe
yrplotsp = dbGetQuery(db, "SELECT year, plot, species, round(AVG(wgt),2) 
FROM surveys 
WHERE wgt is not NULL
GROUP BY year, plot, species")

tot = dbGetQuery(db, "Select year, sum(wgt) as TotMass from surveys Group By year")

yrplotsp = dbGetQuery(db, "SELECT year, plot, species, round(AVG(wgt),2) AS avg_wgt FROM surveys WHERE wgt is not NULL
GROUP BY year, plot, species")

plot = dbGetQuery(db, "SELECT plot,round(AVG(wgt),2) AS avg_wgt FROM surveys WHERE wgt is not NULL
GROUP BY plot")


"FROM Visited JOIN Survey 
ON Visited.ident=Survey.taken 
WHERE person is not NULL AND quant IN ('rad', 'temp');")

dbDisconnect(db)
rm(db)

dbCloseDriver(driver)

results2 = dbSendQuery(con, "select lat, long from site")
fetch(results2,10)
dbClearResult(results2)

# Input values

get_name = function(db_file, person_ident){
  query = paste("select personal || ' ' || family from Person where ident='", person_ident, "';", sep="")
  db = dbConnect(driver, dbname=db_file)
  results = dbGetQuery(db, query)
  dbDisconnect(db)
  return (results[1,1])
}

db = dbConnect(driver, dbname="survey.sqlite")


def get_name(database_file, person_ident):
  query = "select personal || ' ' || family from Person where ident='" + person_ident + "';"



connection = sqlite3.connect(database_file)
cursor = connection.cursor()
cursor.execute(query)
results = cursor.fetchall()
cursor.close()
connection.close()

return results[0][0]

print "full name for dyer:", get_name('survey.db', 'dyer')
