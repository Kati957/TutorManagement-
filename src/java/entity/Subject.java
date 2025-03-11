
package entity;

public class Subject {
    private int subjectID;
    private String subjectName;
    private String description;
    
    private int tutorID; // Thêm
    private String userName; // Thêm
    private int bookingCount;
    
    public Subject() {
    }

    // Constructor cho getAllTutorSubjects
    public Subject(int subjectID, String description, int tutorID, String userName) {
        this.subjectID = subjectID;
        this.description = description;
        this.tutorID = tutorID;
        this.userName = userName;
    }

    public Subject(int subjectID, String subjectName, String description) {
        this.subjectID = subjectID;
        this.subjectName = subjectName;
        this.description = description;
    }

    public int getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(int subjectID) {
        this.subjectID = subjectID;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getTutorID() {
        return tutorID;
    }

    public void setTutorID(int tutorID) {
        this.tutorID = tutorID;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
    
    
    public int getBookingCount() {
        return bookingCount;
    }

    public void setBookingCount(int bookingCount) {
        this.bookingCount = bookingCount;
    }
}
