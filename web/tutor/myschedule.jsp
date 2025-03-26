<%@page import="entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="${sessionScope.locale != null ? sessionScope.locale : 'en'}">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="keywords" content="" />
    <meta name="author" content="" />
    <meta name="robots" content="" />
    <meta name="description" content="G4 SmartTutor : Smart tutor, effective learning." />
    <meta property="og:title" content="G4 SmartTutor : Smart tutor, effective learning." />
    <meta property="og:description" content="G4 SmartTutor : Smart tutor, effective learning." />
    <meta property="og:image" content="" />
    <meta name="format-detection" content="telephone=no">

    <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />
    <script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.css">

    <title>G4 SmartTutor : <fmt:message key="my_schedule"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" type="text/css" href="assets/css/assets.css">
    <link rel="stylesheet" type="text/css" href="assets/css/typography.css">
    <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">
    <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/layers.css">
    <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/settings.css">
    <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/navigation.css">
</head>
<body id="bg">
    <%
        User user = (User) session.getAttribute("user");
    %>
    <fmt:setLocale value="${sessionScope.locale != null ? sessionScope.locale : 'en'}"/>
    <fmt:setBundle basename="messages"/>

    <div class="page-wraper">
        <header class="header rs-nav header-transparent">
            <!-- Header content (giống như của student) -->
        </header>
        <div class="page-content bg-white">
            <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner1.jpg);">
                <div class="container">
                    <div class="page-banner-entry">
                        <h1 class="text-white"><fmt:message key="my_schedule"/></h1>
                    </div>
                </div>
            </div>
            <div class="container mt-4">
                <a href="home" class="btn btn-primary mb-3"><fmt:message key="back"/></a>
                <h3><fmt:message key="my_schedule"/></h3>
                <form method="GET" id="searchForm" class="mb-3">
                    <div class="input-group">
                        <input type="text" id="searchInput" name="search" placeholder="<fmt:message key='search_by_subject'/>" 
                               class="form-control" value="${param.search}" />
                        <button type="submit" class="btn btn-primary"><fmt:message key="search"/></button>
                    </div>
                </form>
                <div id="calendar"></div>
            </div>
        </div>
        <footer>
            <!-- Footer content (giống như của student) -->
        </footer>
    </div>
    <script>
        $(document).ready(function () {
            var events = [];
            const contextPath = "${pageContext.request.contextPath}";
            console.log("Dữ liệu schedules:", "${schedules}");
            <c:forEach var="schedule" items="${schedules}" varStatus="loop">
                console.log("Schedule:", "${schedule.title}", "${schedule.start}", "${schedule.end}", "${schedule.bookingStatus}");
                events.push({
                    title: "${schedule.StudentName} - ${schedule.SubjectName}", // Hiển thị tên học sinh và môn học
                    start: "${schedule.StartTime}",
                    end: "${schedule.EndTime}",
                    bookingID: "${schedule.ScheduleID}",
                    bookingStatus: "${schedule.Status}"
                });
            </c:forEach>
            console.log("Mảng events sau khi xử lý:", events);

            if (events.length === 0) {
                $('#calendar').html('<p class="text-center text-danger"><fmt:message key="no_schedule"/></p>');
            }
            $('#calendar').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay,listWeek'
                },
                editable: true,
                eventLimit: true,
                events: events,
                eventRender: function(event, element, view) {
                    // Thêm logic hiển thị nút "Review" nếu cần
                }
            });
        });
    </script>
</body>
</html>