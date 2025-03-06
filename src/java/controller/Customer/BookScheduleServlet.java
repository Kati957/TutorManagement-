package controller.Customer;

import entity.Booking;
import entity.Slot;
import entity.Subject;
import entity.Tutor;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import model.DAOBooking;
import model.DAOSlot;
import model.DAOSubject;
import model.DAOTutor;

public class BookScheduleServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int studentID = user.getUserID();
        int tutorID = Integer.parseInt(request.getParameter("tutorID"));
        int slotID = Integer.parseInt(request.getParameter("slotID"));
        int subjectID = Integer.parseInt(request.getParameter("subjectID"));

        DAOBooking daoBooking = new DAOBooking();
        DAOSubject daoSubject = new DAOSubject();
        DAOSlot daoSlot = new DAOSlot();
        DAOTutor daoTutor = new DAOTutor();

        Booking booking = new Booking();
        booking.setStudentID(studentID);
        booking.setTutorID(tutorID);
        booking.setSlotID(slotID);
        booking.setBookingDate(Date.valueOf(LocalDate.now()));
        booking.setStatus("Pending");
        booking.setSubjectID(subjectID);

        int result = daoBooking.addBooking(booking);

        List<Tutor> tutorList = daoTutor.getAllTutors();
        List<Slot> slotList = daoSlot.getAllSlots();
        List<Subject> subjectList = daoSubject.getAllSubjects();

        request.setAttribute("tutorList", tutorList);
        request.setAttribute("slotList", slotList);
        request.setAttribute("subjectList", subjectList);

        if (result > 0) {
            request.setAttribute("success", "Đặt lịch thành công!");
        } else {
            request.setAttribute("error", "Lỗi khi đặt lịch. Vui lòng thử lại!");
        }
        request.getRequestDispatcher("user/bookschedule.jsp").forward(request, response);
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

        List<Tutor> tutorList = daoTutor.getAllTutors();
        List<Slot> slotList = daoSlot.getAllSlots();
        List<Subject> subjectList = daoSubject.getAllSubjects();

        // Đặt thuộc tính cho request
        request.setAttribute("tutorList", tutorList);
        request.setAttribute("slotList", slotList);
        request.setAttribute("subjectList", subjectList);
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
