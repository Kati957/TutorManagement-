<%-- 
    Document   : blog-details
    Created on : Mar 1, 2025, 1:01:54 PM
    Author     : minht
--%>

<%@ page import="java.util.List" %>
<%@ page import="entity.Blog" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/index.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:08:15 GMT -->
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
                        <a href="index.jsp" class="ttr-logo">
                            <img class="ttr-logo-mobile" alt="" src="assets/images/logo-mobile.png" width="30" height="30">
                            <img class="ttr-logo-desktop" alt="" src="assets/images/logo-white.png" width="160" height="27">
                        </a>
                    </div>
                </div>
                <!--logo end -->
                <div class="ttr-header-menu">
                    <!-- header left menu start -->
                    <ul class="ttr-header-navigation">
                        <li>
                            <a href="../index.jsp" class="ttr-material-button ttr-submenu-toggle">HOME</a>
                        </li>
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
                    <!-- header left menu end -->
                </div>
                <div class="ttr-header-right ttr-with-seperator">
                    <!-- header right menu start -->
                    <ul class="ttr-header-navigation">
                        <li>
                            <a href="#" class="ttr-material-button ttr-search-toggle"><i class="fa fa-search"></i></a>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button ttr-submenu-toggle"><i class="fa fa-bell"></i></a>
                            <div class="ttr-header-submenu noti-menu">
                                <div class="ttr-notify-header">
                                    <span class="ttr-notify-text-top">9 New</span>
                                    <span class="ttr-notify-text">User Notifications</span>
                                </div>
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
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button ttr-submenu-toggle"><span class="ttr-user-avatar"><img alt="" src="assets/images/testimonials/pic3.jpg" width="32" height="32"></span></a>
                            <div class="ttr-header-submenu">
                                <ul>
                                    <li><a href="user-profile.jsp">My profile</a></li>
                                    <li><a href="list-view-calendar.jsp">Activity</a></li>
                                    <li><a href="mailbox.jsp">Messages</a></li>
                                    <li><a href="../login.jsp">Logout</a></li>
                                </ul>
                            </div>
                        </li>
                        <li class="ttr-hide-on-mobile">
                            <a href="#" class="ttr-material-button"><i class="ti-layout-grid3-alt"></i></a>
                            <div class="ttr-header-submenu ttr-extra-menu">
                                <a href="#">
                                    <i class="fa fa-music"></i>
                                    <span>Musics</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-youtube-play"></i>
                                    <span>Videos</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-envelope"></i>
                                    <span>Emails</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-book"></i>
                                    <span>Reports</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-smile-o"></i>
                                    <span>Persons</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-picture-o"></i>
                                    <span>Pictures</span>
                                </a>
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
        <!-- header end -->
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
                                    <a href="#" class="ttr-material-button"><span class="ttr-label">Status CV</span></a>
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
                                    <a href="#" class="ttr-material-button"><span class="ttr-label">Staff Management</span></a>
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
                                    <a href="${pageContext.request.contextPath}/BlogController?service=listBlog" class="ttr-label">Blog</a>
                                </li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/BlogController?service=addBlog" class="ttr-label">Add Blog</a>
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

        <!--Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Blog</h4>
                </div>	
                <div class="row">
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Basic Calendar</h4>
                            </div>
                            <div class="widget-inner">
                                <div class="content-block">
                                    <div class="section-area section-sp1">
                                        <div class="container">
                                            <div class="row">
                                                <!-- Left part start -->
                                                <div class="col-lg-8 col-xl-8">
                                                    <!-- blog start -->
                                                    <div class="recent-news blog-lg">
                                                        <%
                                                            Blog blog = (Blog) request.getAttribute("blog");
                                                            if (blog != null) {
                                                        %>
                                                        <div class="action-box blog-lg">
                                                            <img src="<%= blog.getThumbnail()%>" alt="<%= blog.getTitle()%>">
                                                        </div>
                                                        <div class="info-bx">
                                                            <ul class="media-post">
                                                                <li><a href="#"><i class="fa fa-calendar"></i> <%= blog.getCreatedAt() != null ? blog.getCreatedAt() : "N/A"%></a></li>
                                                                <li><a href="#"><i class="fa fa-user"></i> By <%= blog.getAuthorName() != null ? blog.getAuthorName() : "Unknown"%></a></li>
                                                            </ul>
                                                            <h5 class="post-title"><%= blog.getTitle()%></h5>
                                                            <p><%= blog.getContent() != null ? blog.getContent() : "No content available."%></p>
                                                            <div class="ttr-divider bg-gray"><i class="icon-dot c-square"></i></div>
                                                            <!-- Thêm nút Update và Delete tại đây -->
                                                            <div class="action-buttons">
                                                                <a href="BlogController?service=updateBlog&blogID=<%= blog.getBlogID()%>" class="btn-update">Update</a>
                                                                <a href="BlogController?service=deleteBlog&blogID=<%= blog.getBlogID()%>" 
                                                                   class="btn-delete" 
                                                                   onclick="return confirm('Delete this blog?');">Delete</a>
                                                            </div>
                                                        </div>
                                                        <%
                                                            } else {
                                                        %>
                                                        <div class="info-bx">
                                                            <p>no post.</p>
                                                        </div>
                                                        <%
                                                            }
                                                        %>
                                                    </div>
                                                    <!-- blog END -->
                                                </div>
                                                <!-- Left part END -->
                
                                                <!-- Side bar start -->
                                                <div class="col-lg-4 col-xl-4 col-md-5 sticky-top">
                                                    <aside class="side-bar sticky-top">
                                                        <div class="widget">
                                                            <h6 class="widget-title">Search</h6>
                                                            <div class="search-bx style-1">
                                                                <form role="search" method="post" action="BlogController">

                                                                    <input type="hidden" name="service" value="searchBlog">
                                                                    <div class="input-group">
                                                                        <input name="text" class="form-control" 
                                                                               placeholder="Enter your keywords..." 
                                                                               type="text" 
                                                                               value="${keyword != null ? keyword : ''}">
                                                                        <span class="input-group-btn">
                                                                            <button type="submit" class="fa fa-search text-primary"></button>
                                                                        </span>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>
                
                                                        <div class="widget recent-posts-entry">
                                                            <h6 class="widget-title">Recent Posts</h6>
                                                            <div class="widget-post-bx">
                                                                <%
                                                                    List<Blog> recentBlogs = (List<Blog>) request.getAttribute("recentBlogs");
                                                                    if (recentBlogs != null && !recentBlogs.isEmpty()) {
                                                                        for (Blog blog1 : recentBlogs) {
                                                                %>
                                                                <div class="widget-post clearfix">
                                                                    <div class="ttr-post-media">
                                                                        <img src="<%= blog1.getThumbnail()%>" 
                                                                             width="200" height="143" alt="<%= blog1.getTitle()%>">
                                                                    </div>
                                                                    <div class="ttr-post-info">
                                                                        <div class="ttr-post-header">
                                                                            <h6 class="post-title">
                                                                                <a href="BlogController?service=detailBlog&blogID=<%= blog1.getBlogID()%>">

                                                                                    <%= blog1.getTitle()%>
                                                                                </a>
                                                                            </h6>
                                                                        </div>
                                                                        <ul class="media-post">
                                                                            <li><a href="#"><i class="fa fa-calendar"></i> <%= blog1.getCreatedAt()%></a></li>
                                                                            <li><a href="#"><i class="fa fa-comments-o"></i> 15 Comment</a></li>
                                                                        </ul>
                                                                    </div>
                                                                </div>
                                                                <%
                                                                    }
                                                                } else {
                                                                %>
                                                                <p>no post.</p>
                                                                <%
                                                                    }
                                                                %>
                                                            </div>
                                                        </div>
                                                            
                                                        <div class="widget widget_gallery gallery-grid-4">
                                                            <h6 class="widget-title">Our Gallery</h6>
                                                            <ul class="gallery-list">
                                                                <c:forEach var="img" items="${galleryBlogs}">
                                                                    <li>
                                                                        <div>
                                                                            <img src="${img.thumbnail}" alt="${img.title}" class="gallery-img" onclick="openImageViewer('${img.thumbnail}', '${img.title}')">
                                                                        </div>
                                                                    </li>
                                                                </c:forEach>
                                                                <c:if test="${empty galleryBlogs}">
                                                                    <li><div><p>null gallery</p></div></li>
                                                                </c:if>
                                                            </ul>
                                                        </div>
                
                                                        <!-- Modal hiển thị ảnh lớn -->
                                                        <div id="imageViewer" class="image-viewer">
                                                            <span class="close-viewer" onclick="closeImageViewer()">×</span>
                                                            <img id="fullImage" src="" alt="Full Image">
                                                            <p id="imageCaption"></p>
                                                        </div>
                                                    </aside>
                                                </div>
                                                <!-- Side bar END -->
                                            </div>
                                        </div>
                                    </div>
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

</html>
