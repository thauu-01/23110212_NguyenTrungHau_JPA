package dao;

import entity.Category;
import entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class CategoryDAO {
    public void create(Category category) {
        EntityManager em = JPAUtil.getEntityManager();
        em.getTransaction().begin();
        try {
            em.persist(category);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public void update(Category category) {
        EntityManager em = JPAUtil.getEntityManager();
        em.getTransaction().begin();
        try {
            em.merge(category);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public void delete(int id, User currentUser) {
        EntityManager em = JPAUtil.getEntityManager();
        Category cat = em.find(Category.class, id);
        if (cat != null && cat.getUser().getId() == currentUser.getId()) {  // Chỉ xóa của chính mình
            em.getTransaction().begin();
            try {
                em.remove(cat);
                em.getTransaction().commit();
            } catch (Exception e) {
                em.getTransaction().rollback();
                e.printStackTrace();
            }
        }
        em.close();
    }

    public Category findById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Category.class, id);
        } finally {
            em.close();
        }
    }

    public List<Category> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Category> query = em.createQuery("SELECT c FROM Category c", Category.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Category> findByUserId(int userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Category> query = em.createQuery("SELECT c FROM Category c WHERE c.user.id = :userId", Category.class);
            query.setParameter("userId", userId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}