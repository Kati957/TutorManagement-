package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Set;
import entity.User;

@WebFilter("/*")
public class AuthorizationFilter implements Filter {

    private static final boolean debug = true;

    private static final Set<String> ADMIN_URLS = Set.of(
            "/admin/index.html", "/admin/add-listing.html", "/admin/basic-calendar.html", "/admin/courses.html",
            "/admin/list-view-calendar.html", "/admin/mailbox.html", "/admin/mailbox-compose.html", "/admin/mailbox-read.html",
            "/admin/review.html", "/admin/teacher-profile.html", "/admin/user-profile.html","/admin/staff-management.html"
    );

    private static final Set<String> STAFF_URLS = Set.of(
            "/admin/index.html", "/admin/basic-calendar.html", "/admin/add-listing.html", "/admin/courses.html", "/admin/list-view-calendar.html",
            "/admin/mailbox.html", "/admin/mailbox-compose.html", "/admin/mailbox-read.html", "/admin/review.html", "/admin/user-profile.html"
    );

    private static final Set<String> TUTOR_URLS = Set.of(
            "/admin/basic-calendar.html", "/admin/bookmark.html", "/admin/courses.html", "/admin/list-view-calendar.html",
            "/admin/mailbox.html", "/admin/mailbox-compose.html", "/admin/mailbox-read.html", "/admin/review.html", "/admin/teacher-profile.html"
    );

    private static final Set<String> USER_URLS = Set.of(
            "/admin/basic-calendar.html", "/admin/bookmark.html", "/admin/courses.html", "/admin/list-view-calendar.html",
            "/admin/mailbox.html", "/admin/mailbox-compose.html", "/admin/mailbox-read.html", "/admin/review.html", "/admin/user-profile.html"
    );

    private FilterConfig filterConfig = null;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        if (debug) {
            log("AuthorizationFilter:doFilter()");
        }

        doBeforeProcessing(request, response);

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());

        if (!isRestricted(path)) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = httpRequest.getSession(false);
        User user = (User) session.getAttribute("user");

        boolean hasAccess = switch (user.getRoleID()) {
            case 2 -> USER_URLS.contains(path);
            case 3 -> STAFF_URLS.contains(path);
            case 4 -> TUTOR_URLS.contains(path);
            case 5 -> ADMIN_URLS.contains(path);
            default -> false;
        };

        if (!hasAccess) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/error-403.html");
            return;
        }

        chain.doFilter(request, response);

        doAfterProcessing(request, response);
    }

    private boolean isRestricted(String path) {
        return ADMIN_URLS.contains(path) || STAFF_URLS.contains(path)
                || TUTOR_URLS.contains(path) || USER_URLS.contains(path);
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AuthorizationFilter:DoBeforeProcessing");
        }
        // Thêm mã xử lý trước khi tiếp tục chuỗi lọc (nếu cần)
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AuthorizationFilter:DoAfterProcessing");
        }
        // Thêm mã xử lý sau khi hoàn thành chuỗi lọc (nếu cần)
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);

        if (stackTrace != null && !stackTrace.isEmpty()) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n");
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>");
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
                // Xử lý ngoại lệ khi gửi lỗi
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
                // Xử lý ngoại lệ khi in stack trace
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
            // Xử lý ngoại lệ khi lấy stack trace
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("AuthorizationFilter:Initializing filter");
            }
        }
    }

    @Override
    public void destroy() {
        // Thực hiện các tác vụ khi hủy filter (nếu cần)
    }
}
