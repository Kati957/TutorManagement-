
package controller.Tutor;

import entity.Schedule;
import entity.Subject;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jdk.jfr.Timestamp;
import model.DAOSchedule;
import model.DAOSubject;
import model.DAOTutor;
import model.DAOTutorSubject;

@WebServlet(name="CreateSchedule", urlPatterns={"/CreateSchedule"})
public class CreateSchedule extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        DAOTutor daoTutor = new DAOTutor();
        DAOSubject daoSubject = new DAOSubject();
        DAOSchedule daoSchedule = new DAOSchedule();

        List<Subject> subjectList = new ArrayList<>();
        List<Schedule> scheduleList = new ArrayList<>();

        try {
            int tutorId = daoTutor.getTutorIdByUserId(userId);
            subjectList = daoSubject.getTutorSubjects(userId);
            scheduleList = daoSchedule.getSchedulesByTutorId(tutorId);
        } catch (SQLException ex) {
            Logger.getLogger(CreateSchedule.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.setAttribute("subjectList", subjectList);
        request.setAttribute("scheduleList", scheduleList);
        request.getRequestDispatcher("tutor/createschedule.jsp").forward(request, response);
        
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    HttpSession session = request.getSession();
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int subjectId = Integer.parseInt(request.getParameter("subject"));
    String startTimeStr = request.getParameter("startTime");
    if (subjectId <= 0 || startTimeStr == null || startTimeStr.isEmpty()) {
        request.setAttribute("message", "Vui lòng nhập đầy đủ thông tin.");
        doGet(request, response);
        return;
    }
    try {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        LocalDateTime startTimeLDT = LocalDateTime.parse(startTimeStr, formatter);
        LocalDateTime endTimeLDT = startTimeLDT.plusMinutes(60);

        // Chuyển LocalDateTime thành java.util.Date
        Date startTime = Date.from(startTimeLDT.atZone(ZoneId.systemDefault()).toInstant());
        Date endTime = Date.from(endTimeLDT.atZone(ZoneId.systemDefault()).toInstant());

        DAOTutor daoTutor = new DAOTutor();
        DAOSchedule daoSchedule = new DAOSchedule();
        int tutorId = daoTutor.getTutorIdByUserId(userId);
        
        // Tạo đối tượng Schedule
        Schedule newSchedule = new Schedule();
        newSchedule.setTutorID(tutorId);
        newSchedule.setStartTime(startTime);
        newSchedule.setEndTime(endTime);
        newSchedule.setIsBooked(false);
        newSchedule.setSubjectId(subjectId);
        newSchedule.setStatus("pending");

        boolean isSuccess = daoSchedule.insertSchedule(newSchedule);
        request.setAttribute("message", isSuccess ? "Tạo lịch dạy thành công!" : "Tạo lịch dạy thất bại. Vui lòng thử lại.");
    } catch (Exception ex) {
        request.setAttribute("message", "Lỗi hệ thống: " + ex.getMessage());
        Logger.getLogger(CreateSchedule.class.getName()).log(Level.SEVERE, null, ex);
    }
    doGet(request, response);
}



    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
