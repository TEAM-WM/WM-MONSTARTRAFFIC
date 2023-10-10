<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 인포윈도우 */
.area {
    position: absolute;
    background: #fff;
    border: 1px solid #888;
    border-radius: 3px;
    font-size: 12px;
    top: -5px;
    left: 15px;
    padding:2px;
}
.info {
    font-size: 12px;
    padding: 2px;
}
.info .title {
    font-weight: bold;
}

/* 차트 */
.chart-container {
    display: flex;
    justify-content: space-between;
    width: 100%;
    margin : 10px 0;
}
.chart-canvas {
    width: 48%;
}
</style>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=de0d60705edf93a4423ecc2b7742476f"></script>
</head>
<body>
<header>
	<h3>서울시 공공자전거 대여소별 이용정보</h3>
</header>
<section>
	<div class="container">
		<div class="select">
			<div align="left">
				<b>월별 이용정보</b>
				<select name="month" id="month" style="border: 1px solid #ccc">
					<option value="230101">23년 1월</option>
					<option value="230201">23년 2월</option>
					<option value="230301">23년 3월</option>
					<option value="230401">23년 4월</option>
					<option value="230501">23년 5월</option>
					<option value="230601">23년 6월</option>
				</select>		
			</div>
			
			<!-- 자치구별 폴리곤 -->
			<div id="map" style="width:100%;height:450px;margin:10px 0;"></div>
			
			<!-- 자치구별 TOP 5 차트-->
			<div class="chart-container">
		        <div class="chart-canvas">
		            <canvas id="myChartOne" height="200px"></canvas>
		        </div>
		        <div class="chart-canvas">
		            <canvas id="myChartTwo" height="200px"></canvas>
		        </div>
		    </div>
		</div>
	</div>
</section>

<script>

var jArray = new Array();
jArray = JSON.parse('${arr}');

/* 자치구별 지도 */
// 지도에 폴리곤으로 표시할 영역데이터 배열입니다 
var areas = [];

/* 1. JSON 파일을 읽어들여 areas 배열을 채워넣는 작업 */

// 1) getJSON도 ajax 메소드와 같이 async(비동기) 방식으로 동작하는데, 순차실행을 위해 이걸 강제로 sync 방식으로 동작하도록 함.
$.ajaxSetup({
	async : false 
}); 

