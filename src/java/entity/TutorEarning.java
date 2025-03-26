package entity;

import java.util.Date;

public class TutorEarning {
    private int id;
    private int tutorID;
    private int bookingID;
    private Date bookingDate;
    private double hourlyRate;
    private double totalEarnings;
    private double sytemCommissionRate;
    private double earningsAfterCommission;
    private int staffID;
    private String withdrawStatus;
    private String content;

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getTutorID() { return tutorID; }
    public void setTutorID(int tutorID) { this.tutorID = tutorID; }

    public int getBookingID() { return bookingID; }
    public void setBookingID(int bookingID) { this.bookingID = bookingID; }

    public Date getBookingDate() { return bookingDate; }
    public void setBookingDate(Date bookingDate) { this.bookingDate = bookingDate; }

    public double getHourlyRate() { return hourlyRate; }
    public void setHourlyRate(double hourlyRate) { this.hourlyRate = hourlyRate; }

    public double getTotalEarnings() { return totalEarnings; }
    public void setTotalEarnings(double totalEarnings) { this.totalEarnings = totalEarnings; }

    public double getSytemCommissionRate() { return sytemCommissionRate; }
    public void setSytemCommissionRate(double sytemCommissionRate) { this.sytemCommissionRate = sytemCommissionRate; }

    public double getEarningsAfterCommission() { return earningsAfterCommission; }
    public void setEarningsAfterCommission(double earningsAfterCommission) { this.earningsAfterCommission = earningsAfterCommission; }

    public int getStaffID() { return staffID; }
    public void setStaffID(int staffID) { this.staffID = staffID; }

    public String getWithdrawStatus() { return withdrawStatus; }
    public void setWithdrawStatus(String withdrawStatus) { this.withdrawStatus = withdrawStatus; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
}