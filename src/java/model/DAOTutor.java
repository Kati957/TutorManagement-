package model;

import entity.Cv;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import entity.Tutor;
import entity.User;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DAOTutor extends DBConnect {

    public int addTutor(Tutor tutor) {
        int result = 0;
        String sql = "INSERT INTO [dbo].[Tutor]([CVIID],[Rating],[Price])\n"
                + "VALUES(?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, tutor.getCVID());
            ps.setFloat(2, tutor.getRating());
            ps.setInt(3, 200);
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
        String sql = """
        SELECT t.tutorID, t.CVIID, t.rating, u.FullName, u.Email
        FROM Tutor t
        JOIN CV c ON t.CVIID = c.CVID
        JOIN Users u ON c.UserID = u.UserID
    """;
        try (Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                User user = new User();
                user.setFullName(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));

                Cv cv = new Cv();
                cv.setUser(user);

                Tutor tutor = new Tutor();
                tutor.setTutorID(rs.getInt("tutorID"));
                tutor.setCVID(rs.getInt("CVIID"));
                tutor.setRating(rs.getFloat("rating"));
                tutor.setCv(cv);
                tutors.add(tutor);
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
                        rs.getInt("CVIID"),
                        rs.getFloat("rating")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Hungnv: su dung trong bookschedule
    public List<Tutor> getAllTutorsBySubject(int subjectID) {
        List<Tutor> tutors = new ArrayList<>();
        String sql = """
        SELECT t.tutorID, t.CVIID, t.rating, u.FullName, u.Email
        FROM Tutor t
        JOIN TutorSubject ts ON t.TutorID = ts.TutorID
        JOIN CV c ON t.CVIID = c.CVID
        JOIN Users u ON c.UserID = u.UserID
        WHERE ts.SubjectID = ?
    """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, subjectID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setFullName(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));

                Cv cv = new Cv();
                cv.setUser(user);

                Tutor tutor = new Tutor();
                tutor.setTutorID(rs.getInt("tutorID"));
                tutor.setCVID(rs.getInt("CVIID"));
                tutor.setRating(rs.getFloat("rating"));
                tutor.setCv(cv);
                tutors.add(tutor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tutors;
    }

    public Tutor getTutorBySubject(int tutorID, int subjectID) {
        Tutor tutor = null;
        String sql = """
        SELECT t.tutorID, t.CVIID, t.rating, 
               u.FullName, u.Email, u.Phone, u.Avatar, 
               c.Education, c.Experience, c.Certificates, c.Status, c.Desciption
        FROM Tutor t
        JOIN Cv c ON t.CVIID = c.CVID
        JOIN Users u ON c.UserID = u.UserID
        JOIN Subject s ON c.SubjectId = s.SubjectID
        WHERE t.TutorID = ? AND s.SubjectID = ?
    """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, tutorID);
            ps.setInt(2, subjectID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setFullName(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone"));
                user.setAvatar(rs.getString("Avatar"));

                Cv cv = new Cv();
                cv.setUser(user);
                cv.setEducation(rs.getString("Education"));
                cv.setExperience(rs.getString("Experience"));
                cv.setCertificates(rs.getString("Certificates"));
                cv.setStatus(rs.getString("Status"));
                cv.setDescription(rs.getString("Desciption"));

                tutor = new Tutor();
                tutor.setTutorID(rs.getInt("tutorID"));
                tutor.setCVID(rs.getInt("CVIID"));
                tutor.setRating(rs.getFloat("rating"));
                int price = rs.getInt("Price");
                if (rs.wasNull()) {
                    tutor.setPrice(0);
                } else {
                    tutor.setPrice(price);
                }
                tutor.setCv(cv);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println("lấy tutor by subject Id thành công");
        return tutor;
    }

    public Tutor getTutorByCVid(int cvId) {
        Tutor tutor = null;
        String query = "SELECT TutorID, CVIID, Rating, Price FROM Tutor WHERE CVIID = ?";

        // Sử dụng try-with-resources để tự động đóng kết nối và statement
        try (
                PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, cvId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    tutor = new Tutor();
                    tutor.setTutorID(rs.getInt("TutorID"));
                    tutor.setCVID(rs.getInt("CVIID"));
                    int rating = rs.getInt("Rating");
                    if (rs.wasNull()) {
                        tutor.setRating(0);
                    } else {
                        tutor.setRating(rating);
                    }
                    int price = rs.getInt("Price");
                    if (rs.wasNull()) {
                        tutor.setPrice(0);
                    } else {
                        tutor.setPrice(price);
                    }
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return tutor;
    }

    public boolean isCVExists(int cvid) {
        String sql = "SELECT COUNT(*) FROM Tutor WHERE CVIIID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cvid);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOTutor.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

}
