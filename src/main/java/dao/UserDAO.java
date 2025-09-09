package dao;

import entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

public class UserDAO {
    public User login(String username, String password) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<User> query = em.createQuery("SELECT u FROM User u WHERE u.username = :username AND u.password = :password", User.class);
            query.setParameter("username", username);
            query.setParameter("password", password);  // Nên hash password thực tế
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }
}