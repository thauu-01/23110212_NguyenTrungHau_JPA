package filter;

import entity.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class RoleFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        String path = req.getServletPath();

        if (path.startsWith("/login") || path.equals("/")) {
            chain.doFilter(request, response);
            return;
        }

        if (user == null) {
            resp.sendRedirect("/login");
            return;
        }

        boolean allowed = false;
        switch (user.getRoleid()) {
            case 1: allowed = path.startsWith("/user/") || path.startsWith("/category/"); break;
            case 2: allowed = path.startsWith("/manager/") || path.startsWith("/category/"); break;
            case 3: allowed = path.startsWith("/admin/") || path.startsWith("/category/"); break;
        }

        if (allowed) {
            chain.doFilter(request, response);
        } else {
            resp.sendError(403, "Access Denied");
        }
    }
}