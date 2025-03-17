package UserController;

import model.DAOHistoryLog; // Đã có
import java.io.IOException; // Đã có
import java.sql.SQLException; // Thêm import này để sử dụng SQLException
import jakarta.servlet.ServletException; // Đã có
import jakarta.servlet.annotation.WebServlet; // Đã có
import jakarta.servlet.http.HttpServlet; // Đã có
import jakarta.servlet.http.HttpServletRequest; // Đã có
import jakarta.servlet.http.HttpServletResponse; // Đã có
import jakarta.servlet.http.HttpSession; // Đã có
import entity.User; // Đã có

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String redirectUrl = request.getContextPath() + "/login.jsp";

        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                try {
                    DAOHistoryLog logDAO = new DAOHistoryLog();
                    logDAO.logLogout(user.getUserID()); // Ghi log đăng xuất
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                if (user.getRoleID() == 1) { // Admin
                    redirectUrl = request.getContextPath() + "/login.jsp";
                } else {
                    redirectUrl = request.getContextPath() + "/home.jsp";
                }
            }
            session.invalidate();
        }

        response.sendRedirect(redirectUrl);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Logout Servlet";
    }
}