-- Author- Karthik Subbarao, Ganesh Prasad
use Group4;

SET FOREIGN_KEY_CHECKS=0;

LOAD DATA INFILE 'C:\\temp\\user.csv'
INTO TABLE uuser
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;



LOAD DATA INFILE 'C:\\temp\\tweets.csv'
INTO TABLE tweet 
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\temp\\tagged.csv'
INTO TABLE tweethashtag
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\temp\\mentioned.csv'
INTO TABLE mentioned
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\temp\\urlused.csv'
INTO TABLE tweeturl
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SET FOREIGN_KEY_CHECKS=1;
