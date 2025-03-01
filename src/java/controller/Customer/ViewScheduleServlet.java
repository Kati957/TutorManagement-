package controller.Customer;

import entity.Schedule;
import entity.Subject;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.DAOSchedule;
import model.DAOSubject;

public class ViewScheduleServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DAOSchedule daoSchedule = new DAOSchedule();
        DAOSubject daoSubject = new DAOSubject();

        User user = (User) request.getSession().getAttribute("user");

        String search = request.getParameter("search") != null ? request.getParameter("search") : "";
        String sortBy = request.getParameter("sortBy") != null ? request.getParameter("sortBy") : "BookingDate";
        String order = request.getParameter("order") != null ? request.getParameter("order") : "asc";
        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int pageSize = 5;

        String subject = request.getParameter("subject");
        if (subject != null && !subject.isEmpty()) {
            search = subject; 
        }

        List<Schedule> schedules = daoSchedule.getSchedulesByUserId(user.getUserID(), search, sortBy, order, page, pageSize);

        List<Subject> subjects = daoSubject.getAllSubjects();
        request.setAttribute("subjects", subjects);

        request.setAttribute("schedules", schedules);
        request.setAttribute("search", search);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("order", order);
        request.setAttribute("page", page);
        request.getRequestDispatcher("user/myschedule.jsp").forward(request, response);
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
        processRequest(request, response);
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
