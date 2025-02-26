/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.User;
import model.DAOUser;
import java.io.IOException;
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
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ProfileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        request.setAttribute("user", currentUser);
        request.getRequestDispatcher("/profile_user.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        DAOUser daoUser = new DAOUser();

        if ("changePassword".equals(action)) {
            // Xử lý đổi mật khẩu
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            try {
                // Kiểm tra mật khẩu hiện tại (giả sử mật khẩu trong DB không mã hóa)
                if (!currentUser.getPassword().equals(currentPassword)) {
                    session.setAttribute("error", "Mật khẩu hiện tại không đúng.");
                    response.sendRedirect("profile");
                    return;
                }

                // Kiểm tra mật khẩu mới và xác nhận mật khẩu
                if (!newPassword.equals(confirmPassword)) {
                    session.setAttribute("error", "Mật khẩu mới và xác nhận mật khẩu không khớp.");
                    response.sendRedirect("profile");
                    return;
                }

                // Cập nhật mật khẩu
                currentUser.setPassword(newPassword);
                if (daoUser.updateUser(currentUser)) {
                    session.setAttribute("user", currentUser);
                    session.setAttribute("message", "Đổi mật khẩu thành công!");
                    response.sendRedirect("profile");
                } else {
                    session.setAttribute("error", "Đổi mật khẩu thất bại.");
                    response.sendRedirect("profile");
                }
            } catch (Exception e) {
                session.setAttribute("error", "Lỗi khi xử lý mật khẩu: " + e.getMessage());
                response.sendRedirect("profile");
            }
        } else {
            // Xử lý chỉnh sửa hồ sơ
            int userId = currentUser.getUserID();
            String email = request.getParameter("email");
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String dobParam = request.getParameter("dob");
            java.sql.Date sqlDob = null;
            if (dobParam != null && !dobParam.trim().isEmpty()) {
                try {
                    LocalDate localDate = LocalDate.parse(dobParam);
                    sqlDob = java.sql.Date.valueOf(localDate);
                } catch (java.time.format.DateTimeParseException e) {
                    session.setAttribute("error", "Ngày sinh không hợp lệ. Vui lòng nhập theo định dạng yyyy-MM-dd (ví dụ: 2025-02-25).");
                    response.sendRedirect("profile");
                    return;
                }
            }
            String address = request.getParameter("address");

            // Xử lý file upload
            Part filePart = request.getPart("avatar");
            String avatar = currentUser.getAvatar();
            if (filePart != null && filePart.getSize() > 0) {
                String uploadPath = getServletContext().getRealPath("/") + "uploads/";
                avatar = "uploads/" + filePart.getSubmittedFileName();
                filePart.write(uploadPath + filePart.getSubmittedFileName());
            }

            User user = new User(userId, currentUser.getRoleID(), email, fullName, phone, currentUser.getCreateAt(), currentUser.getIsActive(), sqlDob, address, avatar, currentUser.getUserName(), currentUser.getPassword());

            if (daoUser.updateUser(user)) {
                session.setAttribute("user", user);
                session.setAttribute("message", "Cập nhật hồ sơ thành công!");
                response.sendRedirect("profile");
            } else {
                session.setAttribute("error", "Cập nhật hồ sơ thất bại.");
                response.sendRedirect("profile");
            }
        }
    }

    // Hàm mã hóa mật khẩu (nếu cần)
    private String hashPassword(String password) throws Exception {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hash = digest.digest(password.getBytes("UTF-8"));
        StringBuilder hexString = new StringBuilder();
        for (byte b : hash) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) hexString.append('0');
            hexString.append(hex);
        }
        return hexString.toString();
    }
}