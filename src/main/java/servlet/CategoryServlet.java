package servlet;

import dao.CategoryDAO;
import entity.Category;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet({"/category/create", "/category/update", "/category/delete", "/category/view"})
public class CategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private CategoryDAO dao = new CategoryDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("/login");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        String path = req.getServletPath();
        Category cat = new Category();
        cat.setCateName(req.getParameter("cateName"));
        cat.setIcons(req.getParameter("icons"));
        cat.setUser(currentUser); 

        if (path.equals("/category/create")) {
            dao.create(cat);
        } else if (path.equals("/category/update")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Category existing = dao.findById(id);
            if (existing != null && existing.getUser().getId() == currentUser.getId()) {
                existing.setCateName(cat.getCateName());
                existing.setIcons(cat.getIcons());
                dao.update(existing);
            } else {
                resp.sendError(403, "You can only update your own category");
            }
        }
        resp.sendRedirect(getHomeUrl(currentUser.getRoleid()));
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("/login");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        String path = req.getServletPath();
        if (path.equals("/category/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Category cat = dao.findById(id);
            if (cat != null && cat.getUser().getId() == currentUser.getId()) {
                dao.delete(id, currentUser);
            } else {
                resp.sendError(403, "You can only delete your own category");
            }
            resp.sendRedirect(getHomeUrl(currentUser.getRoleid()));
        } else if (path.equals("/category/view")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Category cat = dao.findById(id);
            if (cat != null && cat.getUser().getId() == currentUser.getId()) {
                req.setAttribute("category", cat);
                req.getRequestDispatcher("/category-view.jsp").forward(req, resp);
            } else {
                resp.sendError(403, "You can only view your own category");
            }
        }
    }

    private String getHomeUrl(int roleid) {
        return switch (roleid) {
            case 1 -> "/user/home";
            case 2 -> "/manager/home";
            case 3 -> "/admin/home";
            default -> "/login";
        };
    }
}