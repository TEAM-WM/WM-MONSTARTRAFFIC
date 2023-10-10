<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<h3>highwaygraph.jsp</h3>

${arr }
${arr2 }


<div class="container">
	<div class="row">
		<div class="col-md-6">
			<canvas width="400" height="400" id="myChartOne"></canvas>
		</div>
		<div class="col-md-6">
			<canvas width="400" height="400" id="myChartTwo"></canvas>
			<!-- 드롭다운 메뉴 -->
			<div class="container mt-4">
			    <label for="chartSelection">도로 선택:</label>
			    <select name="selWay" id="chartSelection" onchange="changeChart()">
			        <option value="강남순환로">강남순환로</option>
			        <option value="강변북로">강변북로</option>
			        <option value="경부고속도로">경부고속도로</option>
			        <option value="내부순환로">내부순환로</option>
			        <option value="동부간선도로">동부간선도로</option>
			        <option value="북부간선도로">북부간선도로</option>
			        <option value="분당수서로">분당수서로</option>
			        <option value="올림픽대로">올림픽대로</option>
			    </select>
			</div>
		</div>
		<!-- <div class="col-md-6">
			<canvas width="400" height="400" id="myChartThree"></canvas>
		</div> -->
	</div>
</div>
<div id="wayOutput"></div>



<script>






var jArray = new Array();
jArray = '${arr}';

var jArray2 = new Array();
jArray2 = '${arr2}';



//파싱
jArray = JSON.parse(jArray);
jArray2 = JSON.parse(jArray2);


var jArray2 = ${arr2};
document.getElementById('wayOutput').textContent = jArray2[0].way;





const ctx1 = document.getElementById('myChartOne').getContext('2d');
const ctx2 = document.getElementById('myChartTwo').getContext('2d');
//const ctx3 = document.getElementById('myChartThree').getContext('2d');


const myChartOne = new Chart(ctx1, {
	type:'line',
	/*type: bar, pie, line, polarArea, doughnut   */
	data:{
		labels:[
			jArray[0].way,
			jArray[1].way,
			jArray[2].way,
			jArray[3].way,
			jArray[4].way,
			jArray[5].way,
			jArray[6].way,
			jArray[7].way
			],
		datasets:[{
			label:'# 2022년 도로별 교통량 합 ',
			data:[
				jArray[0].way_sum,
				jArray[1].way_sum,
				jArray[2].way_sum,
				jArray[3].way_sum,
				jArray[4].way_sum,
				jArray[5].way_sum,
				jArray[6].way_sum,
				jArray[7].way_sum
				],
			backgroundColor:[
				'rgba(255, 99, 132, 1.0)',
				'rgba(55, 19, 12, 0.2)',
				'rgba(10, 39, 32, 0.2)',
				'rgba(55, 19, 12, 0.2)',
				'rgba(2, 99, 13, 0.7)',
				'rgba(2, 99, 13, 0.7)',
				'rgba(255, 99, 132, 1.0)',
				'rgba(55, 19, 12, 0.2)'
			],
			borderColor:[
				'rgba(255, 99, 13, 1)',
				'rgba(55, 99, 13, 1)',
				'rgba(255, 99, 13, 1)',
				'rgba(55, 19, 13, 1)',
				'rgba(255, 99, 13, 1)',
				'rgba(255, 99, 13, 1)',
				'rgba(55, 99, 13, 1)',
				'rgba(255, 99, 13, 1)'
			],
			borderWidth:3
		}]
	},
	options:{
		scales:{
			y:{
				beginAtZero:true
			}
		}
	}
});


const myChartTwo= new Chart(ctx2, {
	type:'bar',
	//type: bar, pie, line, polarArea, doughnut
	data:{
		labels:[
			jArray2[0].month+'월',
			jArray2[1].month+'월',
			jArray2[2].month+'월',
			jArray2[3].month+'월',
			jArray2[4].month+'월',
			jArray2[5].month+'월',
			jArray2[6].month+'월',
			jArray2[7].month+'월',
			jArray2[8].month+'월',
			jArray2[9].month+'월',
			jArray2[10].month+'월',
			jArray2[11].month+'월'			
			],
		datasets:[{
			label:[
				jArray2[0].way
				],
			data:[
				jArray2[0].avgspeed,
				jArray2[1].avgspeed,
				jArray2[2].avgspeed,
				jArray2[3].avgspeed,
				jArray2[4].avgspeed,
				jArray2[5].avgspeed,
				jArray2[6].avgspeed,
				jArray2[7].avgspeed,
				jArray2[8].avgspeed,
				jArray2[9].avgspeed,
				jArray2[10].avgspeed,
				jArray2[11].avgspeed				
				],
			backgroundColor:[
				'rgba(255, 99, 132, 1.0)',
				'rgba(55, 19, 12, 0.2)',
				'rgba(10, 39, 32, 0.2)',
				'rgba(2, 99, 13, 0.7)',
				'rgba(255, 99, 132, 1.0)',
				'rgba(55, 19, 12, 0.2)',
				'rgba(10, 39, 32, 0.2)',
				'rgba(2, 99, 13, 0.7)',
				'rgba(255, 99, 132, 1.0)',
				'rgba(55, 19, 12, 0.2)',
				'rgba(10, 39, 32, 0.2)',
				'rgba(2, 99, 13, 0.7)'
			],
			borderColor:[
				'rgba(255, 99, 13, 1)',
				'rgba(55, 99, 13, 1)',
				'rgba(255, 99, 13, 1)',
				'rgba(55, 19, 13, 1)',
				'rgba(255, 99, 13, 1)',
				'rgba(255, 99, 13, 1)',
				'rgba(55, 99, 13, 1)',
				'rgba(255, 99, 13, 1)',
				'rgba(55, 19, 13, 1)',
				'rgba(255, 99, 13, 1)',
				'rgba(55, 19, 13, 1)',
				'rgba(55, 19, 13, 1)'
			],
			borderWidth:3
		}]
	},
	options:{
		scales:{
			y:{
				beginAtZero:true
			}
		}
	}
});


/* const myChartThree = new Chart(ctx3, {
	type:'polarArea',
	//type: bar, pie, line, polarArea, doughnut
	data:{
		labels:[
			jArray[0].job,
			jArray[1].job,
			jArray[2].job,
			jArray[3].job,
			jArray[4].job
			],
		datasets:[{
			label:'# 청바지매출액',
			data:[
				jArray[0].sal_sum,
				jArray[1].sal_sum,
				jArray[2].sal_sum,
				jArray[3].sal_sum,
				jArray[4].sal_sum,
				],
			backgroundColor:[
				'rgba(255, 99, 132, 1.0)',
				'rgba(55, 19, 12, 0.2)',
				'rgba(10, 39, 32, 0.2)',
				'rgba(2, 99, 13, 0.7)',
				'#0000ff'
			],
			borderColor:[
				'rgba(255, 99, 13, 1)',
				'rgba(55, 99, 13, 1)',
				'rgba(255, 99, 13, 1)',
				'rgba(55, 19, 13, 1)',
				'rgba(255, 99, 13, 1)'
			],
			borderWidth:3
		}]
	},
	options:{
		scales:{
			y:{
				beginAtZero:true
			}
		}
	}
}); */
	




</script>
</body>
</html>