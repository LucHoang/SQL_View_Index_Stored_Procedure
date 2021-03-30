use classicmodels;

-- Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục)
alter table products add index idx_productCode(productCode);

-- Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)
alter table products add index idx_namePrice(productName, buyPrice);

-- Sử dụng câu lệnh EXPLAIN để biết được câu lệnh SQL của bạn thực thi như nào
explain select * from products where productName = '1968 Ford Mustang';

-- Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products.
create view product_View as
select productCode, productName, buyPrice
from products;

select * from product_view;

-- Tiến hành sửa đổi view
create or replace view product_View as
select productcode, productname, buyPrice
from products
where productname = '1934 Ford V8 Coupe';

-- Tiến hành xoá view
drop view product_view;

-- Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
delimiter //
create procedure findAllProduct()
begin
select * from products;
end //
delimiter //

call findAllProduct();

-- Tạo store procedure thêm một sản phẩm mới
delimiter //
drop procedure if exists `addProduct` //
create procedure addProduct()
begin
insert into products
values (1234, 'Moi them', 'Motorcycles', '1:10', 'Min Lin Diecast', 'This replica features working kickstand, front suspension, gear-shift lever, footbrake lever, drive chain, wheels and steering. All parts are particularly delicate due to their precise scale and require special care and attention.', '7933', '48.81', '95.70');
end //
delimiter //

call addProduct();

-- Tạo store procedure sửa thông tin sản phẩm theo id
delimiter //
create procedure edit_product(IN code varchar(25))
begin
update products
set productname = 'new'
where productcode = code;
end //
delimiter //

call edit_product(1234);

-- Tạo store procedure xoá sản phẩm theo id
delimiter //
create procedure delete_product(IN code varchar(25))
begin
delete from products
where productcode = code;
end //
delimiter //

call delete_product(1234);