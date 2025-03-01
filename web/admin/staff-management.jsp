<%-- 
    Document   : staff-management
    Created on : Mar 1, 2025, 9:56:17 PM
    Author     : Heizxje
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Staff Management - EduChamp</title>

    <!-- CSS từ dashboard -->
    <link rel="stylesheet" type="text/css" href="assets/css/assets.css">
    <link rel="stylesheet" type="text/css" href="assets/vendors/calendar/fullcalendar.css">
    <link rel="stylesheet" type="text/css" href="assets/css/typography.css">
    <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="assets/css/dashboard.css">
    <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">
</head>
<body class="ttr-opened-sidebar ttr-pinned-sidebar">

    <!-- Header từ dashboard -->
    <jsp:include page="header.jsp" />

    <!-- Sidebar từ dashboard -->
    <jsp:include page="sidebar.jsp" />

    <!-- Main content -->
    <main class="ttr-wrapper">
        <div class="container-fluid">
            <div class="db-breadcrumb">
                <h4 class="breadcrumb-title">Staff Management</h4>
                <ul class="db-breadcrumb-list">
                    <li><a href="index.jsp"><i class="fa fa-home"></i>Home</a></li>
                    <li>Staff Management</li>
                </ul>
            </div>

            <!-- Staff Management Section -->
            <div class="row">
                <div class="col-lg-12 m-b30">
                    <div class="widget-box">
                        <div class="wc-title">
                            <h4>Staff Management</h4>
                            <button class="btn button-sm green" id="add-staff-btn" style="float: right;">Add New Staff</button>
                        </div>
                        <div class="widget-inner">
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Role</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody id="staff-table-body">
                                        <c:forEach var="staff" items="${staffList}">
                                            <tr>
                                                <td>${staff.id}</td>
                                                <td>${staff.name}</td>
                                                <td>${staff.email}</td>
                                                <td>${staff.role}</td>
                                                <td>
                                                    <button class="btn button-sm outline edit-staff-btn" data-id="${staff.id}">Edit</button>
                                                    <button class="btn button-sm red delete-staff-btn" data-id="${staff.id}">Delete</button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal để thêm/sửa nhân viên -->
            <div id="staff-modal" class="modal" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: white; padding: 20px; border-radius: 5px; box-shadow: 0 0 10px rgba(0,0,0,0.5); z-index: 1000;">
                <h4 id="modal-title">Add New Staff</h4>
                <form id="staff-form" action="StaffServlet" method="post">
                    <input type="hidden" id="staff-id" name="id">
                    <div class="form-group">
                        <label for="staff-name">Name:</label>
                        <input type="text" id="staff-name" name="name" class="form-controlournament" required>
                    </div>
                    <div class="form-group">
                        <label for="staff-email">Email:</label>
                        <input type="email" id="staff-email" name="email" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="staff-role">Role:</label>
                        <select id="staff-role" name="role" class="form-control" required>
                            <option value="Staff">Staff</option>
                            <option value="Manager">Manager</option>
                        </select>
                    </div>
                    <button type="submit" class="btn green">Save</button>
                    <button type="button" class="btn red" id="close-modal">Close</button>
                </form>
            </div>

            <!-- Overlay cho modal -->
            <div id="modal-overlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 999;"></div>
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
    <script src='assets/vendors/switcher/switcher.js'></script>

    <!-- JavaScript xử lý client-side -->
    <script>
    $(document).ready(function() {
        // Mở modal để thêm nhân viên
        $("#add-staff-btn").click(function() {
            $("#modal-title").text("Add New Staff");
            $("#staff-id").val("");
            $("#staff-name").val("");
            $("#staff-email").val("");
            $("#staff-role").val("Staff");
            $("#staff-modal").show();
            $("#modal-overlay").show();
        });

        // Đóng modal
        $("#close-modal").click(function() {
            $("#staff-modal").hide();
            $("#modal-overlay").hide();
        });

        // Mở modal để sửa nhân viên
        $(".edit-staff-btn").click(function() {
            const id = $(this).data("id");
            $.get("StaffServlet?action=get&id=" + id, function(staff) {
                $("#modal-title").text("Edit Staff");
                $("#staff-id").val(staff.id);
                $("#staff-name").val(staff.name);
                $("#staff-email").val(staff.email);
                $("#staff-role").val(staff.role);
                $("#staff-modal").show();
                $("#modal-overlay").show();
            });
        });

        // Xóa nhân viên
        $(".delete-staff-btn").click(function() {
            if (confirm("Are you sure you want to delete this staff?")) {
                const id = $(this).data("id");
                window.location.href = "StaffServlet?action=delete&id=" + id;
            }
        });
    });
    </script>
</body>
</html>