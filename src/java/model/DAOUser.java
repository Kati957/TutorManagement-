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
 * @author Heizxje
 */
public class DAOUser extends DBConnect {

    private static final String UPDATE_USER = "UPDATE Users set fullname = ?,phone = ?,dob = ?, address = ?,avatar=? where username = ?";

    public void changePassword(User s) {
        String sql = "Update Users set password = ? where username = ? and [status] = 1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, s.getPassword());
            st.setString(2, s.getUserName());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public boolean check(String username, String password) {
        String sql = "SELECT * FROM Users WHERE userName = ? AND password = ? AND isActive = 1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            return rs.next(); // Trả về true nếu có kết quả, ngược lại trả về false
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    public User Login(String username, String password) {
        User user = null;
        String sql = "select*from Users where UserName=? and password=?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, username);
            pre.setString(2, password);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                user = new User(rs.getInt(1), rs.getInt(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(6), rs.getInt(7), rs.getDate(8),
                        rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }

    public int registerUser(User user) throws SQLException {
        int n = 0;
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
            n = stmt.executeUpdate();
        } catch (SQLException ex) {
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
                rs.getString("CreatedAt"),
                rs.getInt("IsActive"),
                rs.getDate("Dob"),
                rs.getString("Address"),
                rs.getString("Avatar"),
                rs.getString("UserName"),
                rs.getString("Password")
        );
    }

    public void updatePasswordByEmail(String email, String password) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public boolean checkUserExists(String username) throws SQLException {
        String sql = "SELECT * FROM Users WHERE UserName=?";
        ResultSet rs = null;
        try (
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            rs = stmt.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs.next();
    }

    public static void main(String[] args) {
        DAOUser dao = new DAOUser();
        int n = 0;
        try {
            n = dao.registerUser(new User(1, 1, "dsfsdf", "DSFsfsd", "dsfsf", null, 1, Date.valueOf("1990-01-01"), "sadsa", "ádsad", "sadsad", "Sada"));
        } catch (Exception e) {

        }
        if (n != 0) {
            System.out.println("aksjdlksajd");
        }
    }

    public boolean updateUser(User user) {
        String sql = "UPDATE Users SET Email = ?, FullName = ?, Phone = ?, Dob = ?, Address = ?, Avatar = ? WHERE UserID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getFullName());
            ps.setString(3, user.getPhone());
            ps.setDate(4, user.getDob());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getAvatar());
            ps.setInt(7, user.getUserID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
