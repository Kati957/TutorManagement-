/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Report;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author dvdung
 */
public class DAOReport extends DBConnect{
     public int addReport(Report report) {
         int n=0;
        String sql = "INSERT INTO Report (BookID, UserID, Reason, Status, CreatedAt) VALUES (?, ?, ?, ?, GETDATE())";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, report.getBookID());
            stmt.setInt(2, report.getUserID());
            stmt.setString(3, report.getReason());
            stmt.setString(4, report.getStatus());
            n = stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOReport.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
     
}
