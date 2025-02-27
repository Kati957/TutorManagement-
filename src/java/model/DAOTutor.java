package model;

import entity.Cv;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import entity.Tutor;
import entity.User;

public class DAOTutor extends DBConnect {

    public int addTutor(Tutor tutor) {
        int result = 0;
        String sql = "INSERT INTO Tutor (CVID, rating) VALUES (?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, tutor.getCVID());
            ps.setFloat(2, tutor.getRating());
            result = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public int updateTutor(Tutor tutor) {
        int result = 0;
        String sql = "UPDATE Tutor SET CVID = ?, rating = ? WHERE tutorID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, tutor.getCVID());
            ps.setFloat(2, tutor.getRating());
            ps.setInt(3, tutor.getTutorID());
            result = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public int deleteTutor(int tutorID) {
        int result = 0;
        String sql = "DELETE FROM Tutor WHERE tutorID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, tutorID);
            result = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // dang su dung: Homepage - lay 5 tutors trong danh sach
    // join: Tutor, CV, User
    public List<Tutor> getTopTutors(int limit) {
        List<Tutor> tutors = new ArrayList<>();
        String sql
                = "SELECT TOP (" + limit + ") t.TutorID, t.Rating, "
                + "c.CVID, c.Desciption, "
                + "u.UserID, u.Email, u.FullName, u.Phone, u.Avatar "
                + "FROM Tutor t "
                + "JOIN CV c ON t.CVIID = c.CVID "
                + "JOIN Users u ON c.UserID = u.UserID "
                + "ORDER BY t.Rating DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setUserID(rs.getInt("UserID"));
                user.setEmail(rs.getString("Email"));
                user.setFullName(rs.getString("FullName"));
                user.setPhone(rs.getString("Phone"));
                user.setAvatar(rs.getString("Avatar"));

                Cv cv = new Cv();
                cv.setCvId(rs.getInt("CVID"));
                cv.setDescription(rs.getString("Desciption"));
                cv.setUser(user);

                Tutor tutor = new Tutor();
                tutor.setTutorID(rs.getInt("TutorID"));
                tutor.setCVID(rs.getInt("CVID"));
                tutor.setRating(rs.getInt("Rating"));
                tutor.setCv(cv);

                tutors.add(tutor);
            }
        } catch (SQLException e) {
            System.out.println("lỗi khi lấy 5 tutors");
            e.printStackTrace();
        }
        return tutors;
    }

    public List<Tutor> getAllTutors() {
        List<Tutor> tutors = new ArrayList<>();
        String sql = "SELECT * FROM Tutor";
        try (Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                tutors.add(new Tutor(
                        rs.getInt("tutorID"),
                        rs.getInt("CVID"),
                        rs.getFloat("rating")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tutors;
    }

    public Tutor getTutorById(int tutorID) {
        String sql = "SELECT * FROM Tutor WHERE tutorID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, tutorID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Tutor(
                        rs.getInt("tutorID"),
                        rs.getInt("CVID"),
                        rs.getFloat("rating")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
