package model;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.persistence.EntityManager;

import jdk.incubator.vector.VectorOperators.Test;
import model.entity.Movie;
import oracle.net.aso.m;
import util.DBUtil;

public class MovieModel {
	private static MovieModel model = new MovieModel();

	private MovieModel() {}
	

	public static MovieModel getMovieModel() {
		return model;
	}
	

	/** 전체 영화 리스트 반환 */
	public static List<Movie> getMovieList() throws Exception {


		EntityManager em = DBUtil.getEntityManager();
		
		try {
			
			List<Movie> resultList = em.createQuery("select m from Movie m", Movie.class).getResultList();
			return processMovieListByTitle(resultList);
			
		} finally {
			
			em.close();
			em = null;
		}

	}
	

	/** 제목 기준 검색 */
	public static List<Movie> findByTitleLike(String text) throws Exception {

		EntityManager em = DBUtil.getEntityManager();

		try {
			
			List<Movie> rawList = em.createQuery("SELECT m FROM Movie m WHERE m.title LIKE :title", Movie.class).setParameter("title", "%" + text + "%").getResultList();
			return processMovieListByTitle(rawList);
			
		} finally {
			
			em.close();
			em = null;
		}

	}
	

	/** 장르 기준 검색 */
	public static List<Movie> getMovieListByGenre(String genreName) throws Exception{
		
		EntityManager em = DBUtil.getEntityManager();
		List<Movie> rawList = null;
		
		try {
			
			rawList = em.createQuery("SELECT m FROM Movie m WHERE m.genres LIKE :genreName", Movie.class).setParameter("genreName", "%" + genreName + "%").getResultList();
			
		} finally {
			em.close();
			em = null;
		}
		
		return processMovieListByTitle(rawList);
	}
	

	
	/** 제목 기준으로 그룹핑 → 평균 평점 계산 → 대표 Movie 추출 */
	private static List<Movie> processMovieListByTitle(List<Movie> rawList) {
		
		Map<String, List<Movie>> grouped = new LinkedHashMap<>();
		
		for (Movie m : rawList) {
			
			grouped.computeIfAbsent(m.getTitle(), k -> new ArrayList<>()).add(m);
		}
		
		List<Movie> group = null;
		double avg = 0.0;
		for (Map.Entry<String, List<Movie>> entry : grouped.entrySet()) {
			
			group = entry.getValue();
			
			avg = group.stream().mapToDouble(Movie::getRating).average().orElse(0.0);
			avg = Math.round(avg * 10.0) / 10.0;

			
			for (Movie m : group) {
				// 모든 Movie에 평균 평점 주입
				m.setRating(avg); 
			}
			
		}
		

		// 대표 Movie 하나씩 추출
		return grouped.values().stream().map(movies -> movies.get(0)).collect(Collectors.toList());
		
	}
	
	
}
