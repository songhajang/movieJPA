<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko" class="transition-colors duration-500">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>영화 추천 사이트</title>
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

<body
	class="bg-gray-100 text-gray-900 dark:bg-zinc-900 dark:text-gray-100 transition-colors duration-500">

	<!-- 전체 레이아웃 메인 콘텐츠 -->
	<div id="main-content" class="flex min-h-screen" tabindex="-1"
		aria-hidden="true">

		<!-- 왼쪽 사이드바 -->
		<aside
			class="w-64 bg-white dark:bg-zinc-800 p-6 shadow-md hidden md:flex md:flex-col md:justify-between">
			<div>
				<h2
					class="text-2xl font-bold mb-4 text-indigo-600 dark:text-red-500">카테고리</h2>
				<ul class="space-y-3 font-medium text-gray-700 dark:text-gray-300">
					<li><a href="genre?genre=Fantasy">판타지</a></li>
					<li><a href="genre?genre=Children">어린이</a></li>
					<li><a href="genre?genre=Animation">애니메이션</a></li>
					<li><a href="genre?genre=Adventure">어드벤처</a></li>
					<li><a href="genre?genre=Comedy">코미디</a></li>
					<li><a href="genre?genre=Romance">로맨스</a></li>
					<li><a href="genre?genre=Action">액션</a></li>
					<li><a href="genre?genre=Crime">크라임</a></li>
					<li><a href="genre?genre=Thriller">스릴러</a></li>
					<li><a href="genre?genre=Horror">호러</a></li>
					<li><a href="genre?genre=Drama">드라마</a></li>
					<li><a href="genre?genre=Sci-Fi">SF</a></li>
					<li><a href="genre?genre=Mystery">미스터리</a></li>
					<li><a href="genre?genre=Musical">뮤지컬</a></li>

				</ul>
			</div>
		</aside>

		<!-- 메인 컨텐츠 -->
		<div class="flex-1 flex flex-col">

			<!-- 헤더 -->
			<header
				class="bg-white dark:bg-zinc-800 shadow-sm px-6 py-4 flex items-center justify-between">

				<a href="home">
					<h1 class="text-xl font-bold text-indigo-600 dark:text-red-500">🎬
						무비무비</h1>
				</a>

				<form action="search" method="get"
					class="flex items-center gap-4 w-1/2 h-full">
					<input type="text" name="search" placeholder="영화 제목을 검색하세요"
						value="${requestScope.title}"
						class="w-full px-4 py-2 border border-gray-300 dark:border-zinc-600 rounded-lg shadow-sm bg-white dark:bg-zinc-700 text-black dark:text-white placeholder-gray-400 dark:placeholder-gray-500 focus:ring-2 focus:ring-indigo-300 dark:focus:ring-red-400 focus:outline-none" />
					<button type="submit" aria-label="검색하기"
						class=" border border-gray-300 dark:border-zinc-600 rounded-lg shadow-sm bg-white dark:bg-zinc-700  p-2.5 text-gray-500 dark:text-gray-300 hover:text-indigo-600 dark:hover:text-red-400 focus:outline-none">
						<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5"
							fill="none" viewBox="0 0 24 24" stroke="currentColor"
							stroke-width="2">
                            <path stroke-linecap="round"
								stroke-linejoin="round"
								d="M21 21l-4.35-4.35M11 19a8 8 0 1 0 0-16 8 8 0 0 0 0 16z" />
                        </svg>
					</button>
				</form>
			</header>

			<!-- 카드 리스트 -->
			<main class="flex flex-col items-center h-full mt-20">
				<div
					class="col-span-full text-center text-gray-400 dark:text-gray-500 text-2xl font-bold mt-10">
					검색 결과가 없습니다.</div>
				<a href="home"class="col-span-full text-center text-gray-400 dark:text-gray-500 text-lg mt-10">홈으로 돌아가기</a>
			</main>

		</div>
	</div>

	<script>

        // 로딩 화면 5초 후 자연스럽게 제거 및 메인 콘텐츠 노출
        window.addEventListener('load', () => {
            setTimeout(() => {
                const loading = document.getElementById('loading-screen');
                const main = document.getElementById('main-content');

                loading.style.opacity = '0';
                loading.setAttribute('aria-hidden', 'true');
                loading.setAttribute('aria-busy', 'false');

                main.classList.add('visible');
                main.setAttribute('aria-hidden', 'false');
                main.focus();

                setTimeout(() => {
                    loading.style.display = 'none';
                }, 1000);
            }, 1000);
        });
    </script>

</body>

</html>