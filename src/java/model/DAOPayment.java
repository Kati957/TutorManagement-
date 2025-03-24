package model;

import entity.Payment;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author minht
 */
public class DAOPayment {

    // Thông tin kết nối cơ sở dữ liệu
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=test";
    private static final String USER = "sa";
    private static final String PASSWORD = "Minh2004";

    // Tạo kết nối mới
    private Connection getConnection() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Lỗi khi tạo kết nối: " + e.getMessage());
            Logger.getLogger(DAOPayment.class.getName()).log(Level.SEVERE, null, e);
            return null;
        }
    }

    public int insertPayment(Payment payment) {
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "INSERT INTO Payment (BookingID, UserID, Amount, PaymentDate, PaymentMethod, SubjectID, Status) "
                + "OUTPUT INSERTED.PaymentID "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            conn = getConnection();
            if (conn == null) {
                throw new SQLException("Không thể tạo kết nối đến cơ sở dữ liệu");
            }
            pre = conn.prepareStatement(sql);
            if (payment.getBookingID() != 0) {
                pre.setInt(1, payment.getBookingID());
            } else {
                pre.setNull(1, java.sql.Types.INTEGER); // BookingID = NULL nếu không có giá trị
            }
            pre.setInt(2, payment.getUserID());
            pre.setDouble(3, payment.getAmount());
            if (payment.getPaymentDate() != null) {
                pre.setTimestamp(4, new Timestamp(payment.getPaymentDate().getTime()));
            } else {
                pre.setTimestamp(4, null);
            }
            pre.setString(5, payment.getPaymentMethod());
            pre.setInt(6, payment.getSubjectID());
            String status = payment.getStatus() != null ? payment.getStatus() : "Processing";
            pre.setString(7, status);

            // Thực thi câu lệnh và lấy PaymentID
            rs = pre.executeQuery();
            if (rs.next()) {
                int paymentID = rs.getInt("PaymentID");
                System.out.println("Inserted Payment: PaymentID=" + paymentID);
                return paymentID; // Trả về PaymentID
            }
        } catch (SQLException ex) {
            System.out.println("Lỗi khi chèn Payment: " + ex.getMessage());
            Logger.getLogger(DAOPayment.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(conn, pre, rs);
        }
        return -1; // Trả về -1 nếu thất bại
    }
