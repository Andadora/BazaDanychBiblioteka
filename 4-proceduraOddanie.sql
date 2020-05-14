CREATE PROCEDURE Oddanie (
	@IdWypozyczenia int, 
	@IdKsiazki int, 
	@IdCzytelnika int, 
	@IdPracownika int,
	@Wynik int OUTPUT
) AS
BEGIN
	IF NOT EXISTS	(SELECT w.IdWypozyczenia 
					from Wypozyczenia w
					left join WypozyczoneKsiazki wk on wk.IdWypozyczenia = w.IdWypozyczenia
					WHERE w.IdWypozyczenia=@IdWypozyczenia 
					and w.IdCzytelnika=@IdCzytelnika
					and wk.IdKsiazki=@IdKsiazki)
	BEGIN
		select @Wynik = 1; --Wypozyczenie o tych parametrach nie istnieje
	END
	ELSE IF NOT EXISTS (SELECT IdPracownika FROM Pracownicy WHERE IdPracownika=@IdPracownika)
	BEGIN
		select @Wynik = 2; --Pracownik o tym Id nie istnieje
	END
	ELSE
	BEGIN
		select @Wynik = 0; -- sukces
		update Wypozyczenia 
		set IdPracownikaOdbierajacego = @IdPracownika,
		DataZwrotu = GETDATE()
		where IdWypozyczenia = @IdWypozyczenia

		update Ksiazki
		set LiczbaWypozyczonych -= 1, 
		LiczbaDostepnych += 1
		where IdKsiazki = @IdKsiazki
		
		delete from WypozyczoneKsiazki where IdWypozyczenia=@IdWypozyczenia
	END
END;
