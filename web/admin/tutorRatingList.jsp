<%-- 
    Document   : tutorRatingList
    Created on : Mar 22, 2025, 6:39:52 PM
    Author     : Heizxje
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="entity.User" %>
<!DOCTYPE html>
<html lang="en">
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

        <link rel="icon" href="../error-404.jsp" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/images/favicon.png" />
        <title>G4 SmartTutor - Admin Tutor Ratings</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/vendors/calendar/fullcalendar.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/typography.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/shortcodes/shortcodes.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
        <link class="skin" rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/color/color-1.css">
    </head>
    <% User user = (User) session.getAttribute("user");%>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
        <!-- Header -->
        <header class="ttr-header">
            <div class="ttr-header-wrapper">
                <div class="ttr-toggle-sidebar ttr-material-button">
                    <i class="ti-close ttr-open-icon"></i>
                    <i class="ti-menu ttr-close-icon"></i>
                </div>
                <div class="ttr-logo-box">
                    <div>
                        <a href="${pageContext.request.contextPath}/admin/index" class="ttr-logo">
                            <img class="ttr-logo-mobile" alt="" src="${pageContext.request.contextPath}/assets/images/logo-mobile.png" width="30" height="30">
                            <img class="ttr-logo-desktop" alt="" src="${pageContext.request.contextPath}/assets/images/logo-white.png" width="160" height="27">
                        </a>
                    </div>
                </div>
            </div>
            <div class="ttr-header-right ttr-with-seperator">
                <ul class="ttr-header-navigation">
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/index" class="ttr-material-button ttr-submenu-toggle">
                            <span class="ttr-user-avatar">
                                <img alt="" src="${pageContext.request.contextPath}/<%= user.getAvatar() != null ? user.getAvatar() : "uploads/default_avatar.jpg"%>" 
                                     width="32" height="32" onerror="this.src='${pageContext.request.contextPath}/uploads/default_avatar.jpg'">
                            </span>
                        </a>
                        <div class="ttr-header-submenu">
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/profile">My profile</a></li>
                                <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
        </header>

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
        <!-- Left sidebar menu end -->
        <!-- Main content -->
        <main class="ttr-wrapper">
            <h2>Tutor Ratings List</h2>

            <!-- Form tìm kiếm gia sư -->
            <div class="sort-options" style="margin-bottom: 20px;">
                <label>Get tutor's average rate: </label>
                <form action="${pageContext.request.contextPath}/admin/AdminListRated" method="get" style="display: inline;">
                    <input type="hidden" name="service" value="searchTutors">
                    <input type="text" name="keyword" value="${keyword}" placeholder="Enter ID or Name" style="padding: 5px;">
                    <button type="submit" style="background-color: #800080; color: white; border: none; padding: 5px 10px; cursor: pointer;">Search</button>
                </form>
            </div>

            <!-- Form tìm kiếm danh sách đánh giá -->
            <div class="sort-options" style="margin-bottom: 20px;">
                <label>Search ratings: </label>
                <form action="${pageContext.request.contextPath}/admin/AdminListRated" method="get" style="display: inline;">
                    <input type="hidden" name="service" value="searchRatingList">
                    <input type="text" name="ratingId" value="${ratingId}" placeholder="Rating ID" style="padding: 5px; width: 100px;">
                    <input type="text" name="tutorId" value="${tutorId}" placeholder="Tutor ID" style="padding: 5px; width: 100px;">
                    <input type="date" name="ratingDate" value="${ratingDate}" style="padding: 5px; width: 150px;">
                    <button type="submit" style="background-color: #800080; color: white; border: none; padding: 5px 10px; cursor: pointer;">Search</button>
                </form>
            </div>

            <!-- Tùy chọn sắp xếp -->
            <div class="sort-dropdown" style="position: relative; display: inline-block;">
                <button class="sort-button" onclick="toggleDropdown()" style="background-color: white; border: 1px solid #ccc; padding: 8px 16px; border-radius: 4px; cursor: pointer; display: flex; align-items: center; justify-content: space-between; width: 200px;">
                    <span id="currentSortLabel">Sort by: Average Rate</span>
                    <svg width="12" height="12" viewBox="0 0 24 24" style="margin-left: 10px;">
                    <path d="M7 10l5 5 5-5z" fill="currentColor"></path>
                    </svg>
                </button>
                <div id="sortOptions" class="dropdown-content" style="display: none; position: absolute; background-color: white; min-width: 200px; box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); z-index: 1; border-radius: 4px; margin-top: 2px;">
                    <a href="${pageContext.request.contextPath}/admin/AdminListRated?service=listTutorsByRating&order=DESC" 
                       class="option" 
                       data-sort="DESC"
                       data-label="Highest rated first"
                       style="padding: 12px 16px; text-decoration: none; display: flex; align-items: center; justify-content: space-between; color: black;">
                        Highest rated first
                        <svg width="16" height="16" viewBox="0 0 24 24" style="color: #4CAF50; display: none;" class="check-icon">
                        <path d="M9 16.2L4.8 12l-1.4 1.4L9 19 21 7l-1.4-1.4z" fill="currentColor"></path>
                        </svg>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/AdminListRated?service=listTutorsByRating&order=ASC" 
                       class="option" 
                       data-sort="ASC"
                       data-label="Lowest rated first"
                       style="padding: 12px 16px; text-decoration: none; display: flex; align-items: center; justify-content: space-between; color: black;">
                        Lowest rated first
                        <svg width="16" height="16" viewBox="0 0 24 24" style="color: #4CAF50; display: none;" class="check-icon">
                        <path d="M9 16.2L4.8 12l-1.4 1.4L9 19 21 7l-1.4-1.4z" fill="currentColor"></path>
                        </svg>
                    </a>
                </div>
            </div>

            <script>
                function toggleDropdown() {
                    document.getElementById("sortOptions").style.display = document.getElementById("sortOptions").style.display === "none" ? "block" : "none";
                }

                window.onclick = function (event) {
                    if (!event.target.matches('.sort-button') && !event.target.matches('.sort-button *')) {
                        var dropdown = document.getElementById("sortOptions");
                        if (dropdown.style.display === "block") {
                            dropdown.style.display = "none";
                        }
                    }
                }

                document.addEventListener("DOMContentLoaded", function () {
                    const urlParams = new URLSearchParams(window.location.search);
                    const currentOrder = urlParams.get('order');
                    const options = document.querySelectorAll('.option');
                    options.forEach(option => {
                        if (option.dataset.sort === currentOrder) {
                            option.querySelector('.check-icon').style.display = 'block';
                            document.getElementById('currentSortLabel').textContent = 'Sort by: ' + option.dataset.label;
                        }
                    });
                    if (!currentOrder) {
                        const firstOption = document.querySelector('.option[data-sort="DESC"]');
                        firstOption.querySelector('.check-icon').style.display = 'block';
                        document.getElementById('currentSortLabel').textContent = 'Sort by: ' + firstOption.dataset.label;
                    }
                });
            </script>

            <!-- Bảng danh sách đánh giá -->
            <table border="1">
                <tr>
                    <th>ID</th>
                    <th>Booking ID</th>
                    <th>Student ID</th>
                    <th>Tutor ID</th>
                    <th>Rating</th>
                    <th>Comment</th>
                    <th>Rating Date</th>
                </tr>
                <c:forEach var="rating" items="${ratingList}">
                    <tr>
                        <td>${rating.ratingId}</td>
                        <td>${rating.bookingId}</td>
                        <td>${rating.studentId}</td>
                        <td>${rating.tutorId}</td>
                        <td>${rating.rating}</td>
                        <td>${rating.comment}</td>
                        <td>${rating.ratingDate}</td>
                    </tr>
                </c:forEach>
            </table>

            <!-- Bảng danh sách gia sư theo điểm trung bình (nếu có) -->
            <c:if test="${not empty tutorList}">
                <h2>Tutors by Average Rating</h2>
                <table border="1">
                    <tr>
                        <th>Tutor ID</th>
                        <th>Tutor Name</th>
                        <th>Average Rating</th>
                        <th>Number of Reviews</th>
                    </tr>
                    <c:forEach var="tutor" items="${tutorList}">
                        <tr>
                            <td>${tutor[0]}</td>
                            <td>${tutor[1]}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${tutor[2] == 0}">
                                        No rated yet
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:formatNumber value="${tutor[2]}" minFractionDigits="1" maxFractionDigits="1"/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${tutor[3]}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>
        </main>

        <div class="ttr-overlay"></div>

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
        <script src='${pageContext.request.contextPath}/assets/vendors/scroll/scrollbar.min.js'></script>
        <script src="${pageContext.request.contextPath}/assets/js/functions.js"></script>
        <script src="${pageContext.request.contextPath}/assets/vendors/chart/chart.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/admin.js"></script>
        <script src='${pageContext.request.contextPath}/assets/vendors/calendar/moment.min.js'></script>
        <script src='${pageContext.request.contextPath}/assets/vendors/calendar/fullcalendar.js'></script>
        <script src='${pageContext.request.contextPath}/assets/vendors/switcher/switcher.js'></script>
    </body>
</html>