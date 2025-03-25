package model;

import entity.Booking;
import entity.Slot;
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
    public int getLastInsertedBookingID() {
    Connection conn = null;
    PreparedStatement pre = null;
    ResultSet rs = null;
    String sql = "SELECT SCOPE_IDENTITY() AS BookingID";
    try {
        conn = getConnection(); // Giả sử bạn có phương thức getConnection trong DAOBooking
        pre = conn.prepareStatement(sql);
        rs = pre.executeQuery();
        if (rs.next()) {
            return rs.getInt("BookingID");
        }
    } catch (SQLException ex) {
        System.out.println("Error getting last inserted BookingID: " + ex.getMessage());
    } finally {
        // Đóng tài nguyên
    }
    return -1;
}

    // Hungnv: Book Schedule
    // DAO: addSlotsAndBookings
    public int addSlotsAndBookings(List<Slot> slots, List<Booking> bookings) {
    int result = 0;
    String slotSql = "INSERT INTO Slot (scheduleID, status) VALUES (?, ?)";
    String bookingSql = "INSERT INTO Booking (studentID, tutorID, slotID, bookingDate, status, subjectID) VALUES (?, ?, ?, ?, ?, ?)";
    String updateScheduleSql = "UPDATE Schedule SET IsBooked = 1 WHERE scheduleID = ?";

    try {
        conn.setAutoCommit(false); // Bắt đầu transaction
        List<Integer> slotIds = new ArrayList<>();

        // 1. Chèn Slot và lấy slotId
        try (PreparedStatement slotPs = conn.prepareStatement(slotSql, Statement.RETURN_GENERATED_KEYS)) {
            for (Slot slot : slots) {
                slotPs.setInt(1, slot.getScheduleID());
                slotPs.setString(2, slot.getStatus());
                slotPs.executeUpdate();
                try (ResultSet rs = slotPs.getGeneratedKeys()) {
                    if (rs.next()) {
                        slotIds.add(rs.getInt(1));
                    }
                }
            }
        }

        // 2. Cập nhật Schedule
        try (PreparedStatement updateSchedulePs = conn.prepareStatement(updateScheduleSql)) {
            for (Slot slot : slots) {
                updateSchedulePs.setInt(1, slot.getScheduleID());
                updateSchedulePs.addBatch();
            }
            updateSchedulePs.executeBatch();
        }

        // 3. Chèn Booking và lấy BookingID
        try (PreparedStatement bookingPs = conn.prepareStatement(bookingSql, Statement.RETURN_GENERATED_KEYS)) {
            for (int i = 0; i < bookings.size(); i++) {
                Booking booking = bookings.get(i);
                bookingPs.setInt(1, booking.getStudentID());
                bookingPs.setInt(2, booking.getTutorID());
                bookingPs.setInt(3, slotIds.get(i));
                bookingPs.setDate(4, booking.getBookingDate());
                bookingPs.setString(5, booking.getStatus());
                bookingPs.setInt(6, booking.getSubjectID());
                bookingPs.executeUpdate();

                try (ResultSet rs = bookingPs.getGeneratedKeys()) {
                    if (rs.next()) {
                        booking.setBookingID(rs.getInt(1));
                        result++;
                    }
                }
            }
        }

        conn.commit();
    } catch (SQLException e) {
        try {
            conn.rollback();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        e.printStackTrace();
    } finally {
        try {
            conn.setAutoCommit(true);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    return result;
}
    public int changeBookingStatusToCompleted(int bookingID) {
        int result = 0;
        String sql = "UPDATE Booking SET Status = 'Completed' WHERE BookingID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingID);
            result = ps.executeUpdate();
            if (result > 0) {
                System.out.println("Booking ID " + bookingID + " updated to Completed successfully.");
            } else {
                System.out.println("Failed to update Booking ID " + bookingID + ": Booking not found.");
            }
        } catch (SQLException e) {
            System.out.println("Error updating booking status: " + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

}
