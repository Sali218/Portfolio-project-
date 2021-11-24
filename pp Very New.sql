select *  from   dbo.['Covid-Death$'] 
where continent  is not null
order by 3,4;

--select *  from   [dbo].['daily-covid-vaccination-doses-p$'] 
--order by 3,4

-- select the data that we are going to be using --
select location, date,  total_cases, new_cases, total_deaths, population 
from [dbo].['Covid-Death$']
where continent  is not null
order by 1,2;

--looking at Total cases VS Total Deaths
--showing liklihood of dying if you contract covid in your country.  
select location, date,  total_cases, total_deaths,total_deaths/ total_cases* 100 as Death_percentage
from [dbo].['Covid-Death$']
where location like '%Israel%' and  continent  is not null

order by 1,2

--looking at the Total Cases VS population 
-- what percentage of population got covid 
select location,  date, population, total_cases, total_cases/population * 100 as Persent_Of_Population_Infected
from [dbo].['Covid-Death$']
where location like '%Israel%'  and  continent  is not null
order by 1,2;
-- looking for countries with highest Infection Rate compared to population 

select location,  population, MAX (total_cases) as highst_Infection_Count, MAX (total_cases/population) * 100 as  Persent_Of_Population_Infected
from [dbo].['Covid-Death$']
where continent  is not null
group by location,  population
order by Persent_Of_Population_Infected desc;



--showing countries with high death count per population 
-- CAST function converts an expression from one datatype to another datatype.
select location, Max (Cast (Total_Deaths as int )) as Total_Death_count
from [dbo].['Covid-Death$']
where continent is not null
group by location 
order by Total_Death_count desc;


--Lets Break things out by continent
select continent , Max (Cast (Total_Deaths as int )) as Total_Death_count
from [dbo].['Covid-Death$']
where continent is not  null
group by continent
order by Total_Death_count desc;


--showing the continent with the highest death count per population 
select continent , Max (Cast (Total_Deaths as int )) as Total_Death_count
from [dbo].['Covid-Death$']
where continent is not  null
group by continent
order by Total_Death_count desc;

--global Numbers

select  date, SUM (new_cases) as Total_cases ,SUM( cast (new_deaths as int )) as Total_deaths, SUM (cast( new_deaths as int )) /
SUM (new_cases) *100 as Death_Percentage 
from [dbo].['Covid-Death$']
where continent is not NULL
group by date 
order by 1,2;

--Looking at total population VS vaccination 

With popvsvac (continent , Location , date, population , new_vaccination, Rolling_peaple_Vaccenated ) 
as (
select dea.continent, dea.location, dea.date, dea.population,vac.new_vaccinations_smoothed_per_million  *100000, 
SUM (convert (int, vac.new_vaccinations_smoothed_per_million*100000)) OVER (partition by dea.location
order by dea.location , dea.date) AS Rolling_peaple_Vaccenated    
from Portfolio..['Covid-Death$'] dea
join Portfolio..['daily-covid-vaccination-doses-p$'] vac 
on dea.date = vac.Day
and dea.location = vac.Entity
where dea.continent is not Null
--order by 2,3
)
select *,(Rolling_peaple_Vaccenated /population)*100  from popvsvac  
--Use CTE 

select  new_vaccinations_smoothed_per_million  *1000000, new_vaccinations_smoothed_per_million
from [dbo].['daily-covid-vaccination-doses-p$']

--temp table 
drop table if exists #percent_population_vaccinated1 
create table #percent_population_vaccinated1
(
continent  nvarchar (255),
location nvarchar (255),
date datetime ,
population  numeric,
new_vaccinations numeric ,
Rolling_peaple_Vaccenated numeric 
)

insert into #percent_population_vaccinated1
select dea.continent, dea.location, dea.date, dea.population,vac.new_vaccinations_smoothed_per_million  *100000 AS new_vaccinations , 
SUM (convert (int, vac.new_vaccinations_smoothed_per_million*100000))  OVER (partition by dea.location
order by dea.location , dea.date) AS Rolling_peaple_Vaccenated   
from Portfolio..['Covid-Death$'] dea
join Portfolio..['daily-covid-vaccination-doses-p$'] vac 
on dea.date = vac.Day
and dea.location = vac.Entity
where dea.continent is not Null
--order by 2,3

select *,(Rolling_peaple_Vaccenated /population)*100 as percentage_peaple_vaccinated  from  #percent_population_vaccinated1

--creating veiw to store data for later visualizations

create view percent_population_vaccinated1 as  
select dea.continent, dea.location, dea.date, dea.population,vac.new_vaccinations_smoothed_per_million  *100000 AS new_vaccinations , 
SUM (convert (int, vac.new_vaccinations_smoothed_per_million*100000))  OVER (partition by dea.location
order by dea.location , dea.date) AS Rolling_peaple_Vaccenated   
from Portfolio..['Covid-Death$'] dea
join Portfolio..['daily-covid-vaccination-doses-p$'] vac 
on dea.date = vac.Day
and dea.location = vac.Entity
where dea.continent is not Null
--order by 2,3
select * 
from  percent_population_vaccinated1
