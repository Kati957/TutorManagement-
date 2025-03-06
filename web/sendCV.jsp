

<%@page import="entity.User,java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>CV</title>
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">
    </head>
    <%
        User user = (User) session.getAttribute("user");
        ResultSet rsSub = (ResultSet) request.getAttribute("rsSub");
    %>
    <body id="bg">
        <div class="page-wraper">
            <div class="account-form">
                <div class="account-head" style="background-image:url(assets/images/background/bg2.jpg);">
                    <a href="index.jsp"><img src="assets/images/logo-white-2.png" alt=""></a>
                </div>
                <div class="account-form-inner">
                    <div class="account-container">
                        <form action="cv" method="POST" class="contact-bx">
                            <img src="<%= user.getAvatar()%>" alt=""> 
                            <div class="form-group row">
                                <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Full Name</label>
                                <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                    <input class="form-control" type="text" name="fullName" value="<%= user.getFullName()%>">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Email</label>
                                <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                    <input class="form-control" type="email" name="email" value="<%= user.getEmail()%>">
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
                                <label class="col-12 col-sm-3 col-md-3 col-lg-2 col-form-label">Address</label>
                                <div class="col-12 col-sm-9 col-md-9 col-lg-7">
                                    <input class="form-control" type="text" name="address" value="<%= user.getAddress()%>">
                                </div>
                            </div>
                            <div class="row placeani">
                                <input type="hidden" name="userId" value="<%= user.getUserID()%>">
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <label>education</label>
                                            <input type="text" name="education" class="form-control" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <label>experience</label>
                                            <input type="text" name="experience" class="form-control" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <label>certificates</label>
                                            <input type="text" name="certificates" class="form-control" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <label>Subject</label>
                                            <select name="Subject" id="Subject">
                                                <% if (rsSub != null) {
                                                        while (rsSub.next()) {%>
                                                <option value="<%=rsSub.getInt(1)%>"><%=rsSub.getString(2)%></option>
                                                <%  }
                                                } else { %>
                                                <option value="">No subjects available</option>
                                                <% }%>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <label>Description</label>
                                            <input type="text" name="Description" class="form-control" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12 m-b30">
                                    <button type="submit" class="btn button-md" name="submit">Send</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

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
