	-- PROBLEMA 2625

SELECT
    concat( SUBSTRING(cpf,1,3),'.',
            SUBSTRING(cpf,4,3),'.',
            SUBSTRING(cpf,7,3),'-',
            SUBSTRING(cpf,10,2))
FROM natural_person
inner join customers
on natural_person.id_customers = customers.id;