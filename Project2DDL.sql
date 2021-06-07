-- Author- Karthik Subbarao, Ganesh Prasad
use Group4;

drop table if exists tweetHashtag;
drop table if exists tweetUrl;
drop table if exists hashtag;
drop table if exists url;
drop table if exists mentioned;
drop table if exists tweet;
drop table if exists uuser;


create table uuser
(screen_name varchar(30),
nameof varchar(30),
sub_category varchar(30),
category varchar(30),
state varchar(30),
num_followers int,
num_following int,
location varchar(30),
primary key(screen_name));

create table tweet
(tid bigint,
textbody varchar(1000),
retweet_count int,
retweet tinyint,
created_at timestamp,
tscreen_name varchar(30),
foreign key(tscreen_name) references uuser(screen_name) ON DELETE CASCADE ON UPDATE CASCADE,
primary key(tid));

create table hashtag(
hashtagname varchar(20),
primary key(hashtagname));

create table url(
urlname varchar(100),
primary key(urlname));

create table tweetHashtag(
  ttid bigint,
  thashtagname varchar(20),
  primary key(ttid,thashtagname),
  foreign key(thashtagname) references hashtag(hashtagname),
  foreign key(ttid) references tweet(tid) ON DELETE CASCADE ON UPDATE CASCADE
);

create table tweetUrl(
  ttid bigint,
  turlname varchar(100),
  primary key(ttid,turlname),
  foreign key(turlname) references url(urlname),
  foreign key(ttid) references tweet(tid) ON DELETE CASCADE ON UPDATE CASCADE
);


create table mentioned(
tweet_id bigint,
mentioned_name varchar(30),
foreign key(tweet_id) references tweet(tid) ON DELETE CASCADE ON UPDATE CASCADE,
foreign key(mentioned_name) references uuser(screen_name) ON DELETE CASCADE ON UPDATE CASCADE,
primary key(tweet_id,mentioned_name));


drop trigger if exists add_url

DELIMITER $$
CREATE TRIGGER add_url
    AFTER INSERT ON tweeturl
    FOR EACH ROW 
BEGIN
SET FOREIGN_KEY_CHECKS=0;
IF not EXISTS (SELECT * FROM url WHERE url.urlname = NEW.turlname) then
	Insert into url (urlname) values (new.turlname);
end if;
END$$
DELIMITER ;

drop trigger if exists add_hashtag

DELIMITER $$
CREATE TRIGGER add_hashtag
    AFTER INSERT ON tweethashtag
    FOR EACH ROW 
BEGIN
SET FOREIGN_KEY_CHECKS=0;
	IF not EXISTS (SELECT * FROM hashtag WHERE hashtag.hashtagname = NEW.thashtagname) then
		Insert into hashtag (hashtagname) values (new.thashtagname);
	END IF;
END$$
DELIMITER ;


drop trigger if exists update_url
DELIMITER $$
CREATE TRIGGER update_url
    AFTER UPDATE ON tweeturl
    FOR EACH ROW 
BEGIN
SET FOREIGN_KEY_CHECKS=0;
IF not EXISTS (SELECT * FROM url WHERE url.urlname = NEW.turlname) then
	Insert into url (urlname) values (new.turlname);
end if;
END$$
DELIMITER ;

drop trigger if exists update_hashtag
DELIMITER $$
CREATE TRIGGER update_hashtag
    AFTER UPDATE ON tweethashtag
    FOR EACH ROW 
BEGIN
SET FOREIGN_KEY_CHECKS=0;
IF not EXISTS (SELECT * FROM hashtag WHERE hashtag.hashtagname = NEW.thashtagname) then
	Insert into hashtag (hashtagname) values (new.thashtagname);
End if;
END$$
DELIMITER ;


-- The below part of this script is used to make the User Application information for the webpage. It has username, passoword, and role.

  drop table if exists userapp;  
  create table userapp(
  username varchar(20),
  userpassword varchar(40),
  userrole varchar(20),
  primary key(username)
);

-- Two users are- 
-- Username -  Karthik  ,  Password -  W1nallday!    ,   Role -  admin   
-- Username -  Ganesh  ,   Password -  1dayUmay!     ,   Role -  other
   
insert into userapp(username, userpassword,userrole) values ("Karthik",SHA1("W1nallday!"),"admin");
insert into userapp(username, userpassword,userrole) values ("Ganesh",SHA1("1dayUmay!"),"other");


-- comment out the below code to test insert
-- select * from userapp;
-- select * from userapp u where u.username = "Karthik" and (u.userpassword) = SHA1(("W1nallday!"));




