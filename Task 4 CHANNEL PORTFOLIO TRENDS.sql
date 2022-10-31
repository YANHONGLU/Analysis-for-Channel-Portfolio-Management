use mavenfuzzyfactory;
select min(date(created_at)) as week_start_date,
       count(distinct case when utm_source='gsearch' and device_type='desktop' then website_session_id else null end) as g_dtop_sessions,
       count(distinct case when utm_source='bsearch' and device_type='desktop' then website_session_id else null end) as b_dtop_sessions,
       count(distinct case when utm_source='bsearch' and device_type='desktop' then website_session_id else null end)
        /count(distinct case when utm_source='gsearch' and device_type='desktop' then website_session_id else null end) as b_pct_of_g_dtop,
        count(distinct case when utm_source='gsearch' and device_type='mobile' then website_session_id else null end) as g_mob_sessions,
       count(distinct case when utm_source='bsearch' and device_type='mobile' then website_session_id else null end) as b_mob_sessions,
       count(distinct case when utm_source='bsearch' and device_type='mobile' then website_session_id else null end) 
       /count(distinct case when utm_source='gsearch' and device_type='mobile' then website_session_id else null end) as  b_pct_of_g_mobile
from website_sessions
where created_at >'2012-11-04' 
      and created_at < '2012-12-22' 
      and utm_campaign='nonbrand'
group by yearweek(created_at)