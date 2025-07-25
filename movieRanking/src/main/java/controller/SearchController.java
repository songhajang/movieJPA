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

@WebServlet("/search")
public class SearchController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String title = req.getParameter("search");

		String viewUrl = "/failView/failBySearch.jsp";

		if (title == null || title.trim().isEmpty()) {
			
			res.sendRedirect("home");
			
		} else {

			// 제목 검색
			List<Movie> movies = null;
			
			try {
				movies = MovieModel.findByTitleLike(title);
				
				if (movies != null && !movies.isEmpty()) {

					req.setAttribute("datas", movies);
					viewUrl = "/successView/successBySearch.jsp";

				} else {

					req.setAttribute("msg", "검색 결과가 없습니다.");
					
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				res.sendRedirect("failView/failConnection");
			}

			
		

			req.setAttribute("title", title);
			req.getRequestDispatcher(viewUrl).forward(req, res);
		}

	}
}
