-- Authors: Ganesh Prasad, Karthik Subbarao

use Group4;

-- Please find the old code commented out for the below optimized queries: 
-- NOTE:Some queries use a temp table. I might have deleted that code in a new stored procedures.
-- q27 optimize
select screen_name, retweet_count
   from (uuser as u inner join tweet as t on u.screen_name = t.tscreen_name)
   where (month(created_at) = 1 or month(created_at) = 2) and year(created_at) = 2016
   order by retweet_count desc limit 10;
   
   -- q23 optimize
select thashtagname, count(thashtagname) as tweet_count
    from (tweethashtag as h inner join tweet as t on h.ttid = t.tid) inner join uuser as u on u.screen_name = t.tscreen_name
    where find_in_set(month(created_at),"1,2,3") and year(created_at) = 2016 and sub_category = "GOP"
    group by thashtagname order by tweet_count desc limit 10;
    
-- q6 optimize
select screen_name, state 
    from (uuser as u inner join tweet as t on u.screen_name = t.tscreen_name) inner join tweethashtag as h on t.tid = h.ttid
    where find_in_set(thashtagname, "GOPDebate,DemDebate") and ttid=tid and screen_name=tscreen_name
    order by num_followers desc limit 10;
    
-- q10 optimize
select thashtagname, group_concat(distinct state, '')
    from (uuser as u inner join tweet as t on u.screen_name = t.tscreen_name) inner join tweethashtag as h on h.ttid = t.tid
    where ttid = tid and screen_name = tscreen_name and find_in_set(state, "FL") and month(created_at) = 1 and year(created_at) = 2016
    group by thashtagname;
    
-- q1 optimize
select retweet_count, textbody, screen_name, category,sub_category
    from (tweet as t inner join uuser as u on t.tscreen_name=u.screen_name)
    where month(created_at) = 1 and year(created_at) = 2016
    order by retweet_count desc limit 10;
    
-- q2 optimize
select screen_name, category, textbody, retweet_count
    from (uuser as u inner join tweet as t on u.screen_name = t.tscreen_name) inner join tweethashtag as h on h.ttid = t.tid
    where thashtagname = "GOPDebate" and  month(created_at) = 1 and year(created_at) = 2016
    order by retweet_count desc limit 10;