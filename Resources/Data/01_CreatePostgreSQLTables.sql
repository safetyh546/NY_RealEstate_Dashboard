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
   , sale_price NUMERIC
   , sale_date date
   , sale_date_YYYYMM varchar(07)	
   , price_per_gross_square_foot NUMERIC
	
);



