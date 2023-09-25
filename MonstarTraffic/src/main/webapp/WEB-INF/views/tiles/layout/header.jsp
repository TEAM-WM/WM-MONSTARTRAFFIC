<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<header class="global-header">
		<div class="global-header-container">
			<h1>
				<a href="${pageContext.request.contextPath}"></a>
			</h1>
			<nav>
				<ul>
					<li class="sub-dropdown"><a>서울시 교통정보 열람</a>
						<div class="sub-menu">
							<ul>
								<li>
									<a href="${pageContext.request.contextPath}/metro/elevator">지하철 엘레베이터 정보</a>
								</li>
								<li>
									<a href="${pageContext.request.contextPath}/metro/jam">지하철 1~8호선 혼잡도 정보</a>
								</li>
							</ul>
						</div></li>
					<li><a href="${pageContext.request.contextPath}/notice">알림마당</a></li>
				</ul>
			</nav>
		</div>
	</header>
</body>
</html>