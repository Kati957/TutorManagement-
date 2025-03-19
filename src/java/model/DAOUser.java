package model;

import entity.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Connection;

/**
 *
 * @author Heizxje
 */
public class DAOUser extends DBConnect {

    public DAOUser() {
        super(); // Gọi constructor của DBConnect để khởi tạo conn
    }

    // Phương thức lấy 5 người dùng mới nhất
    public List<User> getNewUsers() throws SQLException {
        List<User> newUsers = new ArrayList<>();
        String sql = "SELECT TOP 5 * FROM Users WHERE RoleID = 2 ORDER BY CreatedAt DESC"; // Chỉ lấy RoleID = 2
        Logger.getLogger(DAOUser.class.getName()).log(Level.INFO, "Executing query: {0}", sql);

        if (conn == null) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, "Database connection is null");
            throw new SQLException("Database connection is not initialized.");
        }

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.INFO, "Query executed successfully");
            int rowCount = 0;
            while (rs.next()) {
                rowCount++;
                User user = extractUserFromResultSet(rs);
                newUsers.add(user);
                Logger.getLogger(DAOUser.class.getName()).log(Level.INFO, "Added user: ID={0}, Name={1}, RoleID={2}",
                        new Object[]{user.getUserID(), user.getFullName(), user.getRoleID()});
            }
            Logger.getLogger(DAOUser.class.getName()).log(Level.INFO, "Total rows fetched: {0}, Users list size: {1}",
                    new Object[]{rowCount, newUsers.size()});
        } catch (SQLException e) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, "Error fetching new users: {0}", e.getMessage());
            throw e;
        }
        return newUsers;
    }

    // Các phương thức hiện có giữ nguyên
    public User Login(String username, String password) {
        User user = null;
        String sql = "SELECT * FROM Users WHERE UserName = ? AND Password = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, username);
            pre.setString(2, password);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                user = new User(
                        rs.getInt("UserID"),
                        rs.getInt("RoleID"),
                        rs.getString("Email"),
                        rs.getString("FullName"),
                        rs.getString("Phone"),
                        rs.getDate("CreatedAt"),
                        rs.getInt("IsActive"),
                        rs.getDate("Dob"),
                        rs.getString("Address"),
                        rs.getString("Avatar"),
                        rs.getString("UserName"),
                        rs.getString("Password")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, "Error logging in user", ex);
        }
        return user;
    }

    // Phương thức đăng ký người dùng mới
    public int registerUser(User user) throws SQLException {
        if (conn == null) {
            throw new SQLException("Database connection is not initialized.");
        }
        int n = 0;
        String sql = "INSERT INTO Users (RoleID, Email, FullName, Phone, CreatedAt, IsActive, Dob, Address, Avatar, UserName, Password) "
                + "VALUES (?, ?, ?, ?, GETDATE(), 1, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, user.getRoleID());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getFullName());
            stmt.setString(4, user.getPhone());
            stmt.setDate(5, user.getDob());
            stmt.setString(6, user.getAddress());
            stmt.setString(7, user.getAvatar());
            stmt.setString(8, user.getUserName());
            stmt.setString(9, user.getPassword());
            n = stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, "Error registering user", ex);
            throw ex;
        }
        return n;
    }

    // Phương thức lấy thông tin người dùng bằng email
    public User getUserByEmail(String email) {
        if (conn == null) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, "Database connection is null");
            return null;
        }
        String sql = "SELECT * FROM Users WHERE Email = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractUserFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, "Error fetching user by email", e);
        }
        return null;
    }

    // Phương thức lấy thông tin người dùng bằng userID
    public User getUserById(int userId) {
        if (conn == null) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, "Database connection is null");
            return null;
        }
        String sql = "SELECT * FROM Users WHERE UserID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractUserFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, "Error fetching user by ID", e);
        }
        return null;
    }

    // Phương thức cập nhật mật khẩu
    public void updatePassword(String email, String password) {
        if (conn == null) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, "Database connection is null");
            return;
        }
        String sql = "UPDATE Users SET Password = ? WHERE Email = ?";
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, password);
            st.setString(2, email);
            st.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, "Error updating password", e);
        }
    }

    // Phương thức trích xuất thông tin người dùng từ ResultSet
    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        return new User(
                rs.getInt("UserID"),
                rs.getInt("RoleID"),
                rs.getString("Email"),
                rs.getString("FullName"),
                rs.getString("Phone"),
                rs.getDate("CreatedAt"),
                rs.getInt("IsActive"),
                rs.getDate("Dob"),
                rs.getString("Address"),
                rs.getString("Avatar"),
                rs.getString("UserName"),
                rs.getString("Password")
        );
    }

    // Phương thức cập nhật mật khẩu bằng email
    public void updatePasswordByEmail(String email, String password) {
        if (conn == null) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, "Database connection is null");
            return;
        }
        String sql = "UPDATE Users SET Password = ? WHERE Email = ?";
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, password);
            st.setString(2, email);
            st.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, "Error updating password by email", e);
        }
    }

    // Phương thức kiểm tra người dùng có tồn tại không
    public boolean checkUserExists(String username) throws SQLException {
        if (conn == null) {
            throw new SQLException("Database connection is not initialized.");
        }
        String sql = "SELECT * FROM Users WHERE UserName = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, "Error checking user existence", ex);
            throw ex;
        }
    }

    // Phương thức thay đổi mật khẩu
    public boolean changePassword(String username, String oldPassword, String newPassword) {
        if (conn == null) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, "Database connection is null");
            return false;
        }
        String sql = "UPDATE Users SET Password = ? WHERE UserName = ? AND Password = ?";
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, newPassword);
            st.setString(2, username);
            st.setString(3, oldPassword);
            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, "Error changing password", e);
            return false;
        }
    }

    // Phương thức cập nhật thông tin người dùng
    public boolean updateUser(User user) {
        if (conn == null) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, "Database connection is null");
            return false;
        }
        String sql = "UPDATE Users SET RoleID = ?, Email = ?, FullName = ?, Phone = ?, Dob = ?, Address = ?, Avatar = ?, UserName = ?, Password = ? WHERE UserID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, user.getRoleID());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getPhone());
            ps.setDate(5, user.getDob());
            ps.setString(6, user.getAddress());
            ps.setString(7, user.getAvatar());
            ps.setString(8, user.getUserName());
            ps.setString(9, user.getPassword());
            ps.setInt(10, user.getUserID());
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, "Error updating user", e);
            return false;
        }
    }

    // Phương thức kiểm tra Email trùng lặp
    public boolean isEmailExists(String email) throws SQLException {
        if (conn == null) {
            throw new SQLException("Database connection is not initialized.");
        }
        String sql = "SELECT COUNT(*) FROM Users WHERE Email = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    // Phương thức kiểm tra SDT trùng lặp
    public boolean isPhoneExists(String phone) throws SQLException {
        if (conn == null) {
            throw new SQLException("Database connection is not initialized.");
        }
        String sql = "SELECT COUNT(*) FROM Users WHERE Phone = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, phone);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    // Phương thức kiểm tra SDT trùng lặp cho ProfileServlet
    public boolean isPhoneExist(String phone, int excludeUserId) throws SQLException {
        if (conn == null) {
            throw new SQLException("Database connection is not initialized.");
        }
        String sql = "SELECT COUNT(*) FROM Users WHERE Phone = ? AND UserID != ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, phone);
            stmt.setInt(2, excludeUserId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    // Phương thức kiểm tra Username trùng lặp
    public boolean isUsernameExists(String username) throws SQLException {
        if (conn == null) {
            throw new SQLException("Database connection is not initialized.");
        }
        String sql = "SELECT COUNT(*) FROM Users WHERE UserName = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }
<<<<<<< HEAD
=======

    public void updateUserRole(int userId) {
        String sql = "UPDATE Users SET RoleID = 3 WHERE UserID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            int rowsUpdated = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
>>>>>>> main

    // Phương thức main để kiểm tra
    public static void main(String[] args) {
        DAOUser dao = new DAOUser();
        if (dao.conn == null) {
            System.out.println("Failed to connect to database!");
            return;
        }
        int n = 0;
        try {
            n = dao.registerUser(new User(1, 1, "example@example.com", "John Doe", "123456789", null, 1,
                    java.sql.Date.valueOf("1990-01-01"), "123 Main St", "avatar.jpg",
                    "johndoe", "password123"));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if (n > 0) {
            System.out.println("User registered successfully!");
        } else {
            System.out.println("User registration failed!");
        }
    }

    // Phương thức đóng kết nối
    public void closeConnection() {
        if (conn != null) {
            try {
                conn.close();
                Logger.getLogger(DAOUser.class.getName()).log(Level.INFO, "Database connection closed");
            } catch (SQLException e) {
                Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, "Error closing connection", e);
            }
        }
    }

    public boolean isConnected() {
        return conn != null;
    }

    // Lấy danh sách tất cả users
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM Users";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                users.add(extractUserFromResultSet(rs));
            }
        } catch (SQLException e) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, "Error fetching all users", e);
        }
        return users;
    }

    // Xóa user theo UserID
    public boolean deleteUser(int userId) {
        if (conn == null) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, "Database connection is null");
            return false;
        }

        String sql = "DELETE FROM Users WHERE UserID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                Logger.getLogger(DAOUser.class.getName()).log(Level.INFO, "User with ID " + userId + " deleted successfully");
                return true;
            } else {
                Logger.getLogger(DAOUser.class.getName()).log(Level.WARNING, "No user found with ID " + userId + " to delete");
                return false;
            }
        } catch (SQLException e) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, "Error deleting user with ID " + userId, e);
            return false;
        }
    }

    public List<User> getUsersByRole(int roleID) {
        List<User> users = new ArrayList<>();
        if (conn == null) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, "Database connection is null in getUsersByRole");
            return users;
        }
        String sql = "SELECT * FROM Users WHERE RoleID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roleID);
            Logger.getLogger(DAOUser.class.getName()).log(Level.INFO, "Executing query: " + sql + " with RoleID = " + roleID);
            try (ResultSet rs = ps.executeQuery()) {
                int rowCount = 0;
                while (rs.next()) {
                    rowCount++;
                    User user = new User(
                            rs.getInt("UserID"),
                            rs.getInt("RoleID"),
                            rs.getString("Email"),
                            rs.getString("FullName"),
                            rs.getString("Phone"),
                            rs.getDate("CreatedAt"),
                            rs.getInt("IsActive"),
                            rs.getDate("Dob"),
                            rs.getString("Address"),
                            rs.getString("Avatar"),
                            rs.getString("UserName"),
                            rs.getString("Password")
                    );
                    users.add(user);
                    Logger.getLogger(DAOUser.class.getName()).log(Level.INFO, "Added user: ID=" + user.getUserID() + ", Name=" + user.getFullName());
                }
                Logger.getLogger(DAOUser.class.getName()).log(Level.INFO, "Rows fetched: " + rowCount + ", Total users in list: " + users.size());
            }
        } catch (SQLException e) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, "Error fetching users by role: " + e.getMessage(), e);
        }
        return users;
    }
       public int updateRole(int userID, int newRoleID) {
           int n=0;
        String sql = "UPDATE Users SET RoleID = ? WHERE UserID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, newRoleID);
            ps.setInt(2, userID);
            return ps.executeUpdate();// Trả về true nếu có ít nhất một bản ghi được cập nhật
        } catch (SQLException e) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, "Error fetching users by role: " + e.getMessage(), e);
        }
        return n;
    }

}
