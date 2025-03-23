package controller.Customer;

import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.DAOSubject;
import model.DAOTutor;
import model.DAOSchedule;
import model.DAOSlot;
import entity.Subject;
import entity.Tutor;
import entity.Schedule;
import entity.Slot;
import java.util.List;

public class BookScheduleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAOTutor daoTutor = new DAOTutor();
        DAOSubject daoSubject = new DAOSubject();
        DAOSlot daoSlot = new DAOSlot();

        List<Subject> subjectList = daoSubject.getAllSubjects();
        List<Slot> slotList = daoSlot.getAllSlots();
        request.setAttribute("subjectList", subjectList);
        request.setAttribute("slotList", slotList);

        String subjectIdParam = request.getParameter("subjectId");
        String tutorIdParam = request.getParameter("tutorId");

        List<Tutor> tutorList;
        Tutor selectedTutor = null;

        if (subjectIdParam == null || subjectIdParam.isEmpty()) {
            tutorList = daoTutor.getTopTutors(5);
        } else {
            int subjectId = Integer.parseInt(subjectIdParam);
            tutorList = daoTutor.getAllTutorsBySubject(subjectId);
        }

        if (tutorIdParam != null && !tutorIdParam.isEmpty()) {
            int subjectId = Integer.parseInt(subjectIdParam);
            int tutorId = Integer.parseInt(tutorIdParam);
            selectedTutor = daoTutor.getTutorBySubject(tutorId, subjectId);

            DAOSchedule daoSchedule = new DAOSchedule();
            List<Schedule> scheduleList = daoSchedule.getSchedulesByTutorAndSubject(tutorId, subjectId);
            request.setAttribute("scheduleList", scheduleList);
        }
        request.setAttribute("selectedTutor", selectedTutor);
        request.setAttribute("tutorList", tutorList);
        String error = request.getParameter("error");
        String success = request.getParameter("success");
        if (error != null) {
            request.setAttribute("error", error);
        }
        if (success != null) {
            request.setAttribute("success", success);
        }

        request.getRequestDispatcher("user/bookschedule.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String[] scheduleIds = request.getParameterValues("scheduleIds");
        String tutorId = request.getParameter("tutorId");
        String subjectId = request.getParameter("subjectId");
        String totalBill = request.getParameter("totalBill");

        if (scheduleIds == null || tutorId == null || subjectId == null || totalBill == null) {
            response.sendRedirect("bookschedule?subjectId=" + subjectId + "&tutorId=" + tutorId + "&error=Missing information");
            return;
        }

        // Lưu thông tin vào session
        session.setAttribute("scheduleIds", scheduleIds);
        session.setAttribute("tutorId", tutorId);
        session.setAttribute("subjectId", subjectId);
        session.setAttribute("totalBill", totalBill);

        // Chuyển hướng đến ajaxServlet để bắt đầu thanh toán
        response.sendRedirect("ajaxServlet?totalBill=" + totalBill);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}