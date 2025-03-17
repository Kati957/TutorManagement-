package AdminController;

import model.DAOHistoryLog;
import entity.HistoryLog;
import entity.User;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/historyLog")
public class HistoryLogServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        List<HistoryLog> logs = new ArrayList<>();
        try {
            DAOHistoryLog dao = new DAOHistoryLog();
            logs = dao.getAllLogs();

            // Tạo ánh xạ RoleID sang RoleName
            Map<Integer, String> roleMap = new HashMap<>();
            roleMap.put(1, "Admin");
            roleMap.put(2, "User");
            roleMap.put(3, "Tutor");
            roleMap.put(4, "Staff");

            // Gán RoleName, FullName, Email cho mỗi log
            for (HistoryLog log : logs) {
                if (log.getUserId() != null && log.getUserId() != 0) {
                    int roleId = log.getRoleId() != 0 ? log.getRoleId() : 2; // Lấy RoleID từ log, mặc định User
                    String roleName = roleMap.getOrDefault(roleId, "Unknown");
                    log.setRoleName(roleName);

                    // Sử dụng FullName và Email từ DAOHistoryLog
                    log.setFullName(log.getFullName() != null ? log.getFullName() : "N/A");
                    log.setEmail(log.getEmail() != null ? log.getEmail() : "N/A");
                } else {
                    log.setRoleName("Anonymous");
                    log.setFullName("N/A");
                    log.setEmail("N/A");
                }
            }

            request.setAttribute("logs", logs);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load log history.");
        }

        request.getRequestDispatcher("/admin/historyLog.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}