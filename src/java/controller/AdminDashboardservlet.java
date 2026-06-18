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
import java.util.List;

/**
 *
 * @author phatm
 */
@WebServlet(name="AdminDashboardservlet", urlPatterns={"/admin-dashboard"})
public class AdminDashboardservlet extends HttpServlet {
   
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
            out.println("<title>Servlet AdminDashboardservlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminDashboardservlet at " + request.getContextPath () + "</h1>");
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

        // KIỂM TRA PHÂN QUYỀN
        if (acc == null || !acc.getRole().equalsIgnoreCase("admin")) {
            // Nếu không phải admin, đá về trang Login hoặc báo lỗi
            response.sendRedirect("Login.jsp");
            return;
        }

        // Nếu đúng là admin -> Lấy dữ liệu và đi tiếp
        OrderDAO dao = new OrderDAO();
        List<model.Order> allOrders = dao.getAllOrders();

        // Tính tổng doanh thu để hiển thị ở Dashboard cho ngầu
        double totalRevenue = 0;
        for (model.Order o : allOrders) {
            totalRevenue += o.getTotalMoney();
        }

        request.setAttribute("allOrders", allOrders);
        request.setAttribute("totalRevenue", totalRevenue);
        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
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
