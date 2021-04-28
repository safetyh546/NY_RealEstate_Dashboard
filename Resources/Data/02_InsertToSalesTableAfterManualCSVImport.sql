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
   , sale_date_YYYYMM)
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
   , gross_square_feet
   , year_built
   , tax_class_at_time_of_sale
   , building_class_at_time_of_sale
   , sale_price
   , sale_date
   , cast(to_char(sale_date,'YYYYMM') as int)
   from sales_stage
   where sale_price <> ''
   and sale_price > cast(500000 as money)
   and sale_price < cast(800000 as money)

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

