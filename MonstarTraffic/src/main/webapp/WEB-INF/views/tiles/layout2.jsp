<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon"
	href="${pageContext.request.contextPath}/resources/assets/imgs/favicon.png"
	type="image/png">
<title>몬스타트래픽</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/base.css">
</head>
<body>
	<div class="container">
		<tiles:insertAttribute name="header" />
		<main style="width:100%;">
			<article style="width:100%;">
				<tiles:insertAttribute name="main" />
			</article>
		</main>
		<tiles:insertAttribute name="footer" />
	</div>
	<!-- 스크립트 구역 -->
	<script src="https://kit.fontawesome.com/183a0f8087.js"
		crossorigin="anonymous"></script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/js/app.js"></script>
</body>
</html>