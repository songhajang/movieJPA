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

@WebServlet("/home")
public class HomeController extends HttpServlet {
	
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        
        List<Movie> movies = null;
		try {
			movies = MovieModel.getMovieList();
			req.setAttribute("datas", movies);
			req.getRequestDispatcher("index.jsp").forward(req, res);
			
		} catch (Exception e) {
			res.sendRedirect("failView/failConnection.jsp");
			e.printStackTrace();


		}

    }
    
}