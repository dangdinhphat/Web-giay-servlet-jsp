<%-- 
    Document   : add-product
    Created on : Jun 19, 2026, 12:14:00 AM
    Author     : phatm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>KICKSZONE - Thêm sản phẩm mới</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body class="bg-gray-100 font-sans antialiased">

        <div class="flex min-h-screen">
            <div class="w-64 bg-stone-900 text-white flex flex-col justify-between p-6">
                <div>
                    <div class="text-orange-500 font-black text-2xl tracking-wider mb-8 uppercase">
                        KicksZone Admin
                    </div>
                    <nav class="space-y-4">
                        <a href="#" class="flex items-center space-x-3 text-gray-400 hover:text-white transition-colors p-3 rounded-lg">
                            <i class="fa-solid fa-cart-shopping"></i>
                            <span>Đơn hàng</span>
                        </a>
                        <a href="AdminProductServlet?action=list" class="flex items-center space-x-3 text-white bg-stone-800 p-3 rounded-lg font-semibold">
                            <i class="fa-solid fa-box"></i>
                            <span>Sản phẩm</span>
                        </a>
                        <a href="#" class="flex items-center space-x-3 text-gray-400 hover:text-white transition-colors p-3 rounded-lg">
                            <i class="fa-solid fa-users"></i>
                            <span>Người dùng</span>
                        </a>
                    </nav>
                </div>
                <div>
                    <a href="LogoutServlet" class="flex items-center space-x-3 text-gray-400 hover:text-red-400 transition-colors p-3 rounded-lg">
                        <i class="fa-solid fa-arrow-right-from-bracket"></i>
                        <span>Đăng xuất</span>
                    </a>
                </div>
            </div>

            <div class="flex-1 p-10">
                <div class="flex justify-between items-center mb-8">
                    <h1 class="text-3xl font-bold text-stone-800">Thêm sản phẩm mới</h1>
                    <a href="AdminProductServlet?action=list" class="flex items-center space-x-2 text-stone-600 hover:text-stone-900 bg-white px-4 py-2 rounded-lg border shadow-sm text-sm font-medium transition-all">
                        <i class="fa-solid fa-arrow-left"></i>
                        <span>Quay lại danh sách</span>
                    </a>
                </div>

                <div class="bg-white rounded-xl shadow-sm border p-8 max-w-3xl">
                    <form action="AdminProductServlet" method="POST" class="space-y-6">
                        <input type="hidden" name="action" value="insert">

                        <div>
                            <label class="block text-sm font-semibold text-stone-700 mb-2">Tên sản phẩm / Giày</label>
                            <input type="text" name="name" required placeholder="Ví dụ: Nike Air Max 90 Trắng Cam" 
                                   class="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-orange-500 focus:border-orange-500 outline-none transition-all">
                        </div>

                        <div class="grid grid-cols-2 gap-6">
                            <div>
                                <label class="block text-sm font-semibold text-stone-700 mb-2">Giá bán (VNĐ)</label>
                                <input type="number" name="price" required min="0" placeholder="Ví dụ: 2450000" 
                                       class="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-orange-500 focus:border-orange-500 outline-none transition-all">
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-stone-700 mb-2">Trạng thái bán</label>
                                <select name="status" class="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-orange-500 focus:border-orange-500 outline-none transition-all bg-white">
                                    <option value="Active">Còn hàng (Active)</option>
                                    <option value="Inactive">Hết hàng (Inactive)</option>
                                </select>
                            </div>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-stone-700 mb-2">Tên file ảnh sản phẩm</label>
                            <input type="text" name="image" required placeholder="Ví dụ: nike-af1.jpg" 
                                   class="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-orange-500 focus:border-orange-500 outline-none transition-all">
                            <p class="text-xs text-gray-400 mt-1.5">Lưu ý: Hãy đảm bảo file ảnh này đã có sẵn trong thư mục images/ của dự án.</p>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-stone-700 mb-2">Mô tả chi tiết</label>
                            <textarea name="description" rows="4" placeholder="Nhập đặc điểm nổi bật, chất liệu, phong cách của giày..." 
                                      class="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-orange-500 focus:border-orange-500 outline-none transition-all"></textarea>
                        </div>

                        <div class="flex justify-end space-x-4 pt-4 border-t">
                            <button type="reset" class="px-5 py-2.5 rounded-lg border border-gray-300 text-stone-600 font-medium hover:bg-gray-50 transition-colors">
                                Nhập lại
                            </button>
                            <button type="submit" class="px-6 py-2.5 rounded-lg bg-orange-500 text-white font-semibold hover:bg-orange-600 shadow-sm transition-colors">
                                Lưu sản phẩm
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </body>
</html>
