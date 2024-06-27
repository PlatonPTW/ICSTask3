create procedure dbo.usp_MakeFamilyPurchase (@FamilySurName varchar(255))
as
begin
    if not exists (select 1 from dbo.Family where SurName = @FamilySurName)
    begin
        raiserror('Семья с фамилией "%s" не найдена.', 16, 1, @FamilySurName);
        return;
    end;

    update dbo.Family
    set BudgetValue = BudgetValue - (select isnull(sum(Value), 0) from dbo.Basket where ID_Family = f.ID)
    from dbo.Family as f
    where f.SurName = @FamilySurName;
end;
go
