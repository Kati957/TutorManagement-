<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>G4 SmartTutor</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- CKEditor CDN -->
        <script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
    </head>
    <body>
        <div class="container">
            <h2 class="mb-4">Update Blog</h2>
            <%-- Hiển thị thông báo lỗi nếu có --%>
            <%
                String error = (String) session.getAttribute("error");
                if (error != null) {
            %>
            <div class="alert alert-danger"><%= error%></div>
            <%
                    session.removeAttribute("error"); // Xóa sau khi hiển thị
                }
            %>
            <form action="${pageContext.request.contextPath}/staff/BlogController" method="post" enctype="multipart/form-data">
                <input type="hidden" name="service" value="updateBlog">
                <input type="hidden" name="blogID" value="${blog.blogID}">
                <!-- Trường tiêu đề -->
                <div class="form-group">
                    <label for="title">Title:</label>
                    <input type="text" class="form-control" id="title" name="title" value="${blog.title}" required>
                </div>
                <!-- Trường tóm tắt -->
                <div class="form-group">
                    <label for="summary">Summary:</label>
                    <textarea class="form-control" id="summary" name="summary" rows="3" required>${blog.summary}</textarea>
                </div>
                <!-- Trường nội dung -->
                <div class="form-group">
                    <label for="content">Content:</label>
                    <textarea class="form-control" id="content" name="content" rows="8" required>${blog.content}</textarea>
                    <script>
                        CKEDITOR.replace('content', {
                            filebrowserUploadUrl: '${pageContext.request.contextPath}/staff/BlogController?service=uploadImage',
                            extraPlugins: 'uploadimage',
                            height: 300
                        });
                    </script>
                </div>
                <!-- Trường thumbnail hiện tại -->
                <div class="form-group">
                    <label>Current Thumbnail:</label>
                    <div>
                        <img src="${pageContext.request.contextPath}/${blog.thumbnail}" alt="Current Thumbnail" style="max-width: 200px;" class="img-thumbnail">
                    </div>
                </div>
                <!-- Trường thumbnail mới (upload file) -->
                <div class="form-group">
                    <label for="thumbnail">New Thumbnail (Image File - Leave empty to keep current):</label>
                    <input type="file" class="form-control" id="thumbnail" name="thumbnail" accept="image/*">
                </div>
                <!-- Nút submit -->
                <button type="submit" name="submit" value="update" class="btn btn-primary">Update</button>
                <a href="${pageContext.request.contextPath}/staff/BlogController" class="btn btn-secondary">Back</a>
            </form>
        </div>
        <!-- Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>