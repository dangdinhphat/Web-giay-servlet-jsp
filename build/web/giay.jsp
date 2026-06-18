<%-- 
    Document   : giay
    Created on : Jun 2, 2026, 10:48:37 PM
    Author     : phatm
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cửa Hàng Giày Sneaker Toàn Quốc</title>
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap');
            body {
                font-family: 'Plus Jakarta Sans', sans-serif;
            }
        </style>
        <link rel="stylesheet" type="text/css" href="css/stylecss.css">
    </head>
    <body class="bg-stone-50 text-stone-800 antialiased min-h-screen flex flex-col">

        <header class="sticky top-0 z-40 bg-white/80 backdrop-blur-md border-b border-stone-200/80 transition-all">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-20 flex items-center justify-between gap-4">
                <div class="flex items-center gap-3 select-none shrink-0">
                    <div class="w-10 h-10 bg-orange-600 rounded-xl flex items-center justify-center shadow-lg shadow-orange-600/30">
                        <i class="fa-solid fa-bolt text-white text-lg"></i>
                    </div>
                    <span class="text-xl font-black tracking-tighter text-stone-900">KICKS<span class="text-orange-600">ZONE</span></span>
                </div>

                <div class="hidden md:flex flex-1 max-w-md mx-8">
                    <form action="search" method="get" class="flex items-center gap-2">

                        <input type="text" 
                               name="searchQuery" 
                               value="${txtSearchValue}" 
                               placeholder="Tìm kiếm giày..." 
                               class="px-4 py-2 border rounded-xl outline-none w-64 text-sm" />

                        <button type="submit" class="px-4 py-2 bg-stone-900 text-white rounded-xl text-sm hover:bg-orange-600 transition-colors">
                            <i class="fa-solid fa-magnifying-glass"></i> Tìm
                        </button>

                    </form>
                </div>

                <div class="flex items-center gap-4">
                    <c:choose>
                        <%-- Trường hợp 1: Thành viên đã đăng nhập thành công --%>
                        <c:when test="${not empty sessionScope.account}">
                            <div class="flex items-center gap-2">
                                <span class="text-sm font-medium text-stone-600">Chào, ${sessionScope.account.fullName}</span>
                                <a href="logout" class="text-xs text-red-500 hover:underline">Đăng xuất</a>
                                <a href="order-history" class="hover:text-orange-600 mx-3">Lịch sử mua hàng</a>
                            </div>
                        </c:when>

                        <%-- Trường hợp 2: Khách vãng lai chưa đăng nhập --%>
                        <c:otherwise>
                            <a href="login" class="text-sm font-semibold hover:text-orange-600 transition">Đăng nhập</a>
                        </c:otherwise>
                    </c:choose>

                    <button onclick="toggleCart()" class="relative p-2.5 bg-stone-100 hover:bg-orange-50 hover:text-orange-600 rounded-full transition group">
                        <i class="fa-solid fa-bag-shopping text-lg"></i>
                        <span class="absolute -top-1 -right-1 w-5 h-5 bg-orange-600 text-white text-[10px] font-bold rounded-full flex items-center justify-center border-2 border-white">
                            ${not empty sessionScope.cartCount ? sessionScope.cartCount : 0}
                        </span>
                    </button>
                </div>
            </div>
        </header>

        <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10 flex-1 grid grid-cols-1 lg:grid-cols-4 gap-8 w-full">

            <aside class="lg:col-span-1 space-y-6">
                <div class="bg-white p-6 rounded-2xl border border-stone-200 shadow-sm sticky top-28">
                    <div class="flex items-center gap-2.5 pb-4 border-b border-stone-100 mb-5">
                        <i class="fa-solid fa-sliders text-orange-600 text-sm"></i>
                        <h2 class="font-bold text-stone-800 text-base">Bộ lọc tìm kiếm</h2>
                    </div>

                    <div class="space-y-5">
                        <div>
                            <h3 class="text-xs font-bold text-stone-400 uppercase tracking-wider mb-3">Thương hiệu</h3>
                            <div class="space-y-2.5">
                                <label class="flex items-center gap-3 text-sm font-medium text-stone-600 cursor-pointer group">
                                    <input type="checkbox" class="w-4 h-4 rounded border-stone-300 text-orange-600 focus:ring-orange-500/20 cursor-pointer">
                                    <span class="group-hover:text-stone-900 transition">Nike</span>
                                </label>
                                <label class="flex items-center gap-3 text-sm font-medium text-stone-600 cursor-pointer group">
                                    <input type="checkbox" class="w-4 h-4 rounded border-stone-300 text-orange-600 focus:ring-orange-500/20 cursor-pointer">
                                    <span class="group-hover:text-stone-900 transition">Adidas</span>
                                </label>
                                <label class="flex items-center gap-3 text-sm font-medium text-stone-600 cursor-pointer group">
                                    <input type="checkbox" class="w-4 h-4 rounded border-stone-300 text-orange-600 focus:ring-orange-500/20 cursor-pointer">
                                    <span class="group-hover:text-stone-900 transition">Puma</span>
                                </label>
                            </div>
                        </div>

                        <button class="w-full mt-2 py-2.5 bg-stone-900 hover:bg-orange-600 text-white font-semibold text-sm rounded-xl transition duration-300 shadow-sm">
                            Áp dụng bộ lọc
                        </button>
                    </div>
                </div>
            </aside>

            <section class="lg:col-span-3 space-y-6">
                <div class="flex items-center justify-between">
                    <p class="text-sm text-stone-500 font-medium">Hiển thị các mẫu giày mới nhất</p>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6">
                    <c:choose>
                        <%-- Trường hợp TH1: Có sản phẩm truyền xuống từ Servlet --%>
                        <c:when test="${requestScope.dataProduct != null}">
                            <c:forEach var="shoe" items="${requestScope.dataProduct}">
                                <div class="group bg-white rounded-2xl border border-stone-200 shadow-sm hover:shadow-xl hover:border-orange-500/20 transition-all duration-300 flex flex-col overflow-hidden">
                                    <div class="aspect-square bg-stone-100 p-6 flex items-center justify-center relative overflow-hidden">
                                        <a href="product-detail?id=${shoe.id}"><img src="${shoe.imageUrl}" alt="${shoe.name}" class="max-h-full w-full object-contain group-hover:scale-110 transition-transform duration-500"></a>
                                        <span class="absolute top-4 left-4 bg-white/90 backdrop-blur-sm text-stone-800 text-[11px] font-bold px-2.5 py-1 rounded-full shadow-sm">
                                            ${shoe.status}
                                        </span>
                                    </div>
                                    <div class="p-5 flex-1 flex flex-col justify-between">
                                        <div>
                                            <span class="text-[11px] text-orange-600 font-bold tracking-wider uppercase">${shoe.status}</span>
                                            <h3 class="font-bold text-stone-800 group-hover:text-orange-600 line-clamp-1 transition-colors text-base mt-1"><a href="product-detail?id=${shoe.id}" style="text-decoration: none; color: inherit;">${shoe.name}</a></h3>
                                            <p class="text-xs text-stone-400 mt-1 line-clamp-2">${shoe.description}</p>
                                        </div>
                                        <div class="flex items-center justify-between mt-4 pt-3 border-t border-stone-50">
                                            <div>
                                                <span class="block text-xs text-stone-400 font-medium">Giá bán</span>
                                                <span class="text-base font-extrabold text-orange-600">
                                                    <fmt:formatNumber value="${shoe.price}" type="number" maxFractionDigits="0"/>đ
                                                </span>
                                            </div>
                                            <a href="add-to-cart?id=${shoe.id}" class="w-10 h-10 bg-stone-900 hover:bg-orange-600 text-white rounded-xl flex items-center justify-center transition-colors shadow-md">
                                                <i class="fa-solid fa-cart-plus text-sm"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>

                        <%-- Trường hợp TH2: Project chưa chạy DB / Click file tĩnh chạy thử --%>
                        <c:otherwise>
                            <c:forEach var="i" begin="1" end="6">
                                <div class="group bg-white rounded-2xl border border-stone-200 shadow-sm hover:shadow-xl hover:border-orange-500/20 transition-all duration-300 flex flex-col overflow-hidden">
                                    <div class="aspect-square bg-stone-100 p-6 flex items-center justify-center relative overflow-hidden">
                                        <img src="images/nike-trang-cam.png" alt="Giày mẫu" class="max-h-full w-full object-contain group-hover:scale-110 transition-transform duration-500">
                                        <span class="absolute top-4 left-4 bg-white/90 backdrop-blur-sm text-stone-800 text-[11px] font-bold px-2.5 py-1 rounded-full shadow-sm">Nike</span>
                                    </div>
                                    <div class="p-5 flex-1 flex flex-col justify-between">
                                        <div>
                                            <span class="text-[11px] text-orange-600 font-bold tracking-wider uppercase">Nike</span>
                                            <h3 class="font-bold text-stone-800 group-hover:text-orange-600 line-clamp-1 transition-colors text-base mt-1">Nike Air Max 90 Trắng Cam</h3>
                                            <p class="text-xs text-stone-400 mt-1 line-clamp-2">Dòng sản phẩm thể thao chạy bộ cao cấp mẫu 2026.</p>
                                        </div>
                                        <div class="flex items-center justify-between mt-4 pt-3 border-t border-stone-50">
                                            <div>
                                                <span class="block text-xs text-stone-400 font-medium">Giá bán</span>
                                                <span class="text-base font-extrabold text-orange-600">2,450,000đ</span>
                                            </div>
                                            <a href="#" class="w-10 h-10 bg-stone-900 hover:bg-orange-600 text-white rounded-xl flex items-center justify-center transition-colors shadow-md">
                                                <i class="fa-solid fa-cart-plus text-sm"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </section>
        </main>

       <%-- SIDEBAR GIỎ HÀNG --%>
        <div id="cartSidebar" class="fixed top-0 right-0 h-full w-80 bg-white shadow-2xl z-50 transform translate-x-full transition-transform duration-300 border-l border-stone-200 flex flex-col">
            
            <div class="p-4 border-b border-stone-100 flex items-center justify-between">
                <h3 class="font-bold text-stone-800 text-base">Giỏ hàng của bạn</h3>
                <button onclick="toggleCart()" class="text-stone-400 hover:text-stone-600 p-1">
                    <i class="fa-solid fa-xmark text-lg"></i>
                </button>
            </div>

            <div class="p-4 flex-1 overflow-y-auto space-y-4">
                <c:choose>
                    <%-- 1. Kiểm tra xem trong giỏ hàng Session đã có sản phẩm nào chưa --%>
                    <c:when test="${not empty sessionScope.cart}">
                        <%-- Tạo biến tạm để cộng dồn tính tổng tiền tạm tính cho sidebar --%>
                        <c:set var="sidebarTotal" value="0"/>

                        <%-- Vòng lặp duyệt qua toàn bộ sản phẩm đang có giống bên cart.jsp của bạn --%>
                        <c:forEach var="entry" items="${sessionScope.cart}">
                            <c:set var="item" value="${entry.value}"/>
                            <%-- Tính toán cộng dồn tổng tiền: giá x số lượng --%>
                            <c:set var="sidebarTotal" value="${sidebarTotal + (item.product.price * item.quantity)}"/>

                            <div class="flex items-center gap-3 border-b border-stone-100 pb-3">
                                <img src="${item.product.imageUrl}" style="width: 56px; height: 56px; object-fit: cover; border-radius: 4px;"/>

                                <div style="flex: 1;">
                                    <p style="font-weight: 600; font-size: 14px; color: #1f2937; margin: 0; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                                        ${item.product.name}
                                    </p>
                                    <p style="font-size: 12px; color: #9ca3af; margin: 4px 0 0 0;">Số lượng: ${item.quantity}</p>
                                </div>

                                <p style="font-weight: 700; font-size: 14px; color: #ea580c; margin: 0;">
                                    <fmt:formatNumber value="${item.product.price * item.quantity}" type="number"/>đ
                                </p>
                            </div>  
                        </c:forEach>
                    </c:when>

                    <%-- 2. Nếu giỏ hàng trống (chưa mua gì) thì hiển thị trạng thái trống ban đầu --%>
                    <c:otherwise>
                        <div style="padding: 48px 0; color: #9ca3af; font-size: 14px; text-align: center;">
                            Giỏ hàng đang trống!
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="p-4 border-t border-stone-100 bg-stone-50">
                <div class="flex justify-between items-center mb-4">
                    <span class="text-sm text-stone-500">Tổng tiền tạm tính:</span>
                    <span class="font-bold text-lg text-orange-600">
                        <c:choose>
                            <c:when test="${not empty sidebarTotal}">
                                <fmt:formatNumber value="${sidebarTotal}" type="number"/>đ
                            </c:when>
                            <c:otherwise>0đ</c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <a href="thanh-toan.jsp" class="block w-full text-center py-2.5 bg-orange-600 hover:bg-orange-700 text-white font-semibold text-sm rounded-xl transition shadow-sm">
                    Thanh Toán
                </a>
            </div>
        </div>                    
                    
                    
        <footer class="bg-stone-900 text-stone-400 py-8 border-t border-stone-800 text-center text-sm">
            <p>&copy; 2026 KICKSZONE. Hệ thống mô phỏng đồ án Java Web Servlet/JSP.</p>
        </footer>

                    
                    
                    
                    
        <script>
            function toggleCart() {
                const cart = document.getElementById('cartSidebar');
                cart.classList.toggle('translate-x-full');
            }
        </script>
    </body>
</html>