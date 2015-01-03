## Connecting to a database in R

install.packages("RSQLite", dependencies=TRUE)

library(RSQLite)

setwd("/Users/sarah/documents/github/2015-01-05-wise-umich/novice/sql/")


system("ls *.db", show=TRUE)
driver = dbDriver("SQLite")
db = dbConnect(driver, dbname="survey.db")

#get a list of the tables and fields
alltables = dbListTables(db) 
fields1 = dbListFields(db, alltables[1])

#get desired data as a dataframe
results = dbGetQuery(db, "select lat, long from site")

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


#Making a new database in R
driver="SQLite"
db <- dbConnect(driver, dbname="Test.db")

mysql> create database testdb;
mysql> grant all privileges on testdb.* to 'testuser'@'localhost' identified by 'testpass';
mysql> flush privileges;
In R, load the “mtcars” data.frame, clean it up, and write it to a new “motortrend” table:
  
  library(stringr)
library(RMySQL)

data(mtcars)

# car name is data.frame's rownames. Let's split into manufacturer and model columns:
mtcars$mfg = str_split_fixed(rownames(mtcars), ' ', 2)[,1]
mtcars$mfg[mtcars$mfg=='Merc'] = 'Mercedes'
mtcars$model = str_split_fixed(rownames(mtcars), ' ', 2)[,2]

# connect to local MySQL database (host='localhost' by default)
con = dbConnect("MySQL", "testdb", username="testuser", password="testpass")

dbWriteTable(con, 'motortrend', mtcars)

dbDisconnect(con)

