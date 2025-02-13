/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import entity.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author dvdung
 */
public class DAOUser extends DBConnect{
    public User Login(String username, String password){
        User user=null;
        String sql="select*from Users where UserName=? and password=?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1,username );
            pre.setString(2,password );
            ResultSet rs = pre.executeQuery();
            if(rs.next()){
                user=new User(rs.getInt(1),rs.getInt(2),rs.getString(3),
                        rs.getString(4),rs.getString(5),rs.getString(6),rs.getInt(7),rs.getString(8)
                        ,rs.getString(9),rs.getString(10),rs.getString(11),rs.getString(12));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }
    public static void main(String[] args) {
        DAOUser dao=new DAOUser();
        User user= dao.Login("johndoe","password123");
        if(user!=null){
            System.out.println("aksjdlksajd");
        }
    }
}
