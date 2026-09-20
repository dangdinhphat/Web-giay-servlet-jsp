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
import java.util.LinkedHashMap;
import java.util.Map;
import model.CartItem;
import model.Product;

/**
 *
 * @author phatm
 */
@WebServlet(name="AddToCartServlet", urlPatterns={"/add-to-cart","/AddToCartServlet"})
public class AddToCartServlet extends HttpServlet {
   
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
            out.println("<title>Servlet AddToCartServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddToCartServlet at " + request.getContextPath () + "</h1>");
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
        HttpSession session = request.getSession();
        if (session.getAttribute("account") == null) {
            // Lưu thông báo lỗi vào request để hiển thị ngoài trang đăng nhập (tùy chọn)
            request.setAttribute("errorMessage", "Vui lòng đăng nhập để thực hiện chức năng mua hàng!");

            // Chuyển hướng người dùng thẳng về trang login
            response.sendRedirect("login");
            return; // Rất quan trọng: Kết thúc hàm tại đây, không chạy xuống phần xử lý giỏ hàng bên dưới nữa
        }
        
        
        
        
        
        
        
        // 1. Lấy id sản phẩm từ request gửi lên
        String idRaw = request.getParameter("id");
        
        if (idRaw != null) {
            try {
                int productId = Integer.parseInt(idRaw);
                
                // Giỏ hàng sẽ được lưu dưới dạng Map<ProductId, CartItem> để dễ tìm kiếm và quản lý
                Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
                
                if (cart == null) {
                    cart = new LinkedHashMap<>(); // Nếu chưa có giỏ hàng thì tạo mới
                }
                
                // 3. Kiểm tra sản phẩm đã tồn tại trong giỏ hàng chưa
                if (cart.containsKey(productId)) {
                    // Nếu đã có, tăng số lượng lên 1
                    int oldQuantity = cart.get(productId).getQuantity();
                    cart.get(productId).setQuantity(oldQuantity + 1);
                } else {
                    // Nếu chưa có, lấy thông tin sản phẩm từ Database thông qua DAO
                    ProductDAO db = new ProductDAO();
                    Product p = db.getProductById(productId); // Bạn đảm bảo ProductDAO đã có hàm tìm theo ID này nhé
                    
                    if (p != null) {
                        CartItem item = new CartItem(p, 1);
                        cart.put(productId, item);
                    }
                }
                
                // 4. Lưu lại giỏ hàng vào Session
                session.setAttribute("cart", cart);
                
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        
        // 5. Thêm xong thì chuyển hướng người dùng về lại trang giỏ hàng (hoặc trang detail cũ)
        // Ở đây mình chuyển hướng về trang xem giỏ hàng 'cart.jsp' 
        response.sendRedirect("cart.jsp");
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
        processRequest(request, response);
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
