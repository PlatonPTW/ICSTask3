create function dbo.udf_GetSKUPrice (@ID_SKU int)
returns decimal(18, 2)
as
begin
    declare @Price decimal(18, 2);

    select 
        @Price = sum(Value) / sum(Quantity)
    from dbo.Basket
    where ID_SKU = @ID_SKU;

    returns isnull(@Price, 0);
end;
GO
