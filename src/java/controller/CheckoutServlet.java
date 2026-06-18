/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Map;
import model.CartItem;

/**
 *
 * @author phatm
 */
@WebServlet(name="CheckoutServlet", urlPatterns={"/checkout"})
public class CheckoutServlet extends HttpServlet {
   
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
            out.println("<title>Servlet CheckoutServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutServlet at " + request.getContextPath () + "</h1>");
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
        processRequest(request, response);
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
        HttpSession session = request.getSession();

        // 1. Lấy giỏ hàng từ session ra
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        // Nếu giỏ hàng trống thì quay về trang chủ
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("ProductServlet");
            return;
        }

        // 2. Lấy dữ liệu người dùng nhập từ form thanh-toan.jsp
        String name = request.getParameter("customerName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        double totalMoney = Double.parseDouble(request.getParameter("totalMoney"));
        
        // === ĐOẠN CODE BỔ SUNG: LẤY TÀI KHOẢN TỪ SESSION ===
        model.User acc = (model.User) session.getAttribute("account");
        Integer userId = null;
        if (acc != null) {
            userId = acc.getId(); // Lấy ID tài khoản của người dùng đã đăng nhập
        }
        
        

        // 3. Gọi DAO thực hiện lưu đơn hàng vào database
        OrderDAO orderDao = new OrderDAO();
        orderDao.addOrder(userId, name, phone, address, totalMoney, cart);

        // 4. Xóa sạch giỏ hàng sau khi đặt thành công để số lượng về 0
        session.removeAttribute("cart");

        // 5. Chuyển hướng thông báo đặt hàng thành công (hoặc về lại trang chủ)
        response.setContentType("text/html;charset=UTF-8");
        response.getWriter().print("<script>"
                + "alert('Đặt hàng thành công! Cảm ơn bạn.');"
                + "window.location.href='ProductServlet';"
                + "</script>");
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
