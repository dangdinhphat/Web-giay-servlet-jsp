<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Giỏ hàng của bạn</title>
    <style>
        table { width: 80%; margin: 20px auto; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: center; }
        th { background-color: #f4f4f4; }
        .back-btn { display: block; width: 150px; margin: 20px auto; text-align: center; background: black; color: white; padding: 10px; text-decoration: none; }
    </style>
</head>
<body>

    <h2 style="text-align: center; margin-top: 50px;">GIỎ HÀNG CỦA BẠN</h2>

    <table>
        <thead>
            <tr>
                <th>Hình ảnh</th>
                <th>Tên sản phẩm</th>
                <th>Giá tiền</th>
                <th>Số lượng</th>
                <th>Tổng cộng</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty sessionScope.cart}">
                    <c:set var="totalMoney" value="0"/>
                    <c:forEach var="entry" items="${sessionScope.cart}">
                        <c:set var="item" value="${entry.value}"/>
                        <tr>
                            <td><img src="${item.product.imageUrl}" width="80px" alt="shoe"></td>
                            <td>${item.product.name}</td>
                            <td>${item.product.price} VNĐ</td>
                            <td>${item.quantity}</td>
                            <td>${item.product.price * item.quantity} VNĐ</td>
                        </tr>
                        <c:set var="totalMoney" value="${totalMoney + (item.product.price * item.quantity)}"/>
                    </c:forEach>
                    <tr>
                        <td colspan="4" style="text-align: right; font-weight: bold;">Tổng tiền đơn hàng:</td>
                        <td style="color: red; font-weight: bold;">${totalMoney} VNĐ</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="5">Giỏ hàng của bạn đang trống!</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <a href="ProductServlet" class="back-btn">Tiếp tục mua sắm</a>

</body>
</html>