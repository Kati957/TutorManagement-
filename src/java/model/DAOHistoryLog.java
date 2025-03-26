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
     * @param actionType Loại hành động (LOGIN, LOGOUT, v.v.)
     * @param targetId ID của mục tiêu (có thể null)
     * @param details Thông tin chi tiết về hành động
     * @throws SQLException Nếu có lỗi khi thực hiện truy vấn
     */
    public void logAction(int userId, String actionType, Integer targetId, String details) throws SQLException {
        if (userId <= 0) {
            System.out.println("Invalid UserID: " + userId + ". Skipping log.");
            return; // Bỏ qua nếu userId không hợp lệ
        }

        String sql = "INSERT INTO HistoryLog (UserID, ActionType, TargetID, Details, LogDate) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = dbConnect.getConnection(); // Sửa để dùng getConnection()
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setString(2, actionType);
            stmt.setObject(3, targetId); // Hỗ trợ giá trị NULL
            stmt.setString(4, details != null ? details : "No details");
            stmt.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
            stmt.executeUpdate();
            System.out.println("Log recorded: " + actionType + " for UserID " + userId);
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

    // Lấy tất cả log từ bảng HistoryLog với RoleID (cho sidebar)
    public List<HistoryLog> getAllLogs() throws SQLException {
        List<HistoryLog> logs = new ArrayList<>();
        String sql = "SELECT TOP 1000 hl.*, u.FullName, u.Email, u.RoleID "
                + "FROM HistoryLog hl "
                + "LEFT JOIN Users u ON hl.UserID = u.UserID "
                + "ORDER BY hl.LogDate DESC";
        try (Connection conn = dbConnect.getConnection();
             ResultSet rs = conn.createStatement().executeQuery(sql)) {
            while (rs.next()) {
                HistoryLog log = new HistoryLog();
                log.setLogId(rs.getInt("LogID"));
                log.setUserId(rs.getInt("UserID"));
                log.setActionType(rs.getString("ActionType"));
                log.setTargetId(rs.getObject("TargetID") != null ? rs.getString("TargetID") : null);
                log.setDetails(rs.getString("Details"));
                log.setLogDate(rs.getTimestamp("LogDate"));
                log.setFullName(rs.getString("FullName"));
                log.setEmail(rs.getString("Email"));
                log.setRoleId(rs.getInt("RoleID"));
                logs.add(log);
            }
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
        try (Connection conn = dbConnect.getConnection();
             ResultSet rs = conn.createStatement().executeQuery(sql)) {
            while (rs.next()) {
                HistoryLog log = new HistoryLog();
                log.setLogId(rs.getInt("LogID"));
                log.setUserId(rs.getInt("UserID"));
                log.setActionType(rs.getString("ActionType"));
                log.setTargetId(rs.getObject("TargetID") != null ? rs.getString("TargetID") : null);
                log.setDetails(rs.getString("Details"));
                log.setLogDate(rs.getTimestamp("LogDate"));
                log.setFullName(rs.getString("FullName"));
                log.setEmail(rs.getString("Email"));
                log.setRoleId(rs.getInt("RoleID"));
                logs.add(log);
            }
        }
        return logs;
    }

    // Lấy tất cả log của User (RoleID = 2) và Tutor (RoleID = 3) cho Staff xem
    public List<HistoryLog> getUserAndTutorLogs() throws SQLException {
        List<HistoryLog> logs = new ArrayList<>();
        String sql = "SELECT TOP 1000 hl.*, u.FullName, u.Email, u.RoleID "
                + "FROM HistoryLog hl "
                + "LEFT JOIN Users u ON hl.UserID = u.UserID "
                + "WHERE u.RoleID IN (2, 3) "
                + "ORDER BY hl.LogDate DESC";
        try (Connection conn = dbConnect.getConnection();
             ResultSet rs = conn.createStatement().executeQuery(sql)) {
            while (rs.next()) {
                HistoryLog log = new HistoryLog();
                log.setLogId(rs.getInt("LogID"));
                log.setUserId(rs.getInt("UserID"));
                log.setActionType(rs.getString("ActionType"));
                log.setTargetId(rs.getObject("TargetID") != null ? rs.getString("TargetID") : null);
                log.setDetails(rs.getString("Details"));
                log.setLogDate(rs.getTimestamp("LogDate"));
                log.setFullName(rs.getString("FullName"));
                log.setEmail(rs.getString("Email"));
                log.setRoleId(rs.getInt("RoleID"));
                logs.add(log);
            }
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
}