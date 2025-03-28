<%-- 
    Document   : systemRevenue
    Created on : Mar 27, 2025
    Author     : [Your Name]
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="entity.User"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <!-- META -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="keywords" content="" />
    <meta name="author" content="" />
    <meta name="robots" content="" />

    <!-- DESCRIPTION -->
    <meta name="description" content="G4 SmartTutor : Smart tutor, effective learning." />

    <!-- OG -->
    <meta property="og:title" content="G4 SmartTutor : Smart tutor, effective learning." />
    <meta property="og:description" content="G4 SmartTutor : Smart tutor, effective learning." />
    <meta property="og:image" content="" />
    <meta name="format-detection" content="telephone=no">

    <!-- FAVICONS ICON -->
    <link rel="icon" href="${pageContext.request.contextPath}/error-404.jsp" type="image/x-icon" />
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/images/favicon.png" />

    <!-- PAGE TITLE -->
    <title>G4 SmartTutor - Tổng Thu và Lợi Nhuận Hệ Thống</title>

    <!-- MOBILE SPECIFIC -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/assets.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/typography.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/shortcodes/shortcodes.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
    <link class="skin" rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/color/color-1.css">

    <!-- CSS tùy chỉnh từ index.jsp -->
    <style>
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
        }
        .alert-success {
            color: #3c763d;
            background-color: #dff0d8;
            border-color: #d6e9c6;
        }
        .alert-danger {
            color: #a94442;
            background-color: #f2dede;
            border-color: #ebccd1;
        }
        /* Điều chỉnh layout cho 3 cột */
        .row {
            display: flex;
            flex-wrap: wrap;
            margin-right: -15px;
            margin-left: -15px;
        }
        .col-lg-4 {
            flex: 0 0 33.333333%;
            max-width: 33.333333%;
            padding-right: 15px;
            padding-left: 15px;
            box-sizing: border-box;
        }
        .col-md-6, .col-lg-3, .col-xl-3, .col-sm-6, .col-12 {
            padding-right: 15px;
            padding-left: 15px;
            box-sizing: border-box;
        }
        .widget-box {
            background: #fff;
            border: 1px solid #e5e5e5;
            border-radius: 4px;
            box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
        }
        .wc-title {
            padding: 15px;
            border-bottom: 1px solid #e5e5e5;
        }
        .widget-inner {
            padding: 15px;
        }
        .m-b30 {
            margin-bottom: 30px;
        }
        /* Giảm kích thước font của các con số trong Card */
        .wc-stats, .counter, .wc-number {
            font-size: 14px !important; /* Giảm kích thước font, bạn có thể điều chỉnh giá trị này */
        }
    </style>
