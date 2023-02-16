-- Q1 Rewarding Most Loyal Users: People who have been using the platform for the longest time. I need to find the 5 oldest users of the Instagram from the database

-- Select username,created_at FROM ig_clone.users order by created_at limit 5;

-- Q2 Remind Inactive Users to Start Posting: By sending them promotional emails to post their 1st photo. I need to find the users who have never posted a single photo on Instagram

-- Select 
-- 	u.username 
-- from 
-- 	ig_clone.users u 
-- left join 
-- 	ig_clone.photos p 
-- on u.id = p.user_id
-- where 
-- 	p.user_id is null 
-- order by u.username;


-- Q3 Declaring Contest Winner: The team started a contest and the user who gets the most likes on a single photo will win the contest now they wish to declare the winner. I need to identify the winner of the contest and provide their details to the team

-- select 
--     likes.photo_id,
--     users.username,
--     count(likes.user_id) as like_user
-- from
-- 	ig_clone.likes likes
-- inner join 
-- 	ig_clone.photos photos
--     on likes.photo_id = photos.id
-- inner join
-- 	ig_clone.users users
--     on photos.user_id = users.id
-- group by likes.photo_id, users.username
-- order by like_user desc
-- limit 1

-- Q4 Hashtag Researching: A partner brand wants to know, which hashtags to use in the post to reach the most people on the platform. Identify and suggest the top 5 most commonly used hashtags on the platform

-- Select
--     t.tag_name,
--     Count(p.photo_id) as num_tags
-- from
-- 	ig_clone.photo_tags p
-- inner join
-- 	ig_clone.tags t
-- on p.tag_id = t.id
-- group by 
-- 	tag_name
-- order by num_tags desc
-- limit 5

-- Q5 Launch AD Campaign: The team wants to know, which day would be the best day to launch ADs. What day of the week do most users register on?


-- 0 - Monday, 1- Tuesday, 2- Wednesday, 3- Thursday, 4- Friday , 5- Saturday, 6- Sunday 
-- Select weekday(created_at) as weekday,
-- 	Count(username) as num_username
-- from ig_clone.users
-- Group by 1
-- order by 2 Desc

-- Most Number of Account are created on Thursday and Sunday followed by Friday 

-- Investor Metrics
-- Q6 User Engagement: Are users still as active and post on Instagram or they are making fewer posts.Provide how many times does average user posts on Instagram. Also, provide the total number of photos on Instagram/total number of users

-- Create Temporary Table ts (
-- 	select 
-- 		u.id as userid, 
-- 		Count(p.id) as photoid
-- 	from 
-- 		ig_clone.users u
-- 	left join 
-- 		ig_clone.photos p
-- 	on 
-- 		u.id = p.user_id
-- 	group by 1);
--     
-- Select 
-- 	Sum(photoid) as total_photos,
--     Count(userid) as total_users,
--     Sum(photoid)/Count(userid) as photos_per_user
-- from ts

-- Q7 Bots & Fake Accounts: The investors want to know if the platform is crowded with fake and dummy accounts. Provide data on users (bots) who have liked every single photo on the site (since any normal user would not be able to do this).


Create temporary table photo_count(
Select 
	user_id,
    Count(photo_id) as num_like
from
	ig_clone.likes
group by 1
order by num_like Desc);

Select
	*
From
	photo_count
Where
	num_like = (Select Count(*) From ig_clone.photos);