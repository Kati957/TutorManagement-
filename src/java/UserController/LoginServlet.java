package UserController;

import model.DAOHistoryLog;
import model.DAOUser;
import entity.GoogleAccount;
import entity.User;
import model.DAOToken;
import entity.Token;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession(true);
        DAOUser dao = new DAOUser();
        DAOHistoryLog logDAO = new DAOHistoryLog();

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
                } else if (user.getIsActive() == 0) {
                    sendActivationReminder(user, request, response); // Gửi email nhắc nhở
                } else {
                    session.setAttribute("user", user);
                    session.setAttribute("userId", user.getUserID());
                    try {
                        logDAO.logLogin(user.getUserID());
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
            } else if (user.getIsActive() == 0) {
                sendActivationReminder(user, request, response); // Gửi email nhắc nhở
            } else {
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getUserID());
                try {
                    logDAO.logLogin(user.getUserID());
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                redirectBasedOnRole(user, request, response);
            }
        }
    }

    // Phương thức gửi email nhắc nhở kích hoạt
    private void sendActivationReminder(User user, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        resetService service = new resetService();
        DAOToken daoToken = new DAOToken();

        // Tạo token mới
        String token = service.generateToken();
        Token newToken = new Token( // Sử dụng Token
                user.getUserID(), false, token, service.expireDateTime()
        );

        // Lưu token vào bảng Token
        boolean isTokenSaved = daoToken.insertTokenForget(newToken);
        if (!isTokenSaved) {
            request.setAttribute("error", "Tài khoản chưa được kích hoạt. Lỗi khi tạo link kích hoạt mới.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Gửi email nhắc nhở
        String activationLink = "http://localhost:9999/SWP391_Group4_TutorManagement/activate?token=" + token;
        boolean isEmailSent = service.sendActivationEmail(user.getEmail(), activationLink, user.getFullName());

        if (isEmailSent) {
            request.setAttribute("error", "Tài khoản chưa được kích hoạt. Link kích hoạt đã được gửi tới email của bạn.");
        } else {
            request.setAttribute("error", "Tài khoản chưa được kích hoạt. Không thể gửi email kích hoạt, vui lòng thử lại sau.");
        }
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    private void redirectBasedOnRole(User user, HttpServletRequest request, HttpServletResponse response) throws IOException {
        int roleId = user.getRoleID();
        String contextPath = request.getContextPath();

        switch (roleId) {
            case 1: // Admin
                response.sendRedirect(contextPath + "/admin/index");
                break;
            case 2: // User (Student)
                response.sendRedirect(contextPath + "/home");
                break;
            case 3: // Tutor
                response.sendRedirect(contextPath + "/tutor/indextutor.jsp");
                break;
            case 4: // Staff
                response.sendRedirect(contextPath + "/staff/dashboard");
                break;
            default:
                response.sendRedirect(contextPath + "/home.jsp");
                break;
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