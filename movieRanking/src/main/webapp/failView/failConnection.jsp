<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서버 오류</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #fef2f2;
        color: #b91c1c;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    .error-container {
        background-color: #fff1f2;
        border: 1px solid #fca5a5;
        border-radius: 12px;
        padding: 40px;
        text-align: center;
        box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
    }

    .error-title {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 20px;
    }

    .home-link {
        display: inline-block;
        padding: 10px 20px;
        background-color: #f87171;
        color: white;
        text-decoration: none;
        border-radius: 8px;
        transition: background-color 0.3s ease;
    }

    .home-link:hover {
        background-color: #ef4444;
    }
</style>
</head>
<body>
    <div class="error-container">
        <div class="error-title">😵 서버가 힘들어요 ㅠㅠ</div>
        <p>잠시 후 다시 시도해 주세요.</p>
        <br>
        <a href="../index.html" class="home-link">🏠 메인으로 돌아가기</a>
    </div>
</body>
</html>