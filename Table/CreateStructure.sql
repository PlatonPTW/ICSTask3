create table dbo.SKU (
    ID int identity(1,1) primary key,
    Code as 's' + cast(ID as varchar(10)) unique,
    Name nvarchar(255) not null
);
