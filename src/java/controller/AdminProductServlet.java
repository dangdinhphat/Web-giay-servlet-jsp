package controller;

import dal.ProductDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Product;
import model.User;

@WebServlet(name = "AdminProductServlet", urlPatterns = {"/AdminProductServlet", "/admin-product"})
public class AdminProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null || action.trim().isEmpty()) {
            action = "list";
        }

        ProductDAO productDao = new ProductDAO();
        switch (action) {
            case "add":
                request.getRequestDispatcher("add-product.jsp").forward(request, response);
                break;
            case "edit":
                showEditForm(request, response, productDao);
                break;
            case "delete":
                deleteProduct(request, response, productDao);
                break;
            case "list":
            default:
                showProductList(request, response, productDao);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        if (!isAdmin(request)) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String action = request.getParameter("action");
        ProductDAO productDao = new ProductDAO();

        try {
            if ("insert".equals(action)) {
                productDao.insertProduct(
                        request.getParameter("name"),
                        request.getParameter("description"),
                        Double.parseDouble(request.getParameter("price")),
                        request.getParameter("status"),
                        Integer.parseInt(request.getParameter("brandId")),
                        request.getParameter("image")
                );
                response.sendRedirect("admin-product?action=list&success=insert");
                return;
            }

            if ("update".equals(action)) {
                boolean updated = productDao.updateProduct(
                        Integer.parseInt(request.getParameter("id")),
                        request.getParameter("name"),
                        request.getParameter("description"),
                        Double.parseDouble(request.getParameter("price")),
                        request.getParameter("status"),
                        Integer.parseInt(request.getParameter("brandId")),
                        request.getParameter("image")
                );
                response.sendRedirect("admin-product?action=list&success=" + (updated ? "update" : "notfound"));
                return;
            }

            if ("delete".equals(action)) {
                deleteProduct(request, response, productDao);
                return;
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("admin-product?action=list&error=invalid-number");
            return;
        }

        response.sendRedirect("admin-product?action=list");
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return false;
        }

        User account = (User) session.getAttribute("account");
        return account != null && account.getRole() != null && account.getRole().equalsIgnoreCase("admin");
    }

    private void showProductList(HttpServletRequest request, HttpServletResponse response, ProductDAO productDao)
            throws ServletException, IOException {
        List<Product> productList = productDao.getAllProductsForAdmin();
        request.setAttribute("productList", productList);
        request.getRequestDispatcher("admin-product.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response, ProductDAO productDao)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Product product = productDao.getProductById(id);
            if (product == null) {
                response.sendRedirect("admin-product?action=list&error=notfound");
                return;
            }

            request.setAttribute("product", product);
            request.getRequestDispatcher("edit-product.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("admin-product?action=list&error=invalid-id");
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response, ProductDAO productDao)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean deleted = productDao.deleteProduct(id);
            response.sendRedirect("admin-product?action=list&success=" + (deleted ? "delete" : "notfound"));
        } catch (NumberFormatException e) {
            response.sendRedirect("admin-product?action=list&error=invalid-id");
        }
    }
}
