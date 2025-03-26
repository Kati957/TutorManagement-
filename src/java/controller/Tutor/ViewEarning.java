package controller.Tutor;

import entity.TutorEarning;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.DAOTutor;
import model.DAOTutorEarning;

@WebServlet(name = "ViewEarning", urlPatterns = {"/tutor/ViewEarning"})
public class ViewEarning extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAOTutorEarning daoEarnings = new DAOTutorEarning();
        DAOTutor daoTutor = new DAOTutor();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Kiểm tra user có tồn tại và là tutor không (roleID = 3)
        if (user == null || user.getRoleID() != 3) {
            response.sendRedirect(request.getContextPath() + "/error-403.jsp");
            return;
        }

        // Lấy TutorID từ UserID
        int tutorID = daoTutor.getTutorIdByUserId(user.getUserID());

        // Đồng bộ dữ liệu từ Booking sang TutorEarnings
        daoEarnings.syncBookingToTutorEarnings(tutorID);

        // Lấy danh sách các tháng có booking hoàn thành
        List<String> completedMonths = daoEarnings.getCompletedMonthsByTutor(tutorID);

        // Lấy tất cả bản ghi TutorEarnings cho TutorID
        List<TutorEarning> earningsList = daoEarnings.getAllEarningsByTutor(tutorID);

        // Lọc theo tháng nếu có tham số monthFilter
        String monthFilter = request.getParameter("monthFilter");
        if (monthFilter != null && !monthFilter.isEmpty()) {
            earningsList = earningsList.stream()
                    .filter(e -> new java.text.SimpleDateFormat("yyyy-MM").format(e.getBookingDate()).equals(monthFilter))
                    .toList();
        }

        request.setAttribute("earningsList", earningsList);
        request.setAttribute("completedMonths", completedMonths);
        request.setAttribute("tutorName", user.getFullName());
        request.getRequestDispatcher("/tutor/viewEarning.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý logic cho nút Request (nếu cần)
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet to view Tutor Earnings";
    }
}