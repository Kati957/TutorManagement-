//package controller.Tutor;
//
///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//
///**
// *
// * @author Shin
// */
//import com.google.gson.Gson;
//import entity.Schedule;
//import entity.Subject;
//import entity.User;
//import jakarta.servlet.RequestDispatcher;
//import java.io.IOException;
//import java.io.PrintWriter;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.util.List;
//import java.util.Map;
//import model.DAOSchedule;
//import model.DAOSubject;
//import model.ScheduleDAO;
//public class ViewTutorScheduleServlet extends HttpServlet {
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//
//        DAOSchedule daoSchedule = new DAOSchedule();
//        User user = (User) request.getSession().getAttribute("user");
//        String search = request.getParameter("search") != null ? request.getParameter("search") : "";
//
//        List<Map<String, Object>> schedules = daoSchedule.getTutorSchedules(user.getUserID(), search);
//        
//        request.setAttribute("schedules", schedules);
//        request.setAttribute("search", search);
//        request.getRequestDispatcher("tutor_schedule.jsp").forward(request, response);
//    }
//}
//
