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
               query.setParameter("password", password);  
               return query.getSingleResult();
           } catch (Exception e) {
               return null;
           } finally {
               em.close();
           }
       }

       // New method to update user profile
       public void updateProfile(User user) {
           EntityManager em = JPAUtil.getEntityManager();
           em.getTransaction().begin();
           try {
               em.merge(user);  // Cập nhật đối tượng User vào DB
               em.getTransaction().commit();
           } catch (Exception e) {
               em.getTransaction().rollback();
               e.printStackTrace();
           } finally {
               em.close();
           }
       }

       // New method to find user by ID (optional, for completeness)
       public User findById(int id) {
           EntityManager em = JPAUtil.getEntityManager();
           try {
               return em.find(User.class, id);
           } finally {
               em.close();
           }
       }
   }