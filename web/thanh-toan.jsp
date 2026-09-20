<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thanh Toán Đơn Hàng</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 p-10">
    <div class="max-w-xl mx-auto bg-white p-8 rounded-2xl shadow-md">
        <h2 class="text-2xl font-bold mb-6 text-center text-stone-800">THÔNG TIN ĐẶT HÀNG</h2>
        
        <form action="checkout" method="post" class="space-y-4">
            <div>
                <label class="block text-sm font-medium text-gray-700">Họ và tên người nhận</label>
                <input type="text" name="customerName" required class="w-full mt-1 p-2 border rounded-xl outline-none">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700">Số điện thoại</label>
                <input type="text" name="phone" required class="w-full mt-1 p-2 border rounded-xl outline-none">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700">Địa chỉ giao hàng</label>
                <textarea name="address" required class="w-full mt-1 p-2 border rounded-xl outline-none" rows="3"></textarea>
            </div>
            
            <div class="border-t pt-4 flex justify-between items-center font-bold text-lg text-orange-600">
                <span>Tổng tiền tạm tính:</span>
                <c:set var="totalMoney" value="0"/>
                <c:forEach var="entry" items="${sessionScope.cart}">
                    <c:set var="totalMoney" value="${totalMoney + (entry.value.product.price * entry.value.quantity)}"/>
                </c:forEach>
                <span><fmt:formatNumber value="${totalMoney}" type="number"/> VNĐ</span>
                <input type="hidden" name="totalMoney" value="${totalMoney}">
            </div>
            
            <button type="submit" class="w-full py-3 bg-stone-900 text-white font-semibold rounded-xl hover:bg-orange-600 transition-colors">
                XÁC NHẬN ĐẶT HÀNG
            </button>
        </form>
    </div>
</body>
</html>