<%-- 
    Document   : register
    Created on : Jun 14, 2026, 10:36:20 PM
    Author     : phatm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>Đăng ký</title></head>
<body>
    <div style="width: 300px; margin: 50px auto;">
        <h2>ĐĂNG KÝ TÀI KHOẢN</h2>
        <p style="color: red;">${error}</p> <form action="RegisterServlet" method="POST">
            Tên đăng nhập: <input type="text" name="user" required><br><br>
            Mật khẩu: <input type="password" name="pass" required><br><br>
            Họ và tên: <input type="text" name="name" required><br><br>
            Email: <input type="email" name="email" required><br><br>
            <button type="submit">Đăng ký</button>
        </form>
    </div>
</body>
</html>
