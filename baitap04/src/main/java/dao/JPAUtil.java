package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAUtil {
    private static EntityManagerFactory factory = Persistence.createEntityManagerFactory("dataSource");

    public static EntityManager getEntityManager() {
        return factory.createEntityManager();
    }

    public static void shutdown() {
        factory.close();
    }
}