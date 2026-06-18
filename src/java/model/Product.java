package model;

public class Product {
    private int id;
    private String name;
    private String description;
    private double price;
    private String status;
    private String imageUrl; // Trường này để hứng link ảnh từ bảng product_images

    // Constructor không tham số (Default Constructor)
    public Product() {
    }

    // Constructor có đầy đủ tham số
    public Product(int id, String name, String description, double price, String status, String imageUrl) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.status = status;
        this.imageUrl = imageUrl;
    }

    // --- GETTER AND SETTER ---

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    // Hàm toString dùng để bổ sung khi bạn cần System.out.println(product) để kiểm tra dữ liệu nhanh
    @Override
    public String toString() {
        return "Product{" + "id=" + id + ", name=" + name + ", description=" + description + ", price=" + price + ", status=" + status + ", imageUrl=" + imageUrl + '}';
    }
}