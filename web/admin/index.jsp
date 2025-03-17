<%-- 
    Document   : index
    Created on : Feb 27, 2025, 3:59:18 PM
    Author     : Heizxje
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link rel="icon" href="../error-404.jsp" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />

        <!-- PAGE TITLE -->
        <title>G4 SmartTutor</title>

        <!-- MOBILE SPECIFIC -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- CSS -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="assets/vendors/calendar/fullcalendar.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="assets/css/dashboard.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">

        <!-- CSS cho thông báo -->
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
        </style>
    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
        <%
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }
            String message = (String) session.getAttribute("message");
            String error = (String) request.getAttribute("error");
        %>
        <!-- Header start -->
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
                        <a href="index.jsp" class="ttr-logo">
                            <img class="ttr-logo-mobile" alt="" src="assets/images/logo-mobile.png" width="30" height="30">
                            <img class="ttr-logo-desktop" alt="" src="assets/images/logo-white.png" width="160" height="27">
                        </a>
                    </div>
                </div>
                <!-- Logo end -->
                <div class="ttr-header-right ttr-with-seperator">
                    <!-- Header right menu start -->
                    <ul class="ttr-header-navigation">
                        <li>
                            <a href="profile" class="ttr-material-button ttr-submenu-toggle">
                                <span class="ttr-user-avatar">
                                    <img alt="" src="${pageContext.request.contextPath}/<%= user.getAvatar() != null ? user.getAvatar() : "uploads/default_avatar.jpg"%>" width="32" height="32" onerror="this.src='${pageContext.request.contextPath}/uploads/default_avatar.jpg'">
                                </span>
                            </a>
                            <div class="ttr-header-submenu">
                                <ul>
                                    <li><a href="${pageContext.request.contextPath}/admin/adminprofile">My Profile</a></li>
                                    <li><a href="list-view-calendar.jsp">Activity</a></li>
                                    <li><a href="mailbox.jsp">Messages</a></li>
                                    <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                    <!-- Header right menu end -->
                </div>
                <!-- Header search panel start -->
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
                <!-- Header search panel end -->
            </div>
        </header>
        <!-- Header end -->

        <!-- Left sidebar menu start -->
        <div class="ttr-sidebar">
            <div class="ttr-sidebar-wrapper content-scroll">
                <!-- Side menu logo start -->
                <div class="ttr-sidebar-logo">
                    <a href="#"><img alt="" src="assets/images/logo.png" width="122" height="27"></a>
                    <div class="ttr-sidebar-toggle-button">
                        <i class="ti-arrow-left"></i>
                    </div>
                </div>
                <!-- Side menu logo end -->
                <!-- Sidebar menu start -->
                <div class="ttr-sidebar">
                    <div class="ttr-sidebar-wrapper content-scroll">
                        <!-- Side menu logo start -->
                        <div class="ttr-sidebar-logo">
                            <a href="#"><img alt="" src="assets/images/logo.png" width="122" height="27"></a>
                            <div class="ttr-sidebar-toggle-button">
                                <i class="ti-arrow-left"></i>
                            </div>
                        </div>
                        <!-- Side menu logo end -->
                        <!-- Sidebar menu start -->
                        <nav class="ttr-sidebar-navi">
                            <ul>
                                <li>
                                    <a href="index.jsp" class="ttr-material-button">
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
                                            <a href="#" class="ttr-material-button"><span class="ttr-label">Review Courses</span></a>
                                        </li>
                                        <li>
                                            <a href="RequestCV" class="ttr-material-button"><span class="ttr-label">Status CV</span></a>
                                        </li>
                                        <li>
                                            <a href="#" class="ttr-material-button"><span class="ttr-label">Adjust Tutor Earning</span></a>
                                        </li>
                                        <li>
                                            <a href="#" class="ttr-material-button"><span class="ttr-label">View Schedule</span></a>
                                        </li>
                                        <li>
                                            <a href="#" class="ttr-material-button"><span class="ttr-label">Edit Subject</span></a>
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
                                        <li><a href="${pageContext.request.contextPath}/admin/UserRegister" class="ttr-material-button"><span class="ttr-label">Add New User</span></a></li>
                                        <li><a href="#" class="ttr-material-button"><span class="ttr-label">Review Profile</span></a></li>
                                        <li><a href="#" class="ttr-material-button"><span class="ttr-label">Review Tutor</span></a></li>
                                    </ul>
                                </li>
                                <li>
                                    <a href="#" class="ttr-material-button">
                                        <span class="ttr-icon"><i class="ti-credit-card"></i></span>
                                        <span class="ttr-label">Payment</span>
                                        <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                                    </a>
                                    <ul>
                                        <li><a href="#" class="ttr-material-button"><span class="ttr-label">View Earning</span></a></li>
                                        <li><a href="#" class="ttr-material-button"><span class="ttr-label">View History Payment</span></a></li>
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
            </div>
        </div>
        <!-- Left sidebar menu end -->

        <!-- Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Dashboard</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                        <li>Dashboard</li>
                    </ul>
                </div>
                <!-- Hiển thị thông báo -->
                <% if (message != null) {%>
                <div class="alert alert-success">
                    <%= message%>
                </div>
                <% session.removeAttribute("message"); %>
                <% } %>
                <% if (error != null) {%>
                <div class="alert alert-danger">
                    <%= error%>
                </div>
                <% request.removeAttribute("error"); %>
                <% }%>
                <!-- Card -->
                <div class="row">
                    <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12">
                        <div class="widget-card widget-bg1">
                            <div class="wc-item">
                                <h4 class="wc-title">
                                    Total Profit
                                </h4>
                                <span class="wc-des">
                                    All Customs Value
                                </span>
                                <span class="wc-stats">
                                    $<span class="counter">18</span>M
                                </span>
                                <div class="progress wc-progress">
                                    <div class="progress-bar" role="progressbar" style="width: 78%;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <span class="wc-progress-bx">
                                    <span class="wc-change">
                                        Change
                                    </span>
                                    <span class="wc-number ml-auto">
                                        78%
                                    </span>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12">
                        <div class="widget-card widget-bg2">
                            <div class="wc-item">
                                <h4 class="wc-title">
                                    New Feedbacks
                                </h4>
                                <span class="wc-des">
                                    Customer Review
                                </span>
                                <span class="wc-stats counter">
                                    120
                                </span>
                                <div class="progress wc-progress">
                                    <div class="progress-bar" role="progressbar" style="width: 88%;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <span class="wc-progress-bx">
                                    <span class="wc-change">
                                        Change
                                    </span>
                                    <span class="wc-number ml-auto">
                                        88%
                                    </span>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12">
                        <div class="widget-card widget-bg3">
                            <div class="wc-item">
                                <h4 class="wc-title">
                                    New Orders
                                </h4>
                                <span class="wc-des">
                                    Fresh Order Amount
                                </span>
                                <span class="wc-stats counter">
                                    772
                                </span>
                                <div class="progress wc-progress">
                                    <div class="progress-bar" role="progressbar" style="width: 65%;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <span class="wc-progress-bx">
                                    <span class="wc-change">
                                        Change
                                    </span>
                                    <span class="wc-number ml-auto">
                                        65%
                                    </span>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12">
                        <div class="widget-card widget-bg4">
                            <div class="wc-item">
                                <h4 class="wc-title">
                                    New Users
                                </h4>
                                <span class="wc-des">
                                    Joined New User
                                </span>
                                <span class="wc-stats counter">
                                    350
                                </span>
                                <div class="progress wc-progress">
                                    <div class="progress-bar" role="progressbar" style="width: 90%;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <span class="wc-progress-bx">
                                    <span class="wc-change">
                                        Change
                                    </span>
                                    <span class="wc-number ml-auto">
                                        90%
                                    </span>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Card END -->
                <div class="row">
                    <!-- Your Profile Views Chart -->
                    <div class="col-lg-8 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Your Profile Views</h4>
                            </div>
                            <div class="widget-inner">
                                <canvas id="chart" width="100" height="45"></canvas>
                            </div>
                        </div>
                    </div>
                    <!-- Your Profile Views Chart END-->
                    <div class="col-lg-4 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Notifications</h4>
                            </div>
                            <div class="widget-inner">
                                <div class="noti-box-list">
                                    <ul>
                                        <li>
                                            <span class="notification-icon dashbg-gray">
                                                <i class="fa fa-check"></i>
                                            </span>
                                            <span class="notification-text">
                                                <span>Sneha Jogi</span> sent you a message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 02:14</span>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="notification-icon dashbg-yellow">
                                                <i class="fa fa-shopping-cart"></i>
                                            </span>
                                            <span class="notification-text">
                                                <a href="#">Your order is placed</a> sent you a message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 7 Min</span>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="notification-icon dashbg-red">
                                                <i class="fa fa-bullhorn"></i>
                                            </span>
                                            <span class="notification-text">
                                                <span>Your item is shipped</span> sent you a message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 2 May</span>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="notification-icon dashbg-green">
                                                <i class="fa fa-comments-o"></i>
                                            </span>
                                            <span class="notification-text">
                                                <a href="#">Sneha Jogi</a> sent you a message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 14 July</span>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="notification-icon dashbg-primary">
                                                <i class="fa fa-file-word-o"></i>
                                            </span>
                                            <span class="notification-text">
                                                <span>Sneha Jogi</span> sent you a message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 15 Min</span>
                                            </span>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>New Users</h4>
                            </div>
                            <div class="widget-inner">
                                <div class="new-user-list">
                                    <ul>
                                        <li>
                                            <span class="new-users-pic">
                                                <img src="assets/images/testimonials/pic1.jpg" alt=""/>
                                            </span>
                                            <span class="new-users-text">
                                                <a href="#" class="new-users-name">Anna Strong </a>
                                                <span class="new-users-info">Visual Designer,Google Inc </span>
                                            </span>
                                            <span class="new-users-btn">
                                                <a href="#" class="btn button-sm outline">Follow</a>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="new-users-pic">
                                                <img src="assets/images/testimonials/pic2.jpg" alt=""/>
                                            </span>
                                            <span class="new-users-text">
                                                <a href="#" class="new-users-name"> Milano Esco </a>
                                                <span class="new-users-info">Product Designer, Apple Inc </span>
                                            </span>
                                            <span class="new-users-btn">
                                                <a href="#" class="btn button-sm outline">Follow</a>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="new-users-pic">
                                                <img src="assets/images/testimonials/pic1.jpg" alt=""/>
                                            </span>
                                            <span class="new-users-text">
                                                <a href="#" class="new-users-name">Nick Bold  </a>
                                                <span class="new-users-info">Web Developer, Facebook Inc </span>
                                            </span>
                                            <span class="new-users-btn">
                                                <a href="#" class="btn button-sm outline">Follow</a>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="new-users-pic">
                                                <img src="assets/images/testimonials/pic2.jpg" alt=""/>
                                            </span>
                                            <span class="new-users-text">
                                                <a href="#" class="new-users-name">Wiltor Delton </a>
                                                <span class="new-users-info">Project Manager, Amazon Inc </span>
                                            </span>
                                            <span class="new-users-btn">
                                                <a href="#" class="btn button-sm outline">Follow</a>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="new-users-pic">
                                                <img src="assets/images/testimonials/pic3.jpg" alt=""/>
                                            </span>
                                            <span class="new-users-text">
                                                <a href="#" class="new-users-name">Nick Stone </a>
                                                <span class="new-users-info">Project Manager, Amazon Inc </span>
                                            </span>
                                            <span class="new-users-btn">
                                                <a href="#" class="btn button-sm outline">Follow</a>
                                            </span>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Orders</h4>
                            </div>
                            <div class="widget-inner">
                                <div class="orders-list">
                                    <ul>
                                        <li>
                                            <span class="orders-title">
                                                <a href="#" class="orders-title-name">Anna Strong </a>
                                                <span class="orders-info">Order #02357 | Date 12/08/2019</span>
                                            </span>
                                            <span class="orders-btn">
                                                <a href="#" class="btn button-sm red">Unpaid</a>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="orders-title">
                                                <a href="#" class="orders-title-name">Revenue</a>
                                                <span class="orders-info">Order #02357 | Date 12/08/2019</span>
                                            </span>
                                            <span class="orders-btn">
                                                <a href="#" class="btn button-sm red">Unpaid</a>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="orders-title">
                                                <a href="#" class="orders-title-name">Anna Strong </a>
                                                <span class="orders-info">Order #02357 | Date 12/08/2019</span>
                                            </span>
                                            <span class="orders-btn">
                                                <a href="#" class="btn button-sm green">Paid</a>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="orders-title">
                                                <a href="#" class="orders-title-name">Revenue</a>
                                                <span class="orders-info">Order #02357 | Date 12/08/2019</span>
                                            </span>
                                            <span class="orders-btn">
                                                <a href="#" class="btn button-sm green">Paid</a>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="orders-title">
                                                <a href="#" class="orders-title-name">Anna Strong </a>
                                                <span class="orders-info">Order #02357 | Date 12/08/2019</span>
                                            </span>
                                            <span class="orders-btn">
                                                <a href="#" class="btn button-sm green">Paid</a>
                                            </span>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Basic Calendar</h4>
                            </div>
                            <div class="widget-inner">
                                <div id="calendar"></div>
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
        <script>
            $(document).ready(function () {
                $('#calendar').fullCalendar({
                    header: {
                        left: 'prev,next today',
                        center: 'title',
                        right: 'month,agendaWeek,agendaDay,listWeek'
                    },
                    defaultDate: '2019-03-12',
                    navLinks: true,
                    weekNumbers: true,
                    weekNumbersWithinDays: true,
                    weekNumberCalculation: 'ISO',
                    editable: true,
                    eventLimit: true,
                    events: [
                        {title: 'All Day Event', start: '2019-03-01'},
                        {title: 'Long Event', start: '2019-03-07', end: '2019-03-10'},
                        {id: 999, title: 'Repeating Event', start: '2019-03-09T16:00:00'},
                        {id: 999, title: 'Repeating Event', start: '2019-03-16T16:00:00'},
                        {title: 'Conference', start: '2019-03-11', end: '2019-03-13'},
                        {title: 'Meeting', start: '2019-03-12T10:30:00', end: '2019-03-12T12:30:00'},
                        {title: 'Lunch', start: '2019-03-12T12:00:00'},
                        {title: 'Meeting', start: '2019-03-12T14:30:00'},
                        {title: 'Happy Hour', start: '2019-03-12T17:30:00'},
                        {title: 'Dinner', start: '2019-03-12T20:00:00'},
                        {title: 'Birthday Party', start: '2019-03-13T07:00:00'},
                        {title: 'Click for Google', url: 'http://google.com/', start: '2019-03-28'}
                    ]
                });
            });
        </script>
    </body>
</html>