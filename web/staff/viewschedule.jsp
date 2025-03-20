<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard - Schedule List</title>
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">

        <!-- Optional theme -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap-theme.min.css" integrity="sha384-sA6NtfjXTdNyJjgLvwnxyuH08R/O4ONnjq8nlZMZz5VxC0E+IbbVdd+mjMVb+aSk" crossorigin="anonymous">

        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f9;
                margin: 0;
                padding: 0;
                color: #333;
            }

            h2 {
                text-align: center;
                color: #4CAF50;
                margin-top: 20px;
            }

            table {
                width: 80%;
                margin: 20px auto;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            th, td {
                padding: 12px 20px;
                text-align: left;
                border: 1px solid #ddd;
            }

            th {
                background-color: #4CAF50;
                color: white;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            tr:hover {
                background-color: #ddd;
            }

            .pagination {
                text-align: center;
                margin-top: 20px;
            }

            .pagination a {
                padding: 10px 20px;
                margin: 0 5px;
                text-decoration: none;
                background-color: #4CAF50;
                color: white;
                border-radius: 5px;
                transition: background-color 0.3s;
            }

            .pagination a:hover {
                background-color: #45a049;
            }

            .pagination a.disabled {
                background-color: #ddd;
                cursor: not-allowed;
            }
        </style>


    </head>
    <body>
        <a style="margin-left: 150px" href="${pageContext.request.contextPath}/staff/index_staff.jsp" class="btn btn-primary">Dashboard</a>
        <h2>Available Schedules</h2>

        <table>
            <thead>
                <tr>
                    <th>Schedule ID</th>
                    <th>Tutor ID</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Subject ID</th>
                    <th>Is Booked</th>
                    <th>ACTION</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="schedule" items="${schedules}">
                    <tr>
                        <td>${schedule.scheduleID}</td>
                        <td>${schedule.tutorID}</td>
                        <td>${schedule.startTime}</td>
                        <td>${schedule.endTime}</td>
                        <td>${schedule.subjectID}</td>
                        <td>${schedule.booked ? 'Yes' : 'No'}</td>
                        <!-- Add Approve Button with confirmation -->
                        <td>
                            <form action="ViewSchedule" method="POST" onsubmit="confirmApprove(event)">
                                <input type="hidden" name="scheduleID" value="${schedule.scheduleID}">
                                <button type="submit">Approve</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Hiển thị phân trang -->
        <div class="d-flex justify-content-center">
<div class="pagination">
    <c:if test="${currentPage > 1}">
        <a href="ViewSchedule?page=${currentPage - 1}">Previous</a>
    </c:if>

    <c:forEach var="i" begin="1" end="${totalPages}">
        <a href="ViewSchedule?page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
    </c:forEach>

    <c:if test="${currentPage < totalPages}">
        <a href="ViewSchedule?page=${currentPage + 1}">Next</a>
    </c:if>
</div>
</div>


    </body>
</html>
<script type="text/javascript">
    function confirmApprove(event) {
        // Hiển thị hộp thoại xác nhận
        var confirmAction = confirm("Are you sure you want to approve this schedule?");
        if (!confirmAction) {
            event.preventDefault(); // Nếu người dùng hủy, ngừng gửi form
        }
    }
</script>