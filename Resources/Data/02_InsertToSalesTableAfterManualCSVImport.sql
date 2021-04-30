insert into sales (
   borough 
   , borough_name
   , neighborhood
   , building_class_category
   , tax_class_at_present
   , block
   , lot
   , easement
   , building_class_at_present
   , address
   , apartment_number
   , zipcode
   , residential_units
   , commercial_units
   , total_units
   , land_square_feet
   , gross_square_feet
   , year_built
   , tax_class_at_time_of_sale
   , building_class_at_time_of_sale
   , sale_price
   , sale_date
   , sale_date_YYYYMM
   , price_per_gross_square_foot)
 select 
   borough 
   , case 
      when borough = 1 then 'Manhattan' 
	  when borough = 2 then 'Bronx'
	  when borough = 3 then 'Brooklyn'
	  when borough = 4 then 'Queens'
	  when borough = 5 then 'Staten Island'
	  else '' end
	  as borough_name
   , neighborhood
   , building_class_category
   , tax_class_at_present
   , block
   , lot
   , easement
   , building_class_at_present
   , address
   , apartment_number
   , zipcode
   , residential_units
   , commercial_units
   , total_units
   , land_square_feet
   , case when gross_square_feet = ' -  ' then '0' else gross_square_feet end
   , year_built
   , tax_class_at_time_of_sale
   , building_class_at_time_of_sale
   , CAST(sale_price AS NUMERIC)
   , sale_date
   , to_char(sale_date,'YYYY-MM')
   , round(case when (case when gross_square_feet = ' -  ' then '0' else gross_square_feet end) = '0' then '0'
      else    CAST(sale_price AS NUMERIC)/cast((case when gross_square_feet = ' -  ' then '0' else gross_square_feet end) as NUMERIC)
	  end ::numeric,2)
   from sales_stage
   where sale_price <> ''
   and CAST(sale_price AS NUMERIC) >= 500000.00  --cast(500000 as NUMERIC)
   and CAST(sale_price AS NUMERIC) <= 800000.00  --cast(800000 as NUMERIC)


/*
--sales_stage checking queries
select borough, count(*) from sales_stage where sale_price <> '' group by borough
select min(sale_date), max(sale_date) from sales_stage
select borough, count(*) from sales_stage where sale_price <> '' group by borough

--sales checking queries
select sale_date_YYYYMM from sales limit 1000
select borough_name,borough, count(*), min(sale_date),max(sale_date) from sales where sale_price <> '' group by borough_name,borough
select min(sale_date), max(sale_date), min(sale_ID),max(sale_ID) from sales
select sale_price from sales order by sale_price limit 1000

select borough_name,count(*), min(sale_price), max(sale_price) 
--select count(*)
from sales 
where sale_price > cast(200000 as money) and sale_price < cast(400000 as money) --15k 
group by borough_name

select borough_name,count(*), min(sale_price), max(sale_price) , min(sale_date),max(sale_date)
--select count(*)
from sales 
where sale_price > cast(500000 as money) and sale_price < cast(800000 as money) --15k 
group by borough_name
order by count(*) desc
*/


select sale_date_YYYYMM,sum(sale_price),count(sale_id) 
from  sales 
where cast(gross_square_feet as int) > 0
group by sale_date_YYYYMM  order by sale_date_YYYYMM

select * from sales limit 1000
