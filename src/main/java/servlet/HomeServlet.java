package servlet;

import dao.CategoryDAO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet({"/user/home", "/manager/home", "/admin/home"})
public class HomeServlet extends HttpServlet {
    private CategoryDAO dao = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false); // Không tạo session mới
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        List<entity.Category> categories;
        String jsp;
        switch (user.getRoleid()) {
            case 1: // User: Hiển thị tất cả category
            case 3: // Admin: Hiển thị tất cả category
                categories = dao.findAll();
                jsp = (user.getRoleid() == 1) ? "/user-home.jsp" : "/admin-home.jsp";
                break;
            case 2: // Manager: Chỉ category của chính mình
                categories = dao.findByUserId(user.getId());
                jsp = "/manager-home.jsp";
                break;
            default:
                resp.sendError(403, "Invalid role");
                return;
        }

        req.setAttribute("categories", categories);
        req.getRequestDispatcher(jsp).forward(req, resp);
    }
}