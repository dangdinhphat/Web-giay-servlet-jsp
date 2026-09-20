<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lịch Sử Mua Hàng</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 p-6 md:p-12">
    <div class="max-w-5xl mx-auto bg-white p-8 rounded-2xl shadow-sm">
        <div class="flex justify-between items-center mb-8 border-b pb-4">
            <h2 class="text-2xl font-bold text-stone-800">🛍️ LỊCH SỬ ĐẶT HÀNG CỦA BẠN</h2>
            <a href="ProductServlet" class="text-sm text-orange-600 hover:underline">Quay lại cửa hàng</a>
        </div>
        
        <c:choose>
            <%-- Trường hợp chưa có đơn hàng nào --%>
            <c:when test="${empty historyData}">
                <div class="text-center py-12 text-gray-400">
                    <p class="text-lg mb-4">Bạn chưa đặt mua đơn hàng nào.</p>
                    <a href="ProductServlet" class="px-6 py-2 bg-stone-950 text-white rounded-xl inline-block">Mua sắm ngay</a>
                </div>
            </c:when>
            
            <%-- Trường hợp có đơn hàng -> Vẽ bảng ra --%>
            <c:otherwise>
                <div class="overflow-x-auto">
                    <table class="w-full text-left border-collapse">
                        <thead>
                            <tr class="bg-stone-100 text-stone-700 font-semibold uppercase text-sm border-b">
                                <th class="p-4">Mã Đơn</th>
                                <th class="p-4">Ngày Đặt</th>
                                <th class="p-4">Người Nhận</th>
                                <th class="p-4">Địa Chỉ</th>
                                <th class="p-4 text-right">Tổng Tiền</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100 text-gray-700">
                            <c:forEach var="order" items="${historyData}">
                                <tr class="hover:bg-gray-50/70 transition-colors">
                                    <td class="p-4 font-bold text-stone-900">#${order.orderCode}</td>
                                    <td class="p-4"><fmt:formatDate value="${order.date}" pattern="dd/MM/yyyy"/></td>
                                    <td class="p-4">
                                        <p class="font-medium">${order.customerName}</p>
                                        <p class="text-xs text-gray-400">${order.phone}</p>
                                    </td>
                                    <td class="p-4 max-w-xs truncate">${order.address}</td>
                                    <td class="p-4 text-right font-semibold text-orange-600">
                                        <fmt:formatNumber value="${order.totalMoney}" type="number"/> VNĐ
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>