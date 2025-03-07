package controller.Customer;

import entity.Booking;
import entity.Schedule;
import entity.Slot;
import entity.Subject;
import entity.Tutor;
import entity.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import model.DAOBooking;
import model.DAOSchedule;
import model.DAOSlot;
import model.DAOSubject;
import model.DAOTutor;

public class BookScheduleServlet extends HttpServlet {

    // Servlet: processRequest
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int studentID = user.getUserID();

        String[] scheduleIds = request.getParameterValues("scheduleIds");
        String tutorId = request.getParameter("tutorId");
        String subjectId = request.getParameter("subjectId");

        if (scheduleIds == null || tutorId == null || subjectId == null) {
            response.sendRedirect("bookschedule?subjectId=" + subjectId + "&tutorId=" + tutorId + "&error=Missing information");
            return;
        }

        DAOSlot daoSlot = new DAOSlot();
        DAOBooking daoBooking = new DAOBooking();
        List<Slot> slots = new ArrayList<>();
        List<Booking> bookings = new ArrayList<>();

        // Tạo danh sách Slot và Booking
        for (String scheduleId : scheduleIds) {
            Slot slot = new Slot();
            slot.setScheduleID(Integer.parseInt(scheduleId));
            slot.setStatus("Available"); // Đặt trạng thái mặc định

            slots.add(slot);

            Booking booking = new Booking();
            booking.setStudentID(studentID);
            booking.setTutorID(Integer.parseInt(tutorId));
            booking.setBookingDate(new Date(System.currentTimeMillis()));
            booking.setStatus("Pending");
            booking.setSubjectID(Integer.parseInt(subjectId));

            bookings.add(booking);
        }

        int result = daoBooking.addSlotsAndBookings(slots, bookings);

        if (result == bookings.size()) {
            response.sendRedirect("bookschedule?subjectId=" + subjectId + "&tutorId=" + tutorId + "&success=Booking successfully");
        } else {
            response.sendRedirect("bookschedule?subjectId=" + subjectId + "&tutorId=" + tutorId + "&error=Booking failed");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
