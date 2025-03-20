/*
 * Click nbfs://SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package UserController;

import entity.User;
import model.DAOUser;
import model.DAOHistoryLog; // Đảm bảo import này
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

/**
 * Servlet xử lý đăng ký người dùng.
 *
 * @author Heizxje
 */
@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class ProfileServlet extends HttpServlet {

    private static final String PROFILE_PAGE = "/profile_user.jsp";
    private static final String LOGIN_PAGE = "login.jsp";
    private static final int MIN_PASSWORD_LENGTH = 8;
    private DAOUser daoUser;
    private DAOHistoryLog daoLog;

    @Override
    public void init() throws ServletException {
        daoUser = new DAOUser();
        daoLog = new DAOHistoryLog();
    }

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
            // Kiểm tra mật khẩu hiện tại
            if (!currentUser.getPassword().equals(currentPassword)) {
                setError(session, "Mật khẩu hiện tại không đúng.");
                response.sendRedirect("profile");
                return;
            }

            // Kiểm tra mật khẩu mới và xác nhận
            if (!newPassword.equals(confirmPassword)) {
                setError(session, "Mật khẩu mới và xác nhận mật khẩu không khớp.");
                response.sendRedirect("profile");
                return;
            }

            if (newPassword.length() < MIN_PASSWORD_LENGTH) {
                setError(session, "Mật khẩu mới phải có ít nhất " + MIN_PASSWORD_LENGTH + " ký tự.");
                response.sendRedirect("profile");
                return;
            }

            // Cập nhật mật khẩu
            currentUser.setPassword(newPassword);
            if (daoUser.updateUser(currentUser)) {
                session.setAttribute("user", currentUser);
                // Ghi log thay đổi mật khẩu
                daoLog.logUserProfileUpdate(currentUser.getUserID(), "Password");
                setMessage(session, "Đổi mật khẩu thành công!");
            } else {
                setError(session, "Đổi mật khẩu thất bại.");
            }
        } catch (SQLException e) {
            setError(session, "Lỗi khi xử lý mật khẩu: " + e.getMessage());
        } catch (Exception e) {
            setError(session, "Lỗi không xác định: " + e.getMessage());
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

        String avatarPath = handleFileUpload(request, currentUser.getAvatar());
        User updatedUser = new User(userId, currentUser.getRoleID(), currentUser.getEmail(), fullName, phone,
                currentUser.getCreateAt(), currentUser.getIsActive(), sqlDob, address,
                avatarPath, currentUser.getUserName(), currentUser.getPassword());

        // So sánh để xác định các trường đã thay đổi
        StringBuilder updatedFields = new StringBuilder();
        if (!currentUser.getFullName().equals(fullName)) {
            updatedFields.append("FullName, ");
        }
        if (!currentUser.getPhone().equals(phone)) {
            updatedFields.append("Phone, ");
        }
        if (currentUser.getDob() != null && !currentUser.getDob().equals(sqlDob)) {
            updatedFields.append("DateOfBirth, ");
        }
        if (!currentUser.getAddress().equals(address)) {
            updatedFields.append("Address, ");
        }
        if (!currentUser.getAvatar().equals(avatarPath)) {
            updatedFields.append("Avatar, ");
        }

        try {
            if (daoUser.updateUser(updatedUser)) {
                if (updatedFields.length() > 0) {
                    updatedFields.setLength(updatedFields.length() - 2);
                    daoLog.logUserProfileUpdate(userId, updatedFields.toString());
                }
                session.setAttribute("user", updatedUser);
                setMessage(session, "Cập nhật hồ sơ thành công!");
            } else {
                setError(session, "Cập nhật hồ sơ thất bại.");
            }
        } catch (SQLException e) {
            setError(session, "Lỗi khi cập nhật hồ sơ: " + e.getMessage());
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
            setError(session, "Ngày sinh không hợp lệ. Vui lòng nhập theo định dạng yyyy-MM-dd.");
            return null;
        }
    }

    private String handleFileUpload(HttpServletRequest request, String currentAvatar) throws IOException, ServletException {
        Part filePart = request.getPart("avatar");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = extractFileName(filePart);
            if (fileName != null && isImageFile(fileName)) {
                String uploadPath = getServletContext().getRealPath("") + "uploads/";
                java.io.File uploadDir = new java.io.File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }
                filePart.write(uploadPath + fileName);
                return "uploads/" + fileName;
            } else {
                return currentAvatar;
            }
        }
        return currentAvatar;
    }

    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] items = contentDisposition.split(";");
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf("=") + 2, item.length() - 1);
            }
        }
        return null;
    }

    private boolean isImageFile(String fileName) {
        String[] allowedExtensions = {".jpg", ".jpeg", ".png", ".gif"};
        for (String ext : allowedExtensions) {
            if (fileName.toLowerCase().endsWith(ext)) {
                return true;
            }
        }
        return false;
    }

    private void setError(HttpSession session, String errorMessage) {
        session.setAttribute("error", errorMessage);
    }

    private void setMessage(HttpSession session, String message) {
        session.setAttribute("message", message);
    }
}
