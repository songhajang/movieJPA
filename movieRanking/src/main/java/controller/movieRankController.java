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
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        // 클라이언트에서 genreName 파라미터를 받기
        String genreName = req.getParameter("genreName");  // 예: ?genreName=Comedy
        System.out.println("[DEBUG] 전달받은 장르: " + genreName);

        List<Movie> result;

        if (genreName != null && !genreName.isEmpty()) {
            // 파라미터가 있으면 해당 장르로 필터링
            result = MovieModel.getMovieListByGenre(genreName);
        } else {
            // 파라미터가 없으면 전체 목록
            result = MovieModel.getMovieList();
        }

        // 결과 확인용 출력
        result.forEach(m -> System.out.println(m));

        // JSP로 값 전달
        req.setAttribute("datas", result);
        req.getRequestDispatcher("index.jsp").forward(req, res);
    }

}
