package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    // 1. Khai báo biến connection ở đây để các lớp DAO con kế thừa sử dụng
    protected Connection connection;

    // 2. Hàm khởi tạo (Constructor) tự động kết nối Database khi tạo DAO
    public DBContext() {
        try {
            String url = "jdbc:sqlserver://localhost:1433;databaseName=giay;encrypt=true;trustServerCertificate=true;";
            String username = "sa";
            String password = "123"; 
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            
            // Gán kết nối vào biến connection
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("❌ KẾT NỐI THẤT BẠI. LỖI LÀ: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Giữ lại hàm cũ của bạn nếu cần dùng ở nơi khác
    public Connection getConnection() throws Exception {
        return connection;
    }

    public static void main(String[] args) {
        DBContext db = new DBContext();
        if (db.connection != null) {
            System.out.println("✔️ KẾT NỐI DATABASE THÀNH CÔNG RỒI BẠN ƠI!");
        }
    }
}