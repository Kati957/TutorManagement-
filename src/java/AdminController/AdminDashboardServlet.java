package AdminController;

import entity.User;
import entity.HistoryLog;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAOUser;
import model.DAOHistoryLog;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/index"})
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        // Kiểm tra đăng nhập
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Kiểm tra quyền Admin (RoleID = 1)
        if (currentUser.getRoleID() != 1) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // Khởi tạo các danh sách dữ liệu
        List<User> newUsers = null;
        List<HistoryLog> recentLogs = null;

        try {
            // Lấy 5 người dùng mới nhất (RoleID = 2)
            DAOUser daoUser = new DAOUser();
            newUsers = daoUser.getNewUsers();
            request.setAttribute("newUsers", newUsers);

            // Lấy 5 lịch sử log mới nhất cho dashboard
            DAOHistoryLog daoHistoryLog = new DAOHistoryLog();
            recentLogs = daoHistoryLog.getRecentLogs();
            request.setAttribute("logs", recentLogs);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load dashboard data: " + e.getMessage());
        }

        // Forward đến trang index.jsp
        request.getRequestDispatcher("/admin/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}