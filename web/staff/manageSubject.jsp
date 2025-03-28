<%-- 
    Document   : manageSubject
    Created on : Mar 9, 2025, 2:41:52 PM
    Author     : minht
--%>

<%@page import="entity.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- META -->
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

        <!-- FAVICONS ICON -->
        <link rel="icon" href="../error-404.jsp" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />

        <!-- PAGE TITLE -->
        <title>G4 SmartTutor</title>

        <!-- MOBILE SPECIFIC -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- CSS -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="assets/vendors/calendar/fullcalendar.css">
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="assets/css/dashboard.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">

        <!-- Thêm style cho thông báo -->
        <style>
            .message {
                color: green;
                margin-bottom: 10px;
                font-weight: bold;
            }
            .error {
                color: red;
                margin-bottom: 10px;
                font-weight: bold;
            }
        </style>
    </head>
    <%
        User user = (User) session.getAttribute("user");
    %>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
        <!-- Header -->
        <header class="ttr-header">
            <div class="ttr-header-wrapper">
                <!--sidebar menu toggler start -->
                <div class="ttr-toggle-sidebar ttr-material-button">
                    <i class="ti-close ttr-open-icon"></i>
                    <i class="ti-menu ttr-close-icon"></i>
                </div>
                <!--sidebar menu toggler end -->
                <!--logo start -->
                <div class="ttr-logo-box">
                    <div>
                        <a href="${pageContext.request.contextPath}/staff/dashboard" class="ttr-logo">
                            <img class="ttr-logo-mobile" alt="" src="assets/images/logo-mobile.png" width="30" height="30">
                            <img class="ttr-logo-desktop" alt="" src="assets/images/logo-white.png" width="160" height="27">
                        </a>
                    </div>
                </div>
                <!--logo end -->
            </div>
            <div class="ttr-header-right ttr-with-seperator">
                <!-- header right menu start -->
                <ul class="ttr-header-navigation">
                    <li>
                        <a href="dashboard" class="ttr-material-button ttr-submenu-toggle"><span class="ttr-user-avatar">
                                <img alt="" 
                                     src="${pageContext.request.contextPath}/<%= user.getAvatar() != null ? user.getAvatar() : "uploads/default_avatar.jpg"%>" 
                                     width="32" height="32"
                                     onerror="this.src='${pageContext.request.contextPath}/uploads/default_avatar.jpg'"></span></a>
                        <div class="ttr-header-submenu">
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/profile">My profile</a></li>
                                <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
                            </ul>
                        </div>
                    </li>
                </ul>
                <!-- header right menu end -->
            </div>
            <!--header search panel start -->
            <div class="ttr-search-bar">
                <form class="ttr-search-form">
                    <div class="ttr-search-input-wrapper">
                        <input type="text" name="qq" placeholder="search something..." class="ttr-search-input">
                        <button type="submit" name="search" class="ttr-search-submit"><i class="ti-arrow-right"></i></button>
                    </div>
                    <span class="ttr-search-close ttr-search-toggle">
                        <i class="ti-close"></i>
                    </span>
                </form>
            </div>
            <!--header search panel end -->
        </header>

        <!-- Left sidebar menu start -->
        <div class="ttr-sidebar">
            <div class="ttr-sidebar-wrapper content-scroll">
                <!-- Side menu logo start -->
                <div class="ttr-sidebar-logo">
                    <a href="${pageContext.request.contextPath}/staff/dashboard"><img alt="" src="${pageContext.request.contextPath}/assets/images/logo.png" width="122" height="27"></a>
                    <div class="ttr-sidebar-toggle-button">
                        <i class="ti-arrow-left"></i>
                    </div>
                </div>
                <!-- Side menu logo end -->
                <!-- Sidebar menu start -->
                <nav class="ttr-sidebar-navi">
                    <ul>
                        <li>
                            <a href="${pageContext.request.contextPath}/staff/dashboard" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-home"></i></span>
                                <span class="ttr-label">Dashboard</span>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-briefcase"></i></span>
                                <span class="ttr-label">Tutor Management</span>
                                <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                            </a>
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/staff/ViewSchedule" class="ttr-material-button"><span class="ttr-label">View Schedule</span></a></li>
                                <li><a href="${pageContext.request.contextPath}/staff/ListRated" class="ttr-material-button"><span class="ttr-label">Tutor Reviews</span></a></li>
                                <li><a href="${pageContext.request.contextPath}/staff/SubjectController?service=listSubject" class="ttr-material-button"><span class="ttr-label">Control Subject</span></a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-book"></i></span>
                                <span class="ttr-label">Content Management</span>
                                <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                            </a>
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/staff/BlogController?service=listBlog" class="ttr-material-button"><span class="ttr-label">Blog</span></a></li>
                                <li><a href="${pageContext.request.contextPath}/staff/BlogController?service=addBlog" class="ttr-material-button"><span class="ttr-label">Add Blog</span></a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/staff/historyLog" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-clipboard"></i></span>
                                <span class="ttr-label">User & Tutor Logs</span>
                            </a>
                        </li>
                        <li class="ttr-seperate"></li>
                    </ul>
                </nav>
                <!-- Sidebar menu end -->
            </div>
        </div>

        <!-- Main content -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Subject Management</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="${pageContext.request.contextPath}/staff/dashboard"><i class="fa fa-home"></i>Home</a></li>
                        <li>Subject Management</li>
                    </ul>
                </div>
                <div class="row">
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Subject List</h4>
                                <a href="SubjectController?service=addSubject" class="add-btn">Add Subject</a>
                            </div>
                            <div class="table-responsive">
                                <table>
                                    <c:if test="${not empty sessionScope.message}">
                                        <div class="message">${sessionScope.message}</div>
                                        <c:remove var="message" scope="session" />
                                    </c:if>
                                    <c:if test="${not empty sessionScope.error}">
                                        <div class="error">${sessionScope.error}</div>
                                        <c:remove var="error" scope="session" />
                                    </c:if>
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Subject Name</th>
                                            <th>Description</th>
                                            <th>Status</th> <!-- Thêm cột Status -->
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="subject" items="${subjectList}">
                                            <tr>
                                                <td>${subject.subjectID}</td>
                                                <td>${subject.subjectName}</td>
                                                <td>${subject.description}</td>
                                                <td>${subject.status}</td> <!-- Hiển thị trạng thái -->
                                                <td class="action-links">
                                                    <a href="SubjectController?service=updateSubject&subjectID=${subject.subjectID}" class="update-btn">Update</a>
                                                    <!-- Chỉ hiển thị nút Deactivate nếu trạng thái là Active -->
                                                    <c:if test="${subject.status == 'Active'}">
                                                        <a href="SubjectController?service=deleteSubject&subjectID=${subject.subjectID}" 
                                                           class="delete-btn" onclick="return confirm('Bạn có muốn đổi trạng thái subject này thành Inactive?')">Deactivate</a>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <c:if test="${empty subjectList}">
                                    <p class="error">No subjects found.</p>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <!-- Bảng 2: Danh sách Tutor-Subject với UserName -->
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Tutor-Subject List with UserName</h4>
                            </div>
                            <div class="widget-inner">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Tutor ID</th>
                                            <th>User Name</th>
                                            <th>Subject ID</th>
                                            <th>Description</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="tutorSubject" items="${tutorSubjectList}">
                                            <tr>
                                                <td>${tutorSubject.tutorID}</td>
                                                <td>${tutorSubject.userName}</td>
                                                <td>${tutorSubject.subjectID}</td>
                                                <td>${tutorSubject.description}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <c:if test="${empty tutorSubjectList}">
                                    <p class="error">No tutor-subject records found.</p>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <div class="ttr-overlay"></div>

        <!-- External JavaScripts -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/vendors/bootstrap/js/popper.min.js"></script>
        <script src="assets/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
        <script src="assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
        <script src="assets/vendors/magnific-popup/magnific-popup.js"></script>
        <script src="assets/vendors/counter/waypoints-min.js"></script>
        <script src="assets/vendors/counter/counterup.min.js"></script>
        <script src="assets/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="assets/vendors/masonry/masonry.js"></script>
        <script src="assets/vendors/masonry/filter.js"></script>
        <script src="assets/vendors/owl-carousel/owl.carousel.js"></script>
        <script src='assets/vendors/scroll/scrollbar.min.js'></script>
        <script src="assets/js/functions.js"></script>
        <script src="assets/vendors/chart/chart.min.js"></script>
        <script src="assets/js/admin.js"></script>
        <script src='assets/vendors/calendar/moment.min.js'></script>
        <script src='assets/vendors/calendar/fullcalendar.js'></script>
        <script src='assets/vendors/switcher/switcher.js'></script>
    </body>
</html>