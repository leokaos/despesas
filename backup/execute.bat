set _date=%DATE:/=-%

pg_dump --dbname=postgresql://despesas:despesas_db@127.0.0.1:5432/despesas > "D:\Projetos\despesas\backup\backup-%_date%.sql"