// 2) getJSON 메소드를 이용해 JSON 파일을 파싱함
$.getJSON("${pageContext.request.contextPath}/resources/assets/json/seoul.json", function(geojson) { // json 파일관련 객체를 얻음
	var units = geojson.features; // 파일에서 key값이 "features"인 것의 value를 통으로 가져옴(이것은 여러지역에 대한 정보를 모두 담고있음)			
	$.each(units, function(index, unit) { // 1개 지역씩 꺼내서 사용함. val은 그 1개 지역에 대한 정보를 담음
		var coordinates = []; //좌표 저장할 배열
		var name = ''; // 지역 이름

		coordinates = unit.geometry.coordinates; // 1개 지역의 영역을 구성하는 도형의 모든 좌표 배열을 가져옴 
		name = unit.properties.SGG_NM; // 1개 지역의 이름을 가져옴

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

/* 2. 지도 띄우기 */
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 9 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption),
    customOverlay = new kakao.maps.CustomOverlay({}),
    infowindow = new kakao.maps.InfoWindow({removable: true});

// 지도에 영역데이터를 폴리곤으로 표시합니다 
for (var i = 0, len = areas.length; i < len; i++) {
    displayArea(areas[i]);
}

// 다각형을 생상하고 이벤트를 등록하는 함수입니다
function displayArea(area) {

    // 다각형을 생성합니다 
    var polygon = new kakao.maps.Polygon({
        map: map, // 다각형을 표시할 지도 객체
        path: area.path,
        strokeWeight: 2,
        strokeColor: '#004c80',
        strokeOpacity: 0.8,
        fillColor: '#fff',
        fillOpacity: 0.7 
    });

    // 다각형에 mouseover 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 변경합니다 
    // 지역명을 표시하는 커스텀오버레이를 지도위에 표시합니다
    kakao.maps.event.addListener(polygon, 'mouseover', function(mouseEvent) {
        polygon.setOptions({fillColor: '#09f'});

        customOverlay.setContent('<div class="area">' + area.name + '</div>');
        
        customOverlay.setPosition(mouseEvent.latLng); 
        customOverlay.setMap(map);
    });

    // 다각형에 mousemove 이벤트를 등록하고 이벤트가 발생하면 커스텀 오버레이의 위치를 변경합니다 
    kakao.maps.event.addListener(polygon, 'mousemove', function(mouseEvent) {
        
        customOverlay.setPosition(mouseEvent.latLng); 
    });

    // 다각형에 mouseout 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 원래색으로 변경합니다
    // 커스텀 오버레이를 지도에서 제거합니다 
    kakao.maps.event.addListener(polygon, 'mouseout', function() {
        polygon.setOptions({fillColor: '#fff'});
        customOverlay.setMap(null);
    }); 

 // 클릭한 다각형을 저장하는 전역 변수
    var selectedPolygon = null;
    var selectedMouseEvent = null; // 클릭 이벤트에 대한 정보를 저장할 변수

    kakao.maps.event.addListener(polygon, 'click', function(mouseEvent) {
        // 클릭한 다각형을 선택합니다.
        selectedPolygon = polygon;
        selectedMouseEvent = mouseEvent; // 클릭 이벤트 정보 저장

        // 클릭 이벤트가 발생한 다각형에 대한 데이터를 서버로 전송
        $.ajax({
            url: "${pageContext.request.contextPath}/bike/rentReturnMap",
            type: "get",
            dataType: "json",
            data: {
                "month": $("#month").val(), // 원하는 데이터 또는 지역 관련 정보를 전달할 수 있음
                "areaName": area.name // 예를 들어 지역 이름을 전달할 수 있음
            },
            success: function(data) {
                // 서버에서 데이터를 성공적으로 받았을 때 실행되는 코드
                // 인포윈도우 내용 업데이트
                updateInfoWindowContent(data, area);
            },
            error: function() {
                console.log('실패');
            }
        });
    });

    // 인포윈도우 업데이트 함수
    function updateInfoWindowContent(data, area) {
        // 받은 데이터를 기반으로 인포윈도우 내용 생성
        for (var i = 0, len = data.length; i < len; i++) {
        var content = '<div class="info">' +
            '   <div class="title">' + area.name + '</div>' +
            '   <div class="size">총 면적 : 약 ' + Math.floor(selectedPolygon.getArea()) + ' m<sup>2</sup></div>' +
            '   <div class="rent">대여 수 :' + data[i].rentmap + '대</div>' +
            '   <div class="return">반납 수 :' + data[i].returnmap + '대</div>' +
            '</div>';
    	}
        infowindow.setContent(content);
        infowindow.setPosition(selectedMouseEvent.latLng); // selectedMouseEvent 사용
        infowindow.setMap(map);
    }	
}

/* 자치구별 월별 이용 정보 */
$(document).ready(function(){
	$("#month").change(function(){
		infowindow.close();
		var pick = $(this).val();
		
		$.ajax({
			url : "${pageContext.request.contextPath}/bike/rentReturnChart",
			type:"get",
			dataType:"json",
			data:{"pick":pick},
			success:function(data){
				// AJAX 성공 시, 데이터 업데이트 및 차트 다시 렌더링
                updateChart(data);
			},
			error:function(){
				console.log('실패');
			}
		});
	});
});

//Chart.js 차트 객체
var myChart1;
var myChart2;

// 차트 업데이트 함수
function updateChart(data) {
	for (var i = 0; i < data.length; i++) {
        // 데이터 업데이트
		myChart1.data.labels = data.map(function(item) {
        return item.stationgrpname;
	    });
	    myChart1.data.datasets[0].data = data.map(function(item) {
	        return item.rentsum;
	    });
	    myChart2.data.labels = data.map(function(item) {
	        return item.stationgrpname;
	    });
	    myChart2.data.datasets[0].data = data.map(function(item) {
	        return item.returnsum;
		});
	}
    // 차트 다시 렌더링
    myChart1.update();
    myChart2.update();
}

const ctx1 = document.getElementById('myChartOne').getContext('2d');
const ctx2 = document.getElementById('myChartTwo').getContext('2d');

myChart1 = new Chart(ctx1,{
	type : 'bar',
	data : {
		labels : [
			jArray[0].station,
			jArray[1].station,
			jArray[2].station,
			jArray[3].station,
			jArray[4].station
		],
		datasets : [{
			label : '자치구 별 대여 수 TOP 5',
			data : [
				jArray[0].rentsum,
				jArray[1].rentsum,
				jArray[2].rentsum,
				jArray[3].rentsum,
				jArray[4].rentsum
			],
			backgroundColor : [
				'rgba(255, 99, 132, 0.2)',
		       	'rgba(255, 159, 64, 0.2)',
		       	'rgba(54, 162, 235, 0.2)',
		       	'rgba(75, 192, 192, 0.2)',
		       	'rgba(153, 102, 255, 0.2)'
			], 
			borderColor : [
				'rgb(255, 99, 132)',
		     	'rgb(255, 159, 64)',
		     	'rgb(54, 162, 235)',
		     	'rgb(75, 192, 192)',
		     	'rgb(153, 102, 255)'
			],
			borderWidth:3
		}]
	},
	options : {
		scales : {
			y : {
				beginAtZero : true,
				min: 0, // y축 최소값 설정
	            max: 600000 // y축 최대값 설정
			}
		}
	}
});
myChart2 = new Chart(ctx2,{
	type : 'bar',
	data : {
		labels : [
			jArray[0].station,
			jArray[1].station,
			jArray[2].station,
			jArray[3].station,
			jArray[4].station
			],
		datasets : [{
			label : '자치구 별 반납 수 TOP 5',
			data : [
				jArray[0].returnsum,
				jArray[1].returnsum,
				jArray[2].returnsum,
				jArray[3].returnsum,
				jArray[4].returnsum
				],
			backgroundColor : [
				'rgba(255, 99, 132, 0.2)',
		       	'rgba(255, 159, 64, 0.2)',
		       	'rgba(54, 162, 235, 0.2)',
		       	'rgba(75, 192, 192, 0.2)',
		       	'rgba(153, 102, 255, 0.2)'
			], 
			borderColor : [
				'rgb(255, 99, 132)',
		     	'rgb(255, 159, 64)',
		     	'rgb(54, 162, 235)',
		     	'rgb(75, 192, 192)',
		     	'rgb(153, 102, 255)'
			],
			type:'bar',
			borderWidth:3
		}]
	},
	options : {
		scales : {
			y : {
				beginAtZero : true,
				min: 0, // y축 최소값 설정
	            max: 600000 // y축 최대값 설정
			}
		}
	}
});


</script>
</body>
</html>