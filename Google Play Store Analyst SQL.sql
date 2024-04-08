--identifying Null value--
select * from dbo.googleplaystore
where App IS NULL 
or Category IS NULL
or Rating IS NULL
or Reviews IS NULL
or Size IS NULL
or Installs IS NULL
or Type IS NULL 
or Price IS NULL
or Content_Rating IS NULL
or Genres IS NULL
or Last_Updated IS NULL
or Current_Ver IS NULL
or Android_Ver IS NULL 

-- Removing null values-- 
delete from dbo.googleplaystore
where App IS NULL 
or Category IS NULL
or Rating IS NULL
or Reviews IS NULL
or Size IS NULL
or Installs IS NULL
or Type IS NULL 
or Price IS NULL
or Content_Rating IS NULL
or Genres IS NULL
or Last_Updated IS NULL
or Current_Ver IS NULL
or Android_Ver IS NULL

-- Overview of dataset
select 
count(distinct App) as Total_apps,
count(distinct Category) as Total_categories
from dbo.googleplaystore

-- Explore App categories and Counts--
select top 5 Category, 
count(App) as Total_app
from dbo.googleplaystore
group by Category
order by Total_app desc

--Top rated Free Apps--
select top 10 App, Category, Rating, Reviews
from dbo.googleplaystore
where Type = 'Free'and Rating <> 'NaN'
order by Rating desc

-- Most review apps--
select top 10 App, Reviews
from dbo.googleplaystore
order by Reviews desc

-- Avg rating by category--
select Top 5 Category, 
Avg(TRY_CAST(Rating AS float)) as Avg_rating  --use try_cast to change data type--
from dbo.googleplaystore
group by Category
order by Avg_rating desc

--Top Categories by Number of Installs--
select top 10 Category,
sum(cast(replace(substring(installs, 1, Patindex('%[^0-9]%', installs + ' ')-1),',',' ') as INT)) as total_installs
from dbo.googleplaystore
group by Category
order by total_installs desc

--Avg sentiment polarity by app category--
select Category,
avg(try_cast(sentiment_polarity as float)) as avg_sentiment_polarity
from dbo.googleplaystore
join dbo.googleplaystore_user_reviews
on dbo.googleplaystore.App= dbo.googleplaystore_user_reviews.App
group by Category
order by avg_sentiment_polarity desc

--Sentiment reviews by app category--
select top 10
Category, Sentiment,
count (*) as total_sentiment
from dbo.googleplaystore 
join dbo.googleplaystore_user_reviews on dbo.googleplaystore.App = dbo.googleplaystore_user_reviews.App
where sentiment <> 'nan'
group by Category, sentiment
order by total_sentiment desc


