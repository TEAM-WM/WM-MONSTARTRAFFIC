<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>지하철 엘레베이터 정보</title>
<style>
#keyword {
	padding-left: 20px;
}

.area {
	position: absolute;
	background: #fff;
	border: 1px solid #888;
	border-radius: 3px;
	font-size: 12px;
	top: -5px;
	left: 15px;
	padding: 2px;
}

.info {
	font-size: 12px;
	padding: 5px;
	position: relative;
}

.info .title {
	z-index: 999999;
	font-weight: bold;
}
</style>
</head>
<body>
	<header>
		<h3>서울시 지하철 엘레베이터 위치</h3>
	</header>

	<section>
		<div class="search-wrap">
			<div class="search-form-wrap">
				<form onsubmit="searchPlaces(); return false;">
					<input type="text" placeholder="OO동/역명을 입력하세요" id="keyword">
					<input type="submit" value="검색">
				</form>
			</div>
		</div>
		<div class="map_wrap">
			<div id="map" style="width: 100%; height: 500px;"></div>
		</div>
	</section>

	<section>
		<div>
			<canvas id="Chart"></canvas>
		</div>
	</section>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=25d149a1123bfbb2452d5df6e1b341d2&libraries=services,clusterer,drawing"></script>
	<script>
		// JSON 파일 경로
		const jsonFile = '${pageContext.request.contextPath}/resources/assets/seoul.json';
		// 지도에 폴리곤으로 표시할 영역데이터 배열입니다 
		var areas = [];

		/* 1. JSON 파일을 읽어들여 areas 배열을 채워넣는 작업 */

		// 1) getJSON도 ajax 메소드와 같이 async(비동기) 방식으로 동작하는데, 순차실행을 위해 이걸 강제로 sync 방식으로 동작하도록 함.
		$.ajaxSetup({
			async : false
		});

		// 2) getJSON 메소드를 이용해 JSON 파일을 파싱함
		$.getJSON(jsonFile, function(geojson) {
			var units = geojson.features; // 파일에서 key값이 "features"인 것의 value를 통으로 가져옴(이것은 여러지역에 대한 정보를 모두 담고있음)			
			$.each(units, function(index, unit) { // 1개 지역씩 꺼내서 사용함. val은 그 1개 지역에 대한 정보를 담음
				var coordinates = []; //좌표 저장할 배열
				var name = ''; // 지역 이름

				coordinates = unit.geometry.coordinates; // 1개 지역의 영역을 구성하는 도형의 모든 좌표 배열을 가져옴 
				name = unit.properties.name; // 1개 지역의 이름을 가져옴
				var ob = new Object();
				ob.name = name;
				ob.path = [];

				$.each(coordinates[0], function(index, coordinate) { // []로 한번 더 감싸져 있어서 index 0번의 것을 꺼내야 배열을 접근가능.
					ob.path.push(new kakao.maps.LatLng(coordinate[1],
							coordinate[0]));
				});

				areas[index] = ob;
			});//each
		});//getJSON
		// 카카오맵
		// 위도경도 좌표를 가진 json 리스트
		let jArray = new Array();
		jArray = '${jsonlist}';
		jArray = JSON.parse(jArray);
		/*console.log(jArray[0].longitude);
		console.log(jArray[0].latitude);
		 jArray.forEach(function(item) {
			console.log("경도: " + item.longitude);
			console.log("위도: " + item.latitude);
		}); */
		const levelNum = 9;
		var mapContainer = document.getElementById('map'); // 지도를 표시할 div 
		var mapOption = {
			center : new kakao.maps.LatLng(jArray[0].latitude,
					jArray[0].longitude), // 지도의 중심좌표
			level : levelNum
		// 지도의 확대 레벨
		};
		// 지도를 생성합니다

		var map = new kakao.maps.Map(mapContainer, mapOption), customOverlay = new kakao.maps.CustomOverlay(
				{}), infowindow = new kakao.maps.InfoWindow({
			removable : true
		});
		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places();

		// 키워드 검색을 요청하는 함수입니다
		function searchPlaces() {

			var keyword = document.getElementById('keyword').value;

			if (!keyword.replace(/^\s+|\s+$/g, '')) {
				alert('키워드를 입력해주세요!');
				return false;
			}

			// 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
			ps.keywordSearch(keyword, placesSearchCB);
		}

		// 장소검색이 완료됐을 때 호출되는 콜백함수
		function placesSearchCB(data, status, pagination) {
			if (status === kakao.maps.services.Status.OK) {
				// 검색 결과로 받아온 위치 정보를 사용하여 중심 좌표를 변경합니다.
				var place = data[0];
				var newLatitude = place.y; // 검색된 장소의 위도
				var newLongitude = place.x; // 검색된 장소의 경도

				map.setCenter(new kakao.maps.LatLng(newLatitude, newLongitude));
				map.setLevel(3);
			}
		}

		// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
		var mapTypeControl = new kakao.maps.MapTypeControl();

		// 지도 타입 컨트롤을 지도에 표시합니다
		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
		var zoomControl = new kakao.maps.ZoomControl();
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
		/* // 지도에 교통정보를 표시하도록 지도타입을 추가합니다
		map.addOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC);     */

		/* 클러스터러 */
		// 마커 클러스터러를 생성합니다 
		var clusterer = new kakao.maps.MarkerClusterer({
			map : map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
			averageCenter : true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
			minLevel : 7, // 클러스터 할 최소 지도 레벨 
			disableClickZoom : true
		// 클러스터 마커를 클릭했을 때 지도가 확대되지 않도록 설정한다
		});

		var markers = jArray.map(function(position) {
			/* console.log(position.sgg_nm) */
			return new kakao.maps.Marker({
				position : new kakao.maps.LatLng(position.latitude,
						position.longitude),
			});
		});
		// 클러스터러에 마커들을 추가합니다
		clusterer.addMarkers(markers);

		// 특정 지도 레벨에서 클러스터링을 중지하려면 아래와 같이 사용합니다
		if (map.getLevel() > levelNum) {
			clusterer.clear(); // 클러스터링을 중지하고 클러스터를 제거합니다
		}

		// 마커 클러스터러에 클릭이벤트를 등록합니다
		// 마커 클러스터러를 생성할 때 disableClickZoom을 true로 설정하지 않은 경우
		// 이벤트 헨들러로 cluster 객체가 넘어오지 않을 수도 있습니다
		kakao.maps.event.addListener(clusterer, 'clusterclick', function(
				cluster) {

			// 현재 지도 레벨에서 1레벨 확대한 레벨
			var level = map.getLevel() - 1;

			// 지도를 클릭된 클러스터의 마커의 위치를 기준으로 확대합니다
			map.setLevel(level, {
				anchor : cluster.getCenter()
			});
		});

		/* 3. 폴리곤 도형을 지도위에 띄우고 마우스 이벤트 붙이기 */

		// 지도에 영역데이터를 폴리곤으로 표시합니다 
		for (var i = 0, len = areas.length; i < len; i++) {
			displayArea(areas[i]);
		}//for

		// 다각형을 생성하고 이벤트를 등록하는 함수입니다
		function displayArea(area) {
			/* console.log(area.path) */
			var points = area.path; // 폴리곤의 경계 좌표를 points 배열에 저장합니다
			/* console.log(area.path) */
			// 다각형을 생성합니다 
			var polygon = new kakao.maps.Polygon({
				map : map, // 다각형을 표시할 지도 객체
				path : area.path,
				strokeWeight : 2,
				strokeColor : '#004c80',
				strokeOpacity : 0.8,
				fillColor : '#fff',
				fillOpacity : 0.3
			});

			// 다각형에 mouseover 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 변경합니다 
			// 지역명을 표시하는 커스텀오버레이를 지도위에 표시합니다
			kakao.maps.event.addListener(polygon, 'mouseover', function(
					mouseEvent) {
				polygon.setOptions({
					fillColor : '#09f'
				});

				customOverlay.setContent('<div class="area">' + area.name
						+ '</div>');

				customOverlay.setPosition(mouseEvent.latLng);
				customOverlay.setMap(map);
			});

			// 다각형에 mousemove 이벤트를 등록하고 이벤트가 발생하면 커스텀 오버레이의 위치를 변경합니다 
			kakao.maps.event.addListener(polygon, 'mousemove', function(
					mouseEvent) {

				customOverlay.setPosition(mouseEvent.latLng);
			});

			// 다각형에 mouseout 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 원래색으로 변경합니다
			// 커스텀 오버레이를 지도에서 제거합니다 
			kakao.maps.event.addListener(polygon, 'mouseout', function() {
				polygon.setOptions({
					fillColor : '#fff'
				});
				customOverlay.setMap(null);
			});
			// 다각형에 click 이벤트를 등록하고 이벤트가 발생하면 다각형의 이름과 면적을 인포윈도우에 표시합니다 
			kakao.maps.event.addListener(polygon, 'click',
					function(mouseEvent) {
						// 폴리곤 삭제
						polygon.setMap(null);

						// 폴리곤 클릭시 확대 레벨
						const zoomLevel = 4; 

						// 폴리곤의 중심 좌표를 기준으로 지도를 확대
						map.setLevel(zoomLevel, {
							anchor : mouseEvent.latLng
						});
						var content = '<div class="info"><div class="title">'
								+ area.name + '</div></div>';

						infowindow.setContent(content);
						infowindow.setPosition(mouseEvent.latLng);
						infowindow.setMap(map);
					});
		}//displayArea

		//  ================================= chartjs =================================
		let jArray2 = new Array();
		jArray2 = '${jsonSGGList}';
		jArray2 = JSON.parse(jArray2);
		const ctx = document.getElementById('Chart').getContext('2d');

		Chart.defaults.font.family = 'SCoreDream';
		const labels = [];
		const data = [];
		const backgroundColor = [];
		const borderColor = [];

		for (let i = 0; i < jArray2.length; i++) {
			labels.push(jArray2[i].sgg_nm);
			data.push(jArray2[i].sgg_count);

			const RGB_1 = 0;
			const RGB_2 = Math.floor(Math.random() * 2);
			const RGB_3 = Math.floor(Math.random() * 255);
			const strRGBA = 'rgba(' + RGB_1 + ',' + RGB_2 + ',' + RGB_3
					+ ',0.8)';
			/* console.log(strRGBA); */

			backgroundColor.push(strRGBA);
			borderColor.push(strRGBA);
		}

		const myChart = new Chart(ctx, {
			plugins: [ChartDataLabels], // chartjs-plugin-datalabels 불러오기
			type : 'bar',
			data : {
				labels : labels,
				datasets : [ {
					label : '# 서울시 구별 엘레베이터 갯수',
					data : data,
					backgroundColor : backgroundColor,
					borderColor : borderColor,
					borderWidth : 1
				} ],
			},
			
			options : {
					indexAxis : 'x',

					plugins : {
						datalabels : {
							color : 'white',
							display : function(context) {
								return context.dataset.data[context.dataIndex];
							},
							font : {
								weight : 'bold'
							},
							formatter : Math.round
						}
					},
				},
			});
	</script>
</body>
</html>