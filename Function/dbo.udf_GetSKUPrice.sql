create function dbo.udf_GetSKUPrice (@ID_SKU INT)
returns DECIMAL(18, 2)
as
begin
    declare @Price DECIMAL(18, 2);

    select @Price = SUM(Value) / SUM(Quantity)
    from dbo.Basket
    where ID_SKU = @ID_SKU;

    returns ISNULL(@Price, 0);
end;
GO
