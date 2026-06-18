<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Quản Lý Sản Phẩm</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-gray-100 flex">
    
    <div class="w-64 min-h-screen bg-stone-900 text-white p-6">
        <h1 class="text-2xl font-bold mb-10 text-orange-500">KICKSZONE ADMIN</h1>
        <nav class="space-y-4">
            <a href="admin-dashboard" class="block p-3 hover:bg-stone-800 rounded-lg transition-all"><i class="fa-solid fa-cart-shopping mr-2"></i> Đơn hàng</a>
            <a href="admin-product" class="block p-3 bg-stone-800 rounded-lg text-orange-400"><i class="fa-solid fa-box mr-2"></i> Sản phẩm</a>
            <a href="#" class="block p-3 hover:bg-stone-800 rounded-lg transition-all"><i class="fa-solid fa-users mr-2"></i> Người dùng</a>
            <a href="logout" class="block p-3 hover:bg-red-900 rounded-lg transition-all mt-20"><i class="fa-solid fa-right-from-bracket mr-2"></i> Đăng xuất</a>
        </nav>
    </div>

    <div class="flex-1 p-10">
        <header class="flex justify-between items-center mb-8">
            <h2 class="text-3xl font-bold text-gray-800">Quản Lý Sản Phẩm</h2>
            <button onclick="openAddModal()" class="bg-orange-500 hover:bg-orange-600 text-white font-semibold px-5 py-2.5 rounded-xl shadow-sm transition-all">
                <a href="AdminProductServlet?action=add" class="bg-orange-500">+ Thêm sản phẩm mới</a>
            </button>
        </header>

        <div class="bg-white rounded-2xl shadow-sm overflow-hidden">
            <table class="w-full text-left">
                <thead class="bg-gray-50 border-b">
                    <tr>
                        <th class="p-4 font-semibold text-gray-700 w-20">Ảnh</th>
                        <th class="p-4 font-semibold text-gray-700">Tên Sản Phẩm</th>
                        <th class="p-4 font-semibold text-gray-700">Danh Mục/Mô Tả</th>
                        <th class="p-4 font-semibold text-gray-700">Giá Bán</th>
                        <th class="p-4 font-semibold text-gray-700 text-center">Hành Động</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-100">
                    <c:forEach var="p" items="${productList}">
                        <tr class="hover:bg-gray-50 transition-colors">
                            <td class="p-4">
                                <img src="${p.imageUrl}" class="w-16 h-16 object-cover rounded-lg border">
                            </td>
                            <td class="p-4 font-bold text-stone-800">${p.name}</td>
                            <td class="p-4 text-gray-500 text-sm max-w-xs truncate">${p.description}</td>
                            <td class="p-4 font-bold text-orange-600">
                                <fmt:formatNumber value="${p.price}" type="number"/> VNĐ
                            </td>
                            <td class="p-4 text-center space-x-2">
                                <<a href="AdminProductServlet?action=edit&id=${p.id}" class="text-blue-600"> Sửa </a>
                                <a href="delete-product?id=${p.id}" onclick="return confirm('Bạn có chắc chắn muốn xóa đôi giày này không?')" class="text-red-500 hover:text-red-700 p-2">
                                    <i class="fa-solid fa-trash-can"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>