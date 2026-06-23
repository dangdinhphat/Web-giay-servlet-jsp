##KICKZONE-WEB BÁN GIÀY THỂ THAO 
##DỰ ÁN WEB ĐƯỢC XÂY DỰNG BỞI THEO CẤU TRÚC MVC SỬ DỤNG JAVA SERVLET JSP VÀ DATABASE
##Công nghệ sử dụng

* **Backend**: Java Servlet, JSP, JDBC (kiến trúc MVC).
* **Frontend:** CSS (TailwindCSS), JavaScript.
* **Database:** Microsoft SQL Server.
* **Server/IDE:** Apache Tomcat Server, NetBeans IDE.
## Hướng dẫn cài đặt và chạy dự án

Để chạy dự án này trên máy cục bộ (Localhost), vui lòng làm theo các bước sau:

### 1. Chuẩn bị Cơ sở dữ liệu
* Mở **SQL Server Management Studio (SSMS)**.
* Tạo một database mới tên là `giay`.
* Mở và chạy toàn bộ nội dung file script tại đường dẫn: `web/database/database.sql` để khởi tạo cấu trúc bảng và dữ liệu mẫu.

### 2. Cấu hình dự án trên NetBeans
* Mở **NetBeans IDE** và Import dự án vào.
* Tìm đến file kết nối cơ sở dữ liệu (thường nằm trong package `dal` hoặc `context`).
* Chỉnh sửa lại cấu hình `user` và `password` của SQL Server cho đúng với máy của bạn:
```java
  private final String userID = "sa";
  private final String password = "your_password_here";
