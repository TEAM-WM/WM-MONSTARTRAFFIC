<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script> -->
<!-- Kakao Maps JavaScript API -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=98444eefa8d89c60d220fff58bde50de"></script>

<style>
/* 
div {
margin: 0 auto; /* 테이블을 가운데로 정렬 
padding-bottom: 20px;
} */

div#map {
padding-top: 20px;
margin-bottom: 50px;
height: 500px;
z-index: 1; /* 다른 요소 위에 표시 */
}
/* 
.input-group {
width: 50%;
} */

/* .container {
margin-top: 50px;
}
 */
#tableButton {
margin-top: 10px;
margin-bottom: 20px;
}

/* table {
margin: 0 auto; /* 테이블을 가운데로 정렬
text-align: center;
border-collapse: collapse;
width: 80%;
} */
</style>
</head>

<body>
	<header><h3>지하철 출입구 휠체어리프트 정보</h3></header>
<section>

<!-- 읍면동 검색 창 div 입니다 -->
		<div class="search-wrap">
			<div class="search-form-wrap">
					<input type="text" id="searchKeyword" class="form-control" placeholder="지하철 역명을 입력하세요." />
					<input type="submit" value="검색"  onclick="searchLocation()">
			</div>
		</div>

<!-- 지도를 표시할 div 입니다 -->
<div id="map"></div>

<script>
        var jArray = ${arr}; // 서버에서 받은 JSON 데이터

        // Kakao Map을 초기화합니다.
        var mapContainer = document.getElementById('map');
        var mapOption = { 
            center: new kakao.maps.LatLng(37.5665, 126.9780), // 서울의 중심좌표
            level: 9 // 지도 확대 레벨
        };
        var map = new kakao.maps.Map(mapContainer, mapOption);

     // 서버에서 받은 위치 정보를 반복해서 지도에 표시합니다.
        jArray.forEach(function(item) {
            var wktPoint = item.node_wkt; // 위치 정보 (예: "POINT(127.02748750839716 37.49883559708308)")
            var subwayName = item.sw_nm; // 지하철 역명
            
            // WKT 문자열에서 좌표 추출
            var match = wktPoint.match(/POINT\(([^ ]+) ([^)]+)\)/);
            if (match) {
                var lng = parseFloat(match[1]);
                var lat = parseFloat(match[2]);

                // 좌표를 LatLng 객체로 변환하여 지도에 마커로 표시
                var markerPosition = new kakao.maps.LatLng(lat, lng);
                var marker = new kakao.maps.Marker({
                    position: markerPosition,
                    map: map
                });

             // 마커 위에 텍스트 표시 (hidden으로 숨겨진 지하철역명)
                var label = new kakao.maps.CustomOverlay({
                    position: markerPosition,
                    content: '<div class="label" hidden>' + subwayName + '</div>', // hidden 속성 추가
                    zIndex: 1
                });

                // 커스텀 오버레이를 지도에 표시
                label.setMap(map);
            }
        });
        
        function searchLocation() {
            var keyword = document.getElementById('searchKeyword').value; // 검색창의 값을 가져옵니다.
            
            // jArray에서 해당 지하철역명과 일치하는 데이터를 찾습니다.
            var targetData = jArray.find(function(item) {
                return item.sw_nm === keyword;
            });

            if (targetData) {
                var wktPoint = targetData.node_wkt;
                var match = wktPoint.match(/POINT\(([^ ]+) ([^)]+)\)/);
                if (match) {
                    var lng = parseFloat(match[1]);
                    var lat = parseFloat(match[2]);

                    // 해당 지하철역의 위치로 지도 이동 및 확대
                    var moveLatLng = new kakao.maps.LatLng(lat, lng);
                    map.setCenter(moveLatLng);
                    
                    // 확대 레벨 조정 (예: 12는 원하는 확대 레벨)
                    map.setLevel(3);
                }
            } else {
                // 일치하는 데이터를 찾지 못한 경우 처리 (예: 메시지 출력)
                alert('검색 결과를 찾을 수 없습니다.');
            }
        }

    </script>

<!-- 그래프를 표시할 div 입니다 -->
<div class="space">
	<div>
		<canvas width="450" height="450" id="myChart1"></canvas>
	</div>
	<div>
		<canvas width="450" height="450" id="myChart2"></canvas>
	</div>
