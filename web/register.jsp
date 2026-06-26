<%-- 
    Document   : register
    Created on : Jun 14, 2026, 10:36:20 PM
    Author     : phatm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/stylecss.css">
</head>
<body>
    <div class="register d-flex align-items-center justify-content-center vh-100">
        <div style="width: 300px; margin: 50px auto;" class="card shadow-sm p-4">
            <h3>ĐĂNG KÝ TÀI KHOẢN</h3>
            <p style="color: red;">${error}</p> 
            <form action="RegisterServlet" method="POST">
                Tên Đăng Nhập: <input type="text" name="user"  class="form-control" required>
                Mật Khẩu: <input type="password" name="pass"  class="form-control" required>
                Họ Và Tên: <input type="text" name="name"  class="form-control" required>
                Email: <input type="email" name="email"  class="form-control" required><br>
                <button type="submit" class="btn btn-primary w-100">Đăng ký</button>
            </form>
        </div>
    </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>
