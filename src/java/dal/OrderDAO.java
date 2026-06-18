package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Map;
import model.CartItem;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;


public class OrderDAO {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public void addOrder(Integer userId, String name, String phone, String address, double totalMoney, Map<Integer, CartItem> cart) {
    try {
        // Gọi hàm sinh mã kiểu Shopee vừa viết ở Bước 2
        String orderCode = generateShopeeOrderCode(); 
        
        conn = new DBContext().getConnection();
        conn.setAutoCommit(false);
        
        // CẬP NHẬT SQL: Thêm cột order_code và thêm dấu hỏi chấm vào VALUE
        String sqlOrder = "INSERT INTO dbo.orders (user_id, date, customer_name, phone, address, total_money, order_code) VALUES (?, GETDATE(), ?, ?, ?, ?, ?)";
        ps = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
        
        if (userId != null) {
            ps.setInt(1, userId);
        } else {
            ps.setNull(1, java.sql.Types.INTEGER);
        }
        ps.setString(2, name);
        ps.setString(3, phone);
        ps.setString(4, address);
        ps.setDouble(5, totalMoney);
        ps.setString(6, orderCode); // Nạp mã Shopee vào vị trí số 6
        
        ps.executeUpdate();
        
        // ... Các đoạn code xử lý lưu bảng order_line ở bên dưới giữ nguyên 100% ...
            
            // Lấy ID tự động tăng của đơn hàng vừa tạo
            rs = ps.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }
            
            // 2. Chèn dữ liệu danh sách sản phẩm vào bảng order_line
            String sqlLine = "INSERT INTO order_line (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
            PreparedStatement psLine = conn.prepareStatement(sqlLine);
            
            for (Map.Entry<Integer, CartItem> entry : cart.entrySet()) {
                CartItem item = entry.getValue();
                psLine.setInt(1, orderId);
                psLine.setInt(2, item.getProduct().getId());
                psLine.setInt(3, item.getQuantity());
                psLine.setDouble(4, item.getProduct().getPrice());
                psLine.addBatch(); // Gom lệnh lại để thực thi một lần
            }
            psLine.executeBatch();
            
            // Đồng ý lưu tất cả thay đổi vào DB
            conn.commit();
            
        } catch (Exception e) {
            System.out.println("Lỗi addOrder: " + e.getMessage());
            try {
                if (conn != null) conn.rollback(); // Hoàn tác nếu xảy ra lỗi
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    
    // Bạn cần import thêm java.util.ArrayList và java.util.List nếu chưa có
public List<model.Order> getOrdersByUserId(int userId) {
        List<model.Order> list = new ArrayList<>();
        // Sửa SQL: SELECT thêm cột order_code
        String sql = "SELECT id, date, customer_name, phone, address, total_money, order_code FROM dbo.orders WHERE user_id = ? ORDER BY id DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                model.Order o = new model.Order();
                o.setId(rs.getInt("id"));
                o.setDate(rs.getDate("date"));
                o.setCustomerName(rs.getString("customer_name"));
                o.setPhone(rs.getString("phone"));
                o.setAddress(rs.getString("address"));
                o.setTotalMoney(rs.getDouble("total_money"));

                // GÁN THÊM GIÁ TRỊ ORDER_CODE VÀO ĐỐI TƯỢNG ORDER
                o.setOrderCode(rs.getString("order_code"));

                list.add(o);
            }
        } catch (Exception e) {
            System.out.println("Lỗi getOrdersByUserId: " + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }


    private String generateShopeeOrderCode() {
        // 1. Lấy ngày tháng năm hiện tại (Ví dụ: ngày 17/06/2026 -> 260617)
        SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");
        String dateStr = sdf.format(new Date());

        // 2. Định nghĩa danh sách các ký tự dùng để sinh ngẫu nhiên (chữ in hoa và số)
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuilder randomStr = new StringBuilder();
        Random rd = new Random();

        // Sinh ngẫu nhiên chuỗi gồm 4 ký tự
        for (int i = 0; i < 4; i++) {
            int index = rd.nextInt(characters.length());
            randomStr.append(characters.charAt(index));
        }

        // 3. Kết hợp lại thành mã: HD + 260617 + X8A9 = HD260617X8A9
        return "HD" + dateStr + randomStr.toString();
    }
    
    
    public List<model.Order> getAllOrders() {
        List<model.Order> list = new ArrayList<>();
        // Lấy toàn bộ đơn hàng, đơn mới nhất xếp lên đầu
        String sql = "SELECT id, order_code, date, customer_name, phone, address, total_money FROM dbo.orders ORDER BY id DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                model.Order o = new model.Order();
                o.setId(rs.getInt("id"));
                o.setOrderCode(rs.getString("order_code")); // Đảm bảo lấy mã kiểu Shopee đã làm
                o.setDate(rs.getDate("date"));
                o.setCustomerName(rs.getString("customer_name"));
                o.setPhone(rs.getString("phone"));
                o.setAddress(rs.getString("address"));
                o.setTotalMoney(rs.getDouble("total_money"));
                list.add(o);
            }
        } catch (Exception e) {
            System.out.println("Lỗi getAllOrders: " + e.getMessage());
        } finally {
            // ... (tự đóng ps, rs, conn giống các hàm trước) ...
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }



}