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
			<div class="category-sub">
				<ul>
					<c:forEach var="dto" items="${linelist }">
						<li class="${param.station == dto.departurestation ? 'active' : ''}">
							<a
							href="${ctx}/metro/jam?line=${param.line}&station=${dto.departurestation}">${dto.departurestation}</a>
						</li>
					</c:forEach>
				</ul>
			</div><!-- category-sub -->
		</div><!-- category list -->
		<div>
			<canvas id="Chart" height="200"></canvas>
		</div>
	</section>
	
	<script>
	
	let jArray = new Array();
	 jArray = '${list}';
	 jArray = JSON.parse(jArray);
	
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
	<%-- 
		var jArray = new Array();
		jArray = '${list}';
		jArray = JSON.parse(jArray);

		const ctx = document.getElementById('Chart').getContext('2d');

		const labels = [ "5시30분~6시", "6시~6시30분", "6시30분~7시",
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
				"00시~00시30분", "00시30분~1시" ];
		const timeData = [];
		const timeData2 = [];
		const timeData3 = [];
		const timeData4 = [];
		const timeData5 = [];
		const timeData6 = [];
		for (let i = 0; i <= 38; i++) {
			const timeName = "time" + i;
			const timeValue = jArray[0][timeName];
			const timeValue2 = jArray[1][timeName];
			const timeValue3 = jArray[2][timeName];
			const timeValue4 = jArray[3][timeName];
			const timeValue5 = jArray[4][timeName];
			const timeValue6 = jArray[5][timeName];
			timeData.push(timeValue);
			timeData2.push(timeValue2);
			timeData3.push(timeValue3);
			timeData4.push(timeValue4);
			timeData5.push(timeValue5);
			timeData6.push(timeValue6);
		}

		/* console.log(jArray); */

		const myChart = new Chart(ctx, {
			type : 'line',
			data : {
				labels : labels,
				datasets : [
						{
							label : jArray[0].dayofweekdivision + " "
									+jArray[0].departurestation + " "
									+jArray[0].linename + "호선 "
									+jArray[0].divisionname
									+ ' 혼잡도 퍼센트지',
							data : [],
							backgroundColor : [ 'rgba(153, 102, 255, 0.2)', ],
							borderColor : [ 'rgba(153, 102, 255, 0.2)', ],
							borderWidth : 3
						},
						{
							label : jArray[1].dayofweekdivision + " "
									+jArray[1].departurestation + " "
									+jArray[1].linename + "호선 "
									+jArray[1].divisionname
									+ ' 혼잡도 퍼센트지',
							data : [],
							backgroundColor : [ 'rgba(255, 99, 132, 0.2)', ],
							borderColor : [ 'rgba(255, 99, 132, 0.2)', ],
							borderWidth : 3
						},
						{
							label : jArray[2].dayofweekdivision + " "
									+jArray[2].departurestation + " "
									+jArray[2].linename + "호선 "
									+jArray[2].divisionname
									+ ' 혼잡도 퍼센트지',
							data : [],
							backgroundColor : [ 'rgba(102, 207, 255, 0.2)', ],
							borderColor : [ 'rgba(102, 207, 255, 0.2)', ],
							borderWidth : 3
						},
						{
							label : jArray[3].dayofweekdivision + " "
									+jArray[3].departurestation + " "
									+jArray[3].linename + "호선 "
									+jArray[3].divisionname
									+ ' 혼잡도 퍼센트지',
							data : [],
							backgroundColor : [ 'rgba(255, 207, 102, 0.2)', ],
							borderColor : [ 'rgba(255, 207, 102, 0.2)', ],
							borderWidth : 3
						},
						{
							label : jArray[4].dayofweekdivision + " "
									+jArray[4].departurestation + " "
									+jArray[4].linename + "호선 "
									+jArray[4].divisionname
									+ ' 혼잡도 퍼센트지',
							data : [],
							backgroundColor : [ 'rgba(255, 143, 102, 0.2)', ],
							borderColor : [ 'rgba(255, 143, 102, 0.2)', ],
							borderWidth : 3
						},
						{
							label : jArray[5].dayofweekdivision + " "
									+jArray[5].departurestation + " "
									+jArray[5].linename + "호선 "
									+jArray[5].divisionname
									+ ' 혼잡도 퍼센트지',
							data : [],
							backgroundColor : [ 'rgba(0, 255, 76, 0.2)', ],
							borderColor : [ 'rgba(0, 255, 76, 0.2)', ],
							borderWidth : 3
						}, ],
			},
			options : {
				indexAxis : 'x',
			},
		});
--%>
		// Set backgroundColor 랜덤하게 값 추가 ( 투명도 30% )

		/* for (let i = 0; i <= 38; i++) {
			const RGB_1 = Math.floor(Math.random() * (255 + 1))
			const RGB_2 = Math.floor(Math.random() * (255 + 1))
			const RGB_3 = Math.floor(Math.random() * (255 + 1))
			const strRGBA = 'rgba(' + RGB_1 + ',' + RGB_2 + ',' + RGB_3
					+ ',0.3)';
			myChart.data.datasets[0].backgroundColor.push(strRGBA);
			myChart.data.datasets[0].borderColor.push(strRGBA);
		} */

		/* myChart.data.datasets[0].data = timeData; // data 배열 업데이트
		myChart.data.datasets[1].data = timeData2; // data 배열 업데이트
		myChart.data.datasets[2].data = timeData3; // data 배열 업데이트
		myChart.data.datasets[3].data = timeData4; // data 배열 업데이트
		myChart.data.datasets[4].data = timeData5; // data 배열 업데이트
		myChart.data.datasets[5].data = timeData6; // data 배열 업데이트
		myChart.update(); // 차트 업데이트 */

	</script>
</body>
</html>