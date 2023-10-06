<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Home</title>
</head>
<body>
	<section>
		<div id="map" style="width: 100%; height: 800px;"></div>
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