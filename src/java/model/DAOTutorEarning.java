package model;

import entity.TutorEarning;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAOTutorEarning extends DBConnect {

    // Đẩy dữ liệu từ Booking sang TutorEarnings
    public void syncBookingToTutorEarnings(int tutorID) {
        // Lấy danh sách các booking có Status = 'Completed' mà chưa được đồng bộ
        String sql = "SELECT b.BookingID, b.TutorID, b.BookingDate, t.Price " +
                    "FROM Booking b " +
                    "JOIN Tutor t ON b.TutorID = t.TutorID " +
                    "WHERE b.Status = 'Completed' " +
                    "AND b.TutorID = ? " +
                    "AND NOT EXISTS (SELECT 1 FROM TutorEarnings te WHERE te.BookingID = b.BookingID)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, tutorID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int bookingID = rs.getInt("BookingID");
                int fetchedTutorID = rs.getInt("TutorID");
                java.sql.Date bookingDate = rs.getDate("BookingDate");
                double hourlyRate = rs.getDouble("Price");

                // Giả định mỗi booking là 1 giờ
                double totalEarnings = hourlyRate * 1; // Nếu thời lượng booking khác, cần điều chỉnh
                double commissionRate = 0.2; // 20%
                double earningsAfterCommission = totalEarnings * (1 - commissionRate);

                // Tạo bản ghi TutorEarnings
                TutorEarning earnings = new TutorEarning();
                earnings.setTutorID(fetchedTutorID);
                earnings.setBookingID(bookingID);
                earnings.setBookingDate(bookingDate);
                earnings.setHourlyRate(hourlyRate);
                earnings.setTotalEarnings(totalEarnings);
                earnings.setSytemCommissionRate(commissionRate);
                earnings.setEarningsAfterCommission(earningsAfterCommission);
                earnings.setStaffID(47); // Cần thay đổi logic để lấy StaffID thực tế
                earnings.setWithdrawStatus("Pending");
                earnings.setContent(null);

                insertEarnings(earnings);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi đồng bộ Booking sang TutorEarnings: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Thêm bản ghi mới vào TutorEarnings
    public void insertEarnings(TutorEarning earnings) {
        String sql = "INSERT INTO TutorEarnings (TutorID, BookingID, BookingDate, HourlyRate, TotalEarnings, " +
                     "SytemCommissionRate, EarningsAfterCommission, StaffID, WithdrawStatus, Content) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, earnings.getTutorID());
            ps.setInt(2, earnings.getBookingID());
            ps.setDate(3, new java.sql.Date(earnings.getBookingDate().getTime()));
            ps.setDouble(4, earnings.getHourlyRate());
            ps.setDouble(5, earnings.getTotalEarnings());
            ps.setDouble(6, earnings.getSytemCommissionRate());
            ps.setDouble(7, earnings.getEarningsAfterCommission());
            ps.setInt(8, earnings.getStaffID());
            ps.setString(9, earnings.getWithdrawStatus());
            ps.setString(10, earnings.getContent());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Lỗi khi thêm TutorEarnings: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Lấy tất cả bản ghi TutorEarnings theo TutorID
    public List<TutorEarning> getAllEarningsByTutor(int tutorID) {
        List<TutorEarning> earningsList = new ArrayList<>();
        String sql = "SELECT * FROM TutorEarnings WHERE TutorID = ? ORDER BY BookingDate DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, tutorID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                TutorEarning earnings = new TutorEarning();
                earnings.setId(rs.getInt("ID"));
                earnings.setTutorID(rs.getInt("TutorID"));
                earnings.setBookingID(rs.getInt("BookingID"));
                earnings.setBookingDate(rs.getDate("BookingDate"));
                earnings.setHourlyRate(rs.getDouble("HourlyRate"));
                earnings.setTotalEarnings(rs.getDouble("TotalEarnings"));
                earnings.setSytemCommissionRate(rs.getDouble("SytemCommissionRate"));
                earnings.setEarningsAfterCommission(rs.getDouble("EarningsAfterCommission"));
                earnings.setStaffID(rs.getInt("StaffID"));
                earnings.setWithdrawStatus(rs.getString("WithdrawStatus"));
                earnings.setContent(rs.getString("Content"));
                earningsList.add(earnings);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy danh sách TutorEarnings: " + e.getMessage());
            e.printStackTrace();
        }
        return earningsList;
    }

    // Lấy danh sách các tháng có booking hoàn thành
    public List<String> getCompletedMonthsByTutor(int tutorID) {
        List<String> months = new ArrayList<>();
        String sql = "SELECT DISTINCT FORMAT(BookingDate, 'yyyy-MM') AS Month " +
                     "FROM Booking " +
                     "WHERE TutorID = ? " +
                     "AND Status = 'Completed' " +
                     "ORDER BY Month DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, tutorID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                months.add(rs.getString("Month"));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy danh sách tháng: " + e.getMessage());
            e.printStackTrace();
        }
        return months;
    }
}