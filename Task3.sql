CREATE DATABASE Task3;
USE Task3;


//Tạo bảng users
CREATE TABLE Users (
   id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    signup_date DATE NOT NULL
);

//Tạo bảng Products
CREATE TABLE Products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    category VARCHAR(100) NOT NULL
);

//Tạo bảng Orders
CREATE TABLE Orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    order_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(id) ON DELETE CASCADE
);

//Thêm data vao cac bang 
INSERT INTO Users (name, email, signup_date) VALUES
('Nguyen Van A', 'nguyenvana@example.com', '2023-01-10'),
('Tran Thi B', 'tranthib@example.com', '2023-03-15'),
('Le Van C', 'levanc@example.com', '2023-05-20'),
('Pham Van D', 'phamvand@example.com', '2023-07-10'),
('Hoang Thi E', 'hoangthie@example.com', '2023-08-22'),
('Bui Van F', 'buivanf@example.com', '2023-09-05'),
('Nguyen Thi G', 'nguyentg@example.com', '2023-10-12'),
('Tran Van H', 'tranvanh@example.com', '2023-11-30');


INSERT INTO Products (name, price, category) VALUES
('iPhone 14', 999.99, 'Electronics'),
('Samsung Galaxy S23', 899.99, 'Electronics'),
('Nike Air Force 1', 120.00, 'Fashion'),
('Adidas Ultraboost', 180.00, 'Fashion'),
('MacBook Pro 16', 2399.99, 'Electronics'),
('Dell XPS 13', 1299.99, 'Electronics'),
('Sony WH-1000XM5', 349.99, 'Electronics'),
('Apple Watch Series 9', 399.99, 'Electronics'),
('Rolex Submariner', 7500.00, 'Luxury'),
('Gucci Bag', 2500.00, 'Luxury'),
('Jordan 1 Retro', 200.00, 'Fashion'),
('Puma Sneakers', 85.00, 'Fashion'),
('Levi’s 501 Jeans', 70.00, 'Fashion'),
('Ray-Ban Sunglasses', 150.00, 'Accessories');

INSERT INTO Orders (user_id, product_id, order_date, amount) VALUES
(1, 1, '2023-06-01', 999.99),
(1, 3, '2023-06-05', 120.00),
(2, 2, '2023-06-10', 899.99),
(3, 4, '2023-07-15', 180.00),
(1, 2, '2023-08-01', 899.99),
(2, 3, '2023-08-05', 120.00),
(1, 5, '2023-08-15', 2399.99),
(2, 6, '2023-08-20', 1299.99),
(3, 7, '2023-09-01', 349.99),
(4, 8, '2023-09-10', 399.99),
(5, 9, '2023-09-15', 7500.00),
(1, 10, '2023-09-25', 2500.00),
(2, 1, '2023-10-05', 999.99),
(3, 2, '2023-10-10', 899.99),
(4, 3, '2023-10-20', 120.00),
(5, 4, '2023-10-30', 180.00),
(1, 5, '2023-11-10', 2399.99),
(2, 6, '2023-11-15', 1299.99),
(3, 7, '2023-11-20', 349.99),
(4, 8, '2023-11-25', 399.99),
(5, 9, '2023-12-05', 7500.00),
(1, 10, '2023-12-10', 2500.00),
(2, 1, '2023-12-15', 999.99),
(3, 2, '2023-12-20', 899.99),
(4, 3, '2023-12-25', 120.00),
(5, 4, '2023-12-30', 180.00);

//Câu 1: Lấy tất cả người dùng đã lấy ít nhất 3 đơn hàng
SELECT u.id, u.name, u.email, u.signup_date
FROM Users u
JOIN Orders o ON u.id = o.user_id
GROUP BY u.id
HAVING COUNT(o.id) >= 3;

//Câu 2: Tìm 5 sản phẩm đứng đầu theo tổng doanh số bán hàng.
SELECT p.id, p.name, p.price, p.category, SUM(o.amount) AS total_sales
FROM Products p
JOIN Orders o ON p.id = o.product_id
GROUP BY p.id
ORDER BY total_sales DESC
LIMIT 5;
// Câu 3: Tính trung bình giá trị đơn hàng cho từng tháng trong năm 2023
SELECT MONTH(order_date) AS month, AVG(amount) AS avg_order_value
FROM Orders
WHERE order_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY month;
// Câu 4: Tìm người dùng đã mua sản phẩm từ tất cả danh mục
SELECT u.id, u.name, u.email, u.signup_date
FROM Users u
JOIN Orders o ON u.id = o.user_id
JOIN Products p ON o.product_id = p.id
GROUP BY u.id
HAVING COUNT(DISTINCT p.category) = (SELECT COUNT(DISTINCT category) FROM Products);

