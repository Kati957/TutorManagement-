<%-- 
    Document   : staff-management
    Created on : Mar 1, 2025, 9:56:17 PM
    Author     : Heizxje
--%>

<%@page import="entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

        <!-- DESCRIPTION -->
        <meta name="description" content="EduChamp : Education HTML Template" />

        <!-- OG -->
        <meta property="og:title" content="EduChamp : Education HTML Template" />
        <meta property="og:description" content="EduChamp : Education HTML Template" />
        <meta property="og:image" content="" />
        <meta name="format-detection" content="telephone=no">

        <!-- FAVICONS ICON -->
        <link rel="icon" href="../error-404.jsp" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />

        <!-- PAGE TITLE -->
        <title>EduChamp : Staff Management</title>

        <!-- MOBILE SPECIFIC -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- PLUGINS CSS -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="assets/vendors/calendar/fullcalendar.css">

        <!-- TYPOGRAPHY -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="assets/css/dashboard.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">
    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
        <!-- Header start -->
        <header class="ttr-header">
            <div class="ttr-header-wrapper">
                <div class="ttr-toggle-sidebar ttr-material-button">
                    <i class="ti-close ttr-open-icon"></i>
                    <i class="ti-menu ttr-close-icon"></i>
                </div>
                <div class="ttr-logo-box">
                    <div>
                        <a href="index.jsp" class="ttr-logo">
                            <img class="ttr-logo-mobile" alt="" src="assets/images/logo-mobile.png" width="30" height="30">
                            <img class="ttr-logo-desktop" alt="" src="assets/images/logo-white.png" width="160" height="27">
                        </a>
                    </div>
                </div>
                <div class="ttr-header-menu">
                    <ul class="ttr-header-navigation">
                        <li><a href="../index.jsp" class="ttr-material-button ttr-submenu-toggle">HOME</a></li>
                        <li>
                            <a href="#" class="ttr-material-button ttr-submenu-toggle">QUICK MENU <i class="fa fa-angle-down"></i></a>
                            <div class="ttr-header-submenu">
                                <ul>
                                    <li><a href="../courses.jsp">Our Courses</a></li>
                                    <li><a href="../event.jsp">New Event</a></li>
                                    <li><a href="../membership.jsp">Membership</a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="ttr-header-right ttr-with-seperator">
                    <ul class="ttr-header-navigation">
                        <li><a href="#" class="ttr-material-button ttr-search-toggle"><i class="fa fa-search"></i></a></li>
                        <li><a href="#" class="ttr-material-button ttr-submenu-toggle"><i class="fa fa-bell"></i></a></li>
                        <li><a href="#" class="ttr-material-button ttr-submenu-toggle"><span class="ttr-user-avatar"><img alt="" src="assets/images/testimonials/pic3.jpg" width="32" height="32"></span></a></li>
                        <li class="ttr-hide-on-mobile"><a href="#" class="ttr-material-button"><i class="ti-layout-grid3-alt"></i></a></li>
                    </ul>
                </div>
                <div class="ttr-search-bar">
                    <form class="ttr-search-form">
                        <div class="ttr-search-input-wrapper">
                            <input type="text" name="qq" placeholder="search something..." class="ttr-search-input">
                            <button type="submit" name="search" class="ttr-search-submit"><i class="ti-arrow-right"></i></button>
                        </div>
                        <span class="ttr-search-close ttr-search-toggle"><i class="ti-close"></i></span>
                    </form>
                </div>
            </div>
        </header>
        <!-- Header end -->

        <!-- Left sidebar menu start -->
        <div class="ttr-sidebar">
            <div class="ttr-sidebar-wrapper content-scroll">
                <!-- side menu logo start -->
                <div class="ttr-sidebar-logo">
                    <a href="#"><img alt="" src="assets/images/logo.png" width="122" height="27"></a>
                    <!-- <div class="ttr-sidebar-pin-button" title="Pin/Unpin Menu">
                            <i class="material-icons ttr-fixed-icon">gps_fixed</i>
                            <i class="material-icons ttr-not-fixed-icon">gps_not_fixed</i>
                    </div> -->
                    <div class="ttr-sidebar-toggle-button">
                        <i class="ti-arrow-left"></i>
                    </div>
                </div>
                <!-- side menu logo end -->
                <!-- sidebar menu start -->
                <nav class="ttr-sidebar-navi">
                    <ul>
                        <li>
                            <a href="index.jsp" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-home"></i></span>
                                <span class="ttr-label">Dashborad</span> 
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
                                <li>
                                    <a href="StaffRegister" class="ttr-material-button"><span class="ttr-label">Staff Management</span></a>
                                </li>
                                <li>
                                    <a href="#" class="ttr-material-button"><span class="ttr-label">View Reports</span></a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-id-badge"></i></span>
                                <span class="ttr-label">User Management</span>
                                <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                            </a>
                            <ul>
                                <li>
                                    <a href="#" class="ttr-material-button"><span class="ttr-label">Review Profile</span></a>
                                </li>
                                <li>
                                    <a href="#" class="ttr-material-button"><span class="ttr-label">Review Tutor</span></a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-credit-card"></i></span>
                                <span class="ttr-label">Payment</span>
                                <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                            </a>
                            <ul>
                                <li>
                                    <a href="#" class="ttr-material-button"><span class="ttr-label">View Earning</span></a>
                                </li>
                                <li>
                                    <a href="#" class="ttr-material-button"><span class="ttr-label">View History Payment</span></a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-book"></i></span>
                                <span class="ttr-label">Content Management</span>
                                <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                            </a>
                            <ul>
                                <li>
                                    <a href="#" class="ttr-material-button"><span class="ttr-label">Blog</span></a>
                                </li>
                            </ul>
                        </li>
                        <li class="ttr-seperate"></li>
                    </ul>
                    <!-- sidebar menu end -->
                </nav>
                <!-- sidebar menu end -->
            </div>
        </div>
        <!-- Left sidebar menu end -->

        <!-- Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Staff Management</h4>
                </div>	
                <div class="row">
                    <!-- Staff List -->
                    <!-- Staff List -->
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Staff List</h4>
                                <button class="btn btn-success" id="addStaffBtn">Add New Staff</button>
                            </div>
                            <div class="widget-inner">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Full Name</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Created At</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody id="staffTableBody">
                                        <c:forEach var="user" items="${staffList}">
                                            <tr>
                                                <td>${user.userID}</td>
                                                <td>${user.fullName}</td>
                                                <td>${user.email}</td>
                                                <td>${user.phone}</td>
                                                <td>${user.createAt != null ? user.createAt : 'N/A'}</td>
                                                <td>${user.isActive == 1 ? 'Active' : 'Inactive'}</td>
                                                <td>
                                                    <button class="btn btn-primary btn-sm editStaffBtn" data-id="${user.userID}">Edit</button>
                                                    <button class="btn btn-danger btn-sm deleteStaffBtn">Delete</button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty staffList}">
                                            <tr><td colspan="7">No staff members found.</td></tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- Staff List END -->

                    <!-- Add/Edit Staff Form -->
                    <div class="col-lg-12 m-b30" id="staffFormSection" style="display: none;">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4 id="formTitle">Add New Staff</h4>
                            </div>
                            <div class="widget-inner">
                                <form action="${pageContext.request.contextPath}/admin/StaffRegister" method="POST" class="contact-bx" id="staffForm">
                                    <input type="hidden" name="UserID" id="staffUserID" value="${editUser.userID}">
                                    <input type="hidden" name="RoleID" value="4">
                                    <input type="hidden" name="IsActive" value="1">
                                    <div class="row placeani">
                                        <c:if test="${not empty requestScope.error}">
                                            <div class="col-lg-12"><p class="text-danger">${requestScope.error}</p></div>
                                            </c:if>
                                            <c:if test="${not empty sessionScope.success}">
                                            <div class="col-lg-12"><p class="text-success">${sessionScope.success}</p></div>
                                                <c:remove var="success" scope="session"/>
                                            </c:if>
                                        <div class="col-lg-12">
                                            <div class="form-group">
                                                <label>Email</label>
                                                <input type="email" name="Email" class="form-control" value="${editUser.email}" required>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="form-group">
                                                <label>Full Name</label>
                                                <input type="text" name="FullName" class="form-control" value="${editUser.fullName}" required>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="form-group">
                                                <label>Phone</label>
                                                <input type="text" name="Phone" class="form-control" value="${editUser.phone}" required>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="form-group">
                                                <label>Date of Birth</label>
                                                <input type="date" name="Dob" class="form-control" value="${editUser.dob}" required>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="form-group">
                                                <label>Address</label>
                                                <input type="text" name="Address" class="form-control" value="${editUser.address}" required>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="form-group">
                                                <label>Username</label>
                                                <input type="text" name="UserName" class="form-control" value="${editUser.userName}" required>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="form-group">
                                                <label>Password</label>
                                                <input type="password" name="Password" class="form-control" value="${editUser.password}" required>
                                            </div>
                                        </div>
                                        <div class="col-lg-12 m-b30">
                                            <button type="submit" class="btn btn-primary">Save</button>
                                            <button type="button" class="btn btn-secondary" id="cancelStaffBtn">Cancel</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <!-- Add/Edit Staff Form END -->
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
        <script src="assets/vendors/scroll/scrollbar.min.js"></script>
        <script src="assets/js/functions.js"></script>
        <script src="assets/vendors/chart/chart.min.js"></script>
        <script src="assets/js/admin.js"></script>
        <script src="assets/vendors/calendar/moment.min.js"></script>
        <script src="assets/vendors/calendar/fullcalendar.js"></script>
        <script src="assets/vendors/switcher/switcher.js"></script>

        <!-- Script for handling staff management -->
        <script>
            document.getElementById('addStaffBtn').addEventListener('click', function () {
                document.getElementById('staffFormSection').style.display = 'block';
                document.getElementById('formTitle').innerText = 'Add New Staff';
                document.getElementById('staffForm').reset();
                document.getElementById('staffUserID').value = ''; // Reset UserID khi thêm mới
            });

            document.getElementById('cancelStaffBtn').addEventListener('click', function () {
                document.getElementById('staffFormSection').style.display = 'none';
            });

            document.querySelectorAll('.editStaffBtn').forEach(button => {
                button.addEventListener('click', function () {
                    const userID = this.getAttribute('data-id');
                    window.location.href = '${pageContext.request.contextPath}/admin/StaffRegister?edit=' + userID; // Chuyển hướng để lấy thông tin từ servlet
                });
            });

            document.querySelectorAll('.deleteStaffBtn').forEach(button => {
                button.addEventListener('click', function () {
                    if (confirm('Are you sure you want to delete this staff member?')) {
                        const row = this.closest('tr');
                        const userID = row.querySelector('.editStaffBtn').getAttribute('data-id');
                        window.location.href = '${pageContext.request.contextPath}/admin/StaffRegister?delete=' + userID; // Gửi yêu cầu xóa đến servlet
                    }
                });
            });

            // Hiển thị form khi có editUser từ servlet
            <c:if test="${not empty editUser}">
            document.getElementById('staffFormSection').style.display = 'block';
            document.getElementById('formTitle').innerText = 'Edit Staff';
            </c:if>
        </script>
    </body>
</html>