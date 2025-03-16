<%-- 
    Document   : submitRating
    Created on : Mar 15, 2025, 2:05:02 PM
    Author     : minht
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Đánh giá gia sư</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h2 {
            color: #333;
        }
        .form-container {
            max-width: 600px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #fff;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        select, textarea, button {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        select {
            background-color: #f9f9f9;
        }
        textarea {
            resize: vertical;
            min-height: 100px;
        }
        button {
            background-color: #4CAF50; /* Màu xanh lá cho nút */
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #45a049; /* Tông xanh đậm hơn khi hover */
        }
        .error {
            color: red;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <h2>Đánh giá gia sư</h2>
    
    <%-- Hiển thị thông báo lỗi nếu có --%>
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

    <div class="form-container">
        <form id="ratingForm" action="${pageContext.request.contextPath}/TutorRatingController?service=addRating" method="post">
            <%-- Booking ID được truyền từ URL hoặc servlet --%>
            <input type="hidden" name="bookingId" value="${param.bookingId != null ? param.bookingId : ''}">

            <label for="rating">Điểm đánh giá (1-5):</label>
            <select name="rating" id="rating" required>
                <option value="">Chọn điểm</option>
                <option value="1">1 - Kém</option>
                <option value="2">2 - Trung bình</option>
                <option value="3">3 - Khá</option>
                <option value="4">4 - Tốt</option>
                <option value="5">5 - Xuất sắc</option>
            </select>

            <label for="comment">Nhận xét:</label>
            <textarea name="comment" id="comment" placeholder="Viết nhận xét của bạn..." required></textarea>

            <button type="submit" name="submit" value="submit">Gửi đánh giá</button>
        </form>
    </div>

    <%-- JavaScript để kiểm tra dữ liệu trước khi gửi --%>
    <script>
        document.getElementById('ratingForm').addEventListener('submit', function(event) {
            var rating = document.getElementById('rating').value;
            var comment = document.getElementById('comment').value.trim();

            if (rating === '') {
                alert('Vui lòng chọn điểm đánh giá!');
                event.preventDefault();
                return false;
            }
            if (comment === '') {
                alert('Vui lòng nhập nhận xét!');
                event.preventDefault();
                return false;
            }
            if (comment.length < 10) {
                alert('Nhận xét phải có ít nhất 10 ký tự!');
                event.preventDefault();
                return false;
            }
        });
    </script>
</body>
</html>