package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import entity.ScheduleTemp;
import java.time.LocalDateTime;

public class ScheduleDAO {

    // Sử dụng DBConnect đã có sẵn
    private DBConnect dbConnect;

    public ScheduleDAO() {
        this.dbConnect = new DBConnect();  // Khởi tạo kết nối
    }

    // Thêm lịch dạy mới vào cơ sở dữ liệu
    public int createSchedule(ScheduleTemp schedule) {
        String sql = "INSERT INTO dbo.Schedule (TutorID, StartTime, EndTime, IsBooked, SubjectID) VALUES (?, ?, ?, 0, ?)";
        try (Connection conn = dbConnect.conn; PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, schedule.getTutorID());
            stmt.setObject(2, schedule.getStartTime());
            stmt.setObject(3, schedule.getEndTime());
            stmt.setInt(4, schedule.getSubjectID());
            stmt.executeUpdate();

            // Lấy ID của lịch dạy vừa tạo
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);  // Trả về ScheduleID
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Lấy tất cả lịch chưa được đặt
    public List<ScheduleTemp> getAvailableSchedules() {
        List<ScheduleTemp> schedules = new ArrayList<>();
        String sql = "SELECT * FROM dbo.Schedule WHERE IsBooked = 0";
        try (Connection conn = dbConnect.conn; PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ScheduleTemp schedule = new ScheduleTemp();
                schedule.setScheduleID(rs.getInt("ScheduleID"));
                schedule.setTutorID(rs.getInt("TutorID"));
                schedule.setStartTime(rs.getTimestamp("StartTime").toLocalDateTime());
                schedule.setEndTime(rs.getTimestamp("EndTime").toLocalDateTime());
                schedule.setBooked(rs.getBoolean("IsBooked"));
                schedule.setSubjectID(rs.getInt("SubjectID"));
                schedules.add(schedule);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return schedules;
    }

    // Cập nhật lịch đã được phê duyệt (IsBooked = 1)
public boolean approveSchedule(int scheduleID) {
    String sql = "UPDATE dbo.Schedule SET status = 'Qualified' WHERE ScheduleID = ?";
    try (Connection conn = dbConnect.conn; PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, scheduleID);
        int rowsUpdated = stmt.executeUpdate();
        return rowsUpdated > 0;
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}


    // Hủy lịch (IsBooked = 0)
    public boolean cancelSchedule(int scheduleID) {
        String sql = "UPDATE dbo.Schedule SET IsBooked = 0 WHERE ScheduleID = ?";
        try (Connection conn = dbConnect.conn; PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, scheduleID);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<ScheduleTemp> getSchedulesByUserId(int userId) {
        List<ScheduleTemp> schedules = new ArrayList<>();
        String sql = "SELECT * FROM dbo.Schedule WHERE TutorID = ?";
        try (Connection conn = dbConnect.conn; PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ScheduleTemp schedule = new ScheduleTemp();
                schedule.setScheduleID(rs.getInt("ScheduleID"));
                schedule.setTutorID(rs.getInt("TutorID"));
                schedule.setStartTime(rs.getTimestamp("StartTime").toLocalDateTime());
                schedule.setEndTime(rs.getTimestamp("EndTime").toLocalDateTime());
                schedule.setBooked(rs.getBoolean("IsBooked"));
                schedule.setSubjectID(rs.getInt("SubjectID"));
                schedules.add(schedule);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return schedules;
    }

public List<ScheduleTemp> getSchedulesWithPaginationStatusPending(int pageNumber) {
    List<ScheduleTemp> schedules = new ArrayList<>();
    
    // Xác định số lượng bản ghi mỗi trang và offset
    int pageSize = 10;
    int offset = (pageNumber - 1) * pageSize;

    // Câu lệnh SQL phân trang
    String sql = "SELECT * " +
                 "FROM dbo.Schedule " +
                 "WHERE status = 'Pending' " +
                 "ORDER BY ScheduleID " +
                 "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"; // Sử dụng dấu hỏi cho giá trị OFFSET và FETCH

    try (Connection conn = dbConnect.conn; PreparedStatement stmt = conn.prepareStatement(sql)) {
        // Đặt giá trị cho OFFSET và FETCH
        stmt.setInt(1, offset);  // Đặt giá trị OFFSET
        stmt.setInt(2, pageSize); // Đặt giá trị FETCH NEXT

        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            ScheduleTemp schedule = new ScheduleTemp();
            schedule.setScheduleID(rs.getInt("ScheduleID"));
            schedule.setTutorID(rs.getInt("TutorID"));
            schedule.setStartTime(rs.getTimestamp("StartTime").toLocalDateTime());
            schedule.setEndTime(rs.getTimestamp("EndTime").toLocalDateTime());
            schedule.setBooked(rs.getBoolean("IsBooked"));
            schedule.setSubjectID(rs.getInt("SubjectID"));
            schedules.add(schedule);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return schedules;
}

public static void main(String[] args) {
    ScheduleDAO dao = new ScheduleDAO();
    List<ScheduleTemp> list = dao.getSchedulesWithPaginationStatusPending(1); // Lấy dữ liệu trang 1
    for (ScheduleTemp schedule : list) {
        System.out.println(schedule);
    }
}
}




