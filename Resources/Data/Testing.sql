select count(*) ,min(cast(gross_square_feet as int) ), max(cast(gross_square_feet as int) )
from sales 
where gross_square_feet <> ' -  ' 
and cast(gross_square_feet as int)  > 0 
--order by sale_price


select borough_name, ROUND((sale_price/cast(gross_square_feet as money))::numeric,2) , sale_price, gross_square_feet  
--sale_price/cast(gross_square_feet as money),2)
from sales 
where gross_square_feet <> ' -  ' 
and cast(gross_square_feet as int)  > 0 

select borough_name, AVG(prie_per_gross_square_foot)
from sales 
where prie_per_gross_square_foot > cast(0.00 as money)
group by borough_name

select case 
when  cast(gross_square_feet as int)  <= 1000 then '1000 or less'
when cast(gross_square_feet as int) >1000 and cast(gross_square_feet as int) <= 3000 then '>1000 and <= 3000'
when cast(gross_square_feet as int) >3000 and cast(gross_square_feet as int) <= 5000 then '>3000 and less than 5000'
when cast(gross_square_feet as int) >5000 then '>5000'

else 'test' end, 

count(*),
min(sale_price),
max(sale_price)


from sales 
where gross_square_feet <> ' -  ' 
and cast(gross_square_feet as int)  > 0 
group by case 
when  cast(gross_square_feet as int)  <= 1000 then '1000 or less'
when cast(gross_square_feet as int) >1000 and cast(gross_square_feet as int) <= 3000 then '>1000 and <= 3000'
when cast(gross_square_feet as int) >3000 and cast(gross_square_feet as int) <= 5000 then '>3000 and less than 5000'
when cast(gross_square_feet as int) >5000 then '>5000'

else 'test' end

