package util;
import java.io.IOException;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import org.junit.Test;
public class DBUtil {
    private static EntityManagerFactory emf;
    static {
        try {
            emf = Persistence.createEntityManagerFactory("movieProject");
        } catch (Exception e) {
            System.err.println("❌ EntityManagerFactory 초기화 실패: " + e.getMessage());
            e.printStackTrace(); // 콘솔에 전체 예외 출력
        }
    }

    public static EntityManager getEntityManager() throws Exception {
        if (emf == null) {
            System.err.println("⚠ EntityManagerFactory가 null입니다. getEntityManager() 실패");
            return null; // 예외 대신 null 반환
        }
        return emf.createEntityManager();
    }
//    @Test
//    public void test() {
//        System.out.println(getEntityManager());
//    }
}