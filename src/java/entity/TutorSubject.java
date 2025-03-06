/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author minht
 */
public class TutorSubject {
    private int tutorID;
    private int subjectID;

    public TutorSubject() {
    }

    public TutorSubject(int tutorID, int subjectID) {
        this.tutorID = tutorID;
        this.subjectID = subjectID;
    }

    public int getTutorID() {
        return tutorID;
    }

    public void setTutorID(int tutorID) {
        this.tutorID = tutorID;
    }

    public int getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(int subjectID) {
        this.subjectID = subjectID;
    }
    
}
