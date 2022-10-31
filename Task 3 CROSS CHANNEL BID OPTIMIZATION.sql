use mavenfuzzyfactory;
select website_sessions.device_type,website_sessions.utm_source,
       count(distinct website_sessions.website_session_id) as sessions,
       count(distinct orders.order_id) as orders,
       count(distinct orders.order_id)/count(distinct website_sessions.website_session_id) as conv_rate
from website_sessions
left join orders
on orders.website_session_id=website_sessions.website_session_id
where website_sessions.created_at>'2012-08-22' and website_sessions.created_at<'2012-09-19'
      and website_sessions.utm_campaign='nonbrand'
group by website_sessions.device_type,website_sessions.utm_source