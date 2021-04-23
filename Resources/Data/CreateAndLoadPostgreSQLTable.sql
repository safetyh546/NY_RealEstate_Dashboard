/*
Drop table if exists sales_stage
Drop table if exists sales
*/

CREATE TABLE sales_stage (
     file_col_1 int
   , borough int
   , neighborhood VARCHAR(1000)
   , building_class_category 	  VARCHAR(1000)  
   , tax_class_at_present    VARCHAR(1000)
   , block int
   , lot int
   , easement varchar(1000)
   , building_class_at_present varchar(1000)
   , address varchar(1000)
   , apartment_number varchar(1000)
   , zipcode varchar(1000)	
   , residential_units int
   , commercial_units int
   , total_units int
   , land_square_feet VARCHAR(1000)
   , gross_square_feet VARCHAR(1000)
   , year_built int
   , tax_class_at_time_of_sale int
   , building_class_at_time_of_sale varchar(1000)
   , sale_price money
   , sale_date date
	
);

CREATE TABLE sales (
     sale_ID serial PRIMARY KEY
   , borough int
   , borough_name varchar(100)
   , neighborhood VARCHAR(1000)
   , building_class_category 	  VARCHAR(1000)  
   , tax_class_at_present    VARCHAR(1000)
   , block int
   , lot int
   , easement varchar(1000)
   , building_class_at_present varchar(1000)
   , address varchar(1000)
   , apartment_number varchar(1000)
   , zipcode varchar(1000)	
   , residential_units int
   , commercial_units int
   , total_units int
   , land_square_feet VARCHAR(1000)
   , gross_square_feet VARCHAR(1000)
   , year_built int
   , tax_class_at_time_of_sale int
   , building_class_at_time_of_sale varchar(1000)
   , sale_price money
   , sale_date date
	
);

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
   , sale_date)
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
   from sales_stage
   where sale_price <> ''

/*
--sales_stage checking queries
select borough, count(*) from sales_stage where sale_price <> '' group by borough
select min(sale_date), max(sale_date) from sales_stage
select borough, count(*) from sales_stage where sale_price <> '' group by borough

--sales checking queries
select borough_name,borough, count(*), min(sale_date),max(sale_date) from sales where sale_price <> '' group by borough_name,borough
select min(sale_date), max(sale_date), min(sale_ID),max(sale_ID) from sales

*/