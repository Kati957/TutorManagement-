
package entity;

public class Slot {
    private int slotID;
    private int scheduleID;
    private String status;
    private String meetURL;
    private Schedule schedule;
    private Booking booking;
    
    public Slot() {
    }

    public Slot(int slotID, int scheduleID, String status) {
        this.slotID = slotID;
        this.scheduleID = scheduleID;
        this.status = status;
    }

    public Slot(int slotID, int scheduleID, String status, String meetURL, Schedule schedule, Booking booking) {
        this.slotID = slotID;
        this.scheduleID = scheduleID;
        this.status = status;
        this.meetURL = meetURL;
        this.schedule = schedule;
        this.booking = booking;
    }
    

    public int getSlotID() {
        return slotID;
    }

    public void setSlotID(int slotID) {
        this.slotID = slotID;
    }

    public int getScheduleID() {
        return scheduleID;
    }

    public void setScheduleID(int scheduleID) {
        this.scheduleID = scheduleID;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getMeetURL() {
        return meetURL;
    }

    public void setMeetURL(String meetURL) {
        this.meetURL = meetURL;
    }

    public Schedule getSchedule() {
        return schedule;
    }

    public void setSchedule(Schedule schedule) {
        this.schedule = schedule;
    }

    public Booking getBooking() {
        return booking;
    }

    public void setBooking(Booking booking) {
        this.booking = booking;
    }

   
    
}
