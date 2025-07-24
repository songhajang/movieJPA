package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.MovieModel;
import model.entity.Movie;

@WebServlet("/test")
public class movieRankController extends HttpServlet {
	public void service( HttpServletRequest req, HttpServletResponse res) throws ServletException , IOException{
		System.out.println("dddd");
		List<Movie> result = MovieModel.getMovieList();
		result.forEach(m -> System.out.println(m));
		
		req.setAttribute("datas", result);
		req.getRequestDispatcher("index.jsp").forward(req, res);
		
	}
}