// Lấy lịch sử thanh toán theo UserID (cho user) - giữ nguyên

    public List<Payment> getPaymentsByUserId(int userID) {
        List<Payment> payments = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "SELECT p.* FROM Payment p WHERE p.UserID = ? ORDER BY p.PaymentDate DESC";
        try {
            conn = getConnection();
            if (conn == null) {
                throw new SQLException("Không thể tạo kết nối đến cơ sở dữ liệu");
            }
            pre = conn.prepareStatement(sql);
            pre.setInt(1, userID);
            rs = pre.executeQuery();
            while (rs.next()) {
                Payment payment = extractPaymentFromResultSet(rs);
                payments.add(payment);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOPayment.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(conn, pre, rs);
        }
        return payments;
    }

    // Lấy toàn bộ lịch sử thanh toán (cho admin) - cập nhật truy vấn mới
    public List<Payment> getAllPayments() {
        List<Payment> payments = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "SELECT PaymentID, Payment.BookingID, FullName, Email, Price, PaymentDate, Payment.Status, PromotionID " +
                    "FROM dbo.Payment " +
                    "JOIN dbo.Users ON Users.UserID = Payment.UserID " +
                    "LEFT JOIN dbo.Booking ON Booking.BookingID = Payment.BookingID " +
                    "LEFT JOIN dbo.Tutor ON Tutor.TutorID = Booking.TutorID " +
                    "ORDER BY PaymentDate DESC";
        try {
            conn = getConnection();
            if (conn == null) {
                throw new SQLException("Không thể tạo kết nối đến cơ sở dữ liệu");
            }
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                Payment payment = new Payment();
                payment.setPaymentID(rs.getInt("PaymentID"));
                payment.setBookingID(rs.getInt("BookingID"));
                if (rs.wasNull()) {
                    payment.setBookingID(0);
                }
                payment.setPaymentDate(rs.getTimestamp("PaymentDate"));
                payment.setStatus(rs.getString("Status"));
                payment.setUserName(rs.getString("FullName"));
                payment.setEmail(rs.getString("Email"));
                payment.setAmount(rs.getDouble("Price")); // Sử dụng setAmount để lưu Price
                payment.setPromotionID(rs.getInt("PromotionID"));
                if (rs.wasNull()) {
                    payment.setPromotionID(0);
                }
                payments.add(payment);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOPayment.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(conn, pre, rs);
        }
        return payments;
    }

    // Cập nhật phương thức phân trang cho admin
    public List<Payment> getPaymentsByPageForAdmin(int page, int pageSize) {
        List<Payment> payments = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "SELECT PaymentID, Payment.BookingID, FullName, Email, Price, PaymentDate, Payment.Status, PromotionID " +
                    "FROM dbo.Payment " +
                    "JOIN dbo.Users ON Users.UserID = Payment.UserID " +
                    "LEFT JOIN dbo.Booking ON Booking.BookingID = Payment.BookingID " +
                    "LEFT JOIN dbo.Tutor ON Tutor.TutorID = Booking.TutorID " +
                    "ORDER BY PaymentDate DESC " +
                    "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            conn = getConnection();
            if (conn == null) {
                throw new SQLException("Không thể tạo kết nối đến cơ sở dữ liệu");
            }
            pre = conn.prepareStatement(sql);
            pre.setInt(1, offset);
            pre.setInt(2, pageSize);
            rs = pre.executeQuery();
            while (rs.next()) {
                Payment payment = new Payment();
                payment.setPaymentID(rs.getInt("PaymentID"));
                payment.setBookingID(rs.getInt("BookingID"));
                if (rs.wasNull()) {
                    payment.setBookingID(0);
                }
                payment.setPaymentDate(rs.getTimestamp("PaymentDate"));
                payment.setStatus(rs.getString("Status"));
                payment.setUserName(rs.getString("FullName"));
                payment.setEmail(rs.getString("Email"));
                payment.setAmount(rs.getDouble("Price")); // Sử dụng setAmount để lưu Price
                payment.setPromotionID(rs.getInt("PromotionID"));
                if (rs.wasNull()) {
                    payment.setPromotionID(0);
                }
                payments.add(payment);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOPayment.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(conn, pre, rs);
        }
        return payments;
    }
    // Cập nhật TransactionID, Status và PaymentDate của Payment
    public Payment updatePaymentStatuss(Payment payment) {
        Payment updatedPayment = null;
        Connection conn = null;
        PreparedStatement preCheck = null;
        PreparedStatement preUpdate = null;
        PreparedStatement preSelect = null;
        ResultSet rsCheck = null;
        ResultSet rs = null;
        String checkSql = "SELECT COUNT(*) FROM Payment WHERE PaymentID = ?";
        String updateSql = "UPDATE Payment SET Status = ? WHERE PaymentID = ?";
        String selectSql = "SELECT * FROM Payment WHERE PaymentID = ?";

        try {
            conn = getConnection();
            if (conn == null) {
                System.out.println("Kết nối cơ sở dữ liệu không hợp lệ");
                return null;
            }

            // Kiểm tra đầu vào
            if (payment == null || payment.getStatus() == null || payment.getStatus().trim().isEmpty()) {
                System.out.println("Dữ liệu đầu vào không hợp lệ: PaymentID=" + (payment != null ? payment.getPaymentID() : "null"));
                return null;
            }

            // Kiểm tra PaymentID có tồn tại không
            preCheck = conn.prepareStatement(checkSql);
            preCheck.setInt(1, payment.getPaymentID());
            rsCheck = preCheck.executeQuery();
            if (rsCheck.next() && rsCheck.getInt(1) == 0) {
                System.out.println("PaymentID không tồn tại: " + payment.getPaymentID());
                return null;
            }

            // Cập nhật trạng thái
            preUpdate = conn.prepareStatement(updateSql);
            preUpdate.setString(1, payment.getStatus());
            preUpdate.setInt(2, payment.getPaymentID());
            int n = preUpdate.executeUpdate();

            if (n > 0) {
                // Lấy bản ghi đã cập nhật
                preSelect = conn.prepareStatement(selectSql);
                preSelect.setInt(1, payment.getPaymentID());
                rs = preSelect.executeQuery();
                if (rs.next()) {
                    updatedPayment = extractPaymentFromResultSet(rs);
                    System.out.println("Cập nhật thành công: PaymentID=" + payment.getPaymentID() + ", Status=" + payment.getStatus());
                } else {
                    System.out.println("Không lấy được bản ghi sau cập nhật: PaymentID=" + payment.getPaymentID());
                }
            } else {
                System.out.println("Không có dòng nào được cập nhật: PaymentID=" + payment.getPaymentID());
            }
        } catch (SQLException ex) {
            System.out.println("Lỗi SQL khi cập nhật Payment: PaymentID=" + payment.getPaymentID() + ", Error=" + ex.getMessage());
            Logger.getLogger(DAOPayment.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(conn, preCheck, rsCheck);
            closeResources(null, preUpdate, null);
            closeResources(null, preSelect, rs);
        }
        return updatedPayment;
    }

    // Cập nhật trạng thái của Payment (phương thức chính được sử dụng trong VnpayReturn)
    public boolean updatePaymentStatus(Payment payment) {
        Connection conn = null;
        PreparedStatement pre = null;
        String sql = "UPDATE Payment SET Status = ? WHERE PaymentID = ?";
        try {
            conn = getConnection();
            if (conn == null) {
                throw new SQLException("Không thể tạo kết nối đến cơ sở dữ liệu");
            }
            pre = conn.prepareStatement(sql);
            pre.setString(1, payment.getStatus());
            pre.setInt(2, payment.getPaymentID());
            int rowsAffected = pre.executeUpdate();
            System.out.println("Số dòng được cập nhật: " + rowsAffected);
            return rowsAffected > 0;
        } catch (SQLException ex) {
            System.out.println("Lỗi khi cập nhật Payment: PaymentID=" + payment.getPaymentID() + ", Error=" + ex.getMessage());
            Logger.getLogger(DAOPayment.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } finally {
            closeResources(conn, pre, null);
        }
    }

    // Cập nhật BookingID của Payment (phương thức được gọi trong VnpayReturn sau khi tạo Booking)
    public boolean updatePaymentBookingId(Payment payment) {
        Connection conn = null;
        PreparedStatement pre = null;
        String sql = "UPDATE Payment SET BookingID = ? WHERE PaymentID = ?";
        try {
            conn = getConnection();
            if (conn == null) {
                throw new SQLException("Không thể tạo kết nối đến cơ sở dữ liệu");
            }
            pre = conn.prepareStatement(sql);
            if (payment.getBookingID() != 0) {
                pre.setInt(1, payment.getBookingID());
            } else {
                pre.setNull(1, java.sql.Types.INTEGER);
            }
            pre.setInt(2, payment.getPaymentID());
            int rowsAffected = pre.executeUpdate();
            System.out.println("Số dòng được cập nhật BookingID: " + rowsAffected);
            return rowsAffected > 0;
        } catch (SQLException ex) {
            System.out.println("Lỗi khi cập nhật BookingID cho Payment: PaymentID=" + payment.getPaymentID() + ", Error=" + ex.getMessage());
            Logger.getLogger(DAOPayment.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } finally {
            closeResources(conn, pre, null);
        }
    }

    // Lấy Payment theo PaymentID
    public Payment getPaymentById(int paymentID) {
        Payment payment = null;
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM Payment WHERE PaymentID = ?";
        try {
            conn = getConnection();
            if (conn == null) {
                throw new SQLException("Không thể tạo kết nối đến cơ sở dữ liệu");
            }
            pre = conn.prepareStatement(sql);
            pre.setInt(1, paymentID);
            rs = pre.executeQuery();
            if (rs.next()) {
                payment = extractPaymentFromResultSet(rs);
            }
        } catch (SQLException ex) {
            System.out.println("Lỗi khi lấy Payment theo PaymentID=" + paymentID + ": " + ex.getMessage());
            Logger.getLogger(DAOPayment.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(conn, pre, rs);
        }
        return payment;
    }

    // Lấy Payment theo BookingID
    public Payment getPaymentByBookingId(int bookingID) {
        Payment payment = null;
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM Payment WHERE BookingID = ? ORDER BY PaymentDate DESC";
        try {
            conn = getConnection();
            if (conn == null) {
                throw new SQLException("Không thể tạo kết nối đến cơ sở dữ liệu");
            }
            pre = conn.prepareStatement(sql);
            pre.setInt(1, bookingID);
            rs = pre.executeQuery();
            if (rs.next()) {
                payment = extractPaymentFromResultSet(rs);
            }
        } catch (SQLException ex) {
            System.out.println("Lỗi khi lấy Payment theo BookingID=" + bookingID + ": " + ex.getMessage());
            Logger.getLogger(DAOPayment.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(conn, pre, rs);
        }
        return payment;
    }

    // Xóa Payment với trạng thái Processing
    public int deletePayment(int paymentID) {
        int n = 0;
        Connection conn = null;
        PreparedStatement pre = null;
        String sql = "DELETE FROM Payment WHERE PaymentID = ? AND Status = 'Processing'";
        try {
            conn = getConnection();
            if (conn == null) {
                throw new SQLException("Không thể tạo kết nối đến cơ sở dữ liệu");
            }
            pre = conn.prepareStatement(sql);
            pre.setInt(1, paymentID);
            n = pre.executeUpdate();
            if (n > 0) {
                System.out.println("Xóa Payment thành công: PaymentID=" + paymentID);
            } else {
                System.out.println("Không xóa được Payment: PaymentID=" + paymentID);
            }
        } catch (SQLException ex) {
            System.out.println("Lỗi khi xóa Payment: PaymentID=" + paymentID + ", Error=" + ex.getMessage());
            Logger.getLogger(DAOPayment.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(conn, pre, null);
        }
        return n;
    }

    // Lấy danh sách Payment theo UserID (dùng để hiển thị lịch sử giao dịch)
//    public List<Payment> getPaymentsByUserId(int userID) {
//        List<Payment> payments = new ArrayList<>();
//        Connection conn = null;
//        PreparedStatement pre = null;
//        ResultSet rs = null;
//        String sql = "SELECT * FROM Payment WHERE UserID = ? ORDER BY PaymentDate DESC";
//        try {
//            conn = getConnection();
//            if (conn == null) {
//                throw new SQLException("Không thể tạo kết nối đến cơ sở dữ liệu");
//            }
//            pre = conn.prepareStatement(sql);
//            pre.setInt(1, userID);
//            rs = pre.executeQuery();
//            while (rs.next()) {
//                Payment payment = extractPaymentFromResultSet(rs);
//                payments.add(payment);
//            }
//        } catch (SQLException ex) {
//            System.out.println("Lỗi khi lấy danh sách Payment theo UserID=" + userID + ": " + ex.getMessage());
//            Logger.getLogger(DAOPayment.class.getName()).log(Level.SEVERE, null, ex);
//        } finally {
//            closeResources(conn, pre, rs);
//        }
//        return payments;
//    }

    // Lấy danh sách Payment theo trang (phân trang)
    public List<Payment> getPaymentsByPage(int page, int pageSize) {
        List<Payment> paymentList = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM Payment ORDER BY PaymentDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            conn = getConnection();
            if (conn == null) {
                throw new SQLException("Không thể tạo kết nối đến cơ sở dữ liệu");
            }
            pre = conn.prepareStatement(sql);
            pre.setInt(1, offset);
            pre.setInt(2, pageSize);
            rs = pre.executeQuery();
            while (rs.next()) {
                Payment payment = extractPaymentFromResultSet(rs);
                paymentList.add(payment);
            }
        } catch (SQLException ex) {
            System.out.println("Lỗi khi lấy danh sách Payment theo trang: " + ex.getMessage());
            Logger.getLogger(DAOPayment.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(conn, pre, rs);
        }
        return paymentList;
    }

    // Lấy tổng số Payment để tính số trang
    public int getTotalPayments() {
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "SELECT COUNT(*) FROM Payment";
        try {
            conn = getConnection();
            if (conn == null) {
                throw new SQLException("Không thể tạo kết nối đến cơ sở dữ liệu");
            }
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            System.out.println("Lỗi khi lấy tổng số Payment: " + ex.getMessage());
            Logger.getLogger(DAOPayment.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeResources(conn, pre, rs);
        }
        return 0;
    }

    // Phương thức trích xuất dữ liệu Payment từ ResultSet
    private Payment extractPaymentFromResultSet(ResultSet rs) throws SQLException {
        Payment payment = new Payment();
        payment.setPaymentID(rs.getInt("PaymentID"));
        payment.setBookingID(rs.getInt("BookingID"));
        if (rs.wasNull()) {
            payment.setBookingID(0); // Đặt BookingID = 0 nếu giá trị là NULL
        }
        payment.setUserID(rs.getInt("UserID"));
        payment.setAmount(rs.getDouble("Amount"));
        payment.setPaymentMethod(rs.getString("PaymentMethod"));
        Timestamp timestamp = rs.getTimestamp("PaymentDate");
        if (timestamp != null) {
            payment.setPaymentDate(new Date(timestamp.getTime()));
        }
        payment.setSubjectID(rs.getInt("SubjectID"));
        if (rs.wasNull()) {
            payment.setSubjectID(0);
        }
        payment.setStatus(rs.getString("Status"));
        return payment;
    }

    // Phương thức đóng tài nguyên
    private void closeResources(Connection conn, PreparedStatement pre, ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                Logger.getLogger(DAOPayment.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        if (pre != null) {
            try {
                pre.close();
            } catch (SQLException e) {
                Logger.getLogger(DAOPayment.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                Logger.getLogger(DAOPayment.class.getName()).log(Level.SEVERE, null, e);
            }
        }
    }

    // Test method
    public static void main(String[] args) {
        DAOPayment dao = new DAOPayment();
        Payment payment = new Payment();
        payment.setUserID(2);
        payment.setAmount(23232);
        Timestamp createdAt = new Timestamp(System.currentTimeMillis());
        payment.setPaymentDate(createdAt);
        payment.setPaymentMethod("VNPAY");
        payment.setSubjectID(2);
        payment.setBookingID(0); // BookingID = 0 sẽ được chuyển thành NULL trong insertPayment

        int paymentID = dao.insertPayment(payment);
        if (paymentID > 0) {
            System.out.println("Chèn Payment thành công: PaymentID=" + paymentID);
        } else {
            System.out.println("Chèn Payment thất bại");
        }
    }
}
