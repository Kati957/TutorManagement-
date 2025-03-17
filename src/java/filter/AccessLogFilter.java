package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import entity.User;
import model.DAOHistoryLog;

@WebFilter("/*")
public class AccessLogFilter implements Filter {

    // Danh sách các đuôi file (extension) của tài nguyên tĩnh cần bỏ qua
    private static final Set<String> STATIC_EXTENSIONS = new HashSet<>(Arrays.asList(
            ".js", ".png", ".jpg", ".jpeg", ".woff", ".woff2", ".css", ".ico"
    ));

    // Danh sách các đường dẫn cần bỏ qua
    private static final Set<String> EXCLUDED_PATHS = new HashSet<>(Arrays.asList(
            "/error-404.jsp",
            "/assets/",
            "/uploads/"
    ));

    private DAOHistoryLog dao;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo DAOHistoryLog một lần khi filter được khởi tạo
        dao = new DAOHistoryLog();
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;

        // Lấy đường dẫn request
        String path = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String relativePath = path.substring(contextPath.length());

        // Kiểm tra xem request có nên được ghi log hay không
        if (!shouldLogRequest(relativePath)) {
            chain.doFilter(request, response);
            return;
        }

        // Lấy thông tin user từ session (nếu có)
        HttpSession session = httpRequest.getSession(false);
        Integer userId = null;
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            userId = user.getUserID();
        }

        // Ghi log
        try {
            if (userId != null) {
                dao.logPageAccess(userId, path); // Ghi log với userId
            } else {
                dao.logAction(0, "ACCESS_PAGE", null, "Guest accessed page: " + path); // Ghi log cho guest
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý lỗi khi ghi log
        }

        // Tiếp tục chuỗi filter
        chain.doFilter(request, response);
    }

    // Kiểm tra xem request có nên được ghi log hay không
    private boolean shouldLogRequest(String path) {
        // Bỏ qua nếu path nằm trong EXCLUDED_PATHS
        for (String excludedPath : EXCLUDED_PATHS) {
            if (path.startsWith(excludedPath)) {
                return false;
            }
        }

        // Bỏ qua nếu path kết thúc bằng các đuôi file tĩnh
        for (String extension : STATIC_EXTENSIONS) {
            if (path.toLowerCase().endsWith(extension)) {
                return false;
            }
        }

        return true;
    }

    @Override
    public void destroy() {
        // Đóng kết nối khi filter bị hủy
        if (dao != null) {
            dao.closeConnection();
        }
    }
}