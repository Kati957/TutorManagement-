/*
 * Click nbfs://SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package UserController;

import entity.User;
import model.DAOUser;
import java.io.IOException;
import java.security.MessageDigest;
import java.sql.SQLException;
import java.time.LocalDate;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.time.LocalDate;
import java.sql.Date;
import java.security.MessageDigest;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class ProfileServlet extends HttpServlet {

    private static final String PROFILE_PAGE = "/profile_user.jsp";
    private static final String LOGIN_PAGE = "login.jsp";
    private static final int MIN_PASSWORD_LENGTH = 8;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect(LOGIN_PAGE);
            return;
        }

        request.setAttribute("user", currentUser);
        request.getRequestDispatcher(PROFILE_PAGE).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect(LOGIN_PAGE);
            return;
        }

        String action = request.getParameter("action");
        DAOUser daoUser = new DAOUser();

        if ("changePassword".equals(action)) {
            handleChangePassword(request, response, session, currentUser, daoUser);
        } else {
            handleUpdateProfile(request, response, session, currentUser, daoUser);
        }
    }

    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, User currentUser, DAOUser daoUser) throws IOException {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        try {
            if (!currentUser.getPassword().equals(currentPassword)) {
                setError(session, "Mật khẩu hiện tại không đúng.");
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                setError(session, "Mật khẩu mới và xác nhận mật khẩu không khớp.");
                return;
            }

            if (newPassword.length() < MIN_PASSWORD_LENGTH) {
                setError(session, "Mật khẩu mới phải có ít nhất " + MIN_PASSWORD_LENGTH + " ký tự.");
                return;
            }

            currentUser.setPassword(newPassword);
            if (daoUser.updateUser(currentUser)) {
                session.setAttribute("user", currentUser);
                setMessage(session, "Đổi mật khẩu thành công!");
            } else {
                setError(session, "Đổi mật khẩu thất bại.");
            }
        } catch (Exception e) {
            setError(session, "Lỗi khi xử lý mật khẩu: " + e.getMessage());
        } finally {
            response.sendRedirect("profile");
        }
    }

    private void handleUpdateProfile(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, User currentUser, DAOUser daoUser) throws IOException, ServletException {
        int userId = currentUser.getUserID();
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String dobParam = request.getParameter("dob");
        String address = request.getParameter("address");
        java.sql.Date sqlDob = parseDateOfBirth(dobParam, session);

        if (sqlDob == null && session.getAttribute("error") != null) {
            response.sendRedirect("profile");
            return;
        }

        if (phone != null && !phone.trim().isEmpty() && !phone.equals(currentUser.getPhone())) {
            try {
                if (daoUser.isPhoneExist(phone, userId)) {
                    setError(session, "Số điện thoại đã được sử dụng bởi người dùng khác.");
                    response.sendRedirect("profile");
                    return;
                }
            } catch (SQLException e) {
                setError(session, "Lỗi khi kiểm tra số điện thoại: " + e.getMessage());
                response.sendRedirect("profile");
                return;
            }
        }

        String avatar = handleFileUpload(request, currentUser.getAvatar());
        User updatedUser = new User(userId, currentUser.getRoleID(), currentUser.getEmail(), fullName, phone,
                currentUser.getCreateAt(), currentUser.getIsActive(), sqlDob, address,
                avatar, currentUser.getUserName(), currentUser.getPassword());

        if (daoUser.updateUser(updatedUser)) {
            session.setAttribute("user", updatedUser);
            setMessage(session, "Cập nhật hồ sơ thành công!");
        } else {
            setError(session, "Cập nhật hồ sơ thất bại.");
        }
        response.sendRedirect("profile");
    }

    private java.sql.Date parseDateOfBirth(String dobParam, HttpSession session) {
        if (dobParam == null || dobParam.trim().isEmpty()) {
            return null;
        }
        try {
            LocalDate localDate = LocalDate.parse(dobParam);
            return java.sql.Date.valueOf(localDate);
        } catch (java.time.format.DateTimeParseException e) {
            setError(session, "Ngày sinh không hợp lệ. Vui lòng nhập theo định dạng yyyy-MM-dd (ví dụ: 2025-02-25).");
            return null;
        }
    }

    private String handleFileUpload(HttpServletRequest request, String currentAvatar) throws IOException, ServletException {
        Part filePart = request.getPart("avatar");
        if (filePart != null && filePart.getSize() > 0) {
            String uploadPath = getServletContext().getRealPath("/") + "uploads/";
            String fileName = filePart.getSubmittedFileName();
            filePart.write(uploadPath + fileName);
            return "uploads/" + fileName;
        }
        return currentAvatar;
    }

    private void setError(HttpSession session, String errorMessage) {
        session.setAttribute("error", errorMessage);
    }

    private void setMessage(HttpSession session, String message) {
        session.setAttribute("message", message);
    }

    private String hashPassword(String password) throws Exception {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hash = digest.digest(password.getBytes("UTF-8"));
        StringBuilder hexString = new StringBuilder();
        for (byte b : hash) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex);
        }
        return hexString.toString();
    }
}