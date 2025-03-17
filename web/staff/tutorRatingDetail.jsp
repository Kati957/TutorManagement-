<%-- 
    Document   : tutorRatingDetail
    Created on : Mar 15, 2025, 9:21:30 PM
    Author     : minht
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chi tiết đánh giá</title>
</head>
<body>
    <h2>Chi tiết đánh giá</h2>
    <p><strong>ID:</strong> ${rating.ratingId}</p>
    <p><strong>Booking ID:</strong> ${rating.bookingId}</p>
    <p><strong>Student ID:</strong> ${rating.studentId}</p>
    <p><strong>Tutor ID:</strong> ${rating.tutorId}</p>
    <p><strong>Rating:</strong> ${rating.rating}</p>
    <p><strong>Comment:</strong> ${rating.comment}</p>
    <p><strong>Rating Date:</strong> ${rating.ratingDate}</p>
    <a href="ListRated">Quay lại danh sách</a>
</body>
</html>