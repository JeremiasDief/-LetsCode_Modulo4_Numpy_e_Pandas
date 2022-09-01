	-- PROBLEMA 2991

-- MINHA RESOLUÇÃO (aceita) PROBLEMA 2991:
-- (Quase igual ao 2989, só precisou mudar o agrupamento na penúltima linha e mudar as colunas no início do select);

select
    departamento as "Nome Departamento",
    count(empregado) as "Numero de Empregados",
    round(avg(salario_final), 2) as "Media Salarial",
    max(salario_final) as "Maior Salario",
    min(salario_final) as "Menor Salario"
from
    (select
    acrescimos_somados.matr,
    acrescimos_somados.empregado,
    acrescimos_somados.departamento,
    acrescimos_somados.divisao,
    (case
        when (decrescimos_somados.total_decrescimos is null)
        then acrescimos_somados.total_acrescimos
        else (acrescimos_somados.total_acrescimos - decrescimos_somados.total_decrescimos) 
        end) as salario_final
    from
        (select
        acrescimos.matr,
        acrescimos.empregado,
        acrescimos.departamento,
        acrescimos.divisao,
        sum(acrescimos.valor) as total_acrescimos
        from 
            (select 
                empregado.matr, 
                empregado.nome as empregado, 
                departamento.nome as departamento,
                divisao.nome as divisao,
                coalesce(vencimento.valor, 0) as valor
            from empregado
            full join departamento
                on empregado.lotacao = departamento.cod_dep
            full join divisao
                on empregado.lotacao_div = divisao.cod_divisao
            full join emp_venc
                on empregado.matr = emp_venc.matr
            left join vencimento
                on emp_venc.cod_venc = vencimento.cod_venc
            order by lotacao, matr) as acrescimos
        group by acrescimos.matr, acrescimos.empregado, acrescimos.departamento, acrescimos.divisao
        order by matr) as acrescimos_somados
    left join
        (select
        decrescimos.matr,
        decrescimos.empregado,
        decrescimos.departamento,
        decrescimos.divisao,
        sum(decrescimos.descontos) as total_decrescimos
        from 
            (select 
                empregado.matr, 
                empregado.nome as empregado, 
                departamento.nome as departamento,
                divisao.nome as divisao,
                coalesce(desconto.valor) as descontos
            from empregado
            full join departamento
                on empregado.lotacao = departamento.cod_dep
            full join divisao
                on empregado.lotacao_div = divisao.cod_divisao
            full join emp_desc
                on empregado.matr = emp_desc.matr
            left join desconto
                on emp_desc.cod_desc = desconto.cod_desc
                where desconto.valor is not null
            order by lotacao, matr) as decrescimos
        group by decrescimos.matr, decrescimos.empregado, decrescimos.departamento, decrescimos.divisao
        order by matr) as decrescimos_somados
        on acrescimos_somados.matr = decrescimos_somados.matr
    order by acrescimos_somados.departamento, acrescimos_somados.divisao, acrescimos_somados.matr) as salarios_finais
group by departamento
order by "Media Salarial" desc;