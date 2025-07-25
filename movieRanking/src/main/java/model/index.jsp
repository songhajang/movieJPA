<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <style>
        .card-hover {
            transition: transform 0.4s ease, background 0.4s ease;
        }

        .card-hover:hover {
            transform: translateY(-4px) scale(1.02);
        }

        /* 로딩 화면 스타일 */
        #loading-screen {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background: linear-gradient(135deg, #1e1b4b, #7f5af0);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            color: white;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            transition: opacity 1s ease;
        }

        #loading-screen h1 {
            margin-bottom: 24px;
            letter-spacing: 0.15em;
            text-align: center;
        }

        /* 애니메이션 점 3개 */
        .dots {
            margin-top: 20px;
            display: flex;
            gap: 18px;
        }

        .dot {
            width: 10px;
            height: 10px;
            background: white;
            border-radius: 50%;
            opacity: 0.4;
            animation: bounce 1.4s infinite ease-in-out;
        }

        .dot:nth-child(1) {
            animation-delay: 0s;
        }

        .dot:nth-child(2) {
            animation-delay: 0.2s;
        }

        .dot:nth-child(3) {
            animation-delay: 0.4s;
        }

        @keyframes bounce {

            0%,
            80%,
            100% {
                transform: translateY(0);
                opacity: 0.4;
            }

            40% {
                transform: translateY(-20px);
                opacity: 1;
            }
        }

        /* 메인 콘텐츠 숨김 & 전환 효과 */
        #main-content {
            opacity: 0;
            pointer-events: none;
            transition: opacity 1s ease;
        }

        #main-content.visible {
            opacity: 1;
            pointer-events: auto;
        }
    </style>
</head>

<body class="bg-gray-100 text-gray-900 dark:bg-zinc-900 dark:text-gray-100 transition-colors duration-500">

    <!-- 로딩 화면 -->
    <div id="loading-screen" role="alert" aria-busy="true" aria-live="assertive">
        <h1 class="text-2xl md:text-4xl font-bold">영화 추천 사이트 로딩 중</h1>
        <div class="dots" aria-hidden="true">
            <div class="dot"></div>
            <div class="dot"></div>
            <div class="dot"></div>
        </div>
    </div>

    <!-- 전체 레이아웃 메인 콘텐츠 -->
    <div id="main-content" class="flex min-h-screen" tabindex="-1" aria-hidden="true">

        <!-- 왼쪽 사이드바 -->
        <aside class="w-64 bg-white dark:bg-zinc-800 p-6 shadow-md hidden md:flex md:flex-col md:justify-between">
            <div>
                <h2 class="text-2xl font-bold mb-4 text-indigo-600 dark:text-red-500">카테고리</h2>
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
            <button id="toggle-theme"
                class="w-full h-12 px-4 py-2 text-sm bg-indigo-600 dark:bg-red-500 text-white rounded-lg hover:opacity-80 transition">
                테마 변경
            </button>
        </aside>

        <!-- 메인 컨텐츠 -->
        <div class="flex-1 flex flex-col">

            <!-- 헤더 -->
            <header class="bg-white dark:bg-zinc-800 shadow-sm px-6 py-4 flex items-center justify-between">
                <h1 class="text-xl font-bold text-indigo-600 dark:text-red-500">🎬 무비추천</h1>
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
                <!-- 카드: 이미지 없이 구성 -->
                <div
                    class="card-hover cursor-pointer dark:hover:bg-[#1e1b4b] dark:bg-zinc-800 bg-white rounded-xl p-5 shadow-md h-52 flex flex-col justify-between">
                    <div>
                        <h3 class="text-xl font-bold mb-1">영화 제목 1</h3>
                        <p class="text-sm text-gray-400">감성적인 서사와 몰입감 있는 전개</p>
                    </div>
                    <span
                        class="inline-block w-fit px-3 py-1 text-xs font-semibold bg-prism-pink text-black rounded-full">액션</span>
                </div>
                <!-- 필요 시 더 복제 가능 -->
            </main>

        </div>
    </div>

    <!-- 테마 전환 스크립트 -->
    <script>
        // 테마 변경 토글
        document.getElementById('toggle-theme').addEventListener('click', () => {
            document.documentElement.classList.toggle('dark');
        });

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