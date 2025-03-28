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
        <title>G4 SmartTutor</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/vendors/calendar/fullcalendar.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/typography.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/shortcodes/shortcodes.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
        <link class="skin" rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/color/color-1.css">

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
            .delete-btn {
                background-color: #ff4d4d;
                color: white;
                padding: 5px 10px;
                text-decoration: none;
                border-radius: 3px;
            }
            .delete-btn:hover {
                background-color: #cc0000;
            }
        </style>
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
                        <a href="${pageContext.request.contextPath}/staff/dashboard" class="ttr-logo">
                            <img class="ttr-logo-mobile" alt="" src="${pageContext.request.contextPath}/assets/images/logo-mobile.png" width="30" height="30">
                            <img class="ttr-logo-desktop" alt="" src="${pageContext.request.contextPath}/assets/images/logo-white.png" width="160" height="27">
                        </a>
                    </div>
                </div>
            </div>
            <div class="ttr-header-right ttr-with-seperator">
                <ul class="ttr-header-navigation">
                    <li>
                        <a href="${pageContext.request.contextPath}/staff/dashboard" class="ttr-material-button ttr-submenu-toggle">
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

        <!-- Sidebar -->
        <div class="ttr-sidebar">
            <div class="ttr-sidebar-wrapper content-scroll">
                <div class="ttr-sidebar-logo">
                    <a href="${pageContext.request.contextPath}/staff/dashboard"><img alt="" src="${pageContext.request.contextPath}/assets/images/logo.png" width="122" height="27"></a>
                    <div class="ttr-sidebar-toggle-button">
                        <i class="ti-arrow-left"></i>
                    </div>
                </div>
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
            </div>
        </div>

        <!-- Main content -->
        <main class="ttr-wrapper">
            <h2>Tutor Ratings List</h2>

            <!-- Hiển thị thông báo -->
            <c:if test="${not empty sessionScope.message}">
                <div class="message">${sessionScope.message}</div>
                <c:remove var="message" scope="session" />
            </c:if>
            <c:if test="${not empty sessionScope.error}">
                <div class="error">${sessionScope.error}</div>
                <c:remove var="error" scope="session" />
            </c:if>

            <!-- Form tìm kiếm gia sư -->
            <div class="sort-options" style="margin-bottom: 20px;">
                <label>Get tutor's average rate: </label>
                <form action="${pageContext.request.contextPath}/staff/ListRated" method="get" style="display: inline;">
                    <input type="hidden" name="service" value="searchTutors">
                    <input type="text" name="keyword" value="${keyword}" placeholder="Enter ID or Name" style="padding: 5px;">
                    <button type="submit" style="background-color: #800080; color: white; border: none; padding: 5px 10px; cursor: pointer;">Search</button>
                </form>
            </div>

            <!-- Form tìm kiếm danh sách đánh giá -->
            <div class="sort-options" style="margin-bottom: 20px;">
                <label>Search ratings: </label>
                <form action="${pageContext.request.contextPath}/staff/ListRated" method="get" style="display: inline;">
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
                    <a href="${pageContext.request.contextPath}/staff/ListRated?service=listTutorsByRating&order=DESC" 
                       class="option" 
                       data-sort="DESC"
                       data-label="Highest rated first"
                       style="padding: 12px 16px; text-decoration: none; display: flex; align-items: center; justify-content: space-between; color: black;">
                        Highest rated first
                        <svg width="16" height="16" viewBox="0 0 24 24" style="color: #4CAF50; display: none;" class="check-icon">
                            <path d="M9 16.2L4.8 12l-1.4 1.4L9 19 21 7l-1.4-1.4z" fill="currentColor"></path>
                        </svg>
                    </a>
                    <a href="${pageContext.request.contextPath}/staff/ListRated?service=listTutorsByRating&order=ASC" 
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
                    <th>Actions</th> <!-- Thêm cột Actions -->
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
                        <td>
                            <a href="${pageContext.request.contextPath}/staff/ListRated?service=deleteRating&ratingId=${rating.ratingId}" 
                               class="delete-btn" 
                               onclick="return confirm('Bạn có chắc chắn muốn xóa đánh giá này?')">Delete</a>
                        </td>
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