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
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DAOBlog;

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
    private void handleAddBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        DAOBlog dao = new DAOBlog();
        User user = (User) session.getAttribute("user");

        // Kiểm tra quyền (roleID = 4 mới được thêm blog)
        if (user == null || user.getRoleID() != 4) {
            response.sendRedirect("error-403.jsp");
            return;
        }

        String submit = request.getParameter("submit");
        if (submit == null) {
            // Hiển thị form nếu chưa submit
            request.getRequestDispatcher("/staff/addBlog.jsp").forward(request, response);
            return;
        }

        // Lấy dữ liệu từ form
        String title = request.getParameter("title");
        String summary = request.getParameter("summary");
        String content = request.getParameter("content");
        String thumbnail = request.getParameter("thumbnail");

        try {
            // Lấy thông tin từ session
            String authorName = user.getFullName();
            int staffID = dao.getStaffIDByUsername(user.getFullName()); // Lấy staffID từ username

            // Lấy thời gian hiện tại
            Timestamp createdAt = new Timestamp(System.currentTimeMillis());

            // Tạo đối tượng Blog
            Blog blog = new Blog(0, staffID, authorName, thumbnail, title, content, createdAt, summary);

            // Thêm vào database bằng insertBlog
            int n = dao.insertBlog(blog);

            if (n > 0) {
                response.sendRedirect(request.getContextPath() + "/BlogController?service=listBlog");
            } else {
                request.setAttribute("error", "Update Fail!");
                request.getRequestDispatcher("/staff/addBlog.jsp").forward(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BlogController.class.getName()).log(Level.SEVERE, "Database error", ex);
            request.setAttribute("error", "Database may have problems: " + ex.getMessage());
            request.getRequestDispatcher("/staff/addBlog.jsp").forward(request, response);
        }
    }

    // Xử lý cập nhật bài viết
    private void handleUpdateBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        DAOBlog dao = new DAOBlog();
        User user = (User) session.getAttribute("user");

        // Kiểm tra quyền (roleID = 4 mới được cập nhật blog)
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
            Blog blog = dao.getBlogById(blogID);
            if (blog == null) {
                response.sendRedirect("error-404.jsp");
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
            String thumbnail = request.getParameter("thumbnail");

            // Giữ nguyên staffID và authorName
            Timestamp updatedAt = new Timestamp(System.currentTimeMillis());

            // Cập nhật đối tượng Blog
            blog.setTitle(title);
            blog.setSummary(summary);
            blog.setContent(content);
            blog.setThumbnail(thumbnail);
            blog.setCreatedAt(updatedAt); // Cập nhật thời gian

            // Cập nhật vào database
            int n = dao.updateBlog(blog);

            if (n > 0) {
                response.sendRedirect(request.getContextPath() + "/BlogController?service=listBlog");
            } else {
                request.setAttribute("error", "Update Fail!");
                request.setAttribute("blog", blog);
                request.getRequestDispatcher("/staff/updateBlog.jsp").forward(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BlogController.class.getName()).log(Level.SEVERE, "Database error", ex);
            request.setAttribute("error", "Database may have problems:" + ex.getMessage());
            request.getRequestDispatcher("/staff/updateBlog.jsp").forward(request, response);
        }
    }

    // Xử lý xóa bài viết
    private void handleDeleteBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        DAOBlog dao = new DAOBlog();
        User user = (User) session.getAttribute("user");

        // Kiểm tra quyền (roleID = 4 mới được xóa blog)
        if (user == null || user.getRoleID() != 3) {
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
                response.sendRedirect(request.getContextPath() + "/BlogController?service=listBlog");
            } else {
                request.setAttribute("error", "Xóa bài viết thất bại!");
                request.getRequestDispatcher("/staff/blog.jsp").forward(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BlogController.class.getName()).log(Level.SEVERE, "Database error", ex);
            request.setAttribute("error", "Lỗi cơ sở dữ liệu: " + ex.getMessage());
            request.getRequestDispatcher("/staff/blog.jsp").forward(request, response);
        }
    }

//    // 📝 Xử lý hiển thị danh sách blog và recent blogs
//    private void handleListBlog(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        DAOBlog dao = new DAOBlog();
//        try {
//            List<Blog> blogList = dao.getAllBlogs(); // Lấy danh sách tất cả blog từ DB
//            List<Blog> recentBlogs = dao.getRecentBlogs(3); // Lấy 3 blog gần nhất
//            List<Blog> galleryBlogs = dao.getRecentThumbnails(8);
//            request.setAttribute("blogList", blogList); // Gán danh sách blog vào request
//            request.setAttribute("recentBlogs", recentBlogs); // Gán danh sách blog gần đây vào request
//            request.setAttribute("galleryBlogs", galleryBlogs); // Gallery thumbnails
//            request.getRequestDispatcher("/staff/blog.jsp").forward(request, response);
//        } catch (SQLException ex) {
//            Logger.getLogger(BlogController.class.getName()).log(Level.SEVERE, null, ex);
//            response.sendRedirect("error-404.jsp");
//        }
//    }
     // 📝 Xử lý hiển thị danh sách blog và recent blogs
    private void handleListBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAOBlog dao = new DAOBlog();
        try {
            int pageSize = 5; // 5 blog mỗi trang
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
