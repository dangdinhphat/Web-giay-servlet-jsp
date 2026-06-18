/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author phatm
 */


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;

public class UserDAO extends DBContext {

    // 1. Dùng khi ĐĂNG NHẬP: Tìm xem có tài khoản nào đúng user và pass không
    public User login(String username, String password) {
        String sql = "SELECT * FROM Users WHERE username = ? AND password = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new User(
                    rs.getInt("id"), rs.getString("username"), rs.getString("password"),
                    rs.getString("fullName"), rs.getString("email"), rs.getString("role") // Lấy cả role lên
                );
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null; 
    }

    // 2. Dùng khi ĐĂNG KÝ: Kiểm tra xem tên tài khoản này đã có ai dùng chưa
    public boolean checkUsernameExist(String username) {
        String sql = "SELECT * FROM Users WHERE username = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) return true;
        } catch (SQLException e) {
            System.out.println("Lỗi checkUsernameExist: " + e.getMessage());
        }
        return false;
    }

    // 3. Dùng khi ĐĂNG KÝ: Chèn tài khoản mới vào SQL
    public boolean register(String username, String password, String fullName, String email) {
        String sql = "INSERT INTO Users (username, password, fullName, email, role) VALUES (?, ?, ?, ?, 'user')";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username); st.setString(2, password);
            st.setString(3, fullName); st.setString(4, email);
            int rows = st.executeUpdate();
            return rows > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }


}