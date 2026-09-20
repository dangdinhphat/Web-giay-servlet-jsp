<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin - Quản lý sản phẩm</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-gray-100 flex min-h-screen">
    <aside class="w-64 bg-stone-900 text-white p-6">
        <h1 class="text-2xl font-bold mb-10 text-orange-500">KICKSZONE ADMIN</h1>
        <nav class="space-y-4">
            <a href="admin-dashboard" class="block p-3 hover:bg-stone-800 rounded-lg transition-all">
                <i class="fa-solid fa-cart-shopping mr-2"></i> Đơn hàng
            </a>
            <a href="admin-product?action=list" class="block p-3 bg-stone-800 rounded-lg text-orange-400">
                <i class="fa-solid fa-box mr-2"></i> Sản phẩm
            </a>
            <a href="#" class="block p-3 hover:bg-stone-800 rounded-lg transition-all">
                <i class="fa-solid fa-users mr-2"></i> Người dùng
            </a>
            <a href="logout" class="block p-3 hover:bg-red-900 rounded-lg transition-all mt-20">
                <i class="fa-solid fa-right-from-bracket mr-2"></i> Đăng xuất
            </a>
        </nav>
    </aside>

    <main class="flex-1 p-10">
        <header class="flex justify-between items-center mb-8">
            <div>
                <h2 class="text-3xl font-bold text-gray-800">Quản lý sản phẩm</h2>
                <p class="text-sm text-gray-500 mt-1">Thêm, xem, sửa và xóa sản phẩm trong shop.</p>
            </div>
            <a href="admin-product?action=add" class="bg-orange-500 hover:bg-orange-600 text-white font-semibold px-5 py-2.5 rounded-lg shadow-sm transition-all">
                <i class="fa-solid fa-plus mr-2"></i> Thêm sản phẩm
            </a>
        </header>

        <c:if test="${not empty param.success}">
            <div class="mb-5 rounded-lg border border-green-200 bg-green-50 px-4 py-3 text-green-700">
                Thao tác sản phẩm đã được xử lý thành công.
            </div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="mb-5 rounded-lg border border-red-200 bg-red-50 px-4 py-3 text-red-700">
                Không thể xử lý yêu cầu. Vui lòng kiểm tra lại dữ liệu.
            </div>
        </c:if>

        <section class="bg-white rounded-lg shadow-sm overflow-hidden border border-gray-100">
            <table class="w-full text-left">
                <thead class="bg-gray-50 border-b">
                    <tr>
                        <th class="p-4 font-semibold text-gray-700 w-20">Ảnh</th>
                        <th class="p-4 font-semibold text-gray-700">Tên sản phẩm</th>
                        <th class="p-4 font-semibold text-gray-700">Mô tả</th>
                        <th class="p-4 font-semibold text-gray-700">Trạng thái</th>
                        <th class="p-4 font-semibold text-gray-700">Giá bán</th>
                        <th class="p-4 font-semibold text-gray-700 text-center w-44">Hành động</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-100">
                    <c:forEach var="p" items="${productList}">
                        <tr class="hover:bg-gray-50 transition-colors">
                            <td class="p-4">
                                <c:choose>
                                    <c:when test="${not empty p.imageUrl}">
                                        <img src="${p.imageUrl}" alt="${p.name}" class="w-16 h-16 object-cover rounded-lg border">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="w-16 h-16 rounded-lg border bg-gray-100 flex items-center justify-center text-gray-400 text-xs">
                                            No image
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="p-4 font-bold text-stone-800">${p.name}</td>
                            <td class="p-4 text-gray-500 text-sm max-w-xs truncate">${p.description}</td>
                            <td class="p-4">
                                <span class="inline-flex rounded-full bg-stone-100 px-3 py-1 text-xs font-semibold text-stone-700">
                                    ${p.status}
                                </span>
                            </td>
                            <td class="p-4 font-bold text-orange-600">
                                <fmt:formatNumber value="${p.price}" type="number"/> VNĐ
                            </td>
                            <td class="p-4">
                                <div class="flex items-center justify-center gap-2">
                                    <a href="admin-product?action=edit&id=${p.id}" class="inline-flex items-center rounded-lg bg-blue-50 px-3 py-2 text-sm font-semibold text-blue-700 hover:bg-blue-100">
                                        <i class="fa-solid fa-pen-to-square mr-1"></i> Sửa
                                    </a>
                                    <form action="admin-product" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này không?');">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${p.id}">
                                        <button type="submit" class="inline-flex items-center rounded-lg bg-red-50 px-3 py-2 text-sm font-semibold text-red-600 hover:bg-red-100">
                                            <i class="fa-solid fa-trash-can mr-1"></i> Xóa
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty productList}">
                        <tr>
                            <td colspan="6" class="p-8 text-center text-gray-500">Chưa có sản phẩm nào.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </section>
    </main>
</body>
</html>
