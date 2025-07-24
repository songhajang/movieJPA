package model;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

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
	
	
	/**  카테고리별 검색 함수
	 * @param String category
	 * @param String title
	 */
	
	public static List<Movie> findByTitleLike(String category, String text){
		EntityManager em = DBUtil.getEntityManager();
		
	        TypedQuery<Movie> query = em.createQuery("select m from Movie m where m.title LIKE :title AND m.genres LIKE :genres", Movie.class);
	        query.setParameter("title", "%" + text + "%");
	        query.setParameter("genres", "%" + category + "%");

	        return query.getResultList();
	}
	
	
}
