package model;

import entity.Booking;
import entity.Schedule;
import entity.Slot;
import entity.Subject;
import entity.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DAOSchedule extends DBConnect {

    
    public List<Schedule> getSchedulesByUserId(int userId, String search, String sortBy, String order, int page, int pageSize) {
        List<Schedule> schedules = new ArrayList<>();
        String query = """
        SELECT b.BookingID, b.BookingDate, b.Status AS BookingStatus, 
               s.ScheduleID, s.StartTime, s.EndTime, 
               sub.SubjectName, u.FullName
        FROM Booking b
        JOIN Slot sl ON b.SlotID = sl.SlotID
        JOIN Schedule s ON sl.ScheduleID = s.ScheduleID
        JOIN Subject sub ON b.SubjectID = sub.SubjectID
        JOIN [Users] u ON b.StudentID = u.UserID
        WHERE b.StudentID = ? 
          AND (sub.SubjectName LIKE ? OR u.FullName LIKE ?)
        ORDER BY %s %s
        OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
    """.formatted(sortBy, order);

        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setString(2, "%" + search + "%");
            ps.setString(3, "%" + search + "%");
            ps.setInt(4, (page - 1) * pageSize);
            ps.setInt(5, pageSize);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Schedule schedule = new Schedule();
                schedule.setScheduleID(rs.getInt("ScheduleID"));
                schedule.setStartTime(rs.getTimestamp("StartTime"));
                schedule.setEndTime(rs.getTimestamp("EndTime"));

                Subject subject = new Subject();
                subject.setSubjectName(rs.getString("SubjectName"));
                schedule.setSubject(subject);

                Booking booking = new Booking();
                booking.setBookingID(rs.getInt("BookingID"));
                booking.setBookingDate(rs.getDate("BookingDate"));
                booking.setStatus(rs.getString("BookingStatus"));

                Slot slot = new Slot();
                slot.setBooking(booking);
                schedule.setSlot(slot);

                schedules.add(schedule);
                System.out.println("Lấy lịch user thành công");
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy danh sách lịch của user: " + e.getMessage());
            e.printStackTrace();
        }
        return schedules;
    }

}