</div>
</section>
    <script>
    // 그래픽 차트 2개의 폰트 설정
    Chart.defaults.font.family = 'SCoreDream';
    
        var jArray = new Array();
        jArray = ${arr}; // JSON 데이터는 이미 파싱되어 있으므로 따옴표를 사용하지 않습니다.

        // sgg_nm 값을 그룹화하고, 개수를 세기 위한 객체 생성
        var countBySggNm = {};
        jArray.forEach(function(item) {
            var sggNm = item.sgg_nm;
            if (countBySggNm[sggNm]) {
                countBySggNm[sggNm]++;
            } else {
                countBySggNm[sggNm] = 1;
            }
        });

        // emd_nm 값을 그룹화하고, 개수를 세기 위한 객체 생성
        var countByEmdNm = {};
        jArray.forEach(function(item) {
            var emdNm = item.emd_nm;
            if (countByEmdNm[emdNm]) {
                countByEmdNm[emdNm]++;
            } else {
                countByEmdNm[emdNm] = 1;
            }
        });

        // 서울 구별 그래프 데이터 준비
        var sggNms = Object.keys(countBySggNm);
        var sggCounts = sggNms.map(function(sggNm) {
            return countBySggNm[sggNm];
        });

        // 동별 그래프 데이터 준비
        var emdNms = Object.keys(countByEmdNm);
        var emdCounts = emdNms.map(function(emdNm) {
            return countByEmdNm[emdNm];
        });

        // 캔버스 컨텍스트 가져오기
        var ctx1 = document.getElementById('myChart1').getContext('2d');
        var ctx2 = document.getElementById('myChart2').getContext('2d');

        // 서울 구별 리프트 개수 도넛 그래프 생성
        var myChart1 = new Chart(ctx1, {
            type: 'doughnut',
            data: {
                labels: sggNms,
                datasets: [{
                    label: '# 서울 각 구별 지하철 출입구 휠체어리프트 개수',
                    data: sggCounts,
                    backgroundColor: [
                    	'#062d6b',   /* Dark Navy */
						'#4287f5',   /* Blue */
						'#1759c2',   /* Blue 3D #2 */
						'rgba(0, 0, 128, 0.6)', /* Navy */
						'#adcdff',   /* Sky Blue */
						'rgba(65, 105, 225, 0.6)' /* Royal Blue */
                    ],
                }]
            },
            options: {
                plugins: {
                    title: {
                        display: true,
                        text: '서울 각 구별 지하철 출입구 휠체어리프트 현황', // 제목
                        font: {
                            size: 18 // 글꼴 크기를 조절하세요
                        }
                    }
                }
            }
        });

        // 동별 그래프 생성 (바 그래프)
        var myChart2 = new Chart(ctx2, {
            type: 'bar',
            data: {
                labels: emdNms,
                datasets: [{
                    label: '# 서울 각 동별 지하철 출입구 휠체어리프트 개수',
                    data: emdCounts,
                    backgroundColor: [
                    	'#062d6b',   /* Dark Navy */
						'#4287f5',   /* Blue */
						'#1759c2',   /* Blue 3D #2 */
						'rgba(0, 0, 128, 0.6)', /* Navy */
						'#adcdff',   /* Sky Blue */
						'rgba(65, 105, 225, 0.6)' /* Royal Blue */
						],
                }]
            },
            options: {
                plugins: {
                    title: {
                        display: true,
                        text: '서울 각 동별 지하철 출입구 휠체어리프트 현황', // 제목
                        font: {
                            size: 18
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
        
    </script>

<section>
<button id="tableButton">테이블 숨기기/보이기</button>

<script>
    var tableVisible = false; // 테이블은 기본적으로 숨김 상태

    // 테이블을 토글하는 함수
    function toggleTable() {
        var table = document.getElementById('liftTable');
        table.style.display = tableVisible ? 'none' : 'table'; // 숨겼다가 보이게, 보였다가 숨기게 설정
        tableVisible = !tableVisible; // 상태 토글
    }

    // 버튼 클릭 이벤트 처리
    var tableButton = document.getElementById('tableButton');
    tableButton.addEventListener('click', toggleTable);
</script>
	<table id="liftTable" style="display: none;">
    <tr>
		<td>타입</td>
		<td hidden>위치</td>
		<td hidden>아이디</td>
		<td hidden>노드코드</td>
		<td hidden>시군구코드</td>
		<td>시군구명</td>
		<td hidden>읍면동코드</td>
		<td>읍면동명</td>
		<td>지하철코드</td>
		<td>지하철역명</td>
	</tr>

	<c:forEach items="${liftinfo }" var="liftinfo">
		<tr>
		<td>${liftinfo.type }</td>
		<td hidden>${liftinfo.node_wkt }</td>
		<td hidden>${liftinfo.node_id }</td>
    	<td hidden>${liftinfo.node_code }</td>
    	<td hidden>${liftinfo.sgg_cde }</td>
    	<td>${liftinfo.sgg_nm }</td>
    	<td hidden>${liftinfo.node_code }</td>
    	<td>${liftinfo.emd_nm }</td>
    	<td>${liftinfo.sw_cd }</td>
    	<td>${liftinfo.sw_nm }</td>
    	</tr>
	</c:forEach>
	</table>
<script>
	document.title = "MonstarTraffic :: 서울시 지하철 출입구 휠체어리프트 위치정보"; 
</script>
</section>
<footer>
	<p>
		데이터 출처: 서울시 공공데이터 포털(
		<a href="http://data.seoul.go.kr/dataList/OA-21211/S/1/datasetView.do">링크</a>)
	</p>
</footer>
</body>


</html>