package controller.Staff;

import entity.Blog;
import entity.User;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.sql.Timestamp;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.nio.file.Paths;
import model.DAOBlog;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
@WebServlet(name = "BlogController", urlPatterns = {"/staff/BlogController"})
public class BlogController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String service = request.getParameter("service");

        if (service == null) {
            service = "listBlog"; // Mặc định hiển thị danh sách blog
        }

        switch (service) {
            case "addBlog":
                handleAddBlog(request, response);
                break;
            case "listBlog":
                handleListBlog(request, response);
                break;
            case "detailBlog":
                handleDetailBlog(request, response);
                break;
            case "searchBlog":
                handleSearchBlog(request, response);
                break;
            case "updateBlog":
                handleUpdateBlog(request, response);
                break;
            case "deleteBlog":
                handleDeleteBlog(request, response);
                break;
            default:
                response.sendRedirect("error-404.jsp");
        }
    }

    // ? Xử lý thêm bài viết
//    private void handleAddBlog(HttpServletRequest request, HttpServletResponse response)
//        throws ServletException, IOException {
//    response.setContentType("text/html;charset=UTF-8");
//    HttpSession session = request.getSession();
//    DAOBlog dao = new DAOBlog();
//    User user = (User) session.getAttribute("user");
//
//    if (user == null || user.getRoleID() != 4) {
//        response.sendRedirect(request.getContextPath() + "/error-403.jsp");
//        return;
//    }
//
//    String submit = request.getParameter("submit");
//    if (submit == null) {
//        // Hiển thị form thêm blog
//        response.sendRedirect(request.getContextPath() + "/staff/addBlog.jsp");
//        return;
//    }
//
//    String title = request.getParameter("title");
//    String summary = request.getParameter("summary");
//    String content = request.getParameter("content");
//    String thumbnail = handleFileUpload(request);
//
//    if (thumbnail == null) {
//        session.setAttribute("error", "Thumbnail upload failed or invalid file type.");
//        response.sendRedirect(request.getContextPath() + "/staff/BlogController?service=addBlog");
//        return;
//    }
//
//    try {
//        String authorName = user.getFullName();
//        int staffID = dao.getStaffIDByUsername(authorName);
//
//        Timestamp createdAt = new Timestamp(System.currentTimeMillis());
//        Blog blog = new Blog(0, staffID, authorName, thumbnail, title, content, createdAt, summary);
//
//        int n = dao.insertBlog(blog);
//        if (n > 0) {
//            response.sendRedirect(request.getContextPath() + "/staff/BlogController?service=listBlog&message=addSuccess");
//        } else {
//            session.setAttribute("error", "Add Fail!");
//            response.sendRedirect(request.getContextPath() + "/staff/BlogController?service=addBlog");
//        }
//    } catch (SQLException ex) {
//        Logger.getLogger(BlogController.class.getName()).log(Level.SEVERE, "Database error", ex);
//        session.setAttribute("error", "Database error: " + ex.getMessage());
//        response.sendRedirect(request.getContextPath() + "/staff/BlogController?service=addBlog");
//    }
//}
    private void handleAddBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        DAOBlog dao = new DAOBlog();
        User user = (User) session.getAttribute("user");

        // Kiểm tra quyền (roleID = 4 mới được thêm blog)
        if (user == null || user.getRoleID() != 4) {
            response.sendRedirect(request.getContextPath() + "/error-403.jsp");
            return;
        }

        String submit = request.getParameter("submit");
        if (submit == null) {
            // Hiển thị form thêm blog
            request.getRequestDispatcher("/staff/addBlog.jsp").forward(request, response);
            return;
        }

        // Lấy dữ liệu từ form
        String title = request.getParameter("title");
        String summary = request.getParameter("summary");
        String content = request.getParameter("content");

        // Kiểm tra dữ liệu đầu vào
        if (title == null || title.trim().isEmpty() || summary == null || summary.trim().isEmpty()
                || content == null || content.trim().isEmpty()) {
            session.setAttribute("error", "All fields (Title, Summary, Content) are required!");
            response.sendRedirect(request.getContextPath() + "/staff/BlogController?service=addBlog");
            return;
        }

        String thumbnail = handleFileUpload(request); // Xử lý upload file
        if (thumbnail == null) {
            session.setAttribute("error", "Thumbnail upload failed or invalid file type. Please upload a valid image (jpg, jpeg, png, gif).");
            response.sendRedirect(request.getContextPath() + "/staff/BlogController?service=addBlog");
            return;
        }

        try {
            // Lấy thông tin từ session
            String authorName = user.getFullName();
            int staffID;
            try {
                staffID = dao.getStaffIDByUsername(authorName); // Lấy staffID từ username
                if (staffID <= 0) {
                    throw new SQLException("Invalid StaffID retrieved.");
                }
            } catch (SQLException e) {
                session.setAttribute("error", "Staff ID not found for user: " + authorName);
                response.sendRedirect(request.getContextPath() + "/staff/BlogController?service=addBlog");
                return;
            }

            // Lấy thời gian hiện tại
            Timestamp createdAt = new Timestamp(System.currentTimeMillis());

            // Tạo đối tượng Blog
            Blog blog = new Blog(0, staffID, authorName, thumbnail, title, content, createdAt, summary);

            // Thêm vào database bằng insertBlog
            int n = dao.insertBlog(blog);

            if (n > 0) {
                session.removeAttribute("error"); // Xóa lỗi nếu thành công
                response.sendRedirect(request.getContextPath() + "/staff/BlogController?service=listBlog&message=addSuccess");
            } else {
                session.setAttribute("error", "Add Fail! Please try again.");
                response.sendRedirect(request.getContextPath() + "/staff/BlogController?service=addBlog");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BlogController.class.getName()).log(Level.SEVERE, "Database error", ex);
            session.setAttribute("error", "Database error: " + ex.getMessage());
            response.sendRedirect(request.getContextPath() + "/staff/BlogController?service=addBlog");
        }
    }

    private void handleUpdateBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        DAOBlog dao = new DAOBlog();
        User user = (User) session.getAttribute("user");

        // Kiểm tra quyền (roleID = 4 mới được cập nhật blog)
        if (user == null || user.getRoleID() != 4) {
            response.sendRedirect(request.getContextPath() + "/error-403.jsp");
            return;
        }

        String blogIDStr = request.getParameter("blogID");
        if (blogIDStr == null || blogIDStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/error-404.jsp");
            return;
        }

        int blogID;
        try {
            blogID = Integer.parseInt(blogIDStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/error-404.jsp");
            return;
        }

        try {
            Blog blog = dao.getBlogById(blogID);
            if (blog == null) {
                response.sendRedirect(request.getContextPath() + "/error-404.jsp");
                return;
            }

            String submit = request.getParameter("submit");
            if (submit == null) {
                // Hiển thị form cập nhật
                request.setAttribute("blog", blog);
                request.getRequestDispatcher("/staff/updateBlog.jsp").forward(request, response);
                return;
            }

            // Lấy dữ liệu từ form
            String title = request.getParameter("title");
            String summary = request.getParameter("summary");
            String content = request.getParameter("content");

            // Xử lý upload file thumbnail (nếu có)
            String thumbnail = handleFileUpload(request); // Thử upload file mới
            if (thumbnail == null) {
                // Nếu không upload file mới, giữ nguyên thumbnail cũ
                thumbnail = blog.getThumbnail();
            }

            // Kiểm tra dữ liệu đầu vào
            if (title == null || title.trim().isEmpty() || summary == null || summary.trim().isEmpty()
                    || content == null || content.trim().isEmpty()) {
                session.setAttribute("error", "All fields (Title, Summary, Content) are required!");
                response.sendRedirect(request.getContextPath() + "/staff/BlogController?service=updateBlog&blogID=" + blogID);
                return;
            }

            Timestamp updatedAt = new Timestamp(System.currentTimeMillis());

            // Cập nhật đối tượng Blog
            blog.setTitle(title);
            blog.setSummary(summary);
            blog.setContent(content);
            blog.setThumbnail(thumbnail);
            blog.setCreatedAt(updatedAt); // Sử dụng updatedAt thay vì createdAt

            // Cập nhật vào database
            int n = dao.updateBlog(blog);

            if (n > 0) {
                session.removeAttribute("error"); // Xóa lỗi nếu thành công
                response.sendRedirect(request.getContextPath() + "/staff/BlogController?service=listBlog&message=updateSuccess");
            } else {
                session.setAttribute("error", "Update Fail!");
                response.sendRedirect(request.getContextPath() + "/staff/BlogController?service=updateBlog&blogID=" + blogID);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BlogController.class.getName()).log(Level.SEVERE, "Database error", ex);
            session.setAttribute("error", "Database error: " + ex.getMessage());
            response.sendRedirect(request.getContextPath() + "/staff/BlogController?service=updateBlog&blogID=" + blogID);
        }
    }

    // Xử lý xóa bài viết
    private void handleDeleteBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        DAOBlog dao = new DAOBlog();
        User user = (User) session.getAttribute("user");

        // Kiểm tra quyền (roleID = 4 mới được xóa blog)
        if (user == null || user.getRoleID() != 4) {
            response.sendRedirect("error-403.jsp");
            return;
        }

        String blogIDStr = request.getParameter("blogID");
        if (blogIDStr == null || blogIDStr.isEmpty()) {
            response.sendRedirect("error-404.jsp");
            return;
        }

        int blogID;
        try {
            blogID = Integer.parseInt(blogIDStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("error-404.jsp");
            return;
        }

        try {
            int n = dao.deleteBlog(blogID);
            if (n > 0) {
                response.sendRedirect(request.getContextPath() + "/staff/BlogController?service=listBlog&message=deleteSuccess");
            } else {
                request.setAttribute("error", "Xóa bài viết thất bại!");
                request.getRequestDispatcher("/staff/blog.jsp").forward(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BlogController.class.getName()).log(Level.SEVERE, "Database error", ex);
        }
    }

    private void handleListBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAOBlog dao = new DAOBlog();
        try {
            int pageSize = 6; // 6 blog mỗi trang
            String pageStr = request.getParameter("page");
            int page = (pageStr == null || pageStr.isEmpty()) ? 1 : Integer.parseInt(pageStr);
            List<Blog> recentBlogs = dao.getRecentBlogs(3); // Lấy 3 blog cho Recent Posts
            // Lấy 6 blog gần nhất với đầy đủ thông tin thumbnail
            List<Blog> galleryBlogs = dao.getRecentThumbnails(8);

            int totalBlogs = dao.getTotalBlogs(); // Giả sử trả về 7
            int totalPages = (int) Math.ceil((double) totalBlogs / pageSize); // 7 / 5 = 1.4 -> 2 trang

            // Giới hạn page trong khoảng 1 đến totalPages
            if (page < 1) {
                page = 1;
            }
            if (page > totalPages) {
                page = totalPages;
            }

            List<Blog> blogList = dao.getBlogsByPage(page, pageSize);
            request.setAttribute("blogList", blogList);
            request.setAttribute("totalPages", totalPages); // 2
            request.setAttribute("currentPage", page);
            request.setAttribute("recentBlogs", recentBlogs); // Recent Posts
            request.setAttribute("galleryBlogs", galleryBlogs); // Gallery thumbnails
            request.getRequestDispatcher("/staff/blog.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(BlogController.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("error", "error: " + ex.getMessage());
            response.sendRedirect("error-404.jsp"); // Redirect nếu không có bài viết hoặc lỗi
        }
    }

    private String handleFileUpload(HttpServletRequest request) throws IOException, ServletException {
        Part filePart = request.getPart("thumbnail");
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        if (!isImageFile(fileName)) {
            return null;
        }

        // Use a more reliable path
        String applicationPath = request.getServletContext().getRealPath("");
        String uploadPath = applicationPath + File.separator + "uploads";

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Generate a unique filename to prevent overwriting
        String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
        String fullPath = uploadPath + File.separator + uniqueFileName;

        // Write the file
        try (InputStream inputStream = filePart.getInputStream(); FileOutputStream outputStream = new FileOutputStream(fullPath)) {

            byte[] buffer = new byte[8192];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
        }

        return "uploads/" + uniqueFileName;
    }

    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] items = contentDisposition.split(";");
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf("=") + 2, item.length() - 1);
            }
        }
        return null;
    }

    private boolean isImageFile(String fileName) {
        String[] allowedExtensions = {".jpg", ".jpeg", ".png", ".gif"};
        for (String ext : allowedExtensions) {
            if (fileName.toLowerCase().endsWith(ext)) {
                return true;
            }
        }
        return false;
    }

    private void handleDetailBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAOBlog dao = new DAOBlog();
        String blogIDStr = request.getParameter("blogID");

        if (blogIDStr != null && !blogIDStr.isEmpty()) {
            try {
                int blogID = Integer.parseInt(blogIDStr);
                Blog blog = dao.getBlogById(blogID);
                List<Blog> recentBlogs = dao.getRecentBlogs(3); // Lấy 3 blog cho Recent Posts
                // Lấy 6 blog gần nhất với đầy đủ thông tin thumbnail
                List<Blog> galleryBlogs = dao.getRecentThumbnails(8);

                if (blog != null) {
                    request.setAttribute("blog", blog); // Blog chi tiết
                    request.setAttribute("recentBlogs", recentBlogs); // Recent Posts
                    request.setAttribute("galleryBlogs", galleryBlogs); // Gallery thumbnails
                    request.getRequestDispatcher("/staff/blog-details-staff.jsp").forward(request, response);
                    return;
                }
            } catch (SQLException ex) {
                Logger.getLogger(BlogController.class.getName()).log(Level.SEVERE, "Database error", ex);
            } catch (NumberFormatException ex) {
                Logger.getLogger(BlogController.class.getName()).log(Level.SEVERE, "Invalid blogID", ex);
            }
        }
        response.sendRedirect("error-404.jsp"); // Redirect nếu không có bài viết hoặc lỗi
    }

    // Xử lý tìm kiếm blog và lọc trong blogList
    private void handleSearchBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAOBlog dao = new DAOBlog();
        String keyword = request.getParameter("text");
        try {
            List<Blog> blogList;
            if (keyword == null || keyword.trim().isEmpty()) {
                blogList = dao.getAllBlogs();
            } else {
                blogList = dao.searchBlogs(keyword);
            }
            // Thêm recent blogs
            List<Blog> recentBlogs = dao.getRecentBlogs(3); // Lấy top 3 recent blogs
            List<Blog> galleryBlogs = dao.getRecentThumbnails(8);
            request.setAttribute("blogList", blogList);
            request.setAttribute("recentBlogs", recentBlogs); // Đảm bảo recentBlogs được set
            request.setAttribute("keyword", keyword);
            request.setAttribute("galleryBlogs", galleryBlogs); // Gallery thumbnails

            request.getRequestDispatcher("/staff/blog.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(BlogController.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("error-404.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Blog Controller Servlet";
    }
}
