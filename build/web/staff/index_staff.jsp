<%-- 
    Document   : index_staff
    Created on : Mar 3, 2025, 10:24:48 PM
    Author     : minht
--%>

<%@page import="entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

    <head>

        <!-- META ============================================= -->
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

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="../error-404.jsp" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>G4 SmartTutor</title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--[if lt IE 9]>
        <script src="assets/js/html5shiv.min.js"></script>
        <script src="assets/js/respond.min.js"></script>
        <![endif]-->

        <!-- All PLUGINS CSS ============================================= -->
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

    </head>
    <%
        User user = (User) session.getAttribute("user");
    %>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">

        <!-- header start -->
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
                        <a href="index_staff.jsp" class="ttr-logo">

                            <img class="ttr-logo-mobile" alt="" src="assets/images/logo-mobile.png" width="30" height="30">
                            <img class="ttr-logo-desktop" alt="" src="assets/images/logo-white.png" width="160" height="27">
                        </a>
                    </div>
                </div>
                <!--logo end -->

                <!-- header left menu end -->
            </div>
            <div class="ttr-header-right ttr-with-seperator">
                <!-- header right menu start -->
                <ul class="ttr-header-navigation">
                    <li>
                        <a href="index_staff.jsp" class="ttr-material-button ttr-submenu-toggle"><span class="ttr-user-avatar">
                                <img alt="" 
                                     src="${pageContext.request.contextPath}/<%= user.getAvatar() != null ? user.getAvatar() : "uploads/default_avatar.jpg"%>" 
                                     width="32" height="32"
                                     onerror="this.src='${pageContext.request.contextPath}/uploads/default_avatar.jpg'"></a>
                                <div class="ttr-header-submenu">
                                    <ul>
                                        <li><a href="${pageContext.request.contextPath}/staff/staffprofile">My profile</a></li>
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
                                </header>
                                <!-- header end -->
                                <!-- Left sidebar menu start -->
                                <!-- Sidebar -->
                                <div class="ttr-sidebar">
                                    <div class="ttr-sidebar-wrapper content-scroll">
                                        <div class="ttr-sidebar-logo">
                                            <a href="#"><img alt="" src="assets/images/logo.png" width="122" height="27"></a>
                                            <div class="ttr-sidebar-toggle-button"><i class="ti-arrow-left"></i></div>
                                        </div>
                                        <nav class="ttr-sidebar-navi">
                                            <ul>
                                                <li><a href="index_staff.jsp" class="ttr-material-button"><span class="ttr-icon"><i class="ti-home"></i></span><span class="ttr-label">Dashboard</span></a></li>
                                                <li>
                                                    <a href="#" class="ttr-material-button"><span class="ttr-icon"><i class="ti-briefcase"></i></span><span class="ttr-label">Tutor Management</span><span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span></a>
                                                    <ul>
                                                        <li><a href="#" class="ttr-material-button"><span class="ttr-label">Adjust Tutor Earning</span></a></li>
                                                        <li><a href="#" class="ttr-material-button"><span class="ttr-label">View Schedule</span></a></li>
                                                        <li><a href="#" class="ttr-material-button"><span class="ttr-label">View Booking</span></a></li>
                                                        <li><a href="ListRated" class="ttr-material-button"><span class="ttr-label">Tutor Reviews</span></a></li>
                                                        <li><a href="SubjectController" class="ttr-material-button"><span class="ttr-label">Control Subject</span></a></li>
                                                    </ul>
                                                </li>
                                                <li>
                                                    <a href="#" class="ttr-material-button"><span class="ttr-icon"><i class="ti-credit-card"></i></span><span class="ttr-label">Payment</span><span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span></a>
                                                    <ul>
                                                        <li><a href="#" class="ttr-material-button"><span class="ttr-label">View Earning</span></a></li>
                                                        <li><a href="#" class="ttr-material-button"><span class="ttr-label">View History Payment</span></a></li>
                                                    </ul>
                                                </li>
                                                <li>
                                                    <a href="#" class="ttr-material-button"><span class="ttr-icon"><i class="ti-book"></i></span><span class="ttr-label">Content Management</span><span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span></a>
                                                    <ul>
                                                        <li><a href="BlogController?service=listBlog" class="ttr-label">Blog</a></li>
                                                        <li><a href="BlogController?service=addBlog" class="ttr-label">Add Blog</a></li>
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
                                    </div>
                                </div>
                                <!-- Left sidebar menu end -->

                                <!--Main container start -->
                                <main class="ttr-wrapper">
                                    <div class="container-fluid">
                                        <div class="db-breadcrumb">
                                            <h4 class="breadcrumb-title">Dashboard</h4>
                                            <ul class="db-breadcrumb-list">
                                                <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                                                <li>Dashboard</li>
                                            </ul>
                                        </div>	

                                        <!-- Card END -->
                                        <div class="row">
                                            <!-- Your Profile Views Chart -->
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
                                                                        <span class="new-users-info">Project Manager, Amazon Inc  </span>
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

