package controller.Tutor;

import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import model.DAOSchedule;
import model.DAOTutor;

@WebServlet(name = "ViewTutorSchedule", urlPatterns = {"/tutor/ViewTutorSchedule"})
public class ViewTutorSchedule extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        DAOTutor dao = new DAOTutor();
        DAOSchedule daoSchedule = new DAOSchedule();
        // Lấy tham số search từ request, nếu không có thì mặc định là chuỗi rỗng
        String search = request.getParameter("search") != null ? request.getParameter("search") : "";
        int id = dao.getTutorIdByUserId(user.getUserID());
        // Lấy danh sách lịch trình của giáo viên, có lọc theo search
        List<Map<String, Object>> schedules = daoSchedule.getSchedulesByTutorIdd(id, search);
        System.out.println("Schedules retrieved for Tutor ID " + id + " with search '" + search + "': " + schedules);
        request.setAttribute("schedules", schedules);
        request.setAttribute("search", search);

        // Chuyển tiếp đến trang JSP để hiển thị
        request.getRequestDispatcher("/tutor/viewTutorSchedule.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Displays tutor's schedule";
    }
}