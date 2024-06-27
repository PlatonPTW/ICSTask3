reate trigger dbo.TR_Basket_insert_update
on dbo.Basket
after insert, update
as
begin
    update b
    set DiscountValue = case 
                            when i.SKUCount >= 2 then b.Value * 0.05 
                            else 0 
                        end
    from dbo.Basket as b
    inner join inserted as i on b.ID = i.ID
    inner join (
        select ID_SKU, count(*) as SKUCount
        from inserted
        group by ID_SKU
    ) as c on b.ID_SKU = c.ID_SKU;
end;
go
