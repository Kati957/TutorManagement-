/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Staff;

import entity.Subject;
import model.DAOSubject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author minht
 */
@WebServlet(name = "SubjectController", urlPatterns = {"/staff/SubjectController"})
public class SubjectController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String service = request.getParameter("service");

        if (service == null) {
            service = "listSubject"; // Mặc định hiển thị danh sách subject
        }

        DAOSubject dao = new DAOSubject();

        switch (service) {
            case "addSubject":
                handleAddSubject(request, response, dao);
                break;
            case "listSubject":
                handleListSubject(request, response, dao);
                break;
            case "updateSubject":
                handleUpdateSubject(request, response, dao);
                break;
            case "deleteSubject":
                handleDeleteSubject(request, response, dao);
                break;
            default:
                response.sendRedirect("error-404.jsp");
        }
    }

    // Xử lý thêm subject
    private void handleAddSubject(HttpServletRequest request, HttpServletResponse response, DAOSubject dao)
            throws ServletException, IOException {
        String submit = request.getParameter("submit");
        if (submit == null) {
            // Hiển thị form thêm subject
            response.sendRedirect(request.getContextPath() + "/staff/addSubject.jsp");
            return;
        }

        // Lấy dữ liệu từ form
        String subjectName = request.getParameter("subjectName");
        String description = request.getParameter("description");

        Subject subject = new Subject(0, subjectName, description);

        try {
            int newId = dao.addSubject(subject);
            if (newId > 0) {
                // Thành công -> redirect về list
                response.sendRedirect(request.getContextPath() + "/staff/SubjectController?service=listSubject");
            } else {
                // Thất bại -> redirect với thông báo lỗi
                HttpSession session = request.getSession();
                session.setAttribute("error", "Tạo mới subject thất bại, hãy để ý tên không được trùng với những subject khác");
                response.sendRedirect(request.getContextPath() + "/staff/addSubject.jsp?error=AddFailed");
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectController.class.getName()).log(Level.SEVERE, "Database error", ex);
        }
    }

    // Xử lý hiển thị danh sách subject
    private void handleListSubject(HttpServletRequest request, HttpServletResponse response, DAOSubject dao)
            throws ServletException, IOException {
        try {
            // Lấy danh sách từ bảng Subject
            List<Subject> subjectList = dao.getAllSubjects();
            request.setAttribute("subjectList", subjectList);

            // Lấy danh sách Tutor-Subject
            List<Subject> tutorSubjectList = dao.getAllTutorSubjects();
            request.setAttribute("tutorSubjectList", tutorSubjectList);

            request.getRequestDispatcher("/staff/manageSubject.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(SubjectController.class.getName()).log(Level.SEVERE, "Database error", ex);
            response.sendRedirect("error-404.jsp");
        }
    }

    private void handleUpdateSubject(HttpServletRequest request, HttpServletResponse response, DAOSubject dao)
            throws ServletException, IOException {
        String subjectIDStr = request.getParameter("subjectID");
        if (subjectIDStr == null || subjectIDStr.isEmpty()) {
            response.sendRedirect("error-404.jsp");
            return;
        }

        int subjectID;
        try {
            subjectID = Integer.parseInt(subjectIDStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("error-404.jsp");
            return;
        }

        try {
            Subject subject = dao.getSubjectById(subjectID);
            if (subject == null) {
                response.sendRedirect("error-404.jsp");
                return;
            }

            String submit = request.getParameter("submit");
            if (submit == null) {
                // Hiển thị form cập nhật
                request.setAttribute("subject", subject);
                request.getRequestDispatcher("/staff/updateSubject.jsp").forward(request, response);
                return;
            }

            // Lấy dữ liệu từ form
            String subjectName = request.getParameter("subjectName");
            String description = request.getParameter("description");

            subject.setSubjectName(subjectName);
            subject.setDescription(description);

            int n = dao.updateSubject(subject);

            if (n > 0) {
                // Update thành công
                response.sendRedirect(request.getContextPath() + "/staff/SubjectController?service=listSubject");
            } else {
                // Lỗi → lưu vào session rồi redirect
                HttpSession session = request.getSession();
                session.setAttribute("error", "Cập nhật lỗi!");
                response.sendRedirect(request.getContextPath() + "/staff/SubjectController?service=listSubject");
            }

        } catch (SQLException ex) {
            Logger.getLogger(SubjectController.class.getName()).log(Level.SEVERE, "Database error", ex);
        }
    }

    private void handleDeleteSubject(HttpServletRequest request, HttpServletResponse response, DAOSubject dao)
            throws ServletException, IOException {
        String subjectIDStr = request.getParameter("subjectID");
        if (subjectIDStr == null || subjectIDStr.isEmpty()) {
            response.sendRedirect("error-404.jsp");
            return;
        }

        int subjectID;
        try {
            subjectID = Integer.parseInt(subjectIDStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("error-404.jsp");
            return;
        }

        try {
            int n = dao.deleteSubject(subjectID);
            if (n > 0) {
                HttpSession session = request.getSession();
                session.setAttribute("error", "Xóa thành công");
                response.sendRedirect(request.getContextPath() + "/staff/SubjectController?service=listSubject");

            } else {
                HttpSession session = request.getSession();
                session.setAttribute("error", "Không thể xóa");
                response.sendRedirect(request.getContextPath() + "/staff/SubjectController?service=listSubject");
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectController.class.getName()).log(Level.SEVERE, "Database error", ex);
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
        return "Subject Controller Servlet";
    }
}
