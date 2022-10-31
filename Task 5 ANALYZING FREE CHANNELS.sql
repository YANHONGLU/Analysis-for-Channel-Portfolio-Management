use mavenfuzzyfactory;

select year(created_at) as yr,
	   month(created_at) as mo,
       count(distinct case when channel_group='paid_nonbrand' then website_session_id else null end) as nonbrand,
       count(distinct case when channel_group='paid_brand' then website_session_id else null end) as brand,
       count(distinct case when channel_group='paid_brand' then website_session_id else null end) 
       /count(distinct case when channel_group='paid_nonbrand' then website_session_id else null end)  as brand_pct_of_nonbrand,
       count(distinct case when channel_group='direct_type_in' then website_session_id else null end)
       /count(distinct case when channel_group='paid_nonbrand' then website_session_id else null end) as direct_pct_of_nonbrand,
       count(distinct case when channel_group='orangic_search' then website_session_id else null end) as organic,
       count(distinct case when channel_group='orangic_search' then website_session_id else null end)
       /count(distinct case when channel_group='paid_nonbrand' then website_session_id else null end) as orangic_pct_of_nonbrand
from( select website_session_id, created_at,
             case when utm_source is null and http_referer in ('https://www.gsearch.com' ,'https://www.bsearch.com') then 'organic_search'
                  when utm_campaign='nonbrand' then'paid_nonbrand'
                  when utm_campaign='brand' then'paid_brand'
                  when utm_source is null and http_referer is null then 'direct_type_in'
                  end as channel_group
		from website_sessions
        where created_at <'2012-12-23') as sessions_w_channel_group
group by year(created_at),month(created_at)