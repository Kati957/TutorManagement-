package model;

import entity.Subject;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DAOSubject extends DBConnect {

    public int addSubject(Subject subject) throws SQLException {
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

    public int updateSubject(Subject subject) throws SQLException {
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

    public int deleteSubject(int subjectID) throws SQLException {
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

    public Subject getSubjectById(int subjectID) throws SQLException {
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

    // Phương thức để lấy tất cả Tutor-Subject với UserName
    public List<Subject> getAllTutorSubjects() throws SQLException {
        List<Subject> subjectList = new ArrayList<>();
        String sql = """
                     SELECT TutorID , UserName, TutorSubject.SubjectID, Desciption FROM dbo.Users JOIN dbo.CV
                     ON CV.UserID = Users.UserID
                     JOIN dbo.TutorSubject
                     ON TutorSubject.SubjectID = CV.SubjectId""";

        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                int tutorID = rs.getInt("TutorID");
                String userName = rs.getString("UserName");
                int subjectID = rs.getInt("SubjectID");
                String description = rs.getString("Desciption");
                subjectList.add(new Subject(subjectID, description, tutorID, userName));
            }
        }
        return subjectList;
    }


    // dang su dung: Hungnv tai homepage
    // join: Subject, booking
    public List<Subject> getTopSubjectsByBooking(int limit) {
        List<Subject> subjects = new ArrayList<>();
        String sql = """
        SELECT TOP (?) s.SubjectID, s.SubjectName, s.Description, COUNT(b.SubjectID) AS BookingCount
        FROM Subject s
        JOIN Booking b ON s.SubjectID = b.SubjectID
        WHERE b.Status IN ('Confirmed', 'Completed', 'Pending')
        GROUP BY s.SubjectID, s.SubjectName, s.Description
        ORDER BY BookingCount DESC
    """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Subject subject = new Subject();
                subject.setSubjectID(rs.getInt("SubjectID"));
                subject.setSubjectName(rs.getString("SubjectName"));
                subject.setDescription(rs.getString("Description"));
                subject.setBookingCount(rs.getInt("BookingCount"));
                subjects.add(subject);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy các Subject.");
            e.printStackTrace();
        }
        return subjects;
    }

// public static void main(String[] args) {
//    DAOSubject dao = new DAOSubject(); // Tạo instance của DAOSubject
//
//    try {
//        // Gọi hàm getAllTutorSubjects
//        List<Subject> tutorSubjects = dao.getAllTutorSubjects();
//
//        // Kiểm tra và in kết quả
//        if (tutorSubjects == null || tutorSubjects.isEmpty()) {
//            System.out.println("Không có dữ liệu trong danh sách Tutor-Subject.");
//        } else {
//            System.out.println("Danh sách Tutor-Subject:");
//            for (Subject tutorSubject : tutorSubjects) {
//                System.out.println("TutorID: " + tutorSubject.getTutorID()
//                        + ", UserName: " + tutorSubject.getUserName()
//                        + ", SubjectID: " + tutorSubject.getSubjectID()
//                        + ", Description: " + tutorSubject.getDescription());
//            }
//        }
//    } catch (SQLException e) {
//        System.out.println("Lỗi khi truy vấn cơ sở dữ liệu!");
//        e.printStackTrace();
//    }
//}


}
