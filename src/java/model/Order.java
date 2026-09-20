package model;

import java.util.Date;

public class Order {
    private int id;
    private Integer userId; // Dùng Integer để có thể nhận giá trị null nếu khách chưa đăng nhập
    private Date date;
    private String customerName;
    private String phone;
    private String address;
    private double totalMoney;
    private String orderCode; // === THUỘC TÍNH MỚI: Lưu mã đơn hàng kiểu Shopee ===

    // 1. Hàm khởi tạo không tham số (Constructor mặc định)
    public Order() {
    }

    // 2. Hàm khởi tạo đầy đủ tham số (Đã cập nhật thêm orderCode)
    public Order(int id, Integer userId, Date date, String customerName, String phone, String address, double totalMoney, String orderCode) {
        this.id = id;
        this.userId = userId;
        this.date = date;
        this.customerName = customerName;
        this.phone = phone;
        this.address = address;
        this.totalMoney = totalMoney;
        this.orderCode = orderCode;
    }

    // 3. Các hàm Getter và Setter để đọc/ghi dữ liệu
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public double getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(double totalMoney) {
        this.totalMoney = totalMoney;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    // 4. Hàm toString() dùng để in kiểm tra dữ liệu ra Console khi test hệ thống
    @Override
    public String toString() {
        return "Order{" + "id=" + id + ", userId=" + userId + ", date=" + date + ", customerName=" + customerName + ", phone=" + phone + ", address=" + address + ", totalMoney=" + totalMoney + ", orderCode=" + orderCode + '}';
    }
}