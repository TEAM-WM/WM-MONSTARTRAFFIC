<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
	<header>
		<h3>서울시 지하철 1~8호선 혼잡도</h3>
	</header>
	<section>
		<div class="category-list">
			<ul>
				<li class="${param.line == 1 or empty param.line ? 'active' : ''}">
					<a href="${ctx }/metro/jam?line=1&station=동대문">1호선</a>
				</li>
				<li class="${param.line == 2 ? 'active' : ''}">
					<a href="${ctx }/metro/jam?line=2&station=강남">2호선</a>
				</li>
				<li class="${param.line == 3 ? 'active' : ''}">
					<a href="${ctx }/metro/jam?line=3&station=가락시장">3호선</a>
				</li>
				<li class="${param.line == 4 ? 'active' : ''}">
					<a href="${ctx }/metro/jam?line=4&station=길음">4호선</a>
				</li>
				<li class="${param.line == 5 ? 'active' : ''}">
					<a href="${ctx }/metro/jam?line=5&station=강동">5호선</a>
				</li>
				<li class="${param.line == 6 ? 'active' : ''}">
					<a href="${ctx }/metro/jam?line=6&station=고려대">6호선</a>
				</li>
				<li class="${param.line == 7 ? 'active' : ''}">
					<a href="${ctx }/metro/jam?line=7&station=가산디지털단지">7호선</a>
				</li>
				<li class="${param.line == 8 ? 'active' : ''}">
					<a href="${ctx }/metro/jam?line=8&station=가락시장">8호선</a>
				</li>
			</ul>
			<c:set var="defaultLine" value="1" />
			<c:choose>
				<c:when test="${empty param.line}">
					<c:set var="lineValue" value="${defaultLine}" />
				</c:when>
				<c:otherwise>
					<c:set var="lineValue" value="${param.line}" />
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${empty param.station}">
					<c:set var="stationValue" value="서울역" />
				</c:when>
				<c:otherwise>
					<c:set var="stationValue" value="${param.station}" />
				</c:otherwise>
			</c:choose>
			<div class="category-sub">
				<ul>
					<c:forEach var="dto" items="${linelist }">
						<li class="${stationValue == dto.departurestation ? 'active' : ''}">
							<a
							href="${ctx}/metro/jam?line=${lineValue}&station=${dto.departurestation}">${dto.departurestation}</a>
						</li>
					</c:forEach>
				</ul>
			</div><!-- category-sub -->
		</div><!-- category list -->
		<div>
			<canvas id="Chart" height="200"></canvas>
		</div>
	</section>
	<section>
		<h2 class="left">${lineValue }호선 혼잡도 TOP5</h2>
		<table>
			<c:forEach var="dto" items="${lineHighlist }">
			<tr>
				<td>${dto.departurestation }</td>
				<td>${dto.dayofweekdivision }</td>
				<td>${dto.divisionname }</td>
				<td>${dto.most_congested_time }%</td>
				<td>${dto.most_congested_time_hour }</td>
			</tr>
			</c:forEach>
		</table>
	</section>
	<section>
		<h2 class="left">전체 혼잡도 TOP5</h2>
		<table>
			<c:forEach var="dto" items="${lineHighlistALL }">
			<tr>
				<td>${dto.linename }호선</td>
				<td>${dto.departurestation }</td>
				<td>${dto.dayofweekdivision }</td>
				<td>${dto.divisionname }</td>
				<td>${dto.most_congested_time }%</td>
				<td>${dto.most_congested_time_hour }</td>
			</tr>
			</c:forEach>
		</table>
	</section>
	<script>
	
	 let jArray = new Array();
	 jArray = '${list}';
	 jArray = JSON.parse(jArray);
	 Chart.defaults.font.family = 'SCoreDream';
	 const ctx = document.getElementById('Chart').getContext('2d');
	
	 const labels = ["5시30분~6시", "6시~6시30분", "6시30분~7시",
	     "7시~7시30분", "7시30분~8시", "8시~8시30분", "8시30분~9시",
	     "9시~9시30분", "9시30분~10시", "10시~10시30분",
	     "10시30분~11시", "11시~11시30분", "11시30분~12시",
	     "12시~12시30분", "12시30분~13시", "13시~13시30분",
	     "13시30분~14시", "14시~14시30분", "14시30분~15시",
	     "15시~15시30분", "15시30분~16시", "16시~16시30분",
	     "16시30분~17시", "17시~17시30분", "17시30분~18시",
	     "18시~18시30분", "18시30분~19시", "19시~19시30분",
	     "19시30분~20시", "20시~20시30분", "20시30분~21시",
	     "21시~21시30분", "21시30분~22시", "22시~22시30분",
	     "22시30분~23시", "23시~23시30분", "23시30분~00시",
	     "00시~00시30분", "00시30분~1시"];
	 
	 // 데이터셋 생성
	 const datasets = jArray.map((item, index) => {
		const RGB_1 = Math.floor(Math.random() * (255 + 1))
		const RGB_2 = Math.floor(Math.random() * (255 + 1))
		const RGB_3 = Math.floor(Math.random() * (255 + 1))
		const strRGBA = 'rgba(' + RGB_1 + ',' + RGB_2 + ',' + RGB_3+ ',0.3)';
		 let backgroundColor = strRGBA;
		 let borderColor = strRGBA;

		 // 각 데이터셋의 레이블 설정
		 let label = item.dayofweekdivision + " " + item.departurestation + " " + item.linename + "호선 " + item.divisionname + ' 혼잡도 퍼센트지';
	     return {
	         label: label,
	         data: Array(39).fill(null), // 빈 데이터셋 생성
	         backgroundColor: backgroundColor, // 랜덤한 색상
	         borderColor: borderColor,
	         borderWidth: 3
	     };
	 });
	
	 const myChart = new Chart(ctx, {
	     type: 'line',
	     data: {
	         labels: labels,
	         datasets: datasets // 동적으로 생성한 데이터셋 추가
	     },
	     options: {
	         indexAxis: 'x',
	         scales: {
	                y: {
	                    suggestedMax: 150 // 그래프에 뜨는 최대값!
	                }
	            }
	     },
	 });
	
	 // 랜덤한 rgba 색상을 반환하는 함수
	 function getRandomColor() {
	 	const rgbValues = [];
	 	  for (let i = 0; i < 3; i++) {
	 	    rgbValues.push(Math.floor(Math.random() * 256)); // 0부터 255 사이의 랜덤한 RGB 값 생성
	 	  }
	 	  const alpha = 0.3; // 투명도 값 (0.0에서 1.0 사이)
	 	  return `rgba(${rgbValues.join(', ')}, ${alpha})`;
	 }	
	 // 시간 데이터 추가
	 jArray.forEach((item, index) => {
	     for (let i = 0; i <= 38; i++) {
	         const timeName = "time" + i;
	         const timeValue = item[timeName];
	         myChart.data.datasets[index].data[i] = timeValue;
	     }
	 });
	
	 myChart.update(); // 차트 업데이트
	</script>
</body>
</html>