/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Cv;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.ResultSet;

/**
 *
 * @author dvdung
 */
public class DAOCv extends DBConnect {

    public int sendCv(Cv cv) {
        int n = 0;
        String sql = "INSERT INTO CV (UserID, Education, Experience, Certificates, Status, SubjectId, Desciption) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cv.getCvId());
            stmt.setString(2, cv.getEducation());
            stmt.setString(3, cv.getExperience());
            stmt.setString(4, cv.getCertificates());
            stmt.setString(5, cv.getStatus());
            stmt.setInt(6, cv.getSubjectId());
            stmt.setString(7, cv.getDescription());
            n = stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOCv.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public void updateCVStatus(int cvId, String newStatus) {
        String sql = "UPDATE [dbo].[CV] SET [Status] = ? WHERE [CVID] = ?";

        try ( 
            PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, newStatus);
            pstmt.setInt(2, cvId);

            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Cập nhật trạng thái CV thành công!");
            } else {
                System.out.println("Không tìm thấy CV với ID: " + cvId);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOCv.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
