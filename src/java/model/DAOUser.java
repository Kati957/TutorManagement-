/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import entity.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Date;

/**
 *
 * @author dvdung
 */
public class DAOUser extends DBConnect{
    public User Login(String username, String password){
        User user=null;
        String sql="select*from Users where UserName=? and password=?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1,username );
            pre.setString(2,password );
            ResultSet rs = pre.executeQuery();
            if(rs.next()){
                user=new User(rs.getInt(1),rs.getInt(2),rs.getString(3),
                        rs.getString(4),rs.getString(5),rs.getDate(6),rs.getInt(7),rs.getDate(8)
                        ,rs.getString(9),rs.getString(10),rs.getString(11),rs.getString(12));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }
    public int registerUser(User user) throws SQLException {
        int n=0;
        String sql = "INSERT INTO Users (RoleID, Email, FullName, Phone, CreatedAt, IsActive, Dob, Address, Avatar, UserName, Password) "
                   + "VALUES (?, ?, ?, ?, GETDATE(), 1, ?, ?, ?, ?, ?)";
        try (
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, user.getRoleID());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getFullName());
            stmt.setString(4, user.getPhone());
            stmt.setDate(5, user.getDob());
            stmt.setString(6, user.getAddress());
            stmt.setString(7, user.getAvatar());
            stmt.setString(8, user.getUserName());
            stmt.setString(9, user.getPassword());
            n= stmt.executeUpdate();
        }catch (SQLException ex) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM Users WHERE Email = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractUserFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public User getUserById(int userId) {
        String sql = "SELECT * FROM Users WHERE UserID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractUserFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updatePassword(String email, String password) {
        String sql = "UPDATE Users SET Password = ? WHERE Email = ?";
        try (PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, password);
            st.setString(2, email);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

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
    public static void main(String[] args) {
        DAOUser dao=new DAOUser();
        int n=0;
        try{
        n = dao.registerUser(new User(1, 1, "dsfsdf", "DSFsfsd", "dsfsf", null, 1, Date.valueOf("1990-01-01"), "sadsa", "ádsad", "sadsad", "Sada"));
        }catch(Exception e){
            
        }
        if(n!=0){
            System.out.println("aksjdlksajd");
        }
    }
}
