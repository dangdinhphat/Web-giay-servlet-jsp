/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author phatm
 */


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Product;


public class ProductDAO {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        // Câu lệnh SQL lấy thông tin sản phẩm kèm ảnh chính (is_main = 1)
        String query = "SELECT p.id, p.brand_id, p.name, p.description, p.price, p.status, pi.image_url " +
                       "FROM products p " +
                       "LEFT JOIN product_images pi ON p.id = pi.product_id AND pi.is_main = 1 " +
                       "WHERE p.status IS NULL OR LOWER(p.status) <> 'inactive' " +
                       "ORDER BY p.id DESC"; 
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getString("status"),
                    rs.getInt("brand_id"),
                    rs.getString("image_url") // Lấy đường dẫn ví dụ: images/nike-trang-cam.png
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Đóng kết nối sau khi dùng xong để tránh tràn bộ nhớ
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public List<Product> getAllProductsForAdmin() {
        List<Product> list = new ArrayList<>();
        String query = "SELECT p.id, p.brand_id, p.name, p.description, p.price, p.status, pi.image_url " +
                       "FROM products p " +
                       "LEFT JOIN product_images pi ON p.id = pi.product_id AND pi.is_main = 1 " +
                       "ORDER BY p.id DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getString("status"),
                    rs.getInt("brand_id"),
                    rs.getString("image_url")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public Product getProductById(int id) {
        String query = "SELECT p.id, p.brand_id, p.name, p.description, p.price, p.status, pi.image_url " +
                       "FROM products p " +
                       "LEFT JOIN product_images pi ON p.id = pi.product_id AND pi.is_main = 1 " +
                       "WHERE p.id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, id); // Truyền id nhận được vào dấu hỏi chấm (?)
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getString("status"),
                    rs.getInt("brand_id"),
                    rs.getString("image_url")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }
    
    public List<Product> searchByName(String keyword) {
        List<Product> list = new ArrayList<>();
        // 1. Đồng bộ cấu trúc SQL kết hợp bảng ảnh (is_main = 1) giống hàm getAllProducts
        String sql = "SELECT p.id, p.name, p.description, p.price, p.status, pi.image_url " +
                     "FROM products p " +
                     "INNER JOIN product_images pi ON p.id = pi.product_id " +
                     "WHERE pi.is_main = 1 AND (p.status IS NULL OR LOWER(p.status) <> 'inactive') AND p.name LIKE ?";

        try {
            // 2. KHẮC PHỤC LỖI NULL: Khởi tạo kết nối thông qua DBContext trước khi chuẩn bị câu lệnh
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%"); // Tìm kiếm chuỗi chứa từ khóa
            rs = ps.executeQuery();

            while (rs.next()) {
                // 3. Đồng bộ cách khởi tạo đối tượng Product giống hệt hàm getAllProducts của bạn
                list.add(new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getString("status"),
                    rs.getString("image_url")
                ));
            }
        } catch (Exception e) {
            System.out.println("Lỗi searchByName: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // 4. Giải phóng tài nguyên sau khi truy vấn xong để tránh tràn bộ nhớ DB
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }
    
    
  
    public void insertProduct(String name, String description, double price, String status, int brandId, String image) {
        String sql = "INSERT INTO dbo.products (name, description, price, status, brand_id) VALUES (?, ?, ?, ?, ?)";
        String imageSql = "INSERT INTO dbo.product_images (product_id, image_url, is_main) VALUES (?, ?, 1)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setDouble(3, price);
            ps.setString(4, status);
            ps.setInt(5, brandId);

            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                int productId = rs.getInt(1);
                String imageUrl = normalizeImageUrl(image);

                try (PreparedStatement imagePs = conn.prepareStatement(imageSql)) {
                    imagePs.setInt(1, productId);
                    imagePs.setString(2, imageUrl);
                    imagePs.executeUpdate();
                }
            }
        } catch (Exception e) {
            System.out.println("Loi insertProduct: " + e.getMessage());
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
    }

    public void insertProduct(String name, String description, double price, String status) {
        String sql = "INSERT INTO dbo.products (name, description, price, status,brand_id) VALUES (?, ?, ?, ?,1)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setDouble(3, price);
            ps.setString(4, status);
            

            ps.executeUpdate(); // Chạy lệnh thêm vào DB
        } catch (Exception e) {
            System.out.println("Lỗi insertProduct: " + e.getMessage());
        } finally {
            try {
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
    }

    public boolean updateProduct(int id, String name, String description, double price, String status, int brandId, String image) {
        String productSql = "UPDATE dbo.products SET name = ?, description = ?, price = ?, status = ?, brand_id = ? WHERE id = ?";
        String updateImageSql = "UPDATE dbo.product_images SET image_url = ?, is_main = 1 WHERE product_id = ? AND is_main = 1";
        String insertImageSql = "INSERT INTO dbo.product_images (product_id, image_url, is_main) VALUES (?, ?, 1)";
        String imageUrl = normalizeImageUrl(image);

        try (Connection connection = new DBContext().getConnection()) {
            connection.setAutoCommit(false);

            try (PreparedStatement productPs = connection.prepareStatement(productSql)) {
                productPs.setString(1, name);
                productPs.setString(2, description);
                productPs.setDouble(3, price);
                productPs.setString(4, status);
                productPs.setInt(5, brandId);
                productPs.setInt(6, id);

                int updatedRows = productPs.executeUpdate();
                if (updatedRows == 0) {
                    connection.rollback();
                    return false;
                }
            }

            if (!imageUrl.isEmpty()) {
                int updatedImageRows;
                try (PreparedStatement imagePs = connection.prepareStatement(updateImageSql)) {
                    imagePs.setString(1, imageUrl);
                    imagePs.setInt(2, id);
                    updatedImageRows = imagePs.executeUpdate();
                }

                if (updatedImageRows == 0) {
                    try (PreparedStatement imagePs = connection.prepareStatement(insertImageSql)) {
                        imagePs.setInt(1, id);
                        imagePs.setString(2, imageUrl);
                        imagePs.executeUpdate();
                    }
                }
            }

            connection.commit();
            return true;
        } catch (Exception e) {
            System.out.println("Loi updateProduct: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteProduct(int id) {
        String countOrderSql = "SELECT COUNT(*) FROM dbo.order_line WHERE product_id = ?";
        String deleteSql = "DELETE FROM dbo.products WHERE id = ?";
        String inactiveSql = "UPDATE dbo.products SET status = ? WHERE id = ?";

        try (Connection connection = new DBContext().getConnection()) {
            boolean hasOrder = false;
            try (PreparedStatement countPs = connection.prepareStatement(countOrderSql)) {
                countPs.setInt(1, id);
                try (ResultSet countRs = countPs.executeQuery()) {
                    if (countRs.next()) {
                        hasOrder = countRs.getInt(1) > 0;
                    }
                }
            }

            if (hasOrder) {
                try (PreparedStatement inactivePs = connection.prepareStatement(inactiveSql)) {
                    inactivePs.setString(1, "Inactive");
                    inactivePs.setInt(2, id);
                    return inactivePs.executeUpdate() > 0;
                }
            }

            try (PreparedStatement deletePs = connection.prepareStatement(deleteSql)) {
                deletePs.setInt(1, id);
                return deletePs.executeUpdate() > 0;
            }
        } catch (Exception e) {
            System.out.println("Loi deleteProduct: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    private String normalizeImageUrl(String image) {
        if (image == null) {
            return "";
        }

        String imageUrl = image.trim().replace("\\", "/");
        if (imageUrl.isEmpty() || imageUrl.startsWith("images/") || imageUrl.startsWith("http://") || imageUrl.startsWith("https://")) {
            return imageUrl;
        }
        return "images/" + imageUrl;
    }
    
    
    public List<Product> getProductsByBrands(String[] brandIds) {
        List<Product> list = new ArrayList<>();
        if (brandIds == null || brandIds.length == 0) {
            return getAllProducts();
        }

        // Tạo chuỗi dấu hỏi chấm (?, ?, ?) tương ứng với số lượng hãng được chọn
        StringBuilder placeholders = new StringBuilder();
        for (int i = 0; i < brandIds.length; i++) {
            placeholders.append("?");
            if (i < brandIds.length - 1) {
                placeholders.append(",");
            }
        }

        // Câu lệnh SQL thực hiện JOIN bảng ảnh và lọc theo cột brand_id của bảng products
        String query = "SELECT p.id, p.name, p.description, p.price, p.status, pi.image_url "
                + "FROM products p "
                + "INNER JOIN product_images pi ON p.id = pi.product_id "
                + "WHERE pi.is_main = 1 AND (p.status IS NULL OR LOWER(p.status) <> 'inactive') AND p.brand_id IN (" + placeholders.toString() + ")";

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);

            // Truyền các giá trị ID dạng số vào câu lệnh SQL
            for (int i = 0; i < brandIds.length; i++) {
                ps.setInt(i + 1, Integer.parseInt(brandIds[i]));
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("status"),
                        rs.getString("image_url")
                ));
            }
        } catch (Exception e) {
            System.out.println("Lỗi getProductsByBrands: " + e.getMessage());
            e.printStackTrace();
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

    public List<Product> searchProducts(String keyword, String[] brandIds) {
        List<Product> list = new ArrayList<>();
        String searchText = keyword == null ? "" : keyword.trim();
        List<Integer> validBrandIds = new ArrayList<>();

        if (brandIds != null) {
            for (String brandId : brandIds) {
                try {
                    int id = Integer.parseInt(brandId);
                    if (id > 0) {
                        validBrandIds.add(id);
                    }
                } catch (NumberFormatException e) {
                    System.out.println("Bo qua brand_id khong hop le: " + brandId);
                }
            }
        }

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT p.id, p.name, p.description, p.price, p.status, pi.image_url ");
        sql.append("FROM products p ");
        sql.append("INNER JOIN product_images pi ON p.id = pi.product_id ");
        sql.append("WHERE pi.is_main = 1 AND (p.status IS NULL OR LOWER(p.status) <> 'inactive') ");

        if (!searchText.isEmpty()) {
            sql.append("AND p.name LIKE ? ");
        }

        if (!validBrandIds.isEmpty()) {
            sql.append("AND p.brand_id IN (");
            for (int i = 0; i < validBrandIds.size(); i++) {
                sql.append("?");
                if (i < validBrandIds.size() - 1) {
                    sql.append(",");
                }
            }
            sql.append(") ");
        }

        sql.append("ORDER BY p.id DESC");

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql.toString());

            int paramIndex = 1;
            if (!searchText.isEmpty()) {
                ps.setString(paramIndex++, "%" + searchText + "%");
            }

            for (Integer brandId : validBrandIds) {
                ps.setInt(paramIndex++, brandId);
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("status"),
                        rs.getString("image_url")
                ));
            }
        } catch (Exception e) {
            System.out.println("Loi searchProducts: " + e.getMessage());
            e.printStackTrace();
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
    
    
}
