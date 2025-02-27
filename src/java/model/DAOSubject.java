
package model;
import entity.Subject;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DAOSubject extends DBConnect {
    public int addSubject(Subject subject) {
        int result = 0;
        String sql = "INSERT INTO Subject (SubjectName, Description) VALUES (?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, subject.getSubjectName());
            ps.setString(2, subject.getDescription());
            result = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public int updateSubject(Subject subject) {
        int result = 0;
        String sql = "UPDATE Subject SET SubjectName = ?, Description = ? WHERE SubjectID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, subject.getSubjectName());
            ps.setString(2, subject.getDescription());
            ps.setInt(3, subject.getSubjectID());
            result = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public int deleteSubject(int subjectID) {
        int result = 0;
        String sql = "DELETE FROM Subject WHERE SubjectID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, subjectID);
            result = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<Subject> getAllSubjects() {
        List<Subject> subjects = new ArrayList<>();
        String sql = "SELECT * FROM Subject";
        try (Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                subjects.add(new Subject(
                        rs.getInt("SubjectID"),
                        rs.getString("SubjectName"),
                        rs.getString("Description")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return subjects;
    }

    public Subject getSubjectById(int subjectID) {
        String sql = "SELECT * FROM Subject WHERE SubjectID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, subjectID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Subject(
                        rs.getInt("SubjectID"),
                        rs.getString("SubjectName"),
                        rs.getString("Description")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Subject> getTopSubjects(int limit) {
        List<Subject> subjects = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM Subject ORDER BY LEN(Description) DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                subjects.add(new Subject(
                        rs.getInt("SubjectID"),
                        rs.getString("SubjectName"),
                        rs.getString("Description")
                ));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy các Subject.");
            e.printStackTrace();
        }
        return subjects;
    }
}
