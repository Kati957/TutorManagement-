<%-- 
    Document   : addSubject
    Created on : Mar 9, 2025
    Author     : minht
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>G4 SmartTutor - Add Subject</title>

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

    </head>
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
                        <a href="${pageContext.request.contextPath}/staff/index_staff.jsp" class="ttr-logo">
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
                        <a href="#" class="ttr-material-button ttr-submenu-toggle"><span class="ttr-user-avatar"><img alt="" src="assets/images/testimonials/pic3.jpg" width="32" height="32"></span></a>
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
        </div>
    </header>

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
                    <li class="ttr-seperate"></li>
                </ul>
            </nav>
        </div>
    </div>
    <!-- Left sidebar menu end -->
        <!-- Main content -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Add Subject</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="${pageContext.request.contextPath}/staff/index_staff.jsp"><i class="fa fa-home"></i>Home</a></li>
                        <li><a href="SubjectController?service=listSubject">Subject Management</a></li>
                        <li>Add Subject</li>
                    </ul>
                </div>
                <%
                    String error = (String) request.getAttribute("error");
                    if (error != null) {
                %>
                <div class="alert alert-danger"><%= error%></div>
                <%
                    }
                %>
                <div class="row">
                    <div class="col-lg-6 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Add New Subject</h4>
                            </div>
                            <div class="widget-inner">
                                <form action="SubjectController?service=addSubject" method="post">
                                    <div class="form-group">
                                        <label for="subjectName">Subject Name</label>
                                        <input type="text" class="form-control" id="subjectName" name="subjectName" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="description">Description</label>
                                        <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                                    </div>
                                    <button type="submit" name ="submit" class="submit-btn">Add Subject</button>
                                </form>
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