CREATE PROCEDURE dbo.usp_MakeFamilyPurchase (@FamilySurName VARCHAR(255))
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM dbo.Family WHERE SurName = @FamilySurName)
    BEGIN
        RAISERROR('Семья с фамилией "%s" не найдена.', 16, 1, @FamilySurName);
        RETURN;
    END;

    UPDATE dbo.Family
    SET BudgetValue = BudgetValue - (SELECT ISNULL(SUM(Value), 0) FROM dbo.Basket WHERE ID_Family = f.ID)
    FROM dbo.Family AS f
    WHERE f.SurName = @FamilySurName;
END;
GO