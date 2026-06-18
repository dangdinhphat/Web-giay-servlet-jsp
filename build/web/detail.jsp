<%-- 
    Document   : detail
    Created on : Jun 3, 2026, 11:00:38 PM
    Author     : phatm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${product.name} - KICKSZONE</title>
        <style>
        .container { width: 80%; margin: 50px auto; display: flex; gap: 50px; }
        .product-image { width: 45%; }
        .product-image img { width: 100%; border-radius: 8px; }
        .product-info { width: 50%; }
        .price { color: #ff5722; font-size: 24px; font-weight: bold; }
        .btn-add { background-color: #000; color: #fff; padding: 12px 25px; border: none; cursor: pointer; }
    </style>
    </head>
    <body>
        <div class="container">
        <!-- Khối hiển thị ảnh bên trái -->
        <div class="product-image">
            <img src="${product.imageUrl}" alt="${product.name}">
        </div>

        <!-- Khối hiển thị thông tin bên phải -->
        <div class="product-info">
            <h1>${product.name}</h1>
            <p class="status">Trạng thái: <strong>${product.status}</strong></p>
            <p class="price">${product.price} VNĐ</p>
            <hr>
            <h3>Mô tả sản phẩm:</h3>
            <p>${product.description}</p>
            <br>
            <!-- Nút thêm vào giỏ hàng (sẽ xử lý ở các bài sau) -->
            <a href="add-to-cart?id=${product.id}" style="text-decoration: none;">
                <button class="btn-add">THÊM VÀO GIỎ HÀNG</button>
            </a>
        </div>
    </div>
    </body>
</html>
