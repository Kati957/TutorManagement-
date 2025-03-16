package model;

import entity.TutorRating;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DAOTutorRating extends DBConnect {

    // Thêm một đánh giá mới
    public int insertTutorRating(TutorRating rating) throws SQLException {
        int n = 0;
        String sql = "INSERT INTO [dbo].[TutorRating] (BookingID, StudentID, TutorID, Rating, Comment) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, rating.getBookingId());
            pre.setInt(2, rating.getStudentId());
            pre.setInt(3, rating.getTutorId());
            pre.setInt(4, rating.getRating());
            pre.setString(5, rating.getComment());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOTutorRating.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    // Lấy TutorRating theo ID
    public TutorRating getTutorRatingById(int ratingId) throws SQLException {
        TutorRating rating = null;
        String sql = "SELECT * FROM [dbo].[TutorRating] WHERE RatingID = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, ratingId);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                rating = extractTutorRatingFromResultSet(rs);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOTutorRating.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rating;
    }

    // Lấy danh sách tất cả TutorRating
    public List<TutorRating> getAllTutorRatings() throws SQLException {
        List<TutorRating> list = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[TutorRating]";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                TutorRating rating = extractTutorRatingFromResultSet(rs);
                list.add(rating);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOTutorRating.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    // Lấy danh sách đánh giá theo TutorID
    public List<TutorRating> getRatingsByTutorId(int tutorId) throws SQLException {
        List<TutorRating> list = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[TutorRating] WHERE TutorID = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, tutorId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                TutorRating rating = extractTutorRatingFromResultSet(rs);
                list.add(rating);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOTutorRating.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    // Kiểm tra vai trò học sinh (RoleID = 2)
    public boolean isStudent(int userId) throws SQLException {
        String sql = "SELECT RoleID FROM [dbo].[Users] WHERE UserID = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, userId);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return rs.getInt("RoleID") == 2;
            }
            return false;
        } catch (SQLException ex) {
            Logger.getLogger(DAOTutorRating.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // Kiểm tra trạng thái và quyền của Booking
    public TutorRating checkBookingEligibility(int bookingId, int userId) throws SQLException {
        String sql = "SELECT StudentID, TutorID, Status FROM [dbo].[Booking] WHERE BookingID = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, bookingId);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                int studentId = rs.getInt("StudentID");
                int tutorId = rs.getInt("TutorID");
                String status = rs.getString("Status");
                if ("Completed".equals(status) && studentId == userId) {
                    return new TutorRating(0, bookingId, studentId, tutorId, 0, null, null);
                }
            }
            return null;
        } catch (SQLException ex) {
            Logger.getLogger(DAOTutorRating.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // Kiểm tra xem Booking đã được đánh giá chưa
    public boolean isBookingRated(int bookingId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM [dbo].[TutorRating] WHERE BookingID = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, bookingId);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            return false;
        } catch (SQLException ex) {
            Logger.getLogger(DAOTutorRating.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // Trích xuất TutorRating từ ResultSet
    private TutorRating extractTutorRatingFromResultSet(ResultSet rs) throws SQLException {
        int ratingId = rs.getInt("RatingID");
        int bookingId = rs.getInt("BookingID");
        int studentId = rs.getInt("StudentID");
        int tutorId = rs.getInt("TutorID");
        int rating = rs.getInt("Rating");
        String comment = rs.getString("Comment");
        Timestamp ratingDate = rs.getTimestamp("RatingDate");
        return new TutorRating(ratingId, bookingId, studentId, tutorId, rating, comment, ratingDate);
    }

    // Test method trong main
    public static void main(String[] args) {
        DAOTutorRating dao = new DAOTutorRating();

        // Thêm dữ liệu mẫu vào Booking với StudentID = 19
        try {
            String insertBookingSql = "INSERT INTO [dbo].[Booking] (StudentID, TutorID, SlotID, BookingDate, Status, SubjectID) " +
                                     "VALUES (19, 1, 23, '2025-03-15', 'Completed', 3)";
            PreparedStatement preBooking = dao.conn.prepareStatement(insertBookingSql);
            preBooking.executeUpdate();
            System.out.println("Inserted sample Booking for BookingID (auto-incremented)");
        } catch (SQLException ex) {
            Logger.getLogger(DAOTutorRating.class.getName()).log(Level.SEVERE, "Failed to insert sample Booking", ex);
        }

        // Lấy BookingID mới thêm
        int bookingId = -1;
        try {
            String getBookingIdSql = "SELECT TOP 1 BookingID FROM [dbo].[Booking] ORDER BY BookingID DESC";
            PreparedStatement preGetId = dao.conn.prepareStatement(getBookingIdSql);
            ResultSet rs = preGetId.executeQuery();
            if (rs.next()) {
                bookingId = rs.getInt("BookingID");
                System.out.println("Latest BookingID: " + bookingId);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOTutorRating.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Test insertTutorRating với StudentID = 19
        if (bookingId != -1) {
            TutorRating newRating = new TutorRating(
                0,        // RatingID (tự tăng)
                bookingId, // BookingID vừa thêm
                19,       // StudentID = 19
                1,        // TutorID
                5,        // Rating
                "Gia sư dạy rất tốt!", // Comment
                new Timestamp(System.currentTimeMillis()) // RatingDate
            );
            int inserted = 0;
            try {
                inserted = dao.insertTutorRating(newRating);
                System.out.println("Insert result: " + inserted);
            } catch (SQLException ex) {
                Logger.getLogger(DAOTutorRating.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        // Test getRatingsByTutorId
        try {
            List<TutorRating> ratings = dao.getRatingsByTutorId(1);
            System.out.println("Ratings for TutorID = 1:");
            for (TutorRating rating : ratings) {
                System.out.println(rating.getRatingId() + " - " + rating.getRating() + " - " + rating.getComment());
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOTutorRating.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Test isStudent với StudentID = 19
        try {
            boolean isStudent = dao.isStudent(19);
            System.out.println("Is UserID = 19 a student? " + isStudent);
        } catch (SQLException ex) {
            Logger.getLogger(DAOTutorRating.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Test checkBookingEligibility với StudentID = 19
        try {
            TutorRating eligibility = dao.checkBookingEligibility(bookingId, 19);
            if (eligibility != null) {
                System.out.println("BookingID = " + bookingId + " is eligible for UserID = 19: " + eligibility.getStudentId() + " - " + eligibility.getTutorId());
            } else {
                System.out.println("BookingID = " + bookingId + " is not eligible for UserID = 19");
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOTutorRating.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Test isBookingRated
        try {
            boolean isRated = dao.isBookingRated(bookingId);
            System.out.println("Is BookingID = " + bookingId + " already rated? " + isRated);
        } catch (SQLException ex) {
            Logger.getLogger(DAOTutorRating.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}