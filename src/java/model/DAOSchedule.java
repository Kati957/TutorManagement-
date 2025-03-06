package model;

import entity.Booking;
import entity.Cv;
import entity.Schedule;
import entity.Slot;
import entity.Subject;
import entity.Tutor;
import entity.User;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DAOSchedule extends DBConnect {

    public List<Map<String, Object>> getSchedulesByUserId(int userId, String search) {
        List<Map<String, Object>> schedules = new ArrayList<>();
        String query = """
        SELECT b.BookingID, b.BookingDate, b.Status AS BookingStatus, 
               s.ScheduleID, s.StartTime, s.EndTime, sub.SubjectName
        FROM Booking b
        JOIN Slot sl ON b.SlotID = sl.SlotID
        JOIN Schedule s ON sl.ScheduleID = s.ScheduleID
        JOIN Subject sub ON b.SubjectID = sub.SubjectID
        WHERE b.StudentID = ? 
          AND (sub.SubjectName LIKE ? OR b.Status LIKE ?)
    """;
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setString(2, "%" + search + "%");
            ps.setString(3, "%" + search + "%");

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> schedule = new HashMap<>();
                schedule.put("id", rs.getInt("ScheduleID"));
                schedule.put("title", rs.getString("SubjectName") + " - " + rs.getString("BookingStatus"));
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
                schedule.put("start", sdf.format(rs.getTimestamp("StartTime")));
                schedule.put("end", sdf.format(rs.getTimestamp("EndTime")));

                schedules.add(schedule);
            }
        } catch (SQLException e) {
            System.out.println("lấy schedules by user Id thất bại!");
            e.printStackTrace();
        }
        System.out.println("lấy thành công schedules by user Id");
        return schedules;
    }

    public List<Schedule> getSchedulesByTutorId(int tutorId) {
        List<Schedule> schedules = new ArrayList<>();
        String query = """
        SELECT s.ScheduleID, s.StartTime, s.EndTime, 
               sub.SubjectName, u.FullName AS TutorFullName, u.Email AS TutorEmail
        FROM Schedule s
        JOIN Tutor t ON s.TutorID = t.TutorID
        JOIN Cv cv ON t.CVIID = cv.CVID
        JOIN Users u ON cv.UserID = u.UserID
        JOIN Subject sub ON s.SubjectId = sub.SubjectID
    """;
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, tutorId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setFullName(rs.getString("TutorFullName"));
                user.setEmail(rs.getString("TutorEmail"));

                Subject subject = new Subject();
                subject.setSubjectName(rs.getString("SubjectName"));

                Cv cv = new Cv();
                cv.setUser(user);

                Tutor tutor = new Tutor();
                tutor.setCv(cv);

                Schedule schedule = new Schedule();
                schedule.setScheduleID(rs.getInt("ScheduleID"));
                schedule.setStartTime(rs.getTimestamp("StartTime"));
                schedule.setEndTime(rs.getTimestamp("EndTime"));
                schedule.setTutor(tutor);
                schedule.setSubject(subject);

                schedules.add(schedule);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy danh sách lịch của tutor: " + e.getMessage());
            e.printStackTrace();
        }
        return schedules;
    }

    public List<Schedule> getSchedules(int tutorId, int subjectId, int page, int pageSize, String sortBy, String order, String search) {
        List<Schedule> schedules = new ArrayList<>();
        String query = """
        SELECT s.ScheduleID, s.StartTime, s.EndTime, sub.SubjectName, u.FullName AS TutorFullName, u.Email AS TutorEmail
        FROM Schedule s
        JOIN Tutor t ON s.TutorID = t.TutorID
        JOIN Cv cv ON t.CVID = cv.CVID
        JOIN Users u ON cv.UserID = u.UserID
        JOIN Subject sub ON s.SubjectId = sub.SubjectID
        WHERE (s.TutorID = ? OR ? = -1)
          AND (s.SubjectID = ? OR ? = -1)
          AND (sub.SubjectName LIKE ? OR u.FullName LIKE ?)
    """;

        if (!List.of("SubjectName", "BookingDate", "StartTime", "EndTime").contains(sortBy)) {
            sortBy = "StartTime";
        }
        if (!order.equalsIgnoreCase("desc")) {
            order = "asc";
        }

        query += " ORDER BY " + sortBy + " " + order + " LIMIT ? OFFSET ?";

        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, tutorId);
            ps.setInt(2, tutorId);
            ps.setInt(3, subjectId);
            ps.setInt(4, subjectId);
            ps.setString(5, "%" + search + "%");
            ps.setString(6, "%" + search + "%");
            ps.setInt(7, pageSize);
            ps.setInt(8, (page - 1) * pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Schedule schedule = new Schedule();
                schedule.setScheduleID(rs.getInt("ScheduleID"));
                schedule.setStartTime(rs.getTimestamp("StartTime"));
                schedule.setEndTime(rs.getTimestamp("EndTime"));

                User user = new User();
                user.setFullName(rs.getString("TutorFullName"));
                user.setEmail(rs.getString("TutorEmail"));

                Cv cv = new Cv();
                cv.setUser(user);

                Tutor tutor = new Tutor();
                tutor.setCv(cv);
                schedule.setTutor(tutor);

                Subject subject = new Subject();
                subject.setSubjectName(rs.getString("SubjectName"));
                schedule.setSubject(subject);

                schedules.add(schedule);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return schedules;
    }

}
