/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.User;
import model.DAOUser;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.Locale;

/**
 *
 * @author Heizxje
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ProfileServlet extends HttpServlet {

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // Khởi tạo DAOUser
    DAOUser daoUser = new DAOUser();

    // Lấy userId từ request (ví dụ: thông qua tham số URL)
    int userId = Integer.parseInt(request.getParameter("userId"));

    // Lấy thông tin người dùng từ DAOUser
    User user = daoUser.getUserById(userId);

    if (user != null) {
        // Đặt đối tượng user vào request
        request.setAttribute("user", user);

        // Chuyển hướng đến trang JSP
        request.getRequestDispatcher("/profile_user.jsp").forward(request, response);
    } else {
        // Xử lý trường hợp user không tồn tại
        response.sendRedirect("error.jsp");
    }
}

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = currentUser.getUserID();
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String dobParam = request.getParameter("dob");
        Date dob = null;
        if (dobParam != null && !dobParam.trim().isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
                java.util.Date parsedDate = sdf.parse(dobParam);
                dob = new Date(parsedDate.getTime());
            } catch (Exception e) {
                request.setAttribute("error", "Ngày sinh không hợp lệ. Định dạng phải là yyyy-MM-dd.");
                request.getRequestDispatcher("views/profile.jsp").forward(request, response);
                return;
            }
        }
        String address = request.getParameter("address");

        // Xử lý file upload
        Part filePart = request.getPart("avatar");
        String avatar = currentUser.getAvatar(); // Giữ nguyên avatar cũ nếu không có file mới

        if (filePart != null && filePart.getSize() > 0) {
            String uploadPath = getServletContext().getRealPath("/") + "uploads/";
            avatar = "uploads/" + filePart.getSubmittedFileName();
            filePart.write(uploadPath + filePart.getSubmittedFileName());
        }

        User user = new User(userId, currentUser.getRoleID(), email, fullName, phone, currentUser.getCreateAt(), currentUser.getIsActive(), (java.sql.Date) dob, address, avatar, currentUser.getUserName(), currentUser.getPassword());

        DAOUser daoUser = new DAOUser();
        if (daoUser.updateUser(user)) {
            session.setAttribute("user", user); // Cập nhật lại session
            response.sendRedirect("profile");
        } else {
            request.setAttribute("error", "Update failed");
            request.getRequestDispatcher("views/profile.jsp").forward(request, response);
        }
    }
}
