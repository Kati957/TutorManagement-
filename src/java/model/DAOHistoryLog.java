package model;

import entity.HistoryLog;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * Lớp DAO để quản lý ghi log truy cập vào bảng HistoryLog
 *
 * @author Heizxje
 */
public class DAOHistoryLog {

    private DBConnect dbConnect;

    // Khởi tạo với kết nối mặc định
    public DAOHistoryLog() {
        this.dbConnect = new DBConnect();
    }

    // Khởi tạo với kết nối tùy chỉnh
    public DAOHistoryLog(String url, String username, String password) {
        this.dbConnect = new DBConnect(url, username, password);
    }

    /**
     * Ghi log cho một hành động vào bảng HistoryLog
     *
     * @param userId ID của người dùng
     * @param actionType Loại hành động (LOGIN, LOGOUT, ACCESS_PAGE, v.v.)
     * @param targetId ID của mục tiêu (có thể null)
     * @param details Thông tin chi tiết về hành động
     * @throws SQLException Nếu có lỗi khi thực hiện truy vấn
     */
    public void logAction(int userId, String actionType, Integer targetId, String details) throws SQLException {
        String sql = "INSERT INTO HistoryLog (UserID, ActionType, TargetID, Details, LogDate) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = dbConnect.conn; PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setString(2, actionType);
            stmt.setObject(3, targetId); // Hỗ trợ giá trị NULL
            stmt.setString(4, details != null ? details : "No details");
            stmt.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
            stmt.executeUpdate();
            System.out.println("Log recorded: " + actionType + " for UserID " + userId);
        } catch (SQLException ex) {
            System.out.println("Error recording log: " + ex.getMessage());
            throw ex;
        }
    }

    // Phương thức tiện ích để ghi log đăng nhập
    public void logLogin(int userId) throws SQLException {
        logAction(userId, "LOGIN", null, "User logged in successfully");
    }

    // Phương thức tiện ích để ghi log đăng xuất
    public void logLogout(int userId) throws SQLException {
        logAction(userId, "LOGOUT", null, "User logged out");
    }

    // Phương thức tiện ích để ghi log truy cập trang
    public void logPageAccess(int userId, String pageUrl) throws SQLException {
        logAction(userId, "ACCESS_PAGE", null, "Accessed page: " + pageUrl);
    }

    // Lấy tất cả log từ bảng HistoryLog với RoleID (cho sidebar)
    public List<HistoryLog> getAllLogs() throws SQLException {
        List<HistoryLog> logs = new ArrayList<>();
        String sql = "SELECT TOP 1000 hl.*, u.FullName, u.Email, u.RoleID "
                + "FROM HistoryLog hl "
                + "LEFT JOIN Users u ON hl.UserID = u.UserID "
                + "ORDER BY hl.LogDate DESC";
        try (ResultSet rs = dbConnect.getData(sql)) {
            while (rs.next()) {
                HistoryLog log = new HistoryLog();
                log.setLogId(rs.getInt("LogID"));
                log.setUserId(rs.getInt("UserID"));
                log.setActionType(rs.getString("ActionType"));
                if (rs.getObject("TargetID") != null) {
                    log.setTargetId(rs.getString("TargetID"));
                } else {
                    log.setTargetId(null);
                }
                log.setDetails(rs.getString("Details"));
                log.setLogDate(rs.getTimestamp("LogDate"));
                // Lấy thông tin từ Users
                log.setFullName(rs.getString("FullName"));
                log.setEmail(rs.getString("Email"));
                log.setRoleId(rs.getInt("RoleID"));
                logs.add(log);
            }
        } catch (SQLException ex) {
            System.out.println("Error fetching logs: " + ex.getMessage());
            throw ex;
        }
        return logs;
    }

    // Lấy 5 log mới nhất (cho dashboard)
    public List<HistoryLog> getRecentLogs() throws SQLException {
        List<HistoryLog> logs = new ArrayList<>();
        String sql = "SELECT TOP 5 hl.*, u.FullName, u.Email, u.RoleID "
                + "FROM HistoryLog hl "
                + "LEFT JOIN Users u ON hl.UserID = u.UserID "
                + "ORDER BY hl.LogDate DESC";
        try (ResultSet rs = dbConnect.getData(sql)) {
            while (rs.next()) {
                HistoryLog log = new HistoryLog();
                log.setLogId(rs.getInt("LogID"));
                log.setUserId(rs.getInt("UserID"));
                log.setActionType(rs.getString("ActionType"));
                if (rs.getObject("TargetID") != null) {
                    log.setTargetId(rs.getString("TargetID"));
                } else {
                    log.setTargetId(null);
                }
                log.setDetails(rs.getString("Details"));
                log.setLogDate(rs.getTimestamp("LogDate"));
                // Lấy thông tin từ Users
                log.setFullName(rs.getString("FullName"));
                log.setEmail(rs.getString("Email"));
                log.setRoleId(rs.getInt("RoleID"));
                logs.add(log);
            }
        } catch (SQLException ex) {
            System.out.println("Error fetching recent logs: " + ex.getMessage());
            throw ex;
        }
        return logs;
    }

    // Đóng kết nối (nếu cần)
    public void closeConnection() {
        if (dbConnect != null && dbConnect.conn != null) {
            try {
                dbConnect.conn.close();
                System.out.println("Connection closed");
            } catch (SQLException ex) {
                System.out.println("Error closing connection: " + ex.getMessage());
            }
        }
    }

    // Test phương thức
    public static void main(String[] args) {
        DAOHistoryLog dao = new DAOHistoryLog();
        try {
            dao.logLogin(1); // Test với UserID = 1
            dao.logLogout(1); // Test với UserID = 1
            dao.logPageAccess(1, "/admin-profile.jsp"); // Test với UserID = 1
            System.out.println("Testing getRecentLogs:");
            List<HistoryLog> recentLogs = dao.getRecentLogs();
            for (HistoryLog log : recentLogs) {
                System.out.println("Log ID: " + log.getLogId() + ", Action: " + log.getActionType()
                        + ", Date: " + log.getLogDate() + ", RoleID: " + log.getRoleId());
            }
            System.out.println("Testing getAllLogs:");
            List<HistoryLog> allLogs = dao.getAllLogs();
            for (HistoryLog log : allLogs) {
                System.out.println("Log ID: " + log.getLogId() + ", Action: " + log.getActionType()
                        + ", Date: " + log.getLogDate() + ", RoleID: " + log.getRoleId());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            dao.closeConnection();
        }
    }
}