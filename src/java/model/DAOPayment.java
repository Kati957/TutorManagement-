package model;

import entity.Payment;
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
public class DAOPayment extends DBConnect {

    // Thêm một bản ghi thanh toán mới
    public int insertPayment(Payment payment) {
        int n = 0;
        // Chèn các trường UserID, Amount, PaymentDate, PaymentMethod, SubjectID, BookingID, và Status
        String sql = "INSERT INTO Payment (UserID, Amount, PaymentDate, PaymentMethod, SubjectID, BookingID, Status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            pre.setInt(1, payment.getUserID());
            pre.setDouble(2, payment.getAmount());
            if (payment.getPaymentDate() != null) {
                pre.setTimestamp(3, new Timestamp(payment.getPaymentDate().getTime()));
            } else {
                pre.setTimestamp(3, null);
            }
            pre.setString(4, payment.getPaymentMethod());
            pre.setInt(5, payment.getSubjectID());
            pre.setInt(6, payment.getBookingID());
            // Nếu Status không được set, đặt mặc định là "Processing"
            String status = payment.getStatus() != null ? payment.getStatus() : "Processing";
            pre.setString(7, status);

            n = pre.executeUpdate();

            if (n > 0) {
                try (ResultSet rs = pre.getGeneratedKeys()) {
                    if (rs.next()) {
                        payment.setPaymentID(rs.getInt(1));
                    }
                }
            }
            System.out.println("Inserted Payment: PaymentID=" + payment.getPaymentID());
        } catch (SQLException ex) {
            System.out.println("Lỗi khi chèn Payment: " + ex.getMessage());
            Logger.getLogger(DAOPayment.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    // Cập nhật TransactionID, Status và PaymentDate của Payment
public Payment updatePaymentStatuss(Payment payment) {
    Payment updatedPayment = null;
    String checkSql = "SELECT COUNT(*) FROM Payment WHERE PaymentID = ?";
    String updateSql = "UPDATE Payment SET Status = ? WHERE PaymentID = ?";
    String selectSql = "SELECT * FROM Payment WHERE PaymentID = ?";

    try {
        // Kiểm tra kết nối
        if (conn == null || conn.isClosed()) {
            System.out.println("Kết nối cơ sở dữ liệu không hợp lệ");
            return null;
        }

        // Kiểm tra đầu vào
        if (payment == null || payment.getStatus() == null || payment.getStatus().trim().isEmpty()) {
            System.out.println("Dữ liệu đầu vào không hợp lệ: PaymentID=" + (payment != null ? payment.getPaymentID() : "null"));
            return null;
        }

        // Kiểm tra PaymentID có tồn tại không
        PreparedStatement preCheck = conn.prepareStatement(checkSql);
        preCheck.setInt(1, payment.getPaymentID());
        ResultSet rsCheck = preCheck.executeQuery();
        if (rsCheck.next() && rsCheck.getInt(1) == 0) {
            System.out.println("PaymentID không tồn tại: " + payment.getPaymentID());
            return null;
        }

        // Cập nhật trạng thái
        PreparedStatement preUpdate = conn.prepareStatement(updateSql);
        preUpdate.setString(1, payment.getStatus());
        preUpdate.setInt(2, payment.getPaymentID());
        int n = preUpdate.executeUpdate();

        if (n > 0) {
            // Lấy bản ghi đã cập nhật
            PreparedStatement preSelect = conn.prepareStatement(selectSql);
            preSelect.setInt(1, payment.getPaymentID());
            ResultSet rs = preSelect.executeQuery();
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
    }
    return updatedPayment;
}

    // Lấy Payment theo PaymentID
    public Payment getPaymentById(int paymentID) {
        Payment payment = null;
        String sql = "SELECT * FROM Payment WHERE PaymentID = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, paymentID);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                payment = extractPaymentFromResultSet(rs);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOPayment.class.getName()).log(Level.SEVERE, null, ex);
        }
        return payment;
    }

    // Lấy Payment theo BookingID
    public Payment getPaymentByBookingId(int bookingID) {
        Payment payment = null;
        String sql = "SELECT * FROM Payment WHERE BookingID = ? ORDER BY PaymentDate DESC";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, bookingID);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                payment = extractPaymentFromResultSet(rs);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOPayment.class.getName()).log(Level.SEVERE, null, ex);
        }
        return payment;
    }

    // Xóa Payment với trạng thái Processing
    public int deletePayment(int paymentID) {
        int n = 0;
        String sql = "DELETE FROM Payment WHERE PaymentID = ? AND Status = 'Processing'";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, paymentID);
            n = pre.executeUpdate();
            if (n > 0) {
                System.out.println("Xóa Payment thành công: PaymentID=" + paymentID);
            } else {
                System.out.println("Không xóa được Payment: PaymentID=" + paymentID);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOPayment.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    // Lấy danh sách Payment theo UserID (dùng để hiển thị lịch sử giao dịch)
    public List<Payment> getPaymentsByUserId(int userID) {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT * FROM Payment WHERE UserID = ? ORDER BY PaymentDate DESC";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, userID);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Payment payment = extractPaymentFromResultSet(rs);
                payments.add(payment);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOPayment.class.getName()).log(Level.SEVERE, null, ex);
        }
        return payments;
    }

    // Lấy danh sách Payment theo trang (phân trang)
    public List<Payment> getPaymentsByPage(int page, int pageSize) {
        List<Payment> paymentList = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM Payment ORDER BY PaymentDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, offset);
            stmt.setInt(2, pageSize);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Payment payment = extractPaymentFromResultSet(rs);
                paymentList.add(payment);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOPayment.class.getName()).log(Level.SEVERE, null, ex);
        }
        return paymentList;
    }

    // Lấy tổng số Payment để tính số trang
    public int getTotalPayments() {
        String sql = "SELECT COUNT(*) FROM Payment";
        try {
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOPayment.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    public boolean updatePaymentStatus(Payment payment) {
    String sql = "UPDATE Payment SET Status = ? WHERE PaymentID = ?";
    try {
        PreparedStatement pre = conn.prepareStatement(sql);
        pre.setString(1, payment.getStatus());
        pre.setInt(2, payment.getPaymentID());
        return pre.executeUpdate() > 0;
    } catch (SQLException ex) {
        System.out.println("Lỗi khi cập nhật Payment: PaymentID=" + payment.getPaymentID() + ", Error=" + ex.getMessage());
    }
    return false;
}

    // Phương thức trích xuất dữ liệu Payment từ ResultSet
    private Payment extractPaymentFromResultSet(ResultSet rs) throws SQLException {
        Payment payment = new Payment();
        payment.setPaymentID(rs.getInt("PaymentID"));
        payment.setBookingID(rs.getInt("BookingID"));
        payment.setUserID(rs.getInt("UserID"));
        payment.setAmount(rs.getDouble("Amount"));
        payment.setPaymentMethod(rs.getString("PaymentMethod"));
        payment.setTransactionID(rs.getString("TransactionID"));
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

    // Test method
    // Test method
public static void main(String[] args) {
    DAOPayment dao = new DAOPayment();
    Payment payment = new Payment();
    payment.setStatus("Completed");
    payment.setPaymentID(55);
 
   
}
}