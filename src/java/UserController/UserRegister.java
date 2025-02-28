/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nvarchar/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.User;
import model.DAOUser;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet xử lý đăng ký người dùng.
 *
 * @author Heizxje
 */
@WebServlet(name = "UserRegister", urlPatterns = {"/User"})
public class UserRegister extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(UserRegister.class.getName());
    private static final String REGISTER_JSP = "/register.jsp";
    private static final String LOGIN_JSP = "login.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String service = request.getParameter("service");
        if ("registerUser".equals(service)) {
            request.getRequestDispatcher(REGISTER_JSP).forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid service parameter");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        String service = request.getParameter("service");

        // Kiểm tra tham số service
        if (!"registerUser".equals(service)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid service parameter");
            return;
        }

        String submit = request.getParameter("submit");
        if (submit == null) {
            request.getRequestDispatcher(REGISTER_JSP).forward(request, response);
            return;
        }

        // Khởi tạo DAOUser
        DAOUser dao = new DAOUser();
        if (dao.conn == null) {
            LOGGER.log(Level.SEVERE, "Database connection is null");
            request.setAttribute("error", "Không thể kết nối cơ sở dữ liệu. Vui lòng thử lại sau.");
            request.getRequestDispatcher(REGISTER_JSP).forward(request, response);
            return;
        }

        // Lấy dữ liệu từ form
        String email = request.getParameter("Email");
        String fullName = request.getParameter("FullName");
        String phone = request.getParameter("Phone");
        String dob = request.getParameter("Dob");
        String address = request.getParameter("Address");
        String avatar = request.getParameter("Avatar");
        String userName = request.getParameter("UserName");
        String password = request.getParameter("Password");

        try {
            // Kiểm tra dữ liệu đầu vào và trùng lặp
            String error = validateInput(dao, email, fullName, phone, dob, address, userName, password);
            if (!error.isEmpty()) {
                request.setAttribute("error", error);
                request.getRequestDispatcher(REGISTER_JSP).forward(request, response);
                return;
            }

            // Tạo đối tượng User
            User newUser = new User(
                    0, 2, email, fullName, phone, null, 1, Date.valueOf(dob),
                    address, avatar != null && !avatar.isEmpty() ? avatar : "default_avatar.jpg",
                    userName, password
            );

            // Đăng ký người dùng
            int result = dao.registerUser(newUser);
            if (result > 0) {
                session.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
                response.sendRedirect(LOGIN_JSP);
            } else {
                request.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại.");
                request.getRequestDispatcher(REGISTER_JSP).forward(request, response);
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error registering user", ex);
            request.setAttribute("error", "Lỗi hệ thống: " + ex.getMessage());
            request.getRequestDispatcher(REGISTER_JSP).forward(request, response);
        }
    }

    /**
     * Kiểm tra dữ liệu đầu vào và trùng lặp.
     *
     * @return Chuỗi lỗi nếu có, rỗng nếu hợp lệ
     */
    private String validateInput(DAOUser dao, String email, String fullName, String phone, String dob,
            String address, String userName, String password) throws SQLException {
        if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            return "Email không hợp lệ.";
        }
        if (dao.isEmailExists(email)) {
            return "Email đã được sử dụng.";
        }
        if (userName == null || userName.trim().isEmpty()) {
            return "Username không được để trống.";
        }
        if (dao.isUsernameExists(userName)) {
            return "Username đã tồn tại.";
        }
        if (phone == null || !phone.matches("\\d{10}")) {
            return "Số điện thoại phải là 10 chữ số.";
        }
        if (dao.isPhoneExists(phone)) {
            return "Số điện thoại đã được sử dụng.";
        }
        if (password == null || password.length() < 8) {
            return "Mật khẩu phải dài ít nhất 8 ký tự.";
        }
        if (dob == null || dob.trim().isEmpty()) {
            return "Ngày sinh không được để trống.";
        }
        if (fullName == null || fullName.trim().isEmpty()) {
            return "Họ và tên không được để trống.";
        }
        if (address == null || address.trim().isEmpty()) {
            return "Địa chỉ không được để trống.";
        }
        return "";
    }

    @Override
    public String getServletInfo() {
        return "Servlet for user registration";
    }
}
