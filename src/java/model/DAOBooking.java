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

    // Hungnv: Book Schedule
    // DAO: addSlotsAndBookings
    public int addSlotsAndBookings(List<Slot> slots, List<Booking> bookings) {
        int result = 0;
        String slotSql = """
        INSERT INTO Slot (scheduleID, status) 
        VALUES (?, ?)
    """;
        String bookingSql = """
        INSERT INTO Booking (studentID, tutorID, slotID, bookingDate, status, subjectID) 
        VALUES (?, ?, ?, ?, ?, ?)
    """;
        String updateScheduleSql = """
        UPDATE Schedule SET IsBooked = 1 WHERE scheduleID = ?
    """;

        try {
            conn.setAutoCommit(false); // Bắt đầu transaction
            List<Integer> slotIds = new ArrayList<>();

            // 1. Chèn tất cả các Slot trước và lấy slotId
            try (PreparedStatement slotPs = conn.prepareStatement(slotSql, Statement.RETURN_GENERATED_KEYS)) {
                for (Slot slot : slots) {
                    slotPs.setInt(1, slot.getScheduleID());
                    slotPs.setString(2, slot.getStatus());
                    slotPs.executeUpdate();

                    try (ResultSet rs = slotPs.getGeneratedKeys()) {
                        if (rs.next()) {
                            slotIds.add(rs.getInt(1));
                        } else {
                            throw new SQLException("Lỗi khi lấy slotId.");
                        }
                    }
                }
            }

            // Kiểm tra số lượng slotId và bookings phải khớp
            if (slotIds.size() != bookings.size()) {
                throw new SQLException("Số lượng slot và booking không khớp.");
            }

            // 2. Cập nhật trạng thái isBooked cho các Schedule
            try (PreparedStatement updateSchedulePs = conn.prepareStatement(updateScheduleSql)) {
                for (Slot slot : slots) {
                    updateSchedulePs.setInt(1, slot.getScheduleID());
                    updateSchedulePs.addBatch();
                }

                int[] updateResult = updateSchedulePs.executeBatch();
                for (int r : updateResult) {
                    if (r <= 0) {
                        throw new SQLException("Lỗi khi cập nhật Schedule.");
                    }
                }
            }

            // 3. Chèn các Booking với slotId tương ứng
            try (PreparedStatement bookingPs = conn.prepareStatement(bookingSql)) {
                for (int i = 0; i < bookings.size(); i++) {
                    Booking booking = bookings.get(i);
                    bookingPs.setInt(1, booking.getStudentID());
                    bookingPs.setInt(2, booking.getTutorID());
                    bookingPs.setInt(3, slotIds.get(i)); // Gắn slotId vừa tạo vào booking
                    bookingPs.setDate(4, booking.getBookingDate());
                    bookingPs.setString(5, booking.getStatus());
                    bookingPs.setInt(6, booking.getSubjectID());
                    bookingPs.addBatch();
                }

                int[] batchResult = bookingPs.executeBatch();
                for (int r : batchResult) {
                    if (r <= 0) {
                        throw new SQLException("Lỗi khi chèn Booking.");
                    }
                }
            }

            conn.commit(); // Commit toàn bộ
            result = bookings.size();
        } catch (SQLException e) {
            try {
                conn.rollback(); // Rollback nếu lỗi
                System.err.println("Rollback transaction: " + e.getMessage());
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                conn.setAutoCommit(true); // Khôi phục auto-commit
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }

}
