<%-- 
    Document   : updateBlog
    Created on : Mar 3, 2025, 12:54:00 PM
    Author     : minht
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cập nhật Bài Viết</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- CKEditor CDN -->
        <script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
    </head>
    <body>
        <div class="container">
            <h2 class="mb-4">Update Blog</h2>

            <%-- Hiển thị thông báo lỗi nếu có --%>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form action="BlogController" method="post">
                <input type="hidden" name="service" value="updateBlog">
                <input type="hidden" name="blogID" value="${blog.blogID}">

                <!-- Trường tiêu đề -->
                <div class="form-group">
                    <label for="title">Title:</label>
                    <input type="text" class="form-control" id="title" name="title" 
                           value="${blog.title}" placeholder="Enter title" required>
                </div>

                <!-- Trường tóm tắt -->
                <div class="form-group">
                    <label for="summary">Summary:</label>
                    <textarea class="form-control" id="summary" name="summary" rows="3" 
                              placeholder="Enter summary" required>${blog.summary}</textarea>
                </div>

                <!-- Trường nội dung -->
                <div class="form-group">
                    <label for="content">Content:</label>
                    <textarea class="form-control" id="content" name="content" rows="8" 
                              placeholder="Enter content" required>${blog.content}</textarea>
                    <script>
                        CKEDITOR.replace('content', {
                            autoParagraph: false, // Tắt tự động bọc nội dung trong <p>
                            enterMode: CKEDITOR.ENTER_BR // Khi nhấn Enter sẽ tạo <br> thay vì <p>
                        });
                    </script>
                </div>

                <!-- Trường thumbnail (chuỗi URL) -->
                <div class="form-group">
                    <label for="thumbnail">Thumbnail (URL):</label>
                    <input type="text" class="form-control" id="thumbnail" name="thumbnail" 
                           value="${blog.thumbnail}" placeholder="URL img" required>
                </div>

                <!-- Nút submit -->
                <button type="submit" name="submit" value="update" class="btn btn-primary">Update</button>
                <a href="${pageContext.request.contextPath}/BlogController?service=listBlog" class="btn btn-secondary">Return blogs list</a> 
            </form>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>