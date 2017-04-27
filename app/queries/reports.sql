--1. Danh sách các chiến dịch: Chọn thời gian từ ngày đến ngày
--Cho phép lọc theo tỉnh, theo tên sản phẩm khuyến mại (nếu 2 ô này không chọn tức là lấy hết dữ liệu)
--Hiển thị thông tin chiến dịch (tên, nội dung, ngày bắt đầu, ngày kết thúc, tỉnh, số lương sản phẩm khuyến mại,
--tên sản phẩm khuyến mại). Khi nhấn vào tên chiến dịch sẽ hiển thị ra danh sách nông dân đã tham dự chiến dịch, 
--bao gồm các thông tin: SĐT, tên nông dân, Sản phẩm, số lượng. Vì mỗi chiến dịch sẽ khuyến mại ít
-- loại sản phẩm nên chỗ này hiển thị sản phẩm theo hàng ngang cũng được
-----------------------------------------------------------------------------------
--1.1 Danh sach cac chien dich Chọn thời gian từ ngày đến ngày
--date1 la tham so can truyen vao
--Tinh la tham so truyen
select c.id,c.name,c.content,c.start_time,c.end_time,c.location,c.product_count,p.name
From campaigns c
inner join products p on c.product_id=p.id
Where date1 between date_trunc('day',c.start_time) and date_trunc('day',c.end_time)
and c.location like 'Hai Phong'
and p.name like 'Ten sp can loc' 
Order by c.start_time;

-------------------------
--Danh sach nong dan tham gia chien dich
--id la chien dich tham so can truyen vao
select customers.phone,customers.name,p.name as product_name,c.product_count
From campaigns c
inner join products p on c.product_id=p.id
inner join campaign_customers on c.id=campaign_customers.campaign_id
inner join customers on campaign_customers.customer_id=customers.id  
Where c.id=id
Order by customers.name
---------------------------------------------

--2. Danh sách nông dân: Hiển thị thông tin nông dân theo dạng bảng (sđt, tên, tỉnh, địa chỉ).
-- Khi nhấn vào sđt của nông dân sẽ hiển thị ra thông tin của nông dân đó bao gồm: Tên chiến dịch tham gia, 
-- tên sản phẩm được khuyến mại, số lượng sản phẩm được khuyến mại
----------------------------------------------------------------
--2.1 Danh sach cac nong dan
select phone,name,city,address
from customers
order by name
---------------------------
--2.2 Thong tin cua nong dan tham gia chien dich
--phone1 la tham so truyen vao
select c.name,p.name as product_name,c.start_time,c.end_time,c.product_count
From campaigns c
inner join products p on c.product_id=p.id
inner join campaign_customers on c.id=campaign_customers.campaign_id
inner join customers on campaign_customers.customer_id=customers.id  
Where customers.phone='phone1'
----------------------------------------
--3. Danh sách sản phẩm khuyến mại: Chọn thời gian từ ngày đến ngày
--chọn chiến dịch (nếu không chọn thì mặc định là tất cả chiến dịch)
--Bảng hiện thị các thông tin sau: Tên sản phẩm, số lượng sản phẩm đã khuyến mại,
--chiến dịch. Dưới cùng của bảng có dòng tổng cộng số lượng theo từng sản phẩm
--Lưu ý trong bảng sản phẩm có các trường: ID sản phẩm, tên sản phẩm, đơn giá sản phẩm 
--(đơn giá để sau này so sánh kinh phí của các chiến dịch)
----------------------------------------------------------------------------
--3.1 Danh sach cac san pham khuyen mai : Chọn thời gian từ ngày đến ngày
--date1 la tham so can truyen vao

select c.name,p.id,p.name as product_name,c.product_count,c.start_time,c.end_time
From campaigns c
inner join products p on c.product_id=p.id
inner join campaign_customers on c.id=campaign_customers.campaign_id
--inner join customers on campaign_customers.customer_id=customers.id  
Where date1 between date_trunc('day',c.start_time) and date_trunc('day',c.end_time)
and c.name like 'Ten chien dich'
Order by p.name

-----------------------------------------------------
--4. Báo cáo phân tích:
--4.1. Biểu đồ so sánh hiệu quả chiến dịch: 
--- Kinh phí của các chiến dịch
--- Số lượng nông dân tham dự của các chiến dịch
select kp.id,kp.name,kp.total,slg.slg slg_nguoi
from (
select c.id,c.name,c.product_count*p.price as total
From campaigns c
inner join products p on c.product_id=p.id
) As kp
inner join (select campaign_id,count(*) Slg
from campaign_customers
Group by campaign_id
) AS slg
On kp.id=slg.campaign_id
--------------------------------------------------------
--4.2. Biểu đồ so sánh hiệu quả theo thời gian
--- Số lượng nông dân tham dự theo tháng
--- Số lượng sản phẩm theo tháng
Select  s1.campaign_id,s1.month,s1.slg customer_count,s2.product_name,s2.slg Product_count
from (
select s.campaign_id,s.month,count(*) slg  
from (
select campaign_id, date_part( 'month', created_at) as month
from campaign_customers 
) s
group by s.campaign_id,s.month
) as s1
inner join 
(select s.campaign_id,s.product_name,s.month,count(*) slg  
from (
select a.campaign_id,c.name product_name, date_part( 'month', a.created_at) as month
from campaign_customers a
inner join campaigns b on a.campaign_id=b.id
inner join products c on b.product_id=c.id 
) s
group by s.campaign_id,s.product_name,s.month
) as s2
on s1.campaign_id=s2.campaign_id and s1.month=s2.month
Order by s1.month,Product_count
------------------------------------------------------------
--4.3. Biểu đồ so sánh sản phẩm ưa chuộng
--- Số lượng sản phẩm 
select s.product_name,count(*) product_count 
from (
select a.campaign_id,c.name product_name
from campaign_customers a
inner join campaigns b on a.campaign_id=b.id
inner join products c on b.product_id=c.id 
) s
group by s.product_name
Order by product_count desc
-----------------------------------------
--4.4. Danh sách TOP 10 Cấp 2 tiềm năng:
--- 10 cấp 2 có số lượng sản phẩm khuyến mại nhiều nhất (chọn sản phẩm)
--- 10 cấp 2 có số nông dân đến mua nhiều nhất
--Phan nay chua hieu ????