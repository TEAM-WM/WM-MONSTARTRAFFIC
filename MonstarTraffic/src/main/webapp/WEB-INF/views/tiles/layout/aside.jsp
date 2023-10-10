<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<aside class="aside-wrap">
		<div class="aside-title">
			<h2>서울시 교통정보</h2>
		</div>
		<nav>
			<ul>
				<li><a href="${ctx }/highway/highway">도로별 교통량 정보</a></li>
				<li><a href="${ctx }/metro/elevator">지하철 엘레베이터 정보</a></li>
				<li><a href="${ctx }/metro/jam">지하철 1~8호선 혼잡도 정보</a></li>
				<li><a href="${ctx }/subwaylift">지하철 휠체어 리프트 정보</a></li>
				<li><a href="${ctx }/amenities">지하철 편의시설 현황</a></li>
				<li><a href="${ctx }/riderAccident">자전거 사고현황</a></li>
				<li><a href="${ctx }/bike/bikeStationInfo">서울시 공공자전거 대여소 정보</a></li>
				<li><a href="${ctx }/bike/bikeUse">서울시 공공자전거 대여소별 이용정보</a></li>
				<li><a href="${ctx }/accident/2019">년도별 월 교통사고 통계</a></li>
			</ul>
		</nav>
	</aside>
</body>
</html>