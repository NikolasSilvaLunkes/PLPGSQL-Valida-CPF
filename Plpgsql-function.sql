--drop function validarcpf
create or replace function validarCpf(cpf varchar)
returns boolean
	as
	$$
	declare
		total1 integer;
		total2 integer;
		ii integer;
		i integer;
		
		currentInt integer;
		currentChar varchar;
		verificationDigits varchar;
	begin
		if (char_length (cpf))<>11 then
			return false;
		end if;
		--select count(*) into total from inquilino where nome != '';
		--return total;
		total1:= 0;
		total2:= 0;
		i:=10;
		ii:=1;
		loop
			currentChar:= substring(cpf,ii,1);
			currentInt:=cast(currentChar as integer);
			total1:= total1+(currentInt*i);
			if i<=2 then
				exit;
			end if;
			i:=i-1;
			ii:=ii+1;
		end loop;
		total1:= (total1%11);
		
		if total1>=2 then
		 total1:= 11-total1;
		else
		 total1:= 0;
		end if;
		
		i:=11;
		ii:=1;
		loop
			currentChar:= substring(cpf,ii,1);
			currentInt:=cast(currentChar as integer);
			total2:= total2+(currentInt*i);
			if i<=2 then
				exit;
			end if;
			i:=i-1;
			ii:=ii+1;
		end loop;
		--total2:= 11-(total2%11);
		total2:= (total2%11);
		
		if total2>=2 then
		 total2:= 11-total2;
		else
		 total2:= 0;
		end if;
		
		verificationDigits:=concat(cast(total1 as varchar),cast(total2 as varchar));
		
		if verificationDigits=substring(cpf,10,2) then
			return true;
		else
			return false;
		end if;
		
	end;
	$$ language plpgsql;
	
select(validarcpf('08673723973'));


select(substring('08673723972',8,1))







--trigger
create trigger see_total
	before insert
	on inquilino
	--for each row
	execute procedure calc_total_price