<%-- 
    Document   : Login
    Created on : Jun 14, 2026, 10:43:22 PM
    Author     : phatm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>Đăng nhập</title></head>
<body>
    <div style="width: 300px; margin: 50px auto;">
        <h2>ĐĂNG NHẬP</h2>
        <p style="color: red;">${error}</p>
        
        <form action="login" method="POST">
            Tên đăng nhập: <input type="text" name="user" required><br><br>
            Mật khẩu: <input type="password" name="pass" required><br><br>
            <button type="submit">Đăng nhập</button>
        </form>
        
        <p style="margin-top: 15px;">Chưa có tài khoản? <a href="register">Đăng ký ngay tại đây</a></p>
    </div>
</body>
</html>
