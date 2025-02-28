/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package UserController;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import entity.User; // Đảm bảo import entity User

@WebServlet("/logout") // Giữ nguyên ánh xạ chung
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String redirectUrl = request.getContextPath() + "/login.jsp"; // Mặc định về login.jsp

        if (session != null) {
            User user = (User) session.getAttribute("user"); // Lấy thông tin user từ session
            if (user != null && user.getRoleID() == 1) { // Giả sử RoleID = 2 là admin
                redirectUrl = request.getContextPath() + "/login.jsp"; // Admin logout về login
            } else {
                redirectUrl = request.getContextPath() + "/home.jsp"; // User logout về home
            }
            session.invalidate(); // Hủy session sau khi lấy thông tin
        }

        response.sendRedirect(redirectUrl); // Điều hướng dựa trên role
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Logout Servlet";
    }
}