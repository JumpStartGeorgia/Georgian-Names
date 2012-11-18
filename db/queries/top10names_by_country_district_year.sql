/* first name in country */
select
n.name, n.count, n.rank, t.count as num_unique_names, x.total_population
from
names as n, name_totals as t, (
select sum(count) as total_population from names where name_type = 1
) as x
where n.name_type = 1
and t.identifier = 1 and t.total_type = 1
order by n.count desc 
limit 10;

/* last name in country */
select
n.name, n.count, n.rank, t.count as num_unique_names, x.total_population
from
names as n, name_totals as t, (
select sum(count) as total_population from names where name_type = 2
) as x
where n.name_type = 2
and t.identifier = 2 and t.total_type = 1
order by n.count desc 
limit 10;

/* top 10 first names by calendar year */
select
x.birth_year, n.name, x.count, x.rank, un.count as num_unique_names_for_year, pop.count as total_population_for_year
from
names as n inner join birth_years as x on x.name_id = n.id
inner join name_totals as un on un.identifier = x.birth_year
inner join name_totals as pop on pop.identifier = x.birth_year
where n.name_type = 1 and x.rank <= 10
and un.total_type = 3 and pop.total_type = 7
order by x.birth_year, x.count desc, n.name;

/* top 10 last names by calendar year */
select
x.birth_year, n.name, x.count, x.rank, un.count as num_unique_names_for_year, pop.count as total_population_for_year
from
names as n inner join birth_years as x on x.name_id = n.id
inner join name_totals as un on un.identifier = x.birth_year
inner join name_totals as pop on pop.identifier = x.birth_year
where n.name_type = 2 and x.rank <= 10
and un.total_type = 5 and pop.total_type = 7
order by x.birth_year, x.count desc, n.name;

/* top 10 first names by district */
select
x.district_id, d.name, n.name, x.count, x.rank, un.count as num_unique_names_for_district, pop.count as total_population_for_district
from
names as n inner join districts as x on x.name_id = n.id inner join district_names as d on d.id = x.district_id
inner join name_totals as un on un.identifier = x.district_id
inner join name_totals as pop on pop.identifier = x.district_id
where n.name_type = 1 and x.rank <= 10
and un.total_type = 2 and pop.total_type = 6
order by x.district_id, x.count desc, n.name;

/* top 10 last names by district */
select
x.district_id, d.name, n.name, x.count, x.rank, un.count as num_unique_names_for_district, pop.count as total_population_for_district
from
names as n inner join districts as x on x.name_id = n.id inner join district_names as d on d.id = x.district_id
inner join name_totals as un on un.identifier = x.district_id
inner join name_totals as pop on pop.identifier = x.district_id
where n.name_type = 2 and x.rank <= 10
and un.total_type = 4 and pop.total_type = 6
order by x.district_id, x.count desc, n.name;
