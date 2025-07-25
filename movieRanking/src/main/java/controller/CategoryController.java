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

@WebServlet("/genre")
public class CategoryController extends HttpServlet {
	
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    	
    	String viewUrl = "/failView/failByCategory.jsp";
        String genre = req.getParameter("genre");

        List<Movie> movies = null;
		try {
			movies = MovieModel.getMovieListByGenre(genre);
		} catch (Exception e) {
			e.printStackTrace();
			res.sendRedirect("failView/failConnection.jsp");
		}
                
        if (movies != null && !movies.isEmpty()) {
        	
            req.setAttribute("datas", movies);
            req.setAttribute("genre", genre); // 뷰에서 장르명 출력용
            
            viewUrl = "/successView/successByCategory.jsp";
            
        } else {
        	
            req.setAttribute("msg", genre + " 장르의 영화가 없습니다.");
        
        }

        req.getRequestDispatcher(viewUrl).forward(req, res);
    }
}
