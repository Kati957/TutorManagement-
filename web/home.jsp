<%-- 
    Document   : home
    Created on : Feb 13, 2025, 4:41:09 PM
    Author     : dvdung
--%>

<%@page import="entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
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
                                                <li><a href="profile">My profile</a></li>
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
                                <a href="home"><img src="assets/images/logo-white.png" alt=""></a>
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
                                    <li class="active"><a href="home">Home</a>
                                    </li>
                                    <li class="add-mega-menu"><a href="Courses">Our Courses</a>
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
            <!-- Header Top END ==== -->
            <!-- Content -->
            <div class="page-content bg-white">
                <!-- Main Slider -->
                <div class="rev-slider">
                    <div id="rev_slider_486_1_wrapper" class="rev_slider_wrapper fullwidthbanner-container" data-alias="news-gallery36" data-source="gallery" style="margin:0px auto;background-color:#ffffff;padding:0px;margin-top:0px;margin-bottom:0px;">
                        <!-- START REVOLUTION SLIDER 5.3.0.2 fullwidth mode -->
                        <div id="rev_slider_486_1" class="rev_slider fullwidthabanner" style="display:none;" data-version="5.3.0.2">
                            <ul>	<!-- SLIDE  -->
                                <li data-index="rs-100" 
                                    data-transition="parallaxvertical" 
                                    data-slotamount="default" 
                                    data-hideafterloop="0" 
                                    data-hideslideonmobile="off" 
                                    data-easein="default" 
                                    data-easeout="default" 
                                    data-masterspeed="default" 
                                    data-thumb="error-404.html" 
                                    data-rotate="0" 
                                    data-fstransition="fade" 
                                    data-fsmasterspeed="1500" 
                                    data-fsslotamount="7" 
                                    data-saveperformance="off" 
                                    data-title="A STUDY ON HAPPINESS" 
                                    data-param1="" data-param2="" 
                                    data-param3="" data-param4="" 
                                    data-param5="" data-param6="" 
                                    data-param7="" data-param8="" 
                                    data-param9="" data-param10="" 
                                    data-description="Science says that Women are generally happier">
                                    <!-- MAIN IMAGE -->
                                    <img src="assets/images/slider/slide1.jpg" alt="" 
                                         data-bgposition="center center" 
                                         data-bgfit="cover" 
                                         data-bgrepeat="no-repeat" 
                                         data-bgparallax="10" 
                                         class="rev-slidebg" 
                                         data-no-retina />

                                    <!-- LAYER NR. 1 -->
                                    <div class="tp-caption tp-shape tp-shapewrapper " 
                                         id="slide-100-layer-1" 
                                         data-x="['center','center','center','center']" data-hoffset="['0','0','0','0']" 
                                         data-y="['middle','middle','middle','middle']" data-voffset="['0','0','0','0']" 
                                         data-width="full"
                                         data-height="full"
                                         data-whitespace="nowrap"
                                         data-type="shape" 
                                         data-basealign="slide" 
                                         data-responsive_offset="off" 
                                         data-responsive="off"
                                         data-frames='[{"from":"opacity:0;","speed":1,"to":"o:1;","delay":0,"ease":"Power4.easeOut"},{"delay":"wait","speed":1,"to":"opacity:0;","ease":"Power4.easeOut"}]'
                                         data-textAlign="['left','left','left','left']"
                                         data-paddingtop="[0,0,0,0]"
                                         data-paddingright="[0,0,0,0]"
                                         data-paddingbottom="[0,0,0,0]"
                                         data-paddingleft="[0,0,0,0]"
                                         style="z-index: 5;background-color:rgba(2, 0, 11, 0.80);border-color:rgba(0, 0, 0, 0);border-width:0px;"> </div>	
                                    <!-- LAYER NR. 2 -->
                                    <div class="tp-caption Newspaper-Title   tp-resizeme" 
                                         id="slide-100-layer-2" 
                                         data-x="['center','center','center','center']" 
                                         data-hoffset="['0','0','0','0']" 
                                         data-y="['top','top','top','top']" 
                                         data-voffset="['250','250','250','240']" 
                                         data-fontsize="['50','50','50','30']"
                                         data-lineheight="['55','55','55','35']"
                                         data-width="full"
                                         data-height="none"
                                         data-whitespace="normal"
                                         data-type="text" 
                                         data-responsive_offset="on" 
                                         data-frames='[{"from":"y:[-100%];z:0;rX:0deg;rY:0;rZ:0;sX:1;sY:1;skX:0;skY:0;","mask":"x:0px;y:0px;s:inherit;e:inherit;","speed":1500,"to":"o:1;","delay":1000,"ease":"Power3.easeInOut"},{"delay":"wait","speed":1000,"to":"auto:auto;","mask":"x:0;y:0;s:inherit;e:inherit;","ease":"Power3.easeInOut"}]'
                                         data-textAlign="['center','center','center','center']"
                                         data-paddingtop="[0,0,0,0]"
                                         data-paddingright="[0,0,0,0]"
                                         data-paddingbottom="[10,10,10,10]"
                                         data-paddingleft="[0,0,0,0]"
                                         style="z-index: 6; font-family:rubik; font-weight:700; text-align:center; white-space: normal;">
                                        Welcome To G4 SmartTutor
                                    </div>

                                    <!-- LAYER NR. 3 -->
                                    <div class="tp-caption Newspaper-Subtitle   tp-resizeme" 
                                         id="slide-100-layer-3" 
                                         data-x="['center','center','center','center']" 
                                         data-hoffset="['0','0','0','0']" 
                                         data-y="['top','top','top','top']" 
                                         data-voffset="['210','210','210','210']" 
                                         data-width="none"
                                         data-height="none"
                                         data-whitespace="nowrap"
                                         data-type="text" 
                                         data-responsive_offset="on"
                                         data-frames='[{"from":"y:[-100%];z:0;rX:0deg;rY:0;rZ:0;sX:1;sY:1;skX:0;skY:0;","mask":"x:0px;y:0px;s:inherit;e:inherit;","speed":1500,"to":"o:1;","delay":1000,"ease":"Power3.easeInOut"},{"delay":"wait","speed":1000,"to":"auto:auto;","mask":"x:0;y:0;s:inherit;e:inherit;","ease":"Power3.easeInOut"}]'
                                         data-textAlign="['left','left','left','left']"
                                         data-paddingtop="[0,0,0,0]"
                                         data-paddingright="[0,0,0,0]"
                                         data-paddingbottom="[0,0,0,0]"
                                         data-paddingleft="[0,0,0,0]"
                                         style="z-index: 7; white-space: nowrap; color:#fff; font-family:rubik; font-size:18px; font-weight:400;">
                                        Better Education For A Better Future 
                                    </div>

                                    <!-- LAYER NR. 3 -->
                                    <div class="tp-caption Newspaper-Subtitle   tp-resizeme" 
                                         id="slide-100-layer-4" 
                                         data-x="['center','center','center','center']" 
                                         data-hoffset="['0','0','0','0']" 
                                         data-y="['top','top','top','top']" 
                                         data-voffset="['320','320','320','290']" 
                                         data-width="['800','800','700','420']"
                                         data-height="['100','100','100','120']"
                                         data-whitespace="unset"
                                         data-type="text" 
                                         data-responsive_offset="on"
                                         data-frames='[{"from":"y:[-100%];z:0;rX:0deg;rY:0;rZ:0;sX:1;sY:1;skX:0;skY:0;","mask":"x:0px;y:0px;s:inherit;e:inherit;","speed":1500,"to":"o:1;","delay":1000,"ease":"Power3.easeInOut"},{"delay":"wait","speed":1000,"to":"auto:auto;","mask":"x:0;y:0;s:inherit;e:inherit;","ease":"Power3.easeInOut"}]'
                                         data-textAlign="['center','center','center','center']"
                                         data-paddingtop="[0,0,0,0]"
                                         data-paddingright="[0,0,0,0]"
                                         data-paddingbottom="[0,0,0,0]"
                                         data-paddingleft="[0,0,0,0]"
                                         style="z-index: 7; text-transform:capitalize; white-space: unset; color:#fff; font-family:rubik; font-size:18px; line-height:28px; font-weight:400;">
                                        G4 SmartTutor connects students with professional tutors, offering personalized learning for better results.
                                    </div>
                                </li>
                                <!-- SLIDE  -->
                            </ul>
                        </div><!-- END REVOLUTION SLIDER -->  
                    </div>  
                </div>  
                <!-- Main Slider -->
                <div class="content-block">

                    <!-- Our Services -->
                    <div class="section-area content-inner service-info-bx">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-4 col-md-4 col-sm-6">
                                    <div class="service-bx">
                                        <div class="action-box">
                                            <img src="assets/images/our-services/pic1.jpg" alt="">
                                        </div>
                                        <div class="info-bx text-center">
                                            <div class="feature-box-sm radius bg-white">
                                                <i class="fa fa-bank text-primary"></i>
                                            </div>
                                            <h4><a href="#">All Tutors</a></h4>
                                            <a href="#" class="btn radius-xl">View More</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-6">
                                    <div class="service-bx">
                                        <div class="action-box">
                                            <img src="assets/images/our-services/pic2.jpg" alt="">
                                        </div>
                                        <div class="info-bx text-center">
                                            <div class="feature-box-sm radius bg-white">
                                                <i class="fa fa-book text-primary"></i>
                                            </div>
                                            <h4><a href="#">All Subjects</a></h4>
                                            <a href="#" class="btn radius-xl">View More</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-12">
                                    <div class="service-bx m-b0">
                                        <div class="action-box">
                                            <img src="assets/images/our-services/pic3.jpg" alt="">
                                        </div>
                                        <div class="info-bx text-center">
                                            <div class="feature-box-sm radius bg-white">
                                                <i class="fa fa-file-text-o text-primary"></i>
                                            </div>
                                            <h4><a href="myschedule">My Schedule</a></h4>
                                            <a href="myschedule" class="btn radius-xl">View More</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Our Services END -->

                    <!-- Popular Courses -->
                    <div class="section-area section-sp2 popular-courses-bx">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-12 heading-bx left">
                                    <h2 class="title-head">Top <span>Tutors</span></h2>
                                    <p>Những Gia sư hàng đầu của chúng tôi:</p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="courses-carousel owl-carousel owl-btn-1 col-12 p-lr0">
                                    <c:forEach var="tutor" items="${topTutors}">
                                        <div class="item">
                                            <div class="cours-bx">
                                                <div class="action-box">
                                                    <img src="${tutor.cv.user.avatar}" alt="Avatar">
                                                    <a href="#" class="btn">Read More</a>
                                                </div>
                                                <div class="info-bx text-center">
                                                    <h5><a href="#">${tutor.cv.user.fullName}</a></h5>
                                                    <span>${tutor.cv.description}</span>
                                                </div>
                                                <div class="cours-more-info">
                                                    <div class="review">
                                                        <span>${tutor.rating} Rating</span>
                                                        <ul class="cours-star">
                                                            <c:forEach begin="1" end="5" var="i">
                                                                <li class="${i <= tutor.rating ? 'active' : ''}">
                                                                    <i class="fa fa-star"></i>
                                                                </li>
                                                            </c:forEach>
                                                        </ul>
                                                    </div>
                                                    <div class="price">
                                                        <small>${tutor.cv.user.email}</small>
                                                        <h5>${tutor.cv.user.phone}</h5>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Popular Courses END -->
                    <!-- Testimonials -->
                    <div class="section-area section-sp2 bg-fix ovbl-dark" style="background-image:url(assets/images/background/bg1.jpg);">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-12 text-white heading-bx left">
                                    <h2 class="title-head text-uppercase">Top Subjects <span>have the most Bookings</span></h2>
                                    <p>Những môn học nhận được nhiều lượt booking nhất của chúng tôi:</p>
                                </div>
                            </div>
                            <div class="testimonial-carousel owl-carousel owl-btn-1 col-12 p-lr0">
                                <c:forEach var="subject" items="${topSubjects}" varStatus="status">
                                    <div class="item">
                                        <div class="testimonial-bx">
                                            <div class="testimonial-info">
                                                <a href="#"><h5 class="name">Top ${status.index + 1}:  ${subject.subjectName}</h5></a>
                                                <p>Booking Count: ${subject.bookingCount} </p>
                                            </div>
                                            <div class="testimonial-content">
                                                <p>Description: ${subject.description}</p>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <!-- Testimonials END -->
                </div>
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
                                    <a href="home.jsp"><img src="assets/images/logo-white.png" alt=""/></a>
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
        <script src="assets/js/functions.js"></script>
        <script src="assets/js/contact.js"></script>
        <script src='assets/vendors/switcher/switcher.js'></script>
        <!-- Revolution JavaScripts Files -->
        <script src="assets/vendors/revolution/js/jquery.themepunch.tools.min.js"></script>
        <script src="assets/vendors/revolution/js/jquery.themepunch.revolution.min.js"></script>
        <!-- Slider revolution 5.0 Extensions  (Load Extensions only on Local File Systems !  The following part can be removed on Server for On Demand Loading) -->
        <script src="assets/vendors/revolution/js/extensions/revolution.extension.actions.min.js"></script>
        <script src="assets/vendors/revolution/js/extensions/revolution.extension.carousel.min.js"></script>
        <script src="assets/vendors/revolution/js/extensions/revolution.extension.kenburn.min.js"></script>
        <script src="assets/vendors/revolution/js/extensions/revolution.extension.layeranimation.min.js"></script>
        <script src="assets/vendors/revolution/js/extensions/revolution.extension.migration.min.js"></script>
        <script src="assets/vendors/revolution/js/extensions/revolution.extension.navigation.min.js"></script>
        <script src="assets/vendors/revolution/js/extensions/revolution.extension.parallax.min.js"></script>
        <script src="assets/vendors/revolution/js/extensions/revolution.extension.slideanims.min.js"></script>
        <script src="assets/vendors/revolution/js/extensions/revolution.extension.video.min.js"></script>
        <script>
            jQuery(document).ready(function () {
                var ttrevapi;
                var tpj = jQuery;
                if (tpj("#rev_slider_486_1").revolution == undefined) {
                    revslider_showDoubleJqueryError("#rev_slider_486_1");
                } else {
                    ttrevapi = tpj("#rev_slider_486_1").show().revolution({
                        sliderType: "standard",
                        jsFileLocation: "assets/vendors/revolution/js/",
                        sliderLayout: "fullwidth",
                        dottedOverlay: "none",
                        delay: 9000,
                        navigation: {
                            keyboardNavigation: "on",
                            keyboard_direction: "horizontal",
                            mouseScrollNavigation: "off",
                            mouseScrollReverse: "default",
                            onHoverStop: "on",
                            touch: {
                                touchenabled: "on",
                                swipe_threshold: 75,
                                swipe_min_touches: 1,
                                swipe_direction: "horizontal",
                                drag_block_vertical: false
                            }
                            ,
                            arrows: {
                                style: "uranus",
                                enable: true,
                                hide_onmobile: false,
                                hide_onleave: false,
                                tmp: '',
                                left: {
                                    h_align: "left",
                                    v_align: "center",
                                    h_offset: 10,
                                    v_offset: 0
                                },
                                right: {
                                    h_align: "right",
                                    v_align: "center",
                                    h_offset: 10,
                                    v_offset: 0
                                }
                            },

                        },
                        viewPort: {
                            enable: true,
                            outof: "pause",
                            visible_area: "80%",
                            presize: false
                        },
                        responsiveLevels: [1240, 1024, 778, 480],
                        visibilityLevels: [1240, 1024, 778, 480],
                        gridwidth: [1240, 1024, 778, 480],
                        gridheight: [768, 600, 600, 600],
                        lazyType: "none",
                        parallax: {
                            type: "scroll",
                            origo: "enterpoint",
                            speed: 400,
                            levels: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 46, 47, 48, 49, 50, 55],
                            type: "scroll",
                        },
                        shadow: 0,
                        spinner: "off",
                        stopLoop: "off",
                        stopAfterLoops: -1,
                        stopAtSlide: -1,
                        shuffle: "off",
                        autoHeight: "off",
                        hideThumbsOnMobile: "off",
                        hideSliderAtLimit: 0,
                        hideCaptionAtLimit: 0,
                        hideAllCaptionAtLilmit: 0,
                        debugMode: false,
                        fallbacks: {
                            simplifyAll: "off",
                            nextSlideOnWindowFocus: "off",
                            disableFocusListener: false,
                        }
                    });
                }
            });
        </script>
    </body>

</html>