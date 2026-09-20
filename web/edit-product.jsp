<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>KICKSZONE - Sửa sản phẩm</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body class="bg-gray-100 font-sans antialiased">
        <div class="flex min-h-screen">
            <aside class="w-64 bg-stone-900 text-white flex flex-col justify-between p-6">
                <div>
                    <div class="text-orange-500 font-black text-2xl tracking-wider mb-8 uppercase">
                        KicksZone Admin
                    </div>
                    <nav class="space-y-4">
                        <a href="admin-dashboard" class="flex items-center space-x-3 text-gray-400 hover:text-white transition-colors p-3 rounded-lg">
                            <i class="fa-solid fa-cart-shopping"></i>
                            <span>Đơn hàng</span>
                        </a>
                        <a href="admin-product?action=list" class="flex items-center space-x-3 text-white bg-stone-800 p-3 rounded-lg font-semibold">
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
                    <a href="logout" class="flex items-center space-x-3 text-gray-400 hover:text-red-400 transition-colors p-3 rounded-lg">
                        <i class="fa-solid fa-arrow-right-from-bracket"></i>
                        <span>Đăng xuất</span>
                    </a>
                </div>
            </aside>

            <main class="flex-1 p-10">
                <div class="flex justify-between items-center mb-8">
                    <h1 class="text-3xl font-bold text-stone-800">Sửa sản phẩm</h1>
                    <a href="admin-product?action=list" class="flex items-center space-x-2 text-stone-600 hover:text-stone-900 bg-white px-4 py-2 rounded-lg border shadow-sm text-sm font-medium transition-all">
                        <i class="fa-solid fa-arrow-left"></i>
                        <span>Quay lại danh sách</span>
                    </a>
                </div>

                <section class="bg-white rounded-lg shadow-sm border p-8 max-w-3xl">
                    <form action="admin-product" method="POST" class="space-y-6">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="${product.id}">

                        <div>
                            <label class="block text-sm font-semibold text-stone-700 mb-2">Tên sản phẩm</label>
                            <input type="text" name="name" required value="${product.name}"
                                   class="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-orange-500 focus:border-orange-500 outline-none transition-all">
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                            <div>
                                <label class="block text-sm font-semibold text-stone-700 mb-2">Giá bán (VND)</label>
                                <input type="number" name="price" required min="0" step="1000" value="${product.price}"
                                       class="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-orange-500 focus:border-orange-500 outline-none transition-all">
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-stone-700 mb-2">Trạng thái</label>
                                <select id="status" name="status" class="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-orange-500 focus:border-orange-500 outline-none transition-all bg-white">
                                    <option value="available">Còn hàng</option>
                                    <option value="Active">Còn hàng (Active)</option>
                                    <option value="Inactive">Hết hàng</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-stone-700 mb-2">Thương hiệu</label>
                                <select id="brandId" name="brandId" required class="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-orange-500 focus:border-orange-500 outline-none transition-all bg-white">
                                    <option value="1">Nike</option>
                                    <option value="2">Adidas</option>
                                    <option value="3">Puma</option>
                                </select>
                            </div>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-stone-700 mb-2">Ảnh sản phẩm</label>
                            <input type="text" name="image" value="${product.imageUrl}" placeholder="Ví dụ: images/adidas-ultraboost.jpg"
                                   class="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-orange-500 focus:border-orange-500 outline-none transition-all">
                            <p class="text-xs text-gray-400 mt-1.5">Có thể nhập tên file trong thư mục images hoặc đường dẫn đầy đủ bắt đầu bằng images/.</p>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-stone-700 mb-2">Mô tả chi tiết</label>
                            <textarea name="description" rows="4"
                                      class="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-orange-500 focus:border-orange-500 outline-none transition-all">${product.description}</textarea>
                        </div>

                        <div class="flex justify-end gap-4 pt-4 border-t">
                            <a href="admin-product?action=list" class="px-5 py-2.5 rounded-lg border border-gray-300 text-stone-600 font-medium hover:bg-gray-50 transition-colors">
                                Hủy
                            </a>
                            <button type="submit" class="px-6 py-2.5 rounded-lg bg-orange-500 text-white font-semibold hover:bg-orange-600 shadow-sm transition-colors">
                                Cập nhật sản phẩm
                            </button>
                        </div>
                    </form>
                </section>
            </main>
        </div>

        <script>
            const brandSelect = document.getElementById('brandId');
            brandSelect.value = '${product.brandId}';
            if (!brandSelect.value) {
                brandSelect.value = '1';
            }

            const statusSelect = document.getElementById('status');
            statusSelect.value = '${product.status}';
            if (!statusSelect.value) {
                statusSelect.value = 'available';
            }
        </script>
    </body>
</html>
