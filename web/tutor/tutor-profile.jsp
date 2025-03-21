<%-- 
    Document   : tutor-profile
    Created on : Mar 20, 2025, 10:00:00 AM
    Author     : Grok 3 (xAI) - Modified from original by Heizxje
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
%>

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
        <meta name="description" content="G4 SmartTutor : Tutor Profile" />

        <!-- OG -->
        <meta property="og:title" content="G4 SmartTutor : Tutor Profile" />
        <meta property="og:description" content="G4 SmartTutor : Tutor Profile" />
        <meta property="og:image" content="" />
        <meta name="format-detection" content="telephone=no">

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="${pageContext.request.contextPath}/error-404.jsp" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/images/favicon.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>G4 SmartTutor : Tutor Profile</title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">

    </head>
    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>
            <!-- Header Top ==== -->
        <header class="header rs-nav header-transparent">
            <div class="top-bar">
                <div class="container">
                    <div class="row d-flex justify-content-between">
                        <div class="topbar-left">
                            <ul>
                                <li><a href="#"><i class="fa fa-question-circle"></i>Ask a Question</a></li>
                                <li><a href="#"><i class="fa fa-envelope-o"></i>Support@website.com</a></li>
                            </ul>
                        </div>
                        <div class="topbar-right">
                            <ul>
                                <li>
                                    <select class="header-lang-bx">
                                        <option data-icon="flag flag-uk">English UK</option>
                                        <option data-icon="flag flag-us">English US</option>
                                    </select>
                                </li>
                                <li>
                                    <div class="ttr-header-submenu">
                                        <ul>
                                            <li>
                                                <a href="tutorprofile" class="ttr-material-button ttr-submenu-toggle">
                                                    <span class="ttr-user-avatar">
                                                        <img alt="" 
                                                             src="${pageContext.request.contextPath}/<%= user.getAvatar() != null ? user.getAvatar() : "uploads/default_avatar.jpg"%>" 
                                                             width="32" height="32"
                                                             onerror="this.src='${pageContext.request.contextPath}/uploads/default_avatar.jpg'">
                                                    </span>
                                                </a>
                                            </li>
                                            <li><a href="tutorprofile">My Profile</a></li>
                                            <li><a href="tutor-schedule">View Schedule</a></li>
                                            <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
                                        </ul>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="sticky-header navbar-expand-lg">
                <div class="menu-bar clearfix">
                    <div class="container clearfix">
                        <!-- Header Logo ==== -->
                        <div class="menu-logo">
                            <a href="indextutor.jsp"><img src="assets/images/logo-white.png" alt=""></a>
                        </div>
                        <!-- Mobile Nav Button ==== -->
                        <button class="navbar-toggler collapsed menuicon justify-content-end" type="button" data-toggle="collapse" data-target="#menuDropdown" aria-controls="menuDropdown" aria-expanded="false" aria-label="Toggle navigation">
                            <span></span>
                            <span></span>
                            <span></span>
                        </button>
                        <!-- Author Nav ==== -->
                        <div class="secondary-menu">
                            <div class="secondary-inner">
                                <ul>
                                    <li><a href="javascript:;" class="btn-link"><i class="fa fa-facebook"></i></a></li>
                                    <li><a href="javascript:;" class="btn-link"><i class="fa fa-google-plus"></i></a></li>
                                    <li><a href="javascript:;" class="btn-link"><i class="fa fa-linkedin"></i></a></li>
                                    <li class="search-btn"><button id="quik-search-btn" type="button" class="btn-link"><i class="fa fa-search"></i></button></li>
                                </ul>
                            </div>
                        </div>
                        <!-- Search Box ==== -->
                        <div class="nav-search-bar">
                            <form action="#">
                                <input name="search" value="" type="text" class="form-control" placeholder="Type to search">
                                <span><i class="ti-search"></i></span>
                            </form>
                            <span id="search-remove"><i class="ti-close"></i></span>
                        </div>
                        <!-- Navigation Menu ==== -->
                        <div class="menu-links navbar-collapse collapse justify-content-start" id="menuDropdown">
                            <div class="menu-logo">
                                <a href="indextutor.jsp"><img src="assets/images/logo.png" alt=""></a>
                            </div>
                            <ul class="nav navbar-nav">
                                <li class="active"><a href="tutor-home">Tutor Dashboard</a></li>
                                <li><a href="CreateSchedule">My Schedule</a></li>
                                <li><a href="tutor-courses">My Courses</a></li>
                                <li><a href="ViewBlog">Blog</a></li>
                            </ul>
                            <div class="nav-social-link">
                                <a href="javascript:;"><i class="fa fa-facebook"></i></a>
                                <a href="javascript:;"><i class="fa fa-google-plus"></i></a>
                                <a href="javascript:;"><i class="fa fa-linkedin"></i></a>
                            </div>
                        </div>
                        <!-- Navigation Menu END ==== -->
                    </div>
                </div>
            </header>
            <!-- header END ==== -->
            <!-- Content -->
            <div class="page-content bg-white">
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner1.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Tutor Profile</h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="indextutor.jsp">Home</a></li>
                            <li>Tutor Profile</li>
                        </ul>
                    </div>
                </div>
                <!-- Breadcrumb row END -->
                <!-- inner page banner END -->
                <div class="content-block">
                    <!-- About Us -->
                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-3 col-md-4 col-sm-12 m-b30">
                                    <div class="profile-bx text-center">
                                        <div class="user-profile-thumb">
                                            <img src="${pageContext.request.contextPath}/<%= user.getAvatar() != null ? user.getAvatar() : "uploads/default_avatar.jpg"%>" 
                                                 alt="Tutor Avatar" 
                                                 onerror="this.src='${pageContext.request.contextPath}/uploads/default_avatar.jpg'" />
                                        </div>
                                        <div class="profile-info">
                                            <h4><%= user.getFullName()%></h4>
                                            <span><%= user.getEmail()%></span>
                                        </div>
                                        <div class="profile-social">
                                            <ul class="list-inline m-a0">
                                                <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                                                <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                                                <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                                                <li><a href="#"><i class="fa fa-google-plus"></i></a></li>
                                            </ul>
                                        </div>
                                        <div class="profile-tabnav">
                                            <ul class="nav nav-tabs">
                                                <li class="nav-item">
                                                    <a class="nav-link active" data-toggle="tab" href="#tutor-detail"><i class="ti-user"></i>Tutor Details</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link" data-toggle="tab" href="#edit-profile"><i class="ti-pencil-alt"></i>Edit Profile</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link" data-toggle="tab" href="#change-password"><i class="ti-lock"></i>Change Password</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-9 col-md-8 col-sm-12 m-b30">
                                    <div class="profile-content-bx">
                                        <div class="tab-content">
                                            <div class="tab-pane active" id="tutor-detail">
                                                <div class="profile-head">
                                                    <h3>Profile Details</h3>
                                                </div>
                                                <form class="edit-profile">
                                                    <div class="">
                                                        <!-- Email -->
                                                        <div class="form-group row">
                                                            <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Email</label>
                                                            <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                                <input class="form-control" type="email" value="<%= user.getEmail()%>" readonly>
                                                            </div>
                                                        </div>

                                                        <!-- Full Name -->
                                                        <div class="form-group row">
                                                            <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Full Name</label>
                                                            <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                                <input class="form-control" type="text" value="<%= user.getFullName()%>" readonly>
                                                            </div>
                                                        </div>

                                                        <!-- Phone Number -->
                                                        <div class="form-group row">
                                                            <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Phone</label>
                                                            <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                                <input class="form-control" type="text" value="<%= user.getPhone()%>" readonly>
                                                            </div>
                                                        </div>

                                                        <!-- Date of Birth -->
                                                        <div class="form-group row">
                                                            <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Date of Birth</label>
                                                            <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                                <input class="form-control" type="date" value="<%= user.getDob()%>" readonly>
                                                            </div>
                                                        </div>

                                                        <!-- Address -->
                                                        <div class="form-group row">
                                                            <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Address</label>
                                                            <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                                <input class="form-control" type="text" value="<%= user.getAddress()%>" readonly>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <div class="tab-pane" id="edit-profile">
                                                <div class="profile-head">
                                                    <h3>Edit Tutor Profile</h3>
                                                </div>
                                                <form class="edit-profile" action="tutorprofile" method="POST" enctype="multipart/form-data">
                                                    <input type="hidden" name="action" value="editProfile">

                                                    <!-- Các trường thông tin cá nhân -->
                                                    <div class="form-group row">
                                                        <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Full Name</label>
                                                        <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                            <input class="form-control" type="text" name="fullName" value="<%= user.getFullName()%>">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Phone</label>
                                                        <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                            <input class="form-control" type="text" name="phone" value="<%= user.getPhone()%>">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Date of Birth</label>
                                                        <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                            <input class="form-control" type="date" name="dob" value="<%= user.getDob()%>">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Avatar</label>
                                                        <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                            <input class="form-control" type="file" name="avatar" accept="image/*">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Address</label>
                                                        <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                            <input class="form-control" type="text" name="address" value="<%= user.getAddress()%>">
                                                        </div>
                                                    </div>

                                                    <!-- Nút Submit -->
                                                    <div class="row">
                                                        <div class="col-12 col-sm-3 col-md-3 col-lg-2"></div>
                                                        <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                                            <button type="submit" class="btn btn-primary">Save changes</button>
                                                            <button type="reset" class="btn btn-secondary">Cancel</button>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>                                    
                                            <div class="tab-pane" id="change-password">
                                                <div class="profile-head">
                                                    <h3>Change Password</h3>
                                                </div>
                                                <form class="edit-profile" action="tutorprofile" method="POST">
                                                    <input type="hidden" name="action" value="changePassword">

                                                    <!-- Các trường mật khẩu -->
                                                    <div class="form-group row">
                                                        <label class="col-12 col-sm-4 col-md-4 col-lg-3 col-form-label">Current Password</label>
                                                        <div class="col-12 col-sm-8 col-md-8 col-lg-7">
                                                            <input class="form-control" type="password" name="currentPassword" required>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-12 col-sm-4 col-md-4 col-lg-3 col-form-label">New Password</label>
                                                        <div class="col-12 col-sm-8 col-md-8 col-lg-7">
                                                            <input class="form-control" type="password" name="newPassword" required>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-12 col-sm-4 col-md-4 col-lg-3 col-form-label">Re Type New Password</label>
                                                        <div class="col-12 col-sm-8 col-md-8 col-lg-7">
                                                            <input class="form-control" type="password" name="confirmPassword" required>
                                                        </div>
                                                    </div>

                                                    <!-- Nút Submit -->
                                                    <div class="row">
                                                        <div class="col-12 col-sm-4 col-md-4 col-lg-3"></div>
                                                        <div class="col-12 col-sm-8 col-md-8 col-lg-7">
                                                            <button type="submit" class="btn">Save changes</button>
                                                            <button type="reset" class="btn">Cancel</button>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div> 
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    String message = (String) session.getAttribute("message");
                    String error = (String) session.getAttribute("error");
                    if (message != null) {
                %>
                <div class="alert alert-success">
                    <%= message%>
                </div>
                <%
                        session.removeAttribute("message");
                    }
                    if (error != null) {
                %>
                <div class="alert alert-danger">
                    <%= error%>
                </div>
                <%
                        session.removeAttribute("error");
                    }
                %>
                <!-- contact area END -->
            </div>
            <!-- Content END-->
            <!-- Footer ==== -->
            <footer>
                <div class="footer-top">
                    <div class="pt-exebar">
                        <div class="container">
                            <div class="d-flex align-items-stretch">
                                <div class="pt-logo mr-auto">
                                    <a href="indextutor.jsp"><img src="assets/images/logo-white.png" alt=""/></a>
                                </div>
                                <div class="pt-social-link">
                                    <ul class="list-inline m-a0">
                                        <li><a href="#" class="btn-link"><i class="fa fa-facebook"></i></a></li>
                                        <li><a href="#" class="btn-link"><i class="fa fa-twitter"></i></a></li>
                                        <li><a href="#" class="btn-link"><i class="fa fa-linkedin"></i></a></li>
                                        <li><a href="#" class="btn-link"><i class="fa fa-google-plus"></i></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
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
        <script src="assets/js/functions.js"></script>
        <script src="assets/js/contact.js"></script>
        <script src='assets/vendors/switcher/switcher.js'></script>
        <script>
            // Kiểm tra thông báo và kích hoạt tab tương ứng
            <% if (session.getAttribute("message") != null || session.getAttribute("error") != null) { %>
            <% if ("changePassword".equals(request.getParameter("action"))) { %>
            $('#change-password').tab('show');
            <% } else { %>
            $('#edit-profile').tab('show');
            <% } %>
            <% }%>
        </script>
    </body>

</html>