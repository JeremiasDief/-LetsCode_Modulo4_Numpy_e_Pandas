	-- PROBLEMA 2989

-- MINHA RESOLUÇÃO (não aceita) CRIANDO TABELAS AUXILIARES - PROBLEMA 2989:

create table acrescimos as
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
    order by lotacao, matr);

create table acrescimos_somados as
    (select
        acrescimos.matr,
        acrescimos.empregado,
        acrescimos.departamento,
        acrescimos.divisao,
        sum(acrescimos.valor) as total_acrescimos
    from acrescimos
    group by acrescimos.matr, acrescimos.empregado, acrescimos.departamento, acrescimos.divisao
    order by matr);

create table decrescimos as
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
    order by lotacao, matr);
    
create table decrescimos_somados as
    (select
        decrescimos.matr,
        decrescimos.empregado,
        decrescimos.departamento,
        decrescimos.divisao,
        sum(decrescimos.descontos) as total_decrescimos
    from decrescimos
    group by decrescimos.matr, decrescimos.empregado, decrescimos.departamento, decrescimos.divisao
    order by matr);

create table salarios_finais as
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
    from acrescimos_somados
    left join decrescimos_somados
        on acrescimos_somados.matr = decrescimos_somados.matr
    order by acrescimos_somados.departamento, acrescimos_somados.divisao, acrescimos_somados.matr);
    
select
    departamento,
    divisao,
    round(avg(salario_final), 2) as media,
    max(salario_final) as maior
from salarios_finais
group by departamento, divisao
order by media desc;



-- SOLUÇÃO ACEITA (sem criar tabelas auxiliares) APENAS UNINDO TODAS AS QUERYS - PROBLEMA 2989:

select
    departamento,
    divisao,
    round(avg(salario_final), 2) as media,
    max(salario_final) as maior
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
group by departamento, divisao
order by media desc;