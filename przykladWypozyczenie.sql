declare @result int;

EXEC Wypozyczenie
	@IdWypozyczenia=1, 
	@IdKsiazki=13, 
	@IdCzytelnika=23,
	@IdPracownika=2,
	@Wynik=@result OUTPUT;

SELECT @result AS 'wynik';

select 
w.IdWypozyczenia,
w.IdCzytelnika,
wk.IdKsiazki,
k.Tytul,
w.IdPracownikaWydajacego,
w.DataWydania,
w.IdPracownikaOdbierajacego,
w.DataZwrotu,
k.LiczbaWypozyczen,
k.LiczbaWypozyczonych,
k.LiczbaDostepnych
from Wypozyczenia w
left join WypozyczoneKsiazki wk on wk.IdWypozyczenia = w.IdWypozyczenia
left join Ksiazki k on k.IdKsiazki = wk.IdKsiazki