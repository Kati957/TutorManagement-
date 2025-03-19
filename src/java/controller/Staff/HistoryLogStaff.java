/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.Staff;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAOHistoryLog;
import entity.HistoryLog;
import entity.User;

/**
 *
 * @author Heizxje
 */
@WebServlet(name = "HistoryLog", urlPatterns = {"/staff/historyLog"})
public class HistoryLogStaff extends HttpServlet {

    private DAOHistoryLog dao;

    @Override
    public void init() throws ServletException {
        dao = new DAOHistoryLog(); // Khởi tạo DAO
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user.getRoleID() != 4) { // Chỉ staff (RoleID = 4) được xem
            response.sendRedirect(request.getContextPath() + "/access-denied.jsp");
            return;
        }
        
        try {
            // Lấy danh sách log của User và Tutor
            List<HistoryLog> logs = dao.getUserAndTutorLogs();
            request.setAttribute("logs", logs);
            request.getRequestDispatcher("/staff/historylog.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Error loading user and tutor logs: " + e.getMessage());
            request.getRequestDispatcher("/staff/historylog.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu cần xử lý POST (hiện tại chưa cần), bạn có thể thêm logic ở đây
        doGet(request, response); // Gọi lại doGet để xử lý đơn giản
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet to display history logs of Users and Tutors for Staff";
    }

    @Override
    public void destroy() {
        if (dao != null) {
            dao.closeConnection(); // Đóng kết nối khi servlet bị hủy
        }
    }
}