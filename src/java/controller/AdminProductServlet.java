/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author phatm
 */
@WebServlet(name="AdminProductServlet", urlPatterns={"/AdminProductServlet", "/admin-product"})
public class AdminProductServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminProductServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminProductServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        //processRequest(request, response);
        HttpSession session = request.getSession();
        model.User acc = (model.User) session.getAttribute("account");

        // Kiểm tra bảo mật (Chỉ admin mới được vào)
        if (acc == null || !acc.getRole().equalsIgnoreCase("admin")) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // Đọc tham số action xem người dùng muốn làm gì
        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; // Nếu không truyền gì thì mặc định là hiển thị danh sách
        }

        ProductDAO pDao = new ProductDAO();

        switch (action) {
            case "list":
                // 1. Logic hiển thị danh sách sản phẩm (Code cũ của bạn)
                List<model.Product> productList = pDao.getAllProducts();
                request.setAttribute("productList", productList);
                request.getRequestDispatcher("admin-product.jsp").forward(request, response);
                break;

            case "add":
                // 2. Logic khi bấm "Thêm sản phẩm mới" -> Chuyển hướng sang trang điền Form thêm
                // (Bạn cần tạo thêm file add-product.jsp nhé)
                request.getRequestDispatcher("add-product.jsp").forward(request, response);
                break;

            case "edit":
                // 3. Logic khi bấm "Sửa" -> Lấy ID giày -> Tìm thông tin từ DB -> Đẩy sang trang sửa
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    // Lấy thông tin chi tiết của 1 sản phẩm theo ID từ DAO
                    model.Product product = pDao.getProductById(id); 
                    
                    request.setAttribute("product", product);
                    // Chuyển hướng sang trang form sửa (Bạn cần tạo thêm file edit-product.jsp)
                    request.getRequestDispatcher("edit-product.jsp").forward(request, response);
                } catch (Exception e) {
                    response.sendRedirect("AdminProductServlet?action=list");
                }
                break;
        }
    }
   

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        //processRequest(request, response);
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // 1. Lấy tham số action từ form ẩn gửi lên
        String action = request.getParameter("action");
        System.out.println("======> DA CHAY VAO DO_POST, ACTION LA: " + action);
        ProductDAO pDao = new ProductDAO();
        
        if ("insert".equals(action)) {
            try {
                // 2. Hứng toàn bộ dữ liệu từ các ô input của form add-product.jsp
                String name = request.getParameter("name");
                double price = Double.parseDouble(request.getParameter("price"));
                String status = request.getParameter("status");
                int brandId = Integer.parseInt(request.getParameter("brandId"));
                String image = request.getParameter("image");
                String description = request.getParameter("description");
                
                // 3. Gọi DAO để thực hiện thêm vào database
                pDao.insertProduct(name, description, price, status, brandId, image);
                
                // 4. Thêm thành công thì chuyển hướng quay về trang danh sách sản phẩm
                response.sendRedirect("AdminProductServlet?action=list");
                
            } catch (Exception e) {
                // Nếu lỗi (ví dụ nhập sai định dạng số tiền), quay lại trang thêm mới
                response.sendRedirect("AdminProductServlet?action=add");
            }
        }
        
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
