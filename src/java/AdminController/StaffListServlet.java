package AdminController;

import entity.User;
import model.DAOUser;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "StaffListServlet", urlPatterns = {"/admin/StaffList"})
public class StaffListServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(StaffListServlet.class.getName());
    private static final String STAFF_LIST_JSP = "/admin/staff-list.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.log(Level.INFO, "StaffListServlet: Processing GET request for /admin/StaffList");
        DAOUser dao = new DAOUser();
        List<User> staffList = dao.getUsersByRole(4);
        LOGGER.log(Level.INFO, "Staff list size in servlet: " + staffList.size());
        if (staffList.isEmpty()) {
            LOGGER.log(Level.WARNING, "No staff found for RoleID = 4");
        }
        request.setAttribute("staffList", staffList);
        LOGGER.log(Level.INFO, "Forwarding to " + STAFF_LIST_JSP);
        request.getRequestDispatcher(STAFF_LIST_JSP).forward(request, response);
    }
}