<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<header>
		<h3>서울 지하철 혼잡도</h3>
	</header>
	<section>
		<canvas id="Chart"></canvas>
	</section>
	
	<script>
				var jArray = new Array();
				jArray = '${list}';
				jArray = JSON.parse(jArray);

				const ctx = document.getElementById('Chart').getContext('2d');
				
				const labels = ["오전 5시30분~6시","오전 6시~6시30분","오전 6시30분~7시","오전 7시~7시30분","오전 7시30분~8시","오전 8시~8시30분",
					"오전 8시30분~9시","오전 9시~9시30분","오전 9시30분~10시","오전 10시~10시30분","오전 10시30분~11시","오전 11시~11시30분",
					"오전 11시30분~12시","오후 12시~12시30분","오후 12시30분~13시","오후 13시~13시30분","오후 13시30분~14시","오후 14시~14시30분",
					"오후 14시30분~15시","오후 15시~15시30분","오후 15시30분~16시","오후 16시~16시30분","오후 16시30분~17시","오후 17시~17시30분",
					"오후 17시30분~18시","오후 18시~18시30분","오후 18시30분~19시","오후 19시~19시30분","오후 19시30분~20시","오후 20시~20시30분",
					"오후 20시30분~21시","오후 21시~21시30분","오후 21시30분~22시","오후 22시~22시30분","오후 22시30분~23시","오후 23시~23시30분",
					"오후 23시30분~00시","오전 00시~00시30분","오전 00시30분~1시"];
				const timeData = [];
				const timeData2 = [];
				const timeData3 = [];
				const timeData4 = [];
				const timeData5 = [];
				const timeData6 = [];
				for(let i=0; i<=38; i++ ){
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
				datasets : [ {
					label : jArray[0].dayofweekdivision+' 서울역 1호선 상선 혼잡도 퍼센트지',
					data : [],
					backgroundColor : ['rgba(153, 102, 255, 0.2)',],
					borderColor : ['rgba(153, 102, 255, 0.2)',],
					borderWidth : 3
				}, {
					label : jArray[1].dayofweekdivision+' 서울역 1호선 하선 혼잡도 퍼센트지',
					data : [],
					backgroundColor : ['rgba(255, 99, 132, 0.2)',],
					borderColor : ['rgba(255, 99, 132, 0.2)',],
					borderWidth : 3
				},{
					label : jArray[2].dayofweekdivision+' 서울역 1호선 상선 혼잡도 퍼센트지',
					data : [],
					backgroundColor : ['rgba(102, 207, 255, 0.2)',],
					borderColor : ['rgba(102, 207, 255, 0.2)',],
					borderWidth : 3
				},{
					label : jArray[3].dayofweekdivision+' 서울역 1호선 상선 혼잡도 퍼센트지',
					data : [],
					backgroundColor : ['rgba(255, 207, 102, 0.2)',],
					borderColor : ['rgba(255, 207, 102, 0.2)',],
					borderWidth : 3
				},{
					label : jArray[4].dayofweekdivision+' 서울역 1호선 상선 혼잡도 퍼센트지',
					data : [],
					backgroundColor : ['rgba(255, 143, 102, 0.2)',],
					borderColor : ['rgba(255, 143, 102, 0.2)',],
					borderWidth : 3
				},
				{
					label : jArray[5].dayofweekdivision+' 서울역 1호선 상선 혼잡도 퍼센트지',
					data : [],
					backgroundColor : ['rgba(0, 255, 76, 0.2)',],
					borderColor : ['rgba(0, 255, 76, 0.2)',],
					borderWidth : 3
				},
				],
			},

			options : {
				indexAxis : 'x',
			},
		});

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
	
		
		myChart.data.datasets[0].data = timeData; // data 배열 업데이트
		myChart.data.datasets[1].data = timeData2; // data 배열 업데이트
		myChart.data.datasets[2].data = timeData3; // data 배열 업데이트
		myChart.data.datasets[3].data = timeData4; // data 배열 업데이트
		myChart.data.datasets[4].data = timeData5; // data 배열 업데이트
		myChart.data.datasets[5].data = timeData6; // data 배열 업데이트
		myChart.update(); // 차트 업데이트
	</script>
</body>
</html>