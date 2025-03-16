<%-- 
    Document   : tutorRatingList
    Created on : Mar 15, 2025, 9:21:06 PM
    Author     : minht
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Danh sách đánh giá gia sư</title>
</head>
<body>
    <h2>Danh sách đánh giá gia sư</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Booking ID</th>
            <th>Student ID</th>
            <th>Tutor ID</th>
            <th>Rating</th>
            <th>Comment</th>
            <th>Rating Date</th>
            <th>Chi tiết</th>
        </tr>
        <c:forEach var="rating" items="${ratingList}">
            <tr>
                <td>${rating.ratingId}</td>
                <td>${rating.bookingId}</td>
                <td>${rating.studentId}</td>
                <td>${rating.tutorId}</td>
                <td>${rating.rating}</td>
                <td>${rating.comment}</td>
                <td>${rating.ratingDate}</td>
                <td><a href="TutorRatingController?service=detailRating&ratingId=${rating.ratingId}">Xem chi tiết</a></td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>