use mavenfuzzyfactory;
select min(date(created_at)) as week_start_date,
count(distinct case when utm_source='gsearch' then website_session_id else null end) as gsearch_sessions,
count(distinct case when utm_source='bsearch' then website_session_id else null end) as bsearch_sessions
from website_sessions
where created_at>'2012-08-22' and created_at<'2012-11-29' and utm_campaign='nonbrand'
group by yearweek(created_at)