/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.User;
import model.DAOUser;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Locale;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;


/**
 *
 * @author Heizxje
 */
@WebServlet("/UpdateProfileServlet")
@MultipartConfig(fileSizeThreshold = 2 * 1024 * 1024, // 2MB
        maxFileSize = 10 * 1024 * 1024, // 10MB
        maxRequestSize = 50 * 1024 * 1024)   // 50MB
public class UpdateProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        try {
            // Kiểm tra xem userId có trong session không
            Integer userId = (Integer) session.getAttribute("userId");
            if (userId == null) {
                session.setAttribute("error", "Bạn chưa đăng nhập!");
                response.sendRedirect("login.jsp");
                return;
            }

            // Lấy thông tin từ form
            String email = request.getParameter("email");
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String dobParam = request.getParameter("dob");
            String address = request.getParameter("address");

            // Kiểm tra dữ liệu đầu vào
            if (fullName == null || fullName.trim().isEmpty() || phone == null || phone.trim().isEmpty()) {
                session.setAttribute("error", "Vui lòng điền đầy đủ họ tên và số điện thoại.");
                response.sendRedirect("profile_user.jsp");
                return;
            }

            // Xử lý ngày sinh
            Date dob = null;
            if (dobParam != null && !dobParam.trim().isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
                    java.util.Date parsedDate = sdf.parse(dobParam);
                    dob = new Date(parsedDate.getTime());
                } catch (Exception e) {
                    session.setAttribute("error", "Ngày sinh không hợp lệ. Định dạng phải là yyyy-MM-dd.");
                    response.sendRedirect("profile_user.jsp");
                    return;
                }
            }

            // Lấy thông tin user hiện tại từ DB
            DAOUser daoUser = new DAOUser();
            User existingUser = daoUser.getUserById(userId);
            if (existingUser == null) {
                session.setAttribute("error", "Không tìm thấy thông tin người dùng.");
                response.sendRedirect("profile_user.jsp");
                return;
            }

            // Xử lý ảnh đại diện (avatar)
            Part filePart = request.getPart("avatar");
            String avatar = existingUser.getAvatar(); // Mặc định giữ nguyên avatar cũ
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Path.of(filePart.getSubmittedFileName()).getFileName().toString();
                String uploadDir = getServletContext().getRealPath("/") + "uploads/";
                Path filePath = Path.of(uploadDir, fileName);

                try (InputStream fileContent = filePart.getInputStream()) {
                    Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING);
                }
                avatar = "uploads/" + fileName;
            }

            // Tạo đối tượng User mới chỉ với thông tin cần cập nhật
            User updatedUser = new User(userId, email, fullName, phone, 
                                        existingUser.getPassword(), dob, address, avatar);

            // Cập nhật thông tin người dùng
            boolean updateSuccess = daoUser.updateUser(updatedUser);
            if (updateSuccess) {
                session.setAttribute("success", "Cập nhật hồ sơ thành công!");
                session.setAttribute("user", updatedUser); // Cập nhật session với user mới
                response.sendRedirect("profile_user.jsp");
            } else {
                session.setAttribute("error", "Cập nhật thất bại, vui lòng thử lại.");
                response.sendRedirect("profile_user.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Đã xảy ra lỗi trong quá trình cập nhật.");
            response.sendRedirect("profile_user.jsp");
        }
    }
}