</head>
<body class="ttr-opened-sidebar ttr-pinned-sidebar">
    <%
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
    %>

    <!-- Header từ index.jsp -->
    <header class="ttr-header">
        <div class="ttr-header-wrapper">
            <!-- Sidebar menu toggler start -->
            <div class="ttr-toggle-sidebar ttr-material-button">
                <i class="ti-close ttr-open-icon"></i>
                <i class="ti-menu ttr-close-icon"></i>
            </div>
            <!-- Sidebar menu toggler end -->
            <!-- Logo start -->
            <div class="ttr-logo-box">
                <div>
                    <a href="${pageContext.request.contextPath}/admin/index" class="ttr-logo">
                        <img class="ttr-logo-mobile" alt="" src="${pageContext.request.contextPath}/assets/images/logo-mobile.png" width="30" height="30">
                        <img class="ttr-logo-desktop" alt="" src="${pageContext.request.contextPath}/assets/images/logo-white.png" width="160" height="27">
                    </a>
                </div>
            </div>
            <!-- Logo end -->
            <div class="ttr-header-menu">
                <!-- header left menu start -->
                <ul class="ttr-header-navigation">
                    <li>
                        <a href="index" class="ttr-material-button ttr-submenu-toggle">HOME</a>
                    </li>
                    <li>
                        <a href="#" class="ttr-material-button ttr-submenu-toggle">Language <i class="fa fa-angle-down"></i></a>
                        <div class="ttr-header-submenu">
                            <ul>
                                <li><a href="#">Tiếng Việt</a></li>
                                <li><a href="#">English</a></li>
                            </ul>
                        </div>
                    </li>
                </ul>
                <!-- header left menu end -->
            </div>
            <div class="ttr-header-right ttr-with-seperator">
                <!-- Header right menu start -->
                <ul class="ttr-header-navigation">
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/adminprofile" class="ttr-material-button ttr-submenu-toggle">
                            <span class="ttr-user-avatar">
                                <img alt="" 
                                     src="${pageContext.request.contextPath}/<%= user.getAvatar() != null ? user.getAvatar() : "uploads/default_avatar.jpg"%>" 
                                     width="32" height="32"
                                     onerror="this.src='${pageContext.request.contextPath}/uploads/default_avatar.jpg'">
                            </span>
                        </a>
                        <div class="ttr-header-submenu">
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/admin/adminprofile">My Profile</a></li>
                                <li><a href="#">Activity</a></li>
                                <li><a href="mailbox.jsp">Messages</a></li>
                                <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
                            </ul>
                        </div>
                    </li>
                </ul>
                <!-- Header right menu end -->
            </div>
        </div>
    </header>
    <!-- Header end -->

    <!-- Left sidebar menu từ index.jsp -->
    <div class="ttr-sidebar">
        <div class="ttr-sidebar-wrapper content-scroll">
            <!-- Side menu logo start -->
            <div class="ttr-sidebar-logo">
                <a href="${pageContext.request.contextPath}/admin/index"><img alt="" src="${pageContext.request.contextPath}/assets/images/logo.png" width="122" height="27"></a>
                <div class="ttr-sidebar-toggle-button">
                    <i class="ti-arrow-left"></i>
                </div>
            </div>
            <!-- Side menu logo end -->
            <!-- Sidebar -->
            <nav class="ttr-sidebar-navi">
                <ul>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/index" class="ttr-material-button">
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
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/TutorList" class="ttr-material-button"><span class="ttr-label">Tutor List</span></a>
                            </li>
                            <li>
                                <a href="AdminListRated" class="ttr-material-button"><span class="ttr-label">Tutor Reviews</span></a>
                            </li>
                            <li>
                                <a href="RequestCV" class="ttr-material-button"><span class="ttr-label">Status CV</span></a>
                            </li>
                            <li>
                                <a href="ViewBooking" class="ttr-material-button"><span class="ttr-label">Booking Manage</span></a>
                            </li>
                            <li>
                                <a href="#" class="ttr-material-button"><span class="ttr-label">Adjust Tutor Earning</span></a>
                            </li>
                            <li>
                                <a href="AdminViewSchedule" class="ttr-material-button"><span class="ttr-label">View Schedule</span></a>
                            </li>
                            <li>
                                <a href="AdminSubjectController" class="ttr-material-button"><span class="ttr-label">Subject Management</span></a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="#" class="ttr-material-button">
                            <span class="ttr-icon"><i class="ti-user"></i></span>
                            <span class="ttr-label">Staff Management</span>
                            <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                        </a>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/admin/StaffList" class="ttr-material-button"><span class="ttr-label">Staff List</span></a></li>
                            <li><a href="${pageContext.request.contextPath}/admin/StaffManage" class="ttr-material-button"><span class="ttr-label">Add New Staff</span></a></li>
                            <li><a href="#" class="ttr-material-button"><span class="ttr-label">View Reports</span></a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#" class="ttr-material-button">
                            <span class="ttr-icon"><i class="ti-id-badge"></i></span>
                            <span class="ttr-label">User Management</span>
                            <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                        </a>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/admin/UserList" class="ttr-material-button"><span class="ttr-label">User List</span></a></li>
                            <li><a href="#" class="ttr-material-button"><span class="ttr-label">Review Profile</span></a></li>
                            <li><a href="#" class="ttr-material-button"><span class="ttr-label">Review Tutor</span></a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#" class="ttr-material-button active">
                            <span class="ttr-icon"><i class="ti-credit-card"></i></span>
                            <span class="ttr-label">Payment</span>
                            <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                        </a>
                        <ul>
                            <li><a href="#" class="ttr-material-button"><span class="ttr-label">View Earning</span></a></li>
                            <li><a href="PaymentHistory" class="ttr-material-button"><span class="ttr-label">View History Payment</span></a></li>
                            <li><a href="systemRevenue" class="ttr-material-button active"><span class="ttr-label">System revenue</span></a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#" class="ttr-material-button">
                            <span class="ttr-icon"><i class="ti-book"></i></span>
                            <span class="ttr-label">Content Management</span>
                            <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                        </a>
                        <ul>
                            <li><a href="#" class="ttr-material-button"><span class="ttr-label">Blog</span></a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/historyLog" class="ttr-material-button">
                            <span class="ttr-icon"><i class="ti-clipboard"></i></span>
                            <span class="ttr-label">History Log</span>
                        </a>
                    </li>
                    <li class="ttr-seperate"></li>
                </ul>
                <!-- Sidebar menu end -->
            </nav>
        </div>
    </div>
    <!-- Left sidebar menu end -->

    <!-- Main container start -->
    <main class="ttr-wrapper">
        <div class="container-fluid">
            <!-- Breadcrumb -->
            <div class="db-breadcrumb">
                <h4 class="breadcrumb-title">Tổng Thu và Lợi Nhuận Hệ Thống</h4>
                <ul class="db-breadcrumb-list">
                    <li><a href="${pageContext.request.contextPath}/admin/index"><i class="fa fa-home"></i>Home</a></li>
                    <li>Tổng Thu và Lợi Nhuận Hệ Thống</li>
                </ul>
            </div>

            <!-- Nội dung chính của systemRevenue.jsp -->
            <div class="widget-box">
                <div class="wc-title">
                    <h4>Tổng Toàn Bộ</h4>
                </div>
                <div class="widget-inner">
                    <div class="summary">
                        <div>
                            <strong>Tổng thu từ học sinh:</strong> 
                            <fmt:formatNumber value="${totalRevenue}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ
                        </div>
                        <div>
                            <strong>Tổng tiền trả cho gia sư:</strong> 
                            <fmt:formatNumber value="${tutorPayments}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ
                        </div>
                        <div>
                            <strong>Tổng tiền lãi:</strong> 
                            <fmt:formatNumber value="${totalProfit}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ
                        </div>
                    </div>
                </div>
            </div>

            <div class="widget-box">
                <div class="wc-title">
                    <h4>Chi Tiết Theo Tháng</h4>
                </div>
                <div class="widget-inner">
                    <form method="get" action="${pageContext.request.contextPath}/admin/systemRevenue" class="filter-form">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="searchField">Tìm kiếm theo:</label>
                                    <select name="searchField" id="searchField" class="form-control">
                                        <option value="Month" ${searchField == 'Month' ? 'selected' : ''}>Tháng/Năm</option>
                                        <option value="TotalRevenue" ${searchField == 'TotalRevenue' ? 'selected' : ''}>Tổng Thu</option>
                                        <option value="TutorPayments" ${searchField == 'TutorPayments' ? 'selected' : ''}>Tiền Trả Gia Sư</option>
                                        <option value="Profit" ${searchField == 'Profit' ? 'selected' : ''}>Lợi Nhuận</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="search">Giá trị tìm kiếm:</label>
                                    <input type="text" name="search" id="search" value="${search}" class="form-control" 
                                           placeholder="${searchField == 'Month' ? 'Tháng (VD: 3), Năm (VD: 2024), hoặc yyyy-MM (VD: 2025-01, 2025/01)' : 'VD: 1000000'}">
                                    <input type="submit" value="Tìm kiếm">
                                </div>
                            </div>
                        </div>
                    </form>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <c:if test="${empty monthlyDetails}">
                        <div class="alert alert-info">Không có dữ liệu để hiển thị.</div>
                    </c:if>
                    <c:if test="${not empty monthlyDetails}">
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>
                                            <a href="${pageContext.request.contextPath}/admin/systemRevenue?sortBy=Month&sortOrder=${sortBy == 'Month' && sortOrder == 'asc' ? 'desc' : 'asc'}&searchField=${searchField}&search=${search}">
                                                Tháng ${sortBy == 'Month' ? (sortOrder == 'asc' ? '↑' : '↓') : ''}
                                            </a>
                                        </th>
                                        <th>
                                            <a href="${pageContext.request.contextPath}/admin/systemRevenue?sortBy=TotalRevenue&sortOrder=${sortBy == 'TotalRevenue' && sortOrder == 'asc' ? 'desc' : 'asc'}&searchField=${searchField}&search=${search}">
                                                Tổng Thu ${sortBy == 'TotalRevenue' ? (sortOrder == 'asc' ? '↑' : '↓') : ''}
                                            </a>
                                        </th>
                                        <th>
                                            <a href="${pageContext.request.contextPath}/admin/systemRevenue?sortBy=TutorPayments&sortOrder=${sortBy == 'TutorPayments' && sortOrder == 'asc' ? 'desc' : 'asc'}&searchField=${searchField}&search=${search}">
                                                Tiền Trả Gia Sư ${sortBy == 'TutorPayments' ? (sortOrder == 'asc' ? '↑' : '↓') : ''}
                                            </a>
                                        </th>
                                        <th>
                                            <a href="${pageContext.request.contextPath}/admin/systemRevenue?sortBy=Profit&sortOrder=${sortBy == 'Profit' && sortOrder == 'asc' ? 'desc' : 'asc'}&searchField=${searchField}&search=${search}">
                                                Lợi Nhuận ${sortBy == 'Profit' ? (sortOrder == 'asc' ? '↑' : '↓') : ''}
                                            </a>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="entry" items="${monthlyDetails}">
                                        <tr>
                                            <td>${entry.key}</td>
                                            <td><fmt:formatNumber value="${entry.value['TotalRevenue']}" type="number" groupingUsed="true" maxFractionDigits="0"/></td>
                                            <td><fmt:formatNumber value="${entry.value['TutorPayments']}" type="number" groupingUsed="true" maxFractionDigits="0"/></td>
                                            <td><fmt:formatNumber value="${entry.value['Profit']}" type="number" groupingUsed="true" maxFractionDigits="0"/></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>

                    <div class="mt-3">
                        <a href="${pageContext.request.contextPath}/admin/index" class="back-link">Quay lại Dashboard</a>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <div class="ttr-overlay"></div>

    <!-- External JavaScripts từ systemRevenue.jsp (giữ nguyên) -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/vendors/bootstrap/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/vendors/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
    <script src="${pageContext.request.contextPath}/assets/vendors/magnific-popup/magnific-popup.js"></script>
    <script src="${pageContext.request.contextPath}/assets/vendors/counter/waypoints-min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/vendors/counter/counterup.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/vendors/imagesloaded/imagesloaded.js"></script>
    <script src="${pageContext.request.contextPath}/assets/vendors/masonry/masonry.js"></script>
    <script src="${pageContext.request.contextPath}/assets/vendors/masonry/filter.js"></script>
    <script src="${pageContext.request.contextPath}/assets/vendors/owl-carousel/owl.carousel.js"></script>
    <script src="${pageContext.request.contextPath}/assets/vendors/scroll/scrollbar.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/functions.js"></script>
    <script src="${pageContext.request.contextPath}/assets/vendors/chart/chart.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/admin.js"></script>
    <script src="${pageContext.request.contextPath}/assets/vendors/switcher/switcher.js"></script>
</body>
</html>