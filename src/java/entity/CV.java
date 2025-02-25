/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author dvdung
 */
public class CV {

    private int CVID;
    private int UserID;
    private String Education;
    private String Experience;
    private String Certificates;
    private String Status;
    private int subjectID;
    private String description;

    public CV(int CVID, int UserID, String Education, String Experience, String Certificates, String Status, int subjectID, String description) {
        this.CVID = CVID;
        this.UserID = UserID;
        this.Education = Education;
        this.Experience = Experience;
        this.Certificates = Certificates;
        this.Status = Status;
        this.subjectID = subjectID;
        this.description = description;
    }

    public int getCVID() {
        return CVID;
    }

    public void setCVID(int CVID) {
        this.CVID = CVID;
    }

    public int getUserID() {
        return UserID;
    }

    public void setUserID(int UserID) {
        this.UserID = UserID;
    }

    public String getEducation() {
        return Education;
    }

    public void setEducation(String Education) {
        this.Education = Education;
    }

    public String getExperience() {
        return Experience;
    }

    public void setExperience(String Experience) {
        this.Experience = Experience;
    }

    public String getCertificates() {
        return Certificates;
    }

    public void setCertificates(String Certificates) {
        this.Certificates = Certificates;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    public int getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(int subjectID) {
        this.subjectID = subjectID;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    

}

