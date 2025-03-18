/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AdminController;

import entity.User;
import model.DAOUser;
import java.io.PrintWriter;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Heizxje
 */
@WebServlet(name = "TutorListServlet", urlPatterns = {"/admin/TutorList"})
public class TutorListServlet extends HttpServlet {

    private static final String TUTOR_LIST_PAGE = "/admin/tutor-list.jsp";
    private static final String LOGIN_PAGE = "login.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Không tạo session mới nếu chưa có
        User currentUser = (User) session.getAttribute("user");

        // Kiểm tra đăng nhập
        if (currentUser == null) {
            response.sendRedirect(LOGIN_PAGE);
            return;
        }

        // Lấy danh sách tutor từ DAO
        DAOUser daoUser = new DAOUser();
        List<User> tutorList = daoUser.getUsersByRole(3); // RoleID = 3 cho Tutor

        // Set attribute và forward tới JSP
        request.setAttribute("tutorList", tutorList);
        request.getRequestDispatcher(TUTOR_LIST_PAGE).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect(LOGIN_PAGE);
            return;
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String action = request.getParameter("action");
        DAOUser daoUser = new DAOUser();

        if ("delete".equals(action)) {
            int userId;
            try {
                userId = Integer.parseInt(request.getParameter("userId"));
            } catch (NumberFormatException e) {
                out.write("{\"success\": false, \"message\": \"Invalid user ID!\"}");
                out.flush();
                return;
            }

            if (daoUser.deleteUser(userId)) {
                out.write("{\"success\": true, \"message\": \"Tutor deleted successfully!\"}");
            } else {
                out.write("{\"success\": false, \"message\": \"Failed to delete tutor or tutor not found!\"}");
            }
            out.flush();
            return;
        }
        out.write("{\"success\": false, \"message\": \"Invalid action!\"}");
        out.flush();
    }
}
