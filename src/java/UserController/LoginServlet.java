package UserController;

import model.DAOHistoryLog; // Đã có
import model.DAOUser; // Đã có
import entity.GoogleAccount; // Đã có
import entity.User; // Đã có
import UserController.GoogleLogin; // Đã có
import java.io.IOException; // Đã có
import java.sql.SQLException; // Thêm import này để sử dụng SQLException
import jakarta.servlet.ServletException; // Đã có
import jakarta.servlet.annotation.WebServlet; // Đã có
import jakarta.servlet.http.HttpServlet; // Đã có
import jakarta.servlet.http.HttpServletRequest; // Đã có
import jakarta.servlet.http.HttpServletResponse; // Đã có
import jakarta.servlet.http.HttpSession; // Đã có

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession(true);
        DAOUser dao = new DAOUser();
        DAOHistoryLog logDAO = new DAOHistoryLog(); // Thêm DAOHistoryLog

        String service = request.getParameter("service");

        if (service == null) {
            service = "googleLogin";
        }

        switch (service) {
            case "googleLogin":
                handleGoogleLogin(request, response, session, dao, logDAO);
                break;

            case "loginUser":
                handleUserLogin(request, response, session, dao, logDAO);
                break;

            default:
                request.setAttribute("error", "Dịch vụ đăng nhập không hợp lệ.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                break;
        }
    }

    private void handleGoogleLogin(HttpServletRequest request, HttpServletResponse response, HttpSession session, DAOUser dao, DAOHistoryLog logDAO)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        String error = request.getParameter("error");

        if (error != null) {
            request.setAttribute("error", "Bạn đã từ chối quyền truy cập Google");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if (code != null) {
            GoogleLogin gg = new GoogleLogin();
            String accessToken = gg.getToken(code);
            GoogleAccount googleAccount = gg.getUserInfo(accessToken);

            if (googleAccount != null) {
                User user = dao.getUserByEmail(googleAccount.getEmail());

                if (user == null) {
                    request.setAttribute("error", "Tài khoản Google chưa được đăng ký trong hệ thống.");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                } else {
                    session.setAttribute("user", user);
                    session.setAttribute("userId", user.getUserID());
                    try {
                        logDAO.logLogin(user.getUserID()); // Ghi log đăng nhập
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    redirectBasedOnRole(user, request, response);
                }
            } else {
                request.setAttribute("error", "Không lấy được thông tin tài khoản Google.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private void handleUserLogin(HttpServletRequest request, HttpServletResponse response, HttpSession session, DAOUser dao, DAOHistoryLog logDAO)
            throws ServletException, IOException {
        String submit = request.getParameter("submit");
        if (submit == null) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            User user = dao.Login(username, password);
            if (user == null) {
                request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getUserID());
                try {
                    logDAO.logLogin(user.getUserID()); // Ghi log đăng nhập
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                redirectBasedOnRole(user, request, response);
            }
        }
    }

    private void redirectBasedOnRole(User user, HttpServletRequest request, HttpServletResponse response) throws IOException {
        int roleId = user.getRoleID();
        String contextPath = request.getContextPath();
        
        if (roleId == 1) { // Admin
            response.sendRedirect(contextPath + "/admin/index");
        } else if (roleId == 2) { // User
            response.sendRedirect(contextPath + "/home");
        } else if (roleId == 4) { // Staff
            response.sendRedirect("staff/index_staff.jsp");
        } else {
            response.sendRedirect(contextPath + "/home.jsp");
        }
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
        return "Login Servlet";
    }
}