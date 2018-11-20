-- De helpdesk kan ook lijsten opvragen van gebruikers
-- De belangrijke vraag is wel HOE ze dit precies mogen doen. We kunnen wel testen schrijven, maar er is een groot verschil of bv een wildcard mag gebruikt worden of niet 


select *
FROM dbo.user_table;

select first_name
FROM dbo.user_table;

select last_name
FROM dbo.user_table;

select first_name, last_name
FROM dbo.user_table;


-- using wildcards at the beginning make for very inefficient queries as it disables index usage 
-- Think about how names should be searched; full wildcard is alwauys inefficient, perhaps use n.gram tables?

select last_name
FROM dbo.user_table
WHERE last_name LIKE '%for%';


