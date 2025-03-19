<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard - Schedule List</title>

        <a href="CreateSchedule.jsp" >Create Schedule</a>

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

        <script type="text/javascript">
            function confirmApprove(event) {
                // Hiển thị hộp thoại xác nhận
                var confirmAction = confirm("Are you sure you want to approve this schedule?");
                if (!confirmAction) {
                    event.preventDefault(); // Nếu người dùng hủy, ngừng gửi form
                }
            }
        </script>
    </head>
    <body>
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
        <div class="pagination">
            <!-- Hiển thị nút "Previous" nếu không phải là trang đầu -->
            <c:if test="${currentPage > 1}">
                <a href="dashboard?page=${currentPage - 1}">Previous</a>
            </c:if>

            <!-- Hiển thị nút "Next" nếu có lịch dạy để chuyển sang trang tiếp theo -->
            <c:if test="${not empty schedules}">
                <a href="dashboard?page=${currentPage + 1}">Next</a>
            </c:if>
        </div>
    </body>
</html>
