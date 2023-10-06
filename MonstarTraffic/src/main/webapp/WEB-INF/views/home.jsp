<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Home</title>
<style>
.section-wrap{
	position:relative;
}
.overlay {	
	padding:20px;
	position: absolute;
	right: 20px;
	top: 20px;
	border-radius: 10px;
	background:rgb(255 255 255 / 50%);
	border: 1px solid #ccc;
	z-index:9999;
	line-height:2em;
}
.overlay >p {
	font-weight:500;
}
.overlay >p >span{
	position:relative;
	top:3.5px;
	display: inline-block;
	width:50px;
	height:20px;
	border: 1px solid #fff;
	background:#fefefe;
	border-radius: 10px;
}
.overlay >p >span.circle-green{
	background: #2ac218;
}
.overlay >p >span.circle-yellow{
	background: #facb48;
}
.overlay >p >span.circle-orange{
	background: #fb8239;
}
.overlay >p >span.circle-red{
	background: #ec220f;
}
</style>
</head>
<body>
	<section class="section-wrap">
		<div class="overlay">
			<p>원활 <span class="circle-green"></span></p>
			<p>서행 <span class="circle-yellow"></span></p>
			<p>지체 <span class="circle-orange"></span></p>
			<p>정체 <span class="circle-red"></span></p>
		</div>
		<div id="map" style="width: 100%; height: 750px;"></div>
	</section>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=25d149a1123bfbb2452d5df6e1b341d2&libraries=services"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
			level : 9
		// 지도의 확대 레벨
		};

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

		// 지도에 교통정보를 표시하도록 지도타입을 추가합니다
		map.addOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC);

		// 아래 코드는 위에서 추가한 교통정보 지도타입을 제거합니다
		// map.removeOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC);
	</script>
</body>
</html>