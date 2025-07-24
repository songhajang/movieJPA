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
	
	
}
