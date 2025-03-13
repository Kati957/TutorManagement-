<%-- 
    Document   : blog-classic-sidebar
    Created on : Feb 26, 2025, 2:21:45 PM
    Author     : minht
--%>

<%@page import="entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entity.Blog" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


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
        <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon" />
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

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">

        <!-- REVOLUTION SLIDER CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/layers.css">
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/settings.css">
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/navigation.css">
        <!-- REVOLUTION SLIDER END -->	
    </head>

    <body id="bg">
        <%
            User user = (User) session.getAttribute("user");
        %>
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>
            <!-- Header Top ==== -->
            <header class="header rs-nav header-transparent">
                <div class="top-bar">
                    <div class="container">
                        <div class="row d-flex justify-content-between">
                            <div class="topbar-left">
                                <ul>
                                    <li><a href="faq-1.html"><i class="fa fa-question-circle"></i>Ask a Question</a></li>
                                    <li><a href="javascript:;"><i class="fa fa-envelope-o"></i>Support@website.com</a></li>
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
                                    <% if (user == null) { %>
                                    <li><a href="login">Login</a></li>
                                    <li><a href="User?service=registerUser">Register</a></li>
                                        <%} else {%>
                                    <li>
                                        <div class="ttr-header-submenu">
                                            <ul>
                                                <li>
                                                    <a href="profile_user.jsp" class="ttr-material-button ttr-submenu-toggle">
                                                        <span class="ttr-user-avatar">
                                                            <img alt="" 
                                                                 src="${pageContext.request.contextPath}/<%= user.getAvatar() != null ? user.getAvatar() : "uploads/default_avatar.jpg"%>" 
                                                                 width="32" height="32"
                                                                 onerror="this.src='${pageContext.request.contextPath}/uploads/default_avatar.jpg'">
                                                        </span>
                                                    </a>
                                                </li>
                                                <li><a href="profile_user.jsp">My profile</a></li>
                                                <li><a href="list-view-calendar.html">Activity</a></li>
                                                <li><a href="cv">Become a tutor</a></li>
                                                <li><a href="logout">Logout</a></li>
                                            </ul>
                                        </div>
                                    </li>
                                    <%}%>
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
                                <a href="home.jsp"><img src="assets/images/logo-white.png" alt=""></a>
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
                                        <!-- Search Button ==== -->
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
                                    <a href="home.jsp"><img src="assets/images/logo.png" alt=""></a>
                                </div>
                                <ul class="nav navbar-nav">	
                                    <li><a href="home.jsp">Home</a>
                                    </li>
                                    <li class="add-mega-menu"><a href="Courses">Our Courses</a>
                                    </li>

                                    <li class="active"><a href="ViewBlog">Blog</a>
                                    </li>
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
                </div>
            </header>
            <!-- header END -->
            <!-- Content -->
            <div class="page-content bg-white">
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner1.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Blog</h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <ul class="list-inline">
                                <li><a href="home.jsp">Home</a></li>
                                <li><a href="ViewBlog">Blog</a></li>
                            </ul>
                    </div>
                </div>
                <!-- Breadcrumb row END -->
                <div class="content-block">
                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="row">
                                <!-- left part start -->
                                <div class="col-lg-8 col-xl-8 col-md-7">
                                    <!-- blog grid -->

                                    <div id="masonry" class="ttr-blog-grid-3 row">
                                        <%
                                            List<Blog> listBlog = (List<Blog>) request.getAttribute("blogList");

                                            if (listBlog != null && !listBlog.isEmpty()) {
                                                for (Blog blog : listBlog) {
                                        %>
                                        <div class="post action-card col-xl-6 col-lg-6 col-md-12 col-xs-12 m-b40">
                                            <div class="recent-news">
                                                <div class="action-box">
                                                    <img src="<%= blog.getThumbnail()%>" alt="thumbnail">
                                                </div>
                                                <div class="info-bx">
                                                    <ul class="media-post">
                                                        <li><i class="fa fa-calendar"></i><%= blog.getCreatedAt()%></li>
                                                        <li><i class="fa fa-user"></i>By <%= blog.getAuthorName()%></li>
                                                    </ul>
                                                    <h5 class="post-title">
                                                        <a href="ViewBlog?service=detailBlog&blogID=<%= blog.getBlogID()%>"><%= blog.getTitle()%></a>                                                    </h5>
                                                    <p><%= blog.getSummary()%></p>

                                                </div>
                                            </div>
                                        </div>
                                        <%
                                            }
                                        } else {
                                        %>
                                        <p>Không có bài viết nào.</p>
                                        <%
                                            }
                                        %>
                                    </div>

                                    <!-- blog grid END -->

                                    <!-- Pagination -->
                                    <div class="pagination-bx rounded-sm gray clearfix">
                                        <ul class="pagination">
                                            <!-- Nút Previous -->
                                            <li class="previous ${currentPage == 1 ? 'disabled' : ''}">
                                                <a href="${currentPage == 1 ? '#' : 'ViewBlog?service=listBlog&page='.concat(currentPage - 1)}">
                                                    <i class="ti-arrow-left"></i> Prev
                                                </a>
                                            </li>

                                            <!-- Các số trang (chỉ hiển thị đến totalPages, không cần giới hạn 5) -->
                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <li class="${currentPage == i ? 'active' : ''}">
                                                    <a href="ViewBlog?service=listBlog&page=${i}">${i}</a>
                                                </li>
                                            </c:forEach>

                                            <!-- Nút Next -->
                                            <li class="next ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a href="${currentPage == totalPages ? '#' : 'ViewBlog?service=listBlog&page='.concat(currentPage + 1)}">
                                                    Next <i class="ti-arrow-right"></i>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                    <!-- Pagination END -->
                                </div>
                                <!-- left part END -->

                                <!-- Side bar start -->
                                <div class="col-lg-4 col-xl-4 col-md-5 sticky-top">
                                    <aside class="side-bar sticky-top">
                                        <div class="widget">
                                            <h6 class="widget-title">Search</h6>
                                            <div class="search-bx style-1">
                                                <form role="search" method="post" action="ViewBlog">
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
                                                        for (Blog blog : recentBlogs) {
                                                %>
                                                <div class="widget-post clearfix">
                                                    <div class="ttr-post-media">
                                                        <img src="<%= blog.getThumbnail()%>" 
                                                             width="200" height="143" alt="<%= blog.getTitle()%>">
                                                    </div>
                                                    <div class="ttr-post-info">
                                                        <div class="ttr-post-header">
                                                            <h6 class="post-title">
                                                                <a href="ViewBlog?service=detailBlog&blogID=<%= blog.getBlogID()%>">
                                                                    <%= blog.getTitle()%>
                                                                </a>
                                                            </h6>
                                                        </div>
                                                        <ul class="media-post">
                                                            <li><i class="fa fa-calendar"></i> <%= blog.getCreatedAt()%></li>
                                                            <li><i class="fa fa-user"></i><%= blog.getAuthorName()%></li>
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
                                        </div

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
            <!-- Left & right section END -->
            <!-- Content END-->
            <!-- Footer ==== -->
            <footer>
                <div class="footer-top">
                    <div class="pt-exebar">
                        <div class="container">
                            <div class="d-flex align-items-stretch">
                                <div class="pt-logo mr-auto">
                                    <a href="index.jsp"><img src="assets/images/logo-white.png" alt=""/></a>
                                </div>
                                <div class="pt-social-link">
                                    <ul class="list-inline m-a0">
                                        <li><a href="#" class="btn-link"><i class="fa fa-facebook"></i></a></li>
                                        <li><a href="#" class="btn-link"><i class="fa fa-twitter"></i></a></li>
                                        <li><a href="#" class="btn-link"><i class="fa fa-linkedin"></i></a></li>
                                        <li><a href="#" class="btn-link"><i class="fa fa-google-plus"></i></a></li>
                                    </ul>
                                </div>
                                <div class="pt-btn-join">
                                    <a href="#" class="btn ">Join Now</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>
            <!-- Footer END ==== -->
            <!-- scroll top button -->
            <button class="back-to-top fa fa-chevron-up" ></button>
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
    </body>

</html>
