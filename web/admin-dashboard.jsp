<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Quản Lý Đơn Hàng</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-gray-100 flex">
    
    <div class="w-64 min-h-screen bg-stone-900 text-white p-6">
        <h1 class="text-2xl font-bold mb-10 text-orange-500">KICKSZONE ADMIN</h1>
        <nav class="space-y-4">
            <a href="#" class="block p-3 bg-stone-800 rounded-lg text-orange-400"><i class="fa-solid fa-cart-shopping mr-2"></i> Đơn hàng</a>
            <a href="admin-product" class="block p-3 hover:bg-stone-800 rounded-lg transition-all"><i class="fa-solid fa-box mr-2"></i> Sản phẩm</a>
            <a href="#" class="block p-3 hover:bg-stone-800 rounded-lg transition-all"><i class="fa-solid fa-users mr-2"></i> Người dùng</a>
            <a href="logout" class="block p-3 hover:bg-red-900 rounded-lg transition-all mt-20"><i class="fa-solid fa-right-from-bracket mr-2"></i> Đăng xuất</a>
        </nav>
    </div>

    <div class="flex-1 p-10">
        <header class="flex justify-between items-center mb-8">
            <h2 class="text-3xl font-bold text-gray-800">Quản Lý Đơn Hàng</h2>
            <div class="flex items-center space-x-4">
                <span class="text-gray-600">Chào Admin, <b>${sessionScope.account.fullName}</b></span>
                <div class="w-10 h-10 bg-orange-500 rounded-full flex items-center justify-center text-white font-bold">A</div>
            </div>
        </header>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-10">
            <div class="bg-white p-6 rounded-2xl shadow-sm border-l-4 border-orange-500">
                <p class="text-gray-500 text-sm">Tổng đơn hàng</p>
                <h3 class="text-2xl font-bold">${allOrders.size()} đơn</h3>
            </div>
            <div class="bg-white p-6 rounded-2xl shadow-sm border-l-4 border-green-500">
                <p class="text-gray-500 text-sm">Tổng doanh thu</p>
                <h3 class="text-2xl font-bold text-green-600">
                    <fmt:formatNumber value="${totalRevenue}" type="number"/> VNĐ
                </h3>
            </div>
            <div class="bg-white p-6 rounded-2xl shadow-sm border-l-4 border-blue-500">
                <p class="text-gray-500 text-sm">Trạng thái hệ thống</p>
                <h3 class="text-2xl font-bold text-blue-500">Ổn định</h3>
            </div>
        </div>

        <div class="bg-white rounded-2xl shadow-sm overflow-hidden">
            <table class="w-full text-left">
                <thead class="bg-gray-50 border-b">
                    <tr>
                        <th class="p-4 font-semibold text-gray-700">Mã Đơn</th>
                        <th class="p-4 font-semibold text-gray-700">Ngày Đặt</th>
                        <th class="p-4 font-semibold text-gray-700">Khách Hàng</th>
                        <th class="p-4 font-semibold text-gray-700">Địa Chỉ</th>
                        <th class="p-4 font-semibold text-gray-700 text-right">Tổng Tiền</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-100">
                    <c:forEach var="o" items="${allOrders}">
                        <tr class="hover:bg-gray-50 transition-colors">
                            <td class="p-4 font-bold text-stone-800">${o.orderCode}</td>
                            <td class="p-4 text-gray-600"><fmt:formatDate value="${o.date}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td class="p-4">
                                <p class="font-medium">${o.customerName}</p>
                                <p class="text-xs text-gray-400">${o.phone}</p>
                            </td>
                            <td class="p-4 text-gray-600 text-sm max-w-xs truncate">${o.address}</td>
                            <td class="p-4 text-right font-bold text-orange-600">
                                <fmt:formatNumber value="${o.totalMoney}" type="number"/> VNĐ
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>