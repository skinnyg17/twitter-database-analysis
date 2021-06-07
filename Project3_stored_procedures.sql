-- Authors: Ganesh Prasad, Karthik Subbarao

use Group4;

drop procedure if exists q1;
DELIMITER $$

CREATE DEFINER=`Group4`@`%` PROCEDURE `q1`(IN k int, IN mnth int, IN yr int)
BEGIN
    -- keep join result of temp inner join parent
    -- better to use drop table newtable if exists 
	-- but use this to show how to use the catalog
	IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'Group4' 
                 AND  TABLE_NAME = 'result1'))
	THEN
		-- Do Stuff
		truncate result1;
	ELSE
		create table result1 (retweetcnt int, textbody varchar(200), screen_name varchar(30), cat varchar(30) ,sub_cat varchar(30));
	END IF;
    
    -- List most retweeted tweets in a given month and year.
    -- select all the tweets for that month and year
    -- groupy by retweet count in descending order.
    -- select the first k tweets.
    
    -- select t.retweet_count as Retweet_Count, t.textbody as Textbody, u.screen_name as Screen_Name, u.sub_category as Sub_Category 
	-- from tweet t, uuser u 
	-- where month(t.created_at) = mnth and year(t.created_at) = yr and t.tscreen_name = u.screen_name 
	-- order by t.retweet_count desc limit k
    
    insert into result1(retweetcnt , textbody , screen_name , cat, sub_cat ) (
    select retweet_count, textbody, screen_name, category, sub_category
    from (tweet as t inner join uuser as u on t.tscreen_name=u.screen_name)
    where month(created_at) = mnth and year(created_at) = yr
    order by retweet_count desc limit k);
    
   -- resultant set contain answer.
   select * from result1;
END;


drop procedure if exists q2;
DELIMITER $$

CREATE DEFINER=`Group4`@`%` PROCEDURE `q2`(IN k int, IN ht VARCHAR(20), IN mnth int, IN yr int)
BEGIN
    -- keep join result of temp inner join parent
    -- better to use drop table newtable if exists 
	-- but use this to show how to use the catalog
	IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'Group4' 
                 AND  TABLE_NAME = 'result2'))
	THEN
		-- Do Stuff
		truncate result2;
	ELSE
		create table result2 (screen_name varchar(50), category varchar(30), textbody varchar(200), retweetcount int);
	END IF;
    
    -- select u.screen_name, u.category, t.textbody, t.retweet_count
	-- from uuser u, tweet t, tweethashtag h
	-- where month(t.created_at) = mnth and year(t.created_at) = yr and t.tid = h.ttid and h.thashtagname = ht
	-- and u.screen_name = t.tscreen_name
	-- order by t.retweet_count desc limit k
    
    -- in a given month and year and hashtag, find k user with the most number of retweets
	-- return the screenname, category, text text, and retweetcount in desc order of retweetcount
    insert into result2(screen_name , category , textbody , retweetcount) (
    select screen_name, category, textbody, retweet_count
    from (uuser as u inner join tweet as t on u.screen_name = t.tscreen_name) inner join tweethashtag as h on h.ttid = t.tid
    where thashtagname = ht and  month(created_at) = mnth and year(created_at) = yr
    order by retweet_count desc limit k);
    
   -- resultant set contain answer.
   select * from result2;
END;


drop procedure if exists q3;
DELIMITER $$
CREATE DEFINER=`Group4`@`%` PROCEDURE `q3`(IN k int, IN yr int)
BEGIN
	IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'Group4' 
                 AND  TABLE_NAME = 'result3'))
	THEN
		truncate result3;
	ELSE
		create table result3 (Hashtagname varchar(20), State_Count int, StateList varchar(1000));
	END IF;
    
	insert into result3(Hashtagname , State_Count , StateList)  ( 
    
    select h.thashtagname, count(distinct u.state) as StateCount,GROUP_CONCAT( distinct u.state SEPARATOR ', ') as StateList
	from uuser u , tweet t, tweetHashtag h
	where u.screen_name = t.tscreen_name and h.ttid = t.tid and year(t.created_at) = yr and NOT (u.state = "na")
	group by (h.thashtagname) order by StateCount desc limit k
    
    );
    
   select * from result3;
END;


drop procedure if exists q6;
DELIMITER $$

CREATE DEFINER=`Group4`@`%` PROCEDURE `q6`(IN k int, IN hashs varchar(40))
BEGIN
	declare cnt int;
	declare lngth int;
    set lngth = 0;
    set cnt = 1;
    -- keep join result of temp inner join parent
    -- better to use drop table newtable if exists 
	-- but use this to show how to use the catalog
	IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'Group4' 
                 AND  TABLE_NAME = 'result6'))
	THEN
		-- Do Stuff
		truncate result6;
	ELSE
		create table result6 (username varchar(30), state varchar(30));
	END IF;
    
    -- select distinct u.screen_name, u.state
    -- from uuser u, tweethashtag h, tweet t
    -- where find_in_set(h.thashtagname,hashs) and h.ttid = t.tid and t.tscreen_name = u.screen_name
    -- order by u.num_followers desc limit k
    
	insert into result6 (select distinct screen_name, state 
    from (uuser as u inner join tweet as t on u.screen_name = t.tscreen_name) inner join tweethashtag as h on t.tid = h.ttid
    where find_in_set(thashtagname, hashs)
    order by num_followers desc limit k);
    
    select * from result6;
    
