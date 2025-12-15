--tables

CREATE TABLE IF NOT EXISTS public.employees
(
    id serial NOT NULL PRIMARY KEY,
    name text NOT NULL,
    surname text NOT NULL,
    phone_number text
);

CREATE TABLE IF NOT EXISTS public.employees_creation_dates
(
    employee_id integer,
    creation_date timestamp with time zone
);

--trigger
CREATE OR REPLACE FUNCTION public.employee_after_insert()
    RETURNS trigger
    
AS 
$$
begin
	insert into employees_creation_dates(employee_id, creation_date) values (new.id, current_timestamp);
	return old;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER employee_after_insert_trigger
    AFTER INSERT
    ON public.employees
    FOR EACH ROW
    EXECUTE FUNCTION public.employee_after_insert();
	
--view
CREATE OR REPLACE VIEW public.employess_reduced
 AS
 SELECT name,
    surname
   FROM employees;
   
--function plpgsql syntax
CREATE OR REPLACE FUNCTION public.insert_empoyees_func(
	_name text,
	_surname text,
	_phone_number text)
    RETURNS text
    
AS 
$$
begin
	if(not exists (select * from employees e where e.name = _name and e.surname = _surname))
	then
		raise notice 'here is no row with name % and surname %', _name,_surname;
		insert into employees(name, surname, phone_number) values (_name, _surname, _phone_number);
	else
		raise notice 'here is existing row with name % and surname %', _name,_surname;
	end if;
	return _phone_number;
end;
$$
LANGUAGE plpgsql;

--function sql syntax
CREATE OR REPLACE FUNCTION public.insert_empoyees_func_without_check(
	_name text,
	_surname text,
	_phone_number text)
    RETURNS void
AS 
$$
	insert into employees(name, surname, phone_number) values (_name, _surname, _phone_number);
$$
LANGUAGE sql;


--procedure
CREATE OR REPLACE PROCEDURE public.insert_empoyees(
	_name text,
	_surname text,
	_phone_number text)

AS 
$$
begin
	if(not exists (select * from employees e where e.name = _name and e.surname = _surname))
	then
		raise notice 'here is no row with name % and surname %', _name,_surname;
		insert into employees(name, surname, phone_number) values (_name, _surname, _phone_number);
	else
		raise notice 'here is existing row with name % and surname %', _name,_surname;
	end if;
end;
$$
LANGUAGE plpgsql;


select * from employees;

--view
select * from employess_reduced;

--function call
select insert_empoyees_func('Name'::text, 'Surname'::text, '123'::text);

--procedure call
CALL insert_empoyees('Name'::text, 'Surname'::text, '123'::text);