package controller;

import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import model.Product;

@WebServlet(name = "SearchServlet", urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String txtSearch = request.getParameter("searchQuery");
        String[] selectedBrands = request.getParameterValues("brand");

        ProductDAO dao = new ProductDAO();
        List<Product> list = dao.searchProducts(txtSearch, selectedBrands);

        request.setAttribute("dataProduct", list);
        request.setAttribute("txtSearchValue", txtSearch == null ? "" : txtSearch.trim());
        request.setAttribute("selectedBrandIds", selectedBrands == null ? Collections.emptyList() : Arrays.asList(selectedBrands));

        request.getRequestDispatcher("giay.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
