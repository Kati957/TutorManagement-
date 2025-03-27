package AdminController;

import entity.User;
import entity.HistoryLog;
import entity.Payment;
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
import model.DAOPayment;
import model.DAOTutorRating;
import model.DAOBooking;

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
        List<Payment> recentPayments = null;
        double totalProfit = 0.0;
        int totalRatings = 0;
        int totalUsers = 0;
        int totalBookings = 0;

        try {
            DAOUser daoUser = new DAOUser();
            DAOHistoryLog daoHistoryLog = new DAOHistoryLog();
            DAOPayment daoPayment = new DAOPayment();
            DAOTutorRating daoTutorRating = new DAOTutorRating();
            DAOBooking daoBooking = new DAOBooking();

            // Lấy danh sách new users
            newUsers = daoUser.getNewUsers();
            request.setAttribute("newUsers", newUsers);

            // Lấy danh sách history logs
            recentLogs = daoHistoryLog.getRecentLogs();
            request.setAttribute("logs", recentLogs);

            // Lấy tổng profit từ Payment với trạng thái Completed
            totalProfit = daoPayment.getTotalProfit();
            request.setAttribute("totalProfit", totalProfit);

            // Lấy tổng số rating từ TutorRating
            totalRatings = daoTutorRating.getTotalRatings();
            request.setAttribute("totalRatings", totalRatings);

            // Lấy tổng số user từ Users
            totalUsers = daoUser.getTotalUsers();
            request.setAttribute("totalUsers", totalUsers);

            // Lấy tổng số booking từ Booking với trạng thái Confirmed và Completed
            totalBookings = daoBooking.getTotalConfirmedAndCompletedBookings();
            request.setAttribute("totalBookings", totalBookings);

            // Lấy 5 giao dịch gần nhất từ Payment
            recentPayments = daoPayment.getRecentPayments();
            request.setAttribute("recentPayments", recentPayments);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load dashboard data: " + e.getMessage());
        }

        request.getRequestDispatcher("/admin/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
