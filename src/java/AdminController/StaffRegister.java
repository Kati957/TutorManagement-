/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AdminController;

import entity.User;
import model.DAOUser;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "StaffRegister", urlPatterns = {"/admin/StaffRegister"})
public class StaffRegister extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(StaffRegister.class.getName());
    private static final String STAFF_MANAGEMENT_JSP = "/admin/staff-management.jsp";

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    DAOUser dao = new DAOUser();
    String add = request.getParameter("add");
    String edit = request.getParameter("edit");
    String delete = request.getParameter("delete");

    try {
        List<User> staffList = dao.getUsersByRole(4);
        request.setAttribute("staffList", staffList);
        LOGGER.log(Level.INFO, "Staff list size: " + staffList.size()); // Thêm log để kiểm tra

        if ("true".equals(add)) {
            request.getRequestDispatcher(STAFF_MANAGEMENT_JSP).forward(request, response);
            return;
        } else if (edit != null) {
            int editId = Integer.parseInt(edit);
            User editUser = dao.getUserById(editId);
            if (editUser != null && editUser.getRoleID() == 4) {
                request.setAttribute("editUser", editUser);
                request.getRequestDispatcher(STAFF_MANAGEMENT_JSP).forward(request, response);
            } else {
                request.setAttribute("error", "Không tìm thấy nhân viên để chỉnh sửa!");
                request.getRequestDispatcher(STAFF_MANAGEMENT_JSP).forward(request, response);
            }
            return;
        } else if (delete != null) {
            int deleteId = Integer.parseInt(delete);
            User userToDelete = dao.getUserById(deleteId);
            if (userToDelete != null && userToDelete.getRoleID() == 4) {
                int result = dao.deleteUser(deleteId);
                HttpSession session = request.getSession();
                if (result > 0) {
                    session.setAttribute("success", "Xóa nhân viên thành công!");
                } else {
                    request.setAttribute("error", "Xóa nhân viên thất bại!");
                }
            }
            response.sendRedirect(request.getContextPath() + "/admin/StaffRegister");
            return;
        } else {
            request.getRequestDispatcher(STAFF_MANAGEMENT_JSP).forward(request, response);
            return;
        }
    } catch (Exception ex) {
        LOGGER.log(Level.SEVERE, "Error in GET request", ex);
        request.setAttribute("error", "Lỗi hệ thống: " + ex.getMessage());
        request.getRequestDispatcher(STAFF_MANAGEMENT_JSP).forward(request, response);
    }
}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        DAOUser dao = new DAOUser();

        if (!dao.isConnected()) {
            LOGGER.log(Level.SEVERE, "Database connection is null");
            request.setAttribute("error", "Không thể kết nối cơ sở dữ liệu.");
            request.getRequestDispatcher(STAFF_MANAGEMENT_JSP).forward(request, response);
            return;
        }

        String userID = request.getParameter("UserID");
        String email = request.getParameter("Email");
        String fullName = request.getParameter("FullName");
        String phone = request.getParameter("Phone");
        String dob = request.getParameter("Dob");
        String address = request.getParameter("Address");
        String userName = request.getParameter("UserName");
        String password = request.getParameter("Password");

        try {
            String error = validateInput(dao, email, fullName, phone, dob, address, userName, password, userID);
            if (!error.isEmpty()) {
                request.setAttribute("error", error);
                request.getRequestDispatcher(STAFF_MANAGEMENT_JSP).forward(request, response);
                return;
            }

            User user = new User(
                    userID != null && !userID.isEmpty() ? Integer.parseInt(userID) : 0,
                    4, // RoleID cố định là 4 cho staff
                    email, fullName, phone, null, 1,
                    Date.valueOf(dob), address, "default_avatar.jpg", userName, password
            );

            int result;
            if (userID != null && !userID.isEmpty()) {
                result = dao.updateUser(user) ? 1 : 0;
            } else {
                result = dao.registerUser(user);
            }

            if (result > 0) {
                session.setAttribute("success", userID != null ? "Cập nhật nhân viên thành công!" : "Thêm nhân viên thành công!");
                response.sendRedirect(request.getContextPath() + "/admin/StaffRegister");
            } else {
                request.setAttribute("error", "Thao tác thất bại. Vui lòng thử lại.");
                request.getRequestDispatcher(STAFF_MANAGEMENT_JSP).forward(request, response);
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error processing POST request", ex);
            request.setAttribute("error", "Lỗi hệ thống: " + ex.getMessage());
            request.getRequestDispatcher(STAFF_MANAGEMENT_JSP).forward(request, response);
        }
    }

    private String validateInput(DAOUser dao, String email, String fullName, String phone, String dob,
            String address, String userName, String password, String userID) throws SQLException {
        if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) return "Email không hợp lệ.";
        User existingUser = dao.getUserById(userID != null && !userID.isEmpty() ? Integer.parseInt(userID) : -1);
        if (dao.isEmailExists(email) && (existingUser == null || !existingUser.getEmail().equals(email))) {
            return "Email đã được sử dụng.";
        }
        if (userName == null || userName.trim().isEmpty()) return "Username không được để trống.";
        if (dao.isUsernameExists(userName) && (existingUser == null || !existingUser.getUserName().equals(userName))) {
            return "Username đã tồn tại.";
        }
        if (phone == null || !phone.matches("\\d{10}")) return "Số điện thoại phải là 10 chữ số.";
        if (dao.isPhoneExists(phone) && (existingUser == null || !existingUser.getPhone().equals(phone))) {
            return "Số điện thoại đã được sử dụng.";
        }
        if (password == null || password.length() < 8) return "Mật khẩu phải dài ít nhất 8 ký tự.";
        if (dob == null || dob.trim().isEmpty()) return "Ngày sinh không được để trống.";
        if (fullName == null || fullName.trim().isEmpty()) return "Họ và tên không được để trống.";
        if (address == null || address.trim().isEmpty()) return "Địa chỉ không được để trống.";
        return "";
    }

    @Override
    public String getServletInfo() {
        return "Servlet for staff management";
    }
}