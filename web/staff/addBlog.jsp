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
            <h2 class="mb-4">Thêm Bài Viết Mới</h2>

            <%-- Hiển thị thông báo lỗi nếu có --%>
            <%
                String error = (String) request.getAttribute("error");
                if (error != null) {
            %>
            <div class="alert alert-danger"><%= error%></div>
            <%
                }
            %>

            <form action="BlogController" method="post">
                <input type="hidden" name="service" value="addBlog">

                <!-- Trường tiêu đề -->
                <div class="form-group">
                    <label for="title">Title:</label>
                    <input type="text" class="form-control" id="title" name="title" placeholder="Enter title" required>
                </div>

                <!-- Trường tóm tắt -->
                <div class="form-group">
                    <label for="summary">Summary:</label>
                    <textarea class="form-control" id="summary" name="summary" rows="3" placeholder="Enter summary" required></textarea>
                </div>

                <!-- Trường nội dung -->
                <div class="form-group">
                    <label for="content">Content:</label>
                    <textarea class="form-control" id="content" name="content" rows="8" placeholder="Enter content" required></textarea>
                    <script>
                        CKEDITOR.replace('content', {
                            autoParagraph: false, // Tắt tự động bọc nội dung trong <p>
                            enterMode: CKEDITOR.ENTER_BR, // Khi nhấn Enter sẽ tạo <br> thay vì <p>
                            // Bạn có thể thêm các tùy chọn khác nếu cần
                        });
                    </script>
                </div>


                <!-- Trường thumbnail (chuỗi URL) -->
                <div class="form-group">
                    <label for="thumbnail">Thumbnail (URL):</label>
                    <input type="text" class="form-control" id="thumbnail" name="thumbnail" placeholder="URL img" required>
                </div>

                <!-- Nút submit -->
                <button type="submit" name="submit" value="publish" class="btn btn-primary">Đăng bài</button>
            </form>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>