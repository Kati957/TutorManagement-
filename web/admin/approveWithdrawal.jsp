<%-- 
    Document   : approveWithdrawal
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
    <title>G4 SmartTutor - Phê Duyệt Yêu Cầu Rút Tiền</title>

    <!-- MOBILE SPECIFIC -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/assets.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/typography.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/shortcodes/shortcodes.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
    <link class="skin" rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/color/color-1.css">

    <!-- Custom styles for approveWithdrawal -->
    <style>
        .table-responsive { margin-bottom: 20px; }
        .table-bordered th, .table-bordered td { border: 1px solid #dee2e6; }
        .table-striped tbody tr:nth-of-type(odd) { background-color: rgba(0,0,0,.05); }
        .action-buttons form { display: inline; }
        .action-buttons input[type="submit"] { margin-right: 5px; padding: 5px 10px; border: none; border-radius: 4px; cursor: pointer; }
        .action-buttons input[value="Phê Duyệt"] { background-color: #28a745; color: white; }
        .action-buttons input[value="Phê Duyệt"]:hover { background-color: #218838; }
        .action-buttons input[value="Từ Chối"] { background-color: #dc3545; color: white; }
        .action-buttons input[value="Từ Chối"]:hover { background-color: #c82333; }
        .filter-form { margin-bottom: 20px; background-color: #f9f9f9; padding: 20px; border-radius: 5px; }
        .filter-form select, .filter-form input { margin-right: 10px; margin-bottom: 10px; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        .filter-form label { margin-right: 5px; font-weight: 500; }
        .filter-form input[type="submit"] { background-color: #007bff; color: white; border: none; padding: 8px 16px; cursor: pointer; border-radius: 4px; }
        .filter-form input[type="submit"]:hover { background-color: #0056b3; }
        .pagination { margin-top: 20px; text-align: center; }
        .pagination a { margin: 0 5px; padding: 8px 12px; text-decoration: none; border: 1px solid #ddd; border-radius: 4px; }
        .pagination a.current { background-color: #dc3545; color: white; border-color: #dc3545; }
        .pagination a:hover { background-color: #f1f1f1; }
        .alert { padding: 15px; margin-bottom: 20px; border: 1px solid transparent; border-radius: 4px; }
        .alert-success { color: #155724; background-color: #d4edda; border-color: #c3e6cb; }
        .alert-danger { color: #721c24; background-color: #f8d7da; border-color: #f5c6cb; }
        .alert-info { color: #0c5460; background-color: #d1ecf1; border-color: #bee5eb; }
        .back-link { display: inline-block; margin-top: 20px; padding: 10px 20px; background-color: #6c757d; color: white; text-decoration: none; border-radius: 4px; }
        .back-link:hover { background-color: #5a6268; }
        /* CSS từ index.jsp để đảm bảo giao diện đồng bộ */
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
        .wc-stats, .counter, .wc-number {
            font-size: 14px !important;
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
                            <li><a href="approveWithdrawal" class="ttr-material-button active"><span class="ttr-label">Request Withdrawl</span></a></li>
                            <li><a href="PaymentHistory" class="ttr-material-button"><span class="ttr-label">View History Payment</span></a></li>
                            <li><a href="systemRevenue" class="ttr-material-button"><span class="ttr-label">System revenue</span></a></li>
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
                <h4 class="breadcrumb-title">Phê Duyệt Yêu Cầu Rút Tiền</h4>
                <ul class="db-breadcrumb-list">
                    <li><a href="${pageContext.request.contextPath}/admin/index"><i class="fa fa-home"></i>Home</a></li>
                    <li>Phê Duyệt Yêu Cầu Rút Tiền</li>
                </ul>
            </div>

            <!-- Nội dung chính của approveWithdrawal.jsp -->
            <div class="widget-box">
                <div class="wc-title">
                    <h4>Danh Sách Yêu Cầu Rút Tiền</h4>
                </div>
                <div class="widget-inner">
                    <c:if test="${not empty message}">
                        <div class="alert alert-success">${message}</div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <form method="get" action="${pageContext.request.contextPath}/admin/approveWithdrawal" class="filter-form">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="searchField">Tìm kiếm theo:</label>
                                    <select name="searchField" id="searchField" class="form-control">
                                        <option value="TutorName" ${searchField == 'TutorName' ? 'selected' : ''}>Tên Tutor</option>
                                        <option value="WithdrawStatus" ${searchField == 'WithdrawStatus' ? 'selected' : ''}>Trạng Thái</option>
                                        <option value="RequestDate" ${searchField == 'RequestDate' ? 'selected' : ''}>Ngày Gửi</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="search">Giá trị tìm kiếm:</label>
                                    <input type="text" name="search" value="${search}" class="form-control" 
                                           placeholder="${searchField == 'RequestDate' ? 'VD: 15, 03/2025, 2025' : searchField == 'TutorName' ? 'VD: Nguyễn Văn A' : 'VD: Pending'}">
                                    <input type="hidden" name="sortBy" value="${sortBy}">
                                    <input type="hidden" name="sortOrder" value="${sortOrder}">
                                    <input type="submit" value="Tìm kiếm">
                                </div>
                            </div>
                        </div>
                    </form>

                    <c:if test="${empty requests}">
                        <div class="alert alert-info">Không có yêu cầu rút tiền nào.</div>
                    </c:if>
                    <c:if test="${not empty requests}">
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>ID Yêu Cầu</th>
                                        <th>Tutor ID</th>
                                        <th>Tên Tutor</th>
                                        <th>Tháng</th>
                                        <th>
                                            <a href="${pageContext.request.contextPath}/admin/approveWithdrawal?sortBy=TotalEarningsAfterCommission&sortOrder=${sortBy == 'TotalEarningsAfterCommission' && sortOrder == 'asc' ? 'desc' : 'asc'}&search=${search}&searchField=${searchField}">
                                                Tổng Thu Nhập (VND) ${sortBy == 'TotalEarningsAfterCommission' ? (sortOrder == 'asc' ? '↑' : '↓') : ''}
                                            </a>
                                        </th>
                                        <th>
                                            <a href="${pageContext.request.contextPath}/admin/approveWithdrawal?sortBy=WithdrawStatus&sortOrder=${sortBy == 'WithdrawStatus' && sortOrder == 'asc' ? 'desc' : 'asc'}&search=${search}&searchField=${searchField}">
                                                Trạng Thái ${sortBy == 'WithdrawStatus' ? (sortOrder == 'asc' ? '↑' : '↓') : ''}
                                            </a>
                                        </th>
                                        <th>Nội Dung</th>
                                        <th>
                                            <a href="${pageContext.request.contextPath}/admin/approveWithdrawal?sortBy=RequestDate&sortOrder=${sortBy == 'RequestDate' && sortOrder == 'asc' ? 'desc' : 'asc'}&search=${search}&searchField=${searchField}">
                                                Ngày Gửi ${sortBy == 'RequestDate' ? (sortOrder == 'asc' ? '↑' : '↓') : ''}
                                            </a>
                                        </th>
                                        <th>Admin ID</th>
                                        <th>Hành Động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="request" items="${requests}">
                                        <tr>
                                            <td>${request.requestID}</td>
                                            <td>${request.tutorID}</td>
                                            <td>${request.tutorName}</td>
                                            <td>${request.month}</td>
                                            <td><fmt:formatNumber value="${request.totalEarningsAfterCommission}" type="number" groupingUsed="true" maxFractionDigits="0"/>đ</td>
                                            <td>${request.withdrawStatus}</td>
                                            <td>${request.content}</td>
                                            <td><fmt:formatDate value="${request.requestDate}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
                                            <td>${request.adminID == 0 ? 'Chưa xử lý' : request.adminID}</td>
                                            <td class="action-buttons">
                                                <c:if test="${request.withdrawStatus == 'Pending'}">
                                                    <form method="post" action="${pageContext.request.contextPath}/admin/approveWithdrawal">
                                                        <input type="hidden" name="requestID" value="${request.requestID}">
                                                        <input type="hidden" name="action" value="approve">
                                                        <input type="submit" value="Phê Duyệt">
                                                    </form>
                                                    <form method="post" action="${pageContext.request.contextPath}/admin/approveWithdrawal">
                                                        <input type="hidden" name="requestID" value="${request.requestID}">
                                                        <input type="hidden" name="action" value="reject">
                                                        <input type="submit" value="Từ Chối">
                                                    </form>
                                                </c:if>
                                                <c:if test="${request.withdrawStatus != 'Pending'}">
                                                    <span>Đã xử lý</span>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Phân trang -->
                        <div class="pagination">
                            <c:if test="${totalPages > 1}">
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <a href="${pageContext.request.contextPath}/admin/approveWithdrawal?page=${i}&sortBy=${sortBy}&sortOrder=${sortOrder}&search=${search}&searchField=${searchField}"
                                       class="${i == currentPage ? 'current' : ''}">${i}</a>
                                </c:forEach>
                            </c:if>
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

    <!-- External JavaScripts từ approveWithdrawal.jsp (giữ nguyên) -->
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