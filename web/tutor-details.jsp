<%-- 
    Document   : tutor-details
    Created on : Feb 28, 2025, 4:06:09 PM
    Author     : Heizxje
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="model.DAOCv"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSet,entity.User,entity.Subject,java.util.List"%>
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

    </head>
    <%
        ResultSet rsTutor = (ResultSet) request.getAttribute("rsTutor");
        rsTutor.next();
    %>
    <%
        List<Subject> list = (List<Subject>) request.getAttribute("list");
        ResultSet rs = (ResultSet) request.getAttribute("rs");
        User user = (User) session.getAttribute("user");
    %>
    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>
            <!-- Header Top ==== -->
            <header class="header rs-nav">
                <div class="top-bar">
                    <div class="container">
                        <div class="row d-flex justify-content-between">
                            <div class="topbar-left">
                                <ul>
                                    <li><a href="faq-1.jsp"><i class="fa fa-question-circle"></i>Ask a Question</a></li>
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
                                                    <a href="profile" class="ttr-material-button ttr-submenu-toggle">
                                                        <span class="ttr-user-avatar">
                                                            <img alt="" 
                                                                 src="${pageContext.request.contextPath}/<%= user.getAvatar() != null ? user.getAvatar() : "uploads/default_avatar.jpg"%>" 
                                                                 width="32" height="32"
                                                                 onerror="this.src='${pageContext.request.contextPath}/uploads/default_avatar.jpg'">
                                                        </span>
                                                    </a>
                                                </li>
                                                <li><a href="profile">My profile</a></li>
                                                <li><a href="list-view-calendar.jsp">Activity</a></li>
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
                                <a href="home"><img src="assets/images/logo.png" alt=""></a>
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
                                    <a href="home"><img src="assets/images/logo.png" alt=""></a>
                                </div>
                                <ul class="nav navbar-nav">	
                                    <li><a href="home">Home</a>
                                    </li>
                                    <li class="active" class="add-mega-menu"><a href="Tutor">Our Tutor</a>
                                    </li>
                                    <li><a href="ViewBlog">Blog</a>
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
            <!-- header END ==== -->
            <!-- Content -->
            <div class="page-content bg-white">
                <<form action="Tutordetail"></form>
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner2.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Tutor Details</h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="#">Home</a></li>
                            <li>Tutor Details</li>
                        </ul>
                    </div>
                </div>
                <!-- Breadcrumb row END -->
                <!-- inner page banner END -->
                <div class="content-block">
                    <!-- About Us -->
                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="row d-flex flex-row-reverse">
                                <div class="col-lg-3 col-md-4 col-sm-12 m-b30">
                                    <div class="course-detail-bx">
                                        <div class="course-price">
                                            <del>$190</del>
                                            <h4 class="price"><%=rsTutor.getInt(6)%></h4>
                                        </div>	
                                        <div class="course-buy-now text-center">
                                            <a href="Booking?subjectId=<%=rsTutor.getInt("SubjectID")%>&tutorId=<%=rsTutor.getInt("TutorID")%>" class="btn radius-xl text-uppercase">Booking</a>
                                        </div>
                                        <div class="teacher-bx">
                                            <div class="teacher-info">

                                            </div>
                                        </div>
                                        <div class="cours-more-info">
                                            <div class="review">
                                                <span><%= request.getAttribute("reviewCount")%> reviews</span>
                                                <ul class="cours-star">
                                                    <%
                                                        double avgRating = (Double) request.getAttribute("averageRating");
                                                        int soSao = (int) Math.floor(avgRating);
                                                        soSao = Math.max(0, Math.min(5, soSao));
                                                        for (int i = 0; i < soSao; i++) {
                                                    %>
                                                    <li class="active"><i class="fa fa-star"></i></li>
                                                        <%
                                                            }
                                                            for (int i = 0; i < 5 - soSao; i++) {
                                                        %>
                                                    <li><i class="fa fa-star"></i></li>
                                                        <%
                                                            }
                                                        %>
                                                </ul>
                                            </div>
                                            <div class="price categories">
                                                <span>Subject</span>
                                                <h5 class="text-primary"><%=rsTutor.getString(3)%></h5>
                                            </div>
                                        </div>

                                    </div>
                                </div>

                                <div class="col-lg-9 col-md-8 col-sm-12">
                                    <div class="courses-post">
                                        <div class="ttr-post-media media-effect">
                                            <a href="#"><img src="<%=rsTutor.getString(5)%>" alt=""></a>
                                        </div>
                                        <div class="ttr-post-info">
                                            <div class="ttr-post-title ">
                                                <h2 class="post-title"><%=rsTutor.getString(2)%></h2>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="courese-overview" id="overview">
                                        <h4>Overview</h4>
                                        <div class="row">
                                            <div class="col-md-12 col-lg-4">
                                                <ul class="course-features">
                                                    <li><i class="ti-book"></i> <span class="label">Lectures</span> <span class="value">8</span></li>
                                                    <li><i class="ti-help-alt"></i> <span class="label">Quizzes</span> <span class="value">1</span></li>
                                                    <li><i class="ti-time"></i> <span class="label">Duration</span> <span class="value">60 hours</span></li>
                                                    <li><i class="ti-stats-up"></i> <span class="label">Skill level</span> <span class="value">Beginner</span></li>
                                                    <li><i class="ti-smallcap"></i> <span class="label">Language</span> <span class="value">English</span></li>
                                                    <li><i class="ti-user"></i> <span class="label">Students</span> <span class="value">32</span></li>
                                                    <li><i class="ti-check-box"></i> <span class="label">Assessments</span> <span class="value">Yes</span></li>
                                                </ul>
                                            </div>
                                            <div class="col-md-12 col-lg-8">
                                                <h5 class="m-b5">Tutor Description</h5>
                                                <p><%=rsTutor.getString(7)%></p>
                                                <h5 class="m-b5">Certification</h5>
                                                <p><%=rsTutor.getString("Certificates")%></p>
                                                <h5 class="m-b5">Learning Outcomes</h5>
                                                <ul class="list-checked primary">

                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="reviews-section" id="reviews">
                                        <h4>WHAT MY STUDENTS SAY</h4>
                                        <div class="review-bx">
                                            <div class="all-review">
                                                <h2 class="rating-type"><%= String.format("%.1f", request.getAttribute("averageRating"))%></h2>
                                                <ul class="cours-star">
                                                    <%
                                                        for (int i = 0; i < 5; i++) {
                                                            if (i < Math.floor(avgRating)) {
                                                    %>
                                                    <li class="active"><i class="fa fa-star"></i></li>
                                                        <%
                                                        } else {
                                                        %>
                                                    <li><i class="fa fa-star"></i></li>
                                                        <%
                                                                }
                                                            }
                                                        %>
                                                </ul>
                                                <span><%= request.getAttribute("reviewCount")%> reviews</span>
                                            </div>
                                            <div class="rating-distribution">
                                                <%
                                                    int[] ratingDist = (int[]) request.getAttribute("ratingDistribution");
                                                    int reviewCount = (Integer) request.getAttribute("reviewCount");
                                                    for (int i = 4; i >= 0; i--) {
                                                        int count = ratingDist[i];
                                                        double percentage = reviewCount > 0 ? (double) count / reviewCount * 100 : 0;
                                                %>
                                                <div class="rating-bar">
                                                    <span><%= (i + 1)%> stars</span>
                                                    <div class="bar-container">
                                                        <div class="bar" style="width: <%= percentage%>%;"></div>
                                                    </div>
                                                    <span>(<%= count%>)</span>
                                                </div>
                                                <%
                                                    }
                                                %>
                                            </div>
                                        </div>
                                        <div class="student-reviews" id="student-reviews">
                                            <%
                                                ResultSet rsReviews = (ResultSet) request.getAttribute("rsReviews");
                                                DAOCv dao = new DAOCv();
                                                List<Object[]> reviews = new ArrayList<>();

                                                // Lưu tất cả đánh giá vào danh sách
                                                while (rsReviews.next()) {
                                                    int studentId = rsReviews.getInt("StudentID");
                                                    int rating = rsReviews.getInt("Rating");
                                                    String comment = rsReviews.getString("Comment");
                                                    String ratingDate = rsReviews.getString("RatingDate");

                                                    ResultSet rsStudent = dao.getData("SELECT FullName, Avatar FROM users WHERE UserID = " + studentId);
                                                    String reviewerName = "";
                                                    String reviewerAvatar = "";
                                                    if (rsStudent.next()) {
                                                        reviewerName = rsStudent.getString("FullName");
                                                        reviewerAvatar = rsStudent.getString("Avatar");
                                                    }

                                                    boolean isLongReview = comment.length() > 100;
                                                    String displayText = isLongReview ? comment.substring(0, 100) + "..." : comment;

                                                    // Lưu thông tin vào mảng để tái sử dụng
                                                    reviews.add(new Object[]{studentId, rating, comment, ratingDate, reviewerName, reviewerAvatar, isLongReview, displayText});
                                                }

                                                // Hiển thị tối đa 6 đánh giá đầu tiên
                                                int displayLimit = Math.min(6, reviews.size());
                                                for (int i = 0; i < displayLimit; i++) {
                                                    Object[] review = reviews.get(i);
                                                    int studentId = (int) review[0];
                                                    int rating = (int) review[1];
                                                    String comment = (String) review[2];
                                                    String ratingDate = (String) review[3];
                                                    String reviewerName = (String) review[4];
                                                    String reviewerAvatar = (String) review[5];
                                                    boolean isLongReview = (boolean) review[6];
                                                    String displayText = (String) review[7];
                                            %>
                                            <div class="review-card">
                                                <div class="reviewer-info">
                                                    <div class="reviewer-avatar">
                                                        <% if (reviewerAvatar != null && !reviewerAvatar.isEmpty()) {%>
                                                        <img src="${pageContext.request.contextPath}/<%= reviewerAvatar%>" alt="<%= reviewerName%>" width="32" height="32" onerror="this.src='${pageContext.request.contextPath}/uploads/default_avatar.jpg'">
                                                        <% } else {%>
                                                        <div class="avatar-placeholder"><%= reviewerName.charAt(0)%></div>
                                                        <% }%>
                                                    </div>
                                                    <div class="reviewer-details">
                                                        <h5><%= reviewerName%></h5>
                                                        <span><%= ratingDate%></span>
                                                    </div>
                                                </div>
                                                <ul class="cours-star">
                                                    <% for (int j = 0; j < 5; j++) {%>
                                                    <li class="<%= j < rating ? "active" : ""%>"><i class="fa fa-star"></i></li>
                                                        <% }%>
                                                </ul>
                                                <p><%= displayText%>
                                                    <% if (isLongReview) {%>
                                                    <a href="javascript:void(0);" class="show-more" data-fulltext="<%= comment%>">SHOW MORE</a>
                                                    <% } %>
                                                </p>
                                            </div>
                                            <%
                                                }
                                            %>
                                            <!-- Nút "Xem thêm" -->
                                            <% if (reviews.size() > 6) { %>
                                            <div class="view-more-container text-center">
                                                <button id="view-more-btn" class="btn radius-xl text-uppercase">SHOW MORE</button>
                                            </div>
                                            <div class="grid-row-break"></div>
                                            <!-- Container để hiển thị các đánh giá còn lại khi nhấn "Xem thêm" -->
                                            <div id="hidden-reviews" style="display: none;">
                                                <%
                                                    for (int i = 6; i < reviews.size(); i++) {
                                                        Object[] review = reviews.get(i);
                                                        int studentId = (int) review[0];
                                                        int rating = (int) review[1];
                                                        String comment = (String) review[2];
                                                        String ratingDate = (String) review[3];
                                                        String reviewerName = (String) review[4];
                                                        String reviewerAvatar = (String) review[5];
                                                        boolean isLongReview = (boolean) review[6];
                                                        String displayText = (String) review[7];
                                                %>
                                                <div class="review-card">
                                                    <div class="reviewer-info">
                                                        <div class="reviewer-avatar">
                                                            <% if (reviewerAvatar != null && !reviewerAvatar.isEmpty()) {%>
                                                            <img src="${pageContext.request.contextPath}/<%= reviewerAvatar%>" alt="<%= reviewerName%>" width="32" height="32" onerror="this.src='${pageContext.request.contextPath}/uploads/default_avatar.jpg'">
                                                            <% } else {%>
                                                            <div class="avatar-placeholder"><%= reviewerName.charAt(0)%></div>
                                                            <% }%>
                                                        </div>
                                                        <div class="reviewer-details">
                                                            <h5><%= reviewerName%></h5>
                                                            <span><%= ratingDate%></span>
                                                        </div>
                                                    </div>
                                                    <ul class="cours-star">
                                                        <% for (int j = 0; j < 5; j++) {%>
                                                        <li class="<%= j < rating ? "active" : ""%>"><i class="fa fa-star"></i></li>
                                                            <% }%>
                                                    </ul>
                                                    <p><%= displayText%>
                                                        <% if (isLongReview) {%>
                                                        <a href="javascript:void(0);" class="show-more" data-fulltext="<%= comment%>">SHOW MORE</a>
                                                        <% } %>
                                                    </p>
                                                </div>
                                                <%
                                                    }
                                                %>
                                            </div>
                                            <!-- Nút "Rút lại" đặt ở cuối -->
                                            <div class="collapse-container text-center">
                                                <button id="collapse-btn" class="btn radius-xl text-uppercase" style="display: none;">COLLAPSE</button>
                                            </div>
                                            <% }%>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            const viewMoreBtn = document.getElementById('view-more-btn');
                            const collapseBtn = document.getElementById('collapse-btn');
                            const hiddenReviews = document.getElementById('hidden-reviews');

                            if (viewMoreBtn && collapseBtn && hiddenReviews) {
                                viewMoreBtn.addEventListener('click', function () {
                                    hiddenReviews.style.display = 'contents'; // Hiển thị các đánh giá ẩn
                                    viewMoreBtn.style.display = 'none';      // Ẩn nút "Xem thêm"
                                    collapseBtn.style.display = 'inline-block'; // Hiển thị nút "Rút lại"
                                    console.log('Đã hiển thị đánh giá ẩn');
                                });

                                collapseBtn.addEventListener('click', function () {
                                    hiddenReviews.style.display = 'none';    // Ẩn các đánh giá bổ sung
                                    viewMoreBtn.style.display = 'inline-block'; // Hiển thị lại nút "Xem thêm"
                                    collapseBtn.style.display = 'none';      // Ẩn nút "Rút lại"
                                    console.log('Đã rút lại đánh giá');
                                });
                            }

                            // Xử lý nút "SHOW MORE" cho từng đánh giá
                            document.querySelectorAll('.show-more').forEach(link => {
                                link.addEventListener('click', function () {
                                    const fullText = this.getAttribute('data-fulltext');
                                    const reviewText = this.parentElement;
                                    reviewText.innerHTML = fullText;
                                });
                            });
                        });
                    </script>

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
                                        <a href="home"><img src="assets/images/logo-white.png" alt=""/></a>
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
            <script src="assets/js/jquery.scroller.js"></script>
            <script src="assets/js/functions.js"></script>
            <script src="assets/js/contact.js"></script>
            <script src="assets/vendors/switcher/switcher.js"></script>
    </body>

</html>
