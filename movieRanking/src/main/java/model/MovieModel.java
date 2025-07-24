package model;

import java.util.List;

import javax.persistence.EntityManager;

import model.entity.Movie;
import util.DBUtil;

public class MovieModel {
	private static MovieModel model = new MovieModel();
	
	private MovieModel() {}
	
	public static MovieModel getMovieModel() {
		return model;
	}
	
	// TODO: sql 코드 작성 예정
	public static List<Movie> getMovieList() {
		EntityManager em = DBUtil.getEntityManager();
		
		return em.createQuery("select m from Movie m", Movie.class).getResultList();
		
	}
	
	/**장르(카테고리) 클릭시 해당 장르에 대한 영화들 리스트로 반환
	 * @param String genreName
	 * @return
	 */
	
	public static List<Movie> getMovieListByGenre(String genreName) {
	    EntityManager em = DBUtil.getEntityManager();
	    try {
	        // genres 컬럼에 genreName이 포함된 데이터를 조회
	        return em.createQuery(
	                "SELECT m FROM Movie m WHERE m.genres LIKE :genreName", Movie.class)
	                 .setParameter("genreName", "%" + genreName + "%")
	                 .getResultList();
	    } finally {
	        em.close(); // 자원 정리
	    }
	}
	
	
}
