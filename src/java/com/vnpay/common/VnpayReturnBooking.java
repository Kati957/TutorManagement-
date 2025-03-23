package com.vnpay.common;

import entity.Booking;
import entity.Payment;
import entity.Slot;
import entity.User;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAOBooking;
import model.DAOPayment;

public class VnpayReturnBooking extends HttpServlet {
    DAOPayment dao = new DAOPayment();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        response.setContentType("text/html;charset=UTF-8");

        Map fields = new HashMap();
        for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
            String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
            String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                fields.put(fieldName, fieldValue);
            }
        }

        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
        if (fields.containsKey("vnp_SecureHashType")) {
            fields.remove("vnp_SecureHashType");
        }
        if (fields.containsKey("vnp_SecureHash")) {
            fields.remove("vnp_SecureHash");
        }
        String signValue = Config.hashAllFields(fields);
        if (signValue.equals(vnp_SecureHash)) {
            String paymentID = request.getParameter("vnp_TxnRef");
            Payment payment = new Payment();
            payment.setPaymentID(Integer.parseInt(paymentID));
            boolean transSuccess = false;

            if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
                payment.setStatus("Completed");
                transSuccess = true;

                // Lấy thông tin từ session
                String[] scheduleIds = (String[]) session.getAttribute("scheduleIds");
                String tutorId = (String) session.getAttribute("tutorId");
                String subjectId = (String) session.getAttribute("subjectId");
                User user = (User) session.getAttribute("user");
                int studentID = user.getUserID();

                if (scheduleIds != null && tutorId != null && subjectId != null) {
                    // Tạo Booking
                    List<Slot> slots = new ArrayList<>();
                    List<Booking> bookings = new ArrayList<>();

                    for (String scheduleId : scheduleIds) {
                        Slot slot = new Slot();
                        slot.setScheduleID(Integer.parseInt(scheduleId));
                        slot.setStatus("Available");
                        slots.add(slot);

                        Booking booking = new Booking();
                        booking.setStudentID(studentID);
                        booking.setTutorID(Integer.parseInt(tutorId));
                        booking.setBookingDate(new Date(System.currentTimeMillis()));
                        booking.setStatus("Confirmed");
                        booking.setSubjectID(Integer.parseInt(subjectId));
                        bookings.add(booking);
                    }

                    DAOBooking daoBooking = new DAOBooking();
                    int result = daoBooking.addSlotsAndBookings(slots, bookings);
                    if (result == bookings.size() && !bookings.isEmpty()) {
                        int bookingID = bookings.get(0).getBookingID();
                        payment.setBookingID(bookingID);
                        dao.updatePaymentBookingId(payment);
                        System.out.println("Booking created successfully, BookingID: " + bookingID);
                    }
                }
            } else {
                payment.setStatus("Failed");
            }

            dao.updatePaymentStatus(payment);
            request.setAttribute("transResult", transSuccess);

            // Xóa dữ liệu trong session
            session.removeAttribute("scheduleIds");
            session.removeAttribute("tutorId");
            session.removeAttribute("subjectId");
            session.removeAttribute("totalBill");
            session.removeAttribute("paymentID");

            request.getRequestDispatcher("paymentResult.jsp").forward(request, response);
        } else {
            System.out.println("GD KO HOP LE (invalid signature)");
            response.sendRedirect("paymentResult.jsp?error=Invalid signature");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}