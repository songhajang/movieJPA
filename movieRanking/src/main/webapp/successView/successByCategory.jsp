<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko" class="transition-colors duration-500">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>영화 추천 사이트</title>
    <link rel="css/style.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {
                        prism: {
                            pink: '#ff4d8c',
                            purple: '#7f5af0',
                            neon: '#00ffd5',
                        },
                    }
                }
            }
        };
    </script>
    
</head>

<body class="bg-gray-100 text-gray-900 dark:bg-zinc-900 dark:text-gray-100 transition-colors duration-500">

    <!-- 전체 레이아웃 메인 콘텐츠 -->
    <div id="main-content" class="flex min-h-screen" tabindex="-1" aria-hidden="true">

        <!-- 왼쪽 사이드바 -->
        <aside class="w-64 bg-white dark:bg-zinc-800 p-6 shadow-md hidden md:flex md:flex-col md:justify-between">
            <div>
                <h2 class="text-2xl font-bold mb-4 text-indigo-600 dark:text-red-500">카테고리</h2>
                <ul class="space-y-3 font-medium text-gray-700 dark:text-gray-300">
                    <li><a href="genre?genre=Fantasy" class="${requestScope.genre == 'Fantasy' ? 'font-bold text-indigo-600' : ''}">판타지</a></li>
					<li><a href="genre?genre=Children" class="${requestScope.genre == 'Children' ? 'font-bold text-indigo-600' : ''}">어린이</a></li>
					<li><a href="genre?genre=Animation" class="${requestScope.genre == 'Animation' ? 'font-bold text-indigo-600' : ''}">애니메이션</a></li>
					<li><a href="genre?genre=Adventure" class="${requestScope.genre == 'Adventure' ? 'font-bold text-indigo-600' : ''}">어드벤처</a></li>
					<li><a href="genre?genre=Comedy" class="${requestScope.genre == 'Comedy' ? 'font-bold text-indigo-600' : ''}">코미디</a></li>
					<li><a href="genre?genre=Romance" class="${requestScope.genre == 'Romance' ? 'font-bold text-indigo-600' : ''}">로맨스</a></li>
					<li><a href="genre?genre=Action" class="${requestScope.genre == 'Action' ? 'font-bold text-indigo-600' : ''}">액션</a></li>
					<li><a href="genre?genre=Crime" class="${requestScope.genre == 'Crime' ? 'font-bold text-indigo-600' : ''}">크라임</a></li>
					<li><a href="genre?genre=Thriller" class="${requestScope.genre == 'Thriller' ? 'font-bold text-indigo-600' : ''}">스릴러</a></li>
					<li><a href="genre?genre=Horror" class="${requestScope.genre == 'Horror' ? 'font-bold text-indigo-600' : ''}">호러</a></li>
					<li><a href="genre?genre=Drama" class="${requestScope.genre == 'Drama' ? 'font-bold text-indigo-600' : ''}">드라마</a></li>
					<li><a href="genre?genre=Sci-Fi" class="${requestScope.genre == 'Sci-Fi' ? 'font-bold text-indigo-600' : ''}">SF</a></li>
					<li><a href="genre?genre=Mystery" class="${requestScope.genre == 'Mystery' ? 'font-bold text-indigo-600' : ''}">미스터리</a></li>
					<li><a href="genre?genre=Musical" class="${requestScope.genre == 'Musical' ? 'font-bold text-indigo-600' : ''}">뮤지컬</a></li>
                </ul>
            </div>
        </aside>

        <!-- 메인 컨텐츠 -->
        <div class="flex-1 flex flex-col">

            <!-- 헤더 -->
            <header class="bg-white dark:bg-zinc-800 shadow-sm px-6 py-4 flex items-center justify-between">
                    
                <a href="home">
                	<h1 class="text-xl font-bold text-indigo-600 dark:text-red-500"> 🎬 ${requestScope.genre} 무비무비</h1>
                </a>
                
                <form action="search" method="get" class="flex items-center gap-4 w-1/2 h-full">
                    <input type="text" name="search" placeholder="영화 제목을 검색하세요"
                        class="w-full px-4 py-2 border border-gray-300 dark:border-zinc-600 rounded-lg shadow-sm bg-white dark:bg-zinc-700 text-black dark:text-white placeholder-gray-400 dark:placeholder-gray-500 focus:ring-2 focus:ring-indigo-300 dark:focus:ring-red-400 focus:outline-none" />
                    <button type="submit" aria-label="검색하기"
                        class=" border border-gray-300 dark:border-zinc-600 rounded-lg shadow-sm bg-white dark:bg-zinc-700  p-2.5 text-gray-500 dark:text-gray-300 hover:text-indigo-600 dark:hover:text-red-400 focus:outline-none">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24"
                            stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                d="M21 21l-4.35-4.35M11 19a8 8 0 1 0 0-16 8 8 0 0 0 0 16z" />
                        </svg>
                    </button>
                </form>
            </header>

            <!-- 카드 리스트 -->
             <main class="p-6 grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
            <c:choose>
                <c:when test="${empty requestScope.datas}">
                    <div class="col-span-full text-center text-gray-400 dark:text-gray-500 text-lg mt-10">
                        해당 카테고리에 영화가 없습니다.
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="movie" items="${requestScope.datas}">
                        <div class="card-hover cursor-pointer dark:hover:bg-[#1e1b4b] dark:bg-zinc-800 bg-white rounded-xl p-5 shadow-md h-52 flex flex-col justify-center items-center">
                            <h3 class="text-xl font-bold mb-1 text-center">${movie.title}</h3>
                            <br>
                            <h5 class="text-xl font-bold mb-1 text-center"> ⭐ ${movie.rating}</h5>
                            <span class="dark:text-white inline-block w-fit px-3 py-1 text-xs font-semibold text-black rounded-full mt-2">${movie.genres}</span>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </main>

        </div>
    </div>

</body>

</html>
