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
        String sql = "SELECT * FROM [dbo].[TutorRating]  ORDER BY RatingDate DESC";
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

    public List<Object[]> getTutorsWithAverageRating(String order) throws SQLException {
        List<Object[]> list = new ArrayList<>();
        String sql = "SELECT t.TutorID, u.FullName, ROUND(COALESCE(AVG(tr.Rating), 0), 1) as averageRating, COUNT(tr.Rating) as reviewCount "
                + "FROM dbo.Users u "
                + "JOIN dbo.CV cv ON cv.UserID = u.UserID "
                + "JOIN dbo.Tutor t ON t.CVID = cv.CVID "
                + "LEFT JOIN dbo.TutorRating tr ON tr.TutorID = t.TutorID "
                + "GROUP BY t.TutorID, u.FullName "
                + "ORDER BY averageRating " + ("DESC".equals(order) ? "DESC" : "ASC");

        try (PreparedStatement pre = conn.prepareStatement(sql); ResultSet rs = pre.executeQuery()) {
            while (rs.next()) {
                Object[] tutorData = new Object[4]; // Có 4 cột: TutorID, FullName, averageRating, reviewCount
                tutorData[0] = rs.getInt("TutorID");           // Mã gia sư
                tutorData[1] = rs.getString("FullName");       // Tên gia sư
                tutorData[2] = rs.getDouble("averageRating");  // Điểm trung bình (đã làm tròn)
                tutorData[3] = rs.getInt("reviewCount");       // Số lượng đánh giá
                list.add(tutorData);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOTutorRating.class.getName()).log(Level.SEVERE, "Error fetching tutors with ratings", ex);
            throw ex;
        }
        return list;
    }

    public List<Object[]> searchTutorsByIdOrName(String keyword) throws SQLException {
        List<Object[]> list = new ArrayList<>();
        String sql = "SELECT t.TutorID, u.FullName, ROUND(COALESCE(AVG(tr.Rating), 0), 1) as averageRating, COUNT(tr.Rating) as reviewCount "
                + "FROM dbo.Users u "
                + "JOIN dbo.CV cv ON cv.UserID = u.UserID "
                + "JOIN dbo.Tutor t ON t.CVID = cv.CVID "
                + "LEFT JOIN dbo.TutorRating tr ON tr.TutorID = t.TutorID "
                + "WHERE t.TutorID LIKE ? OR u.FullName LIKE ? "
                + "GROUP BY t.TutorID, u.FullName "
                + "ORDER BY averageRating DESC";
        try (PreparedStatement pre = conn.prepareStatement(sql)) {
            pre.setString(1, "%" + keyword + "%");
            pre.setString(2, "%" + keyword + "%");
            try (ResultSet rs = pre.executeQuery()) {
                while (rs.next()) {
                    Object[] tutorData = new Object[4];
                    tutorData[0] = rs.getInt("TutorID");
                    tutorData[1] = rs.getString("FullName");
                    tutorData[2] = rs.getDouble("averageRating");
                    tutorData[3] = rs.getInt("reviewCount");
                    list.add(tutorData);
                }
            }
        }
        return list;
    }
    
    // Tìm kiếm TutorRating theo RatingID, TutorID, RatingDate
public List<TutorRating> searchTutorRatings(String ratingId, String tutorId, String ratingDate) throws SQLException {
    List<TutorRating> list = new ArrayList<>();
    
    // Bắt đầu câu truy vấn với điều kiện luôn đúng
    String sql = "SELECT * FROM [dbo].[TutorRating] WHERE 1=1";
    
    // Danh sách các giá trị sẽ được set cho PreparedStatement
    List<Object> params = new ArrayList<>();
    
    // Nếu có truyền ratingId, thêm điều kiện
    if (ratingId != null && !ratingId.trim().isEmpty()) {
        sql += " AND RatingID = ?";
        params.add(Integer.parseInt(ratingId));
    }
    
    // Nếu có truyền tutorId, thêm điều kiện
    if (tutorId != null && !tutorId.trim().isEmpty()) {
        sql += " AND TutorID = ?";
        params.add(Integer.parseInt(tutorId));
    }
    
    // Nếu có truyền ratingDate, thêm điều kiện (giả sử ratingDate là kiểu date hoặc varchar lưu dạng 'YYYY-MM-DD')
    if (ratingDate != null && !ratingDate.trim().isEmpty()) {
        sql += " AND CONVERT(date, RatingDate) = ?"; 
        // Nếu cột RatingDate là kiểu datetime, CONVERT(date, RatingDate) sẽ lấy phần ngày
        params.add(ratingDate);
    }
    
    // Sắp xếp theo ngày đánh giá từ mới nhất đến cũ nhất (nếu có trường RatingDate)
    sql += " ORDER BY RatingDate DESC";
    
    try {
        PreparedStatement pre = conn.prepareStatement(sql);
        // Set các tham số vào PreparedStatement
        for (int i = 0; i < params.size(); i++) {
            pre.setObject(i + 1, params.get(i));
        }
        ResultSet rs = pre.executeQuery();
        while (rs.next()) {
            TutorRating rating = extractTutorRatingFromResultSet(rs);
            list.add(rating);
        }
    } catch (SQLException ex) {
        Logger.getLogger(DAOTutorRating.class.getName()).log(Level.SEVERE, null, ex);
        throw ex;
    }
    return list;
}


    // Test method trong main
    public static void main(String[] args) {
        DAOTutorRating dao = new DAOTutorRating();
        try {
            // Test với thứ tự giảm dần (DESC)
            System.out.println("=== Danh sách gia sư sắp xếp theo điểm trung bình giảm dần (DESC) ===");
            List<Object[]> tutorListDesc = dao.getTutorsWithAverageRating("DESC");
            printTutorList(tutorListDesc);

            // Test với thứ tự tăng dần (ASC)
            System.out.println("\n=== Danh sách gia sư sắp xếp theo điểm trung bình tăng dần (ASC) ===");
            List<Object[]> tutorListAsc = dao.getTutorsWithAverageRating("ASC");
            printTutorList(tutorListAsc);

        } catch (SQLException e) {
            System.err.println("Lỗi khi thực hiện truy vấn: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static void printTutorList(List<Object[]> tutorList) {
        if (tutorList.isEmpty()) {
            System.out.println("Không có dữ liệu gia sư nào.");
            return;
        }

        System.out.printf("%-10s %-20s %-15s %-15s%n", "TutorID", "FullName", "AverageRating", "ReviewCount");
        System.out.println("------------------------------------------------------------");
        for (Object[] tutor : tutorList) {
            int tutorId = (int) tutor[0];
            String fullName = (String) tutor[1];
            double averageRating = (double) tutor[2];
            int reviewCount = (int) tutor[3];
            System.out.printf("%-10d %-20s %-15.2f %-15d%n", tutorId, fullName, averageRating, reviewCount);
        }
    }
}
