<%-- 
    Document   : Login
    Created on : Jun 14, 2026, 10:43:22 PM
    Author     : phatm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/stylecss.css">
</head>
<body>
    <div style="width: 300px; margin: 50px auto;" class="card shadow-sm p-4 auth-card">
        
        <h2>ĐĂNG NHẬP</h2>
        <p style="color: red;">${error}</p>
        
        <form action="login" method="POST">
            Tên đăng nhập: <input type="text" name="user" class="form-control" required><br>
            Mật khẩu: <input type="password" name="pass" class="form-control" required><br>
            <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
        </form>
        
        <p style="margin-top: 15px;">Chưa có tài khoản? <a href="register">Đăng ký ngay tại đây</a></p>
    </div>
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>
