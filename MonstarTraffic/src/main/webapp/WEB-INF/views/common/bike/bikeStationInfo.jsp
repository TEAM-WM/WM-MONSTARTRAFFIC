<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>따릉이 마스터</title>
<style>
#detail_info {
	text-align: left;
	border: 1px solid #ccc;
	font-size: 16px;
	padding : 0 0 0 20px;
	margin: 20px 0;
    justify-content: space-between;
}
.sta_nm{
	font-weight: bold;
	font-size: 20px;
	margin: 20px 0;
}

.img {
	width: 310px;
}
img{
	width: 300px;
	height: 200px;
}
.sta_info{
	width:600px;
}
p {
    margin-bottom: 10px; /* 각 문단의 아래쪽 간격을 조절 */
}
/* .search-wrap .search-form-wrap form input[type="text"] {
	padding-left: 20px;
} */
</style>
</head>
<body>
<header>
	<h3>서울시 공공자전거 대여소 정보</h3>
</header>
<section>
	<!-- 지도 -->
	<%-- <div class="search-wrap">
		<div class="search-form-wrap">
			<input type="text" placeholder="검색어를 입력해주세요." name="searchValue" value=${searchValue }/>
		</div>
	</div> --%>
	<div id="map" style="width:100%;height:500px;"></div>
	
	<!-- 대여소 정보 -->
	<div id="detail_info" style="display: none"></div>
</section>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=de0d60705edf93a4423ecc2b7742476f"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new kakao.maps.LatLng(37.566535, 126.9779692), // 지도의 중심좌표
        level: 4 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

var positions= [];

	$.ajax({
		type: "post",
		url : "${pageContext.request.contextPath}/bike/stationInfo",
		dataType: "json",
		success : function(data) {
			for(var i in data){
				// data[i].sta_install을 'YYYY-MM-DD' 형식의 문자열로 가정
				var dateStr = data[i].sta_install;
				var dateObj = new Date(dateStr);

				// 날짜 포맷팅 함수 정의
				function formatDate(date) {
				    var year = date.getFullYear();
				    var month = String(date.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더하고 두 자리로 포맷팅
				    var day = String(date.getDate()).padStart(2, '0'); // 일도 두 자리로 포맷팅
				    return year + '년 ' + month + '월 ' + day+'일';
				}

				// 날짜 포맷팅 적용
				var formattedDate = formatDate(dateObj);
				
				// 대여소 정보
				var contentHTML = '<div class="sta_info"><div class="sta_nm">대여소 명 : ' + data[i].sta_nm + '</div>'
				    + '<p>상세 주소 : ' + data[i].sta_addr + '</p>'
				    + '<p>설치 시기 : ' + formattedDate + '</p>'
				    + '<p>LCD/QR 거치대 수 : ' + data[i].lcd_cnt + ' / ' + data[i].qr_cnt + '</p>'
				    + '<p>대여소 운영 방식 : ' + data[i].sta_op + '</p></div>';
				
				// 대여소 운영 방식에 따른 이미지 정보
				if (data[i].sta_op === 'LCD') {
				    contentHTML += '<div class="img"> <img src="${pageContext.request.contextPath}/resources/assets/imgs/bike/LCD.png" alt="LCD 대여소" /> </div>';
				} else if (data[i].sta_op === 'QR') {
				    contentHTML += '<div class="img"> <img src="${pageContext.request.contextPath}/resources/assets/imgs/bike/QR.png" alt="QR 대여소" /> </div>';
				}
				
				positions.push({
					title: '<div style="width:350px;">'+data[i].sta_addr+'<br>'+data[i].sta_nm+'</div>', 
					content: contentHTML,
					latlng : new kakao.maps.LatLng(data[i].sta_lat,data[i].sta_long)
				});
			}
		},
		error:function(request,status,error){
			console.log('실패');
		},
		async : false
	});

	// 마커 이미지의 이미지 주소입니다
	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
	var openInfowindow = null; // 열려 있는 인포윈도우를 추적할 변수
	var currentInfowindow = null; // 현재 열린 인포윈도우를 추적할 변수

	for (var i = 0; i < positions.length; i++) {
	    // 마커 이미지의 이미지 크기 입니다
	    var imageSize = new kakao.maps.Size(24, 35); 
	    
	    // 마커 이미지를 생성합니다    
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
	    
	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: positions[i].latlng, // 마커의 위치
	        image: markerImage // 마커 이미지 
	    });

	    // 마커에 표시할 인포윈도우를 생성합니다 
	    var infowindow = new kakao.maps.InfoWindow({
	        content: positions[i].title // 인포윈도우에 표시할 내용
	    });

	    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
	    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
	    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
	    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
	    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(marker, infowindow));

	    // 클릭 이벤트
	    (function (marker, infowindow, content) {
	        var detail_info = document.getElementById('detail_info');

	        kakao.maps.event.addListener(marker, 'click', function () {
	            // 현재 열려 있는 인포윈도우가 있으면 닫고, 클릭한 마커의 인포윈도우를 엽니다.
	            if (currentInfowindow) {
	                currentInfowindow.close();
	            }
	            infowindow.open(map, marker);
	            detail_info.style.display = 'flex';
	            currentInfowindow = infowindow;
	            $("#detail_info").html(content);
	        }); 
	    })(marker, infowindow, positions[i].content);
	}

	// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
	function makeOverListener(map, marker, infowindow) {
	    return function() {
	        infowindow.open(map, marker);
	    };
	}

	// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
	function makeOutListener(marker, infowindow) {
	    return function() {
	        // 클릭된 마커가 아닌 경우에만 인포윈도우를 닫습니다.
	        if (infowindow !== currentInfowindow) {
	            infowindow.close();
	        }
	    };
	}
</script>
</body>
</html>