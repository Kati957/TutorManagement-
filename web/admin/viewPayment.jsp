<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%-- 
      Document   : index
      Created on : Feb 27, 2025, 3:59:18 PM
      Author     : Heizxje
    --%>

    <%@page import="entity.HistoryLog"%>
    <%@page import="entity.User, java.util.List, java.util.ArrayList"%>

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
    <title>G4 SmartTutor</title>

    <!-- MOBILE SPECIFIC -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/assets.css">

    <!-- TYPOGRAPHY -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/typography.css">

    <!-- SHORTCODES -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/shortcodes/shortcodes.css">

    <!-- STYLESHEETS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
    <link class="skin" rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/color/color-1.css">

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
        .pagination {
            justify-content: center;
            margin-top: 20px;
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
        List<User> newUsers = (List<User>) request.getAttribute("newUsers");
        if (newUsers == null) {
            newUsers = new ArrayList<>();
        }
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
                    <a href="${pageContext.request.contextPath}/admin/index" class="ttr-logo">
                        <img class="ttr-logo-mobile" alt="" src="${pageContext.request.contextPath}/assets/images/logo-mobile.png" width="30" height="30">
                        <img class="ttr-logo-desktop" alt="" src="${pageContext.request.contextPath}/assets/images/logo-white.png" width="160" height="27">
                    </a>
                </div>
            </div>
            <!-- Logo end -->
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
                <a href="${pageContext.request.contextPath}/admin/index"><img alt="" src="${pageContext.request.contextPath}/assets/images/logo.png" width="122" height="27"></a>
                <div class="ttr-sidebar-toggle-button">
                    <i class="ti-arrow-left"></i>
                </div>
            </div>
            <!-- Side menu logo end -->
            <!-- Sidebar menu start -->
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
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/TutorList" class="ttr-material-button"><span class="ttr-label">Tutor List</span></a>
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
                        <a href="#" class="ttr-material-button">
                            <span class="ttr-icon"><i class="ti-credit-card"></i></span>
                            <span class="ttr-label">Payment</span>
                            <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                        </a>
                        <ul>
                            <li><a href="#" class="ttr-material-button"><span class="ttr-label">View Earning</span></a></li>
                            <li><a href="PaymentHistory" class="ttr-material-button"><span class="ttr-label">View History Payment</span></a></li>
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
                <h4 class="breadcrumb-title">Lịch Sử Thanh Toán</h4>
                <ul class="db-breadcrumb-list">
                    <li><a href="${pageContext.request.contextPath}/admin/index"><i class="fa fa-home"></i>Home</a></li>
                    <li>Payment</li>
                    <li>Lịch Sử Thanh Toán</li>
                </ul>
            </div>

            <!-- Nội dung chính -->
            <div class="row">
                <div class="col-lg-12 m-b30">
                    <div class="widget-box">
                        <div class="wc-title">
                            <h4>Lịch Sử Thanh Toán (Admin)</h4>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>ID Giao Dịch</th>
                                        <th>ID Booking</th>
                                        <th>Học Viên</th>
                                        <th>Email</th>
                                        <th>Giá Tiền</th>
                                        <th>ID Khuyến Mãi</th>
                                        <th>Ngày Thanh Toán</th>
                                        <th>Trạng Thái</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="payment" items="${paymentHistory}">
                                        <tr>
                                            <td>${payment.paymentID}</td>
                                            <td>${payment.bookingID}</td>
                                            <td>${payment.userName}</td>
                                            <td>${payment.email}</td>
                                            <td><fmt:formatNumber value="${payment.amount}" type="number" pattern="#,###" /> VNĐ</td>
                                            <td>${payment.promotionID == 0 ? 'Không có' : payment.promotionID}</td>
                                            <td><fmt:formatDate value="${payment.paymentDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${payment.status == 'Completed'}">
                                                        <span class="badge bg-success">Thành công</span>
                                                    </c:when>
                                                    <c:when test="${payment.status == 'Failed'}">
                                                        <span class="badge bg-danger">Thất bại</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-warning">Đang xử lý</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty paymentHistory}">
                                        <tr>
                                            <td colspan="8" class="text-center">Không có giao dịch nào.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>

                        <!-- Phân trang -->
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <!-- Nút Previous -->
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/admin/PaymentHistory?page=${currentPage - 1}" aria-label="Previous">
                                        <span aria-hidden="true">«</span>
                                    </a>
                                </li>

                                <!-- Các số trang -->
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/PaymentHistory?page=${i}">${i}</a>
                                    </li>
                                </c:forEach>

                                <!-- Nút Next -->
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/admin/PaymentHistory?page=${currentPage + 1}" aria-label="Next">
                                        <span aria-hidden="true">»</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- External JavaScripts -->
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