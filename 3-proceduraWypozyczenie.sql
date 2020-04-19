CREATE PROCEDURE Wypozyczenie (
	@IdWypozyczenia int, 
	@IdKsiazki int, 
	@IdCzytelnika int, 
	@IdPracownika int,
	@Wynik int OUTPUT
) AS
BEGIN
	IF EXISTS (SELECT IdWypozyczenia FROM Wypozyczenia WHERE IdWypozyczenia=@IdWypozyczenia)
	BEGIN
		select @Wynik = 1; --Wypozyczenie o tym Id ju¿ istnieje
	END
	ELSE IF NOT EXISTS (SELECT IdCzytelnika FROM Czytelnicy WHERE IdCzytelnika=@IdCzytelnika)
	BEGIN
		select @Wynik = 2; --Czytelnik o tym Id nie istnieje
	END
	ELSE IF NOT EXISTS (SELECT IdPracownika FROM Pracownicy WHERE IdPracownika=@IdPracownika)
	BEGIN
		select @Wynik = 3; --Pracownik o tym Id nie istnieje
	END
	ELSE IF NOT EXISTS (SELECT IdKsiazki FROM Ksiazki WHERE IdKsiazki=@IdKsiazki)
	BEGIN
		select @Wynik = 4; --Ksi¹¿ka o tym Id nie istnieje
	END
	ELSE IF NOT ((SELECT LiczbaDostepnych FROM Ksiazki WHERE IdKsiazki=@IdKsiazki) > 0)
	BEGIN
		select @Wynik = 5; --Ksi¹¿ek o podanym Id nie ma na stanie
	END
	ELSE
	BEGIN
		select @Wynik = 0; -- sukces
		insert into Wypozyczenia 
		(IdWypozyczenia, IdCzytelnika, IdPracownikaWydajacego, DataWydania)
		values(@IdWypozyczenia, @IdCzytelnika, @IdPracownika, GETDATE())

		insert into WypozyczoneKsiazki
		(IdWypozyczenia, IdKsiazki)
		values(@IdWypozyczenia, @IdKsiazki)

		update Ksiazki
		set LiczbaWypozyczen += 1,
		LiczbaWypozyczonych += 1,
		LiczbaDostepnych -= 1
		where IdKsiazki = @IdKsiazki
	END
END;