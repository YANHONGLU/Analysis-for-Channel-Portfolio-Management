use mavenfuzzyfactory;
select utm_source,
       count(distinct website_session_id) as sessions,
       count(distinct case when device_type='mobile' then website_session_id else null end) mobile_sessions,
       count(distinct case when device_type='mobile' then website_session_id else null end)/count(distinct website_session_id) as pct_mobile
from website_sessions
where created_at>'2012-08-22' and created_at <'2012-11-30' and utm_campaign='nonbrand'
group by 1