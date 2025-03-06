
package model;
import entity.Booking;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DAOBooking extends DBConnect {
    public int addBooking(Booking booking) {
        int result = 0;
        String sql = """
            INSERT INTO Booking (studentID, tutorID, slotID, bookingDate, status, subjectID) 
            VALUES (?, ?, ?, ?, ?, ?)
        """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, booking.getStudentID());
            ps.setInt(2, booking.getTutorID());
            ps.setInt(3, booking.getSlotID());
            ps.setDate(4, booking.getBookingDate());
            ps.setString(5, booking.getStatus());
            ps.setInt(6, booking.getSubjectID());
            result = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}