END;


drop procedure if exists q10;
DELIMITER $$


CREATE DEFINER=`Group4`@`%` PROCEDURE `q10`(IN states varchar(100), IN mnth int, IN yr int)
BEGIN
    -- keep join result of temp inner join parent
    -- better to use drop table newtable if exists 
	-- but use this to show how to use the catalog
	IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'Group4' 
                 AND  TABLE_NAME = 'result10'))
	THEN
		-- Do Stuff
		truncate result10;
	ELSE
		create table result10 (state varchar(30), hashtag varchar(1000));
	END IF;
    
    -- drop table if exists search_state;
    -- create table search_state (to_search varchar(20));
    
    -- insert into search_state(to_search) (select distinct u.state from uuser u where find_in_set(u.state, states) > 0);
    
    -- select distinct uuser.state, tweethashtag.thashtagname
    -- from   
    
    -- u.state in (select to_search from search_state)
    
	-- select h.thashtagname, group_concat(distinct u.state, '')
    -- from tweethashtag h, uuser u, tweet t
    -- where month(t.created_at) = mnth and year(t.created_at) = yr and  find_in_set(u.state,states)
	-- and h.ttid = t.tid and t.tscreen_name = u.screen_name group by h.thashtagname
    
	insert into result10 (select group_concat(distinct state, ''), thashtagname
    from (uuser as u inner join tweet as t on u.screen_name = t.tscreen_name) inner join tweethashtag as h on h.ttid = t.tid
    where ttid = tid and screen_name = tscreen_name and find_in_set(state, states) and month(created_at) = mnth and year(created_at) = yr
    group by thashtagname);
    
	select * from result10;
    
END;


drop procedure if exists q15;
DELIMITER $$

CREATE DEFINER=`Group4`@`%` PROCEDURE `q15`(IN subcat varchar(30), IN mnth int, IN yr int)
BEGIN
	IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'Group4' 
                 AND  TABLE_NAME = 'result15'))
	THEN
		truncate result15;
	ELSE
		create table result15 (scname varchar(30), State varchar(30), UrlList varchar(1000));
	END IF;
    
    insert into result15(scname , State , UrlList)  ( 
	select u.screen_name, u.state , GROUP_CONCAT(tu.turlname, ', ') as URL_List
	from uuser u , tweet t, tweetUrl tu
	where u.screen_name = t.tscreen_name and tu.ttid = t.tid and u.sub_category = subcat
	and month(t.created_at) = mnth and year(t.created_at) = yr
    group by u.screen_name, u.state);

   select * from result15;
END;


drop procedure if exists q23;
DELIMITER $$


CREATE DEFINER=`Group4`@`%` PROCEDURE `q23`(IN sub varchar(30), IN mnths varchar(40), IN k int)
BEGIN
    -- keep join result of temp inner join parent
    -- better to use drop table newtable if exists 
	-- but use this to show how to use the catalog
	IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'Group4' 
                 AND  TABLE_NAME = 'result23'))
	THEN
		-- Do Stuff
		truncate result23;
	ELSE
		create table result23 (hashs varchar(40), tweet_count int);
	END IF;

	-- select distinct h.thashtagname, t.retweet_count
    -- from tweethashtag h, uuser u, tweet t
    -- where find_in_set(month(t.created_at), mnths) and year(t.created_at) = 2016 and u.sub_category = sub 
		-- and h.ttid = t.tid and t.tscreen_name = u.screen_name
	-- order by t.retweet_count desc limit k

	insert into result23(hashs, tweet_count) (select thashtagname, count(thashtagname) as tweet_count
    from (tweethashtag as h inner join tweet as t on h.ttid = t.tid) inner join uuser as u on u.screen_name = t.tscreen_name
    where find_in_set(month(created_at),mnths) and year(created_at) = 2016 and sub_category = sub
    group by thashtagname order by tweet_count desc limit k);

	select * from result23;
    
END;


drop procedure if exists q27;
DELIMITER $$


CREATE DEFINER=`Group4`@`%` PROCEDURE `q27`(IN k int, IN mnth1 int, IN mnth2 int, IN yr int)
BEGIN
    -- keep join result of temp inner join parent
    -- better to use drop table newtable if exists 
	-- but use this to show how to use the catalog
	IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'Group4' 
                 AND  TABLE_NAME = 'result27'))
	THEN
		-- Do Stuff
		truncate result27;
	ELSE
		create table result27 (sc_name varchar(30), rt_count int);
	END IF;
    
    -- select distinct u.screen_name, t.retweet_count
    -- from uuser u, tweet t
    -- where (month(t.created_at) = mnth1 or month(t.created_at) = mnth2) and year(t.created_at) = yr and t.tscreen_name = u.screen_name
	-- order by t.retweet_count desc

	insert into result27(sc_name, rt_count) (select distinct screen_name, retweet_count
   from (uuser as u inner join tweet as t on u.screen_name = t.tscreen_name)
   where (month(created_at) = mnth1 or month(created_at) = mnth2) and year(created_at) = yr
   order by retweet_count desc limit k);
    
	select distinct r.sc_name from result27 r order by r.rt_count desc limit k;
    
END;
