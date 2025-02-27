package controller.Customer;

import entity.Tutor;
import entity.Cv;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.DAOTutor;
import model.DAOUser;

public class HomePageServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        DAOUser daoUser = new DAOUser();
        DAOTutor daoTutor = new DAOTutor();

        try {
            if (user.getEmail() == null) {
                int userId = user.getUserID();
                if (userId != 0) {
                    user = daoUser.getUserById(userId);
                    if (user != null) {
                        session.setAttribute("user", user);
                    }
                }
            }
        } catch (Exception e) {
            user = daoUser.getUserById(4);
            if (user != null) {
                session.setAttribute("user", user);
            }
        }

        List<Tutor> topTutors = daoTutor.getTopTutors(5);

        request.setAttribute("user", user);
        request.setAttribute("topTutors", topTutors);
        request.getRequestDispatcher("index.jsp").forward(request, response);
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
