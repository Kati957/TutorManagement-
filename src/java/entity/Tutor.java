/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author dvdung
 */
public class Tutor {
    private int tutorID;
    private int CvID;
    private int rating;

    public Tutor(int tutorID, int CvID, int rating) {
        this.tutorID = tutorID;
        this.CvID = CvID;
        this.rating = rating;
    }

    public int getTutorID() {
        return tutorID;
    }

    public void setTutorID(int tutorID) {
        this.tutorID = tutorID;
    }

    public int getCvID() {
        return CvID;
    }

    public void setCvID(int CvID) {
        this.CvID = CvID;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }
    
}
