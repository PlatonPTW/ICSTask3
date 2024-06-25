REATE TRIGGER dbo.TR_Basket_insert_update
ON dbo.Basket
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE b
    SET DiscountValue = CASE 
                            WHEN i.SKUCount >= 2 THEN b.Value * 0.05 
                            ELSE 0 
                        END
    FROM dbo.Basket AS b
    INNER JOIN inserted AS i ON b.ID = i.ID
    INNER JOIN (
        SELECT ID_SKU, COUNT(*) AS SKUCount
        FROM inserted
        GROUP BY ID_SKU
    ) AS c ON b.ID_SKU = c.ID_SKU;
END;
GO