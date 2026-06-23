<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>KICKSZONE - Them san pham moi</title>
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
                            <span>Don hang</span>
                        </a>
                        <a href="AdminProductServlet?action=list" class="flex items-center space-x-3 text-white bg-stone-800 p-3 rounded-lg font-semibold">
                            <i class="fa-solid fa-box"></i>
                            <span>San pham</span>
                        </a>
                        <a href="#" class="flex items-center space-x-3 text-gray-400 hover:text-white transition-colors p-3 rounded-lg">
                            <i class="fa-solid fa-users"></i>
                            <span>Nguoi dung</span>
                        </a>
                    </nav>
                </div>
                <div>
                    <a href="LogoutServlet" class="flex items-center space-x-3 text-gray-400 hover:text-red-400 transition-colors p-3 rounded-lg">
                        <i class="fa-solid fa-arrow-right-from-bracket"></i>
                        <span>Dang xuat</span>
                    </a>
                </div>
            </div>

            <div class="flex-1 p-10">
                <div class="flex justify-between items-center mb-8">
                    <h1 class="text-3xl font-bold text-stone-800">Them san pham moi</h1>
                    <a href="AdminProductServlet?action=list" class="flex items-center space-x-2 text-stone-600 hover:text-stone-900 bg-white px-4 py-2 rounded-lg border shadow-sm text-sm font-medium transition-all">
                        <i class="fa-solid fa-arrow-left"></i>
                        <span>Quay lai danh sach</span>
                    </a>
                </div>

                <div class="bg-white rounded-xl shadow-sm border p-8 max-w-3xl">
                    <form action="AdminProductServlet" method="POST" class="space-y-6">
                        <input type="hidden" name="action" value="insert">

                        <div>
                            <label class="block text-sm font-semibold text-stone-700 mb-2">Ten san pham / Giay</label>
                            <input type="text" name="name" required placeholder="Vi du: Adidas Ultraboost"
                                   class="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-orange-500 focus:border-orange-500 outline-none transition-all">
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                            <div>
                                <label class="block text-sm font-semibold text-stone-700 mb-2">Gia ban (VND)</label>
                                <input type="number" name="price" required min="0" placeholder="2450000"
                                       class="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-orange-500 focus:border-orange-500 outline-none transition-all">
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-stone-700 mb-2">Trang thai ban</label>
                                <select name="status" class="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-orange-500 focus:border-orange-500 outline-none transition-all bg-white">
                                    <option value="Active">Con hang (Active)</option>
                                    <option value="Inactive">Het hang (Inactive)</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-semibold text-stone-700 mb-2">Thuong hieu</label>
                                <select name="brandId" required class="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-orange-500 focus:border-orange-500 outline-none transition-all bg-white">
                                    <option value="1">Nike</option>
                                    <option value="2">Adidas</option>
                                    <option value="3">Puma</option>
                                </select>
                            </div>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-stone-700 mb-2">Ten file anh san pham</label>
                            <input type="text" name="image" required placeholder="Vi du: adidas-ultraboost.jpg"
                                   class="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-orange-500 focus:border-orange-500 outline-none transition-all">
                            <p class="text-xs text-gray-400 mt-1.5">Dat file anh trong thu muc web/images/. He thong se luu thanh duong dan images/ten-file.</p>
                        </div>

                        <div>
                            <label class="block text-sm font-semibold text-stone-700 mb-2">Mo ta chi tiet</label>
                            <textarea name="description" rows="4" placeholder="Nhap dac diem noi bat, chat lieu, phong cach..."
                                      class="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:ring-2 focus:ring-orange-500 focus:border-orange-500 outline-none transition-all"></textarea>
                        </div>

                        <div class="flex justify-end space-x-4 pt-4 border-t">
                            <button type="reset" class="px-5 py-2.5 rounded-lg border border-gray-300 text-stone-600 font-medium hover:bg-gray-50 transition-colors">
                                Nhap lai
                            </button>
                            <button type="submit" class="px-6 py-2.5 rounded-lg bg-orange-500 text-white font-semibold hover:bg-orange-600 shadow-sm transition-colors">
                                Luu san pham
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
