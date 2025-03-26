<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bảng Lương</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2>BẢNG LƯƠNG</h2>
        <h4>Giảng Viên: ${tutorName}</h4>

        <!-- Dropdown để lọc theo tháng -->
        <form method="get" action="${pageContext.request.contextPath}/tutor/ViewEarning" class="mb-3">
            <label for="monthFilter">Lọc theo tháng:</label>
            <select name="monthFilter" id="monthFilter" onchange="this.form.submit()">
                <option value="">Tất cả</option>
                <c:forEach var="month" items="${completedMonths}">
                    <option value="${month}" ${param.monthFilter == month ? 'selected' : ''}>${month}</option>
                </c:forEach>
            </select>
        </form>

        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>TutorID</th>
                    <th>BookingID</th>
                    <th>Ngày Dạy</th>
                    <th>Giá Mỗi Giờ</th>
                    <th>Tổng Doanh Thu</th>
                    <th>Tỷ Lệ Hoa Hồng</th>
                    <th>Thu Nhập Sau Hoa Hồng</th>
                    <th>Trạng Thái Rút Tiền</th>
                    <th>Content</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${not empty earningsList}">
                    <c:forEach var="earnings" items="${earningsList}">
                        <tr>
                            <td>${earnings.id}</td>
                            <td>${earnings.tutorID}</td>
                            <td>${earnings.bookingID}</td>
                            <td><fmt:formatDate value="${earnings.bookingDate}" pattern="yyyy-MM-dd"/></td>
                            <td><fmt:formatNumber value="${earnings.hourlyRate}" type="number" pattern="#,###"/>đ</td>
                            <td><fmt:formatNumber value="${earnings.totalEarnings}" type="number" pattern="#,###"/>đ</td>
                            <td>${earnings.sytemCommissionRate * 100}%</td>
                            <td><fmt:formatNumber value="${earnings.earningsAfterCommission}" type="number" pattern="#,###"/>đ</td>
                            <td>${earnings.withdrawStatus}</td>
                            <td>${earnings.content != null ? earnings.content : 'Chưa có thông tin'}</td>
                        </tr>
                    </c:forEach>
                </c:if>
                <c:if test="${empty earningsList}">
                    <tr>
                        <td colspan="10">Không có dữ liệu thu nhập.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <button class="btn btn-primary">Request</button>

        <a href="${pageContext.request.contextPath}/tutor/dashboard" class="btn btn-secondary mt-3">Quay Lại</a>
    </div>
</body>
</html>