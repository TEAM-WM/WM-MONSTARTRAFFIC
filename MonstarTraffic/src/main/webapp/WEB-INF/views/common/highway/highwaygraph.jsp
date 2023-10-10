<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h3>highwaygraph.jsp</h3>



<div class="container">
	<div class="row">
		<div class="col-md-12">
			<canvas width="400" height="200" id="myChartOne"></canvas>
			<p>도로별 교통량 합</p>
			<br />
			<br />
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
		<div class="col-md-6">
			<canvas width="400" height="400" id="myChartThree"></canvas>
		</div>
	</div>
</div>
<div id="wayOutput"></div>

${arr }
${arr2 }

<script>

/* $(document).ready(function() {

    // changeChart() 함수를 document ready 함수 밖으로 이동
    function changeChart() {
        // 선택한 도로 값을 가져옴
        var selectedWay = document.getElementById('chartSelection').value;


        $.ajax({
            type: 'GET',
            url: '${pageContext.request.contextPath}/refresh/waydata',
            data: {
                selWay: selectedWay // 선택한 도로 값을 매개변수로 전달
            },
            success: function(response) {
                // 서버에서 반환한 데이터를 사용하여 그래프를 업데이트
                var newData = response;
                
                // 그래프 업데이트
                myChartTwo.data.labels = newData.labels;
                myChartTwo.data.datasets[0].data = newData.data;
                myChartTwo.update();
            },
            error: function(error) {
                console.error('Ajax 요청 실패:', error);
            }
        });
    }

    // 드롭다운 엘리먼트에 'chartSelection' ID를 가진 것의 'change' 이벤트에 대한 리스너를 추가
    $('#chartSelection').on('change', changeChart);
    
    // 초기 데이터를 로드하기 위해 초기화할 때 'changeChart' 함수를 호출
    changeChart();
}); */

/* 자치구별 월별 이용 정보 */
$(document).ready(function(){
   $("#chartSelection").change(function(){
      var selectedWay = $(this).val();
      
      $.ajax({
         url : "${pageContext.request.contextPath}/refresh/waydata",
         type:"get",
         dataType:"json",
         data:{"selWay":selectedWay},
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
//var myChart1;
var myChart2;

// 차트 업데이트 함수
function updateChart(data) {
   for (var i = 0; i < data.length; i++) {
        // 데이터 업데이트
      /* myChartOne.data.labels = data.map(function(item) {
        return item.stationgrpname;
       });
       myChartOne.data.datasets[0].data = data.map(function(item) {
           return item.rentsum;
       }); */
       myChartTwo.data.labels = data.map(function(item) {
           return item.month+'월';
       });
       myChartTwo.data.datasets[0].data = data.map(function(item) {
           return item.avgspeed;
      });
   }
    // 차트 다시 렌더링
    //myChartOne.update();
    myChartTwo.update();
}

var jArray = new Array();
jArray = JSON.parse('${arr}');






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
const ctx3 = document.getElementById('myChartThree').getContext('2d');


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
				'rgba(54, 162, 235, 1.0)',
				'rgba(255, 206, 86, 1.0)',
				'rgba(75, 192, 192, 1.0)',
				'rgba(255, 204, 204, 1.0)',
				'rgba(204, 255, 204, 1.0)',
				'rgba(204, 204, 255, 1.0)',
				'rgba(10, 39, 32, 0.2)'
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
				'rgba(54, 162, 235, 1.0)',
				'rgba(255, 206, 86, 1.0)',
				'rgba(75, 192, 192, 1.0)',
				'rgba(255, 204, 204, 1.0)',
				'rgba(204, 255, 204, 1.0)',
				'rgba(204, 204, 255, 1.0)',
				'rgba(128, 255, 0, 1.0)',
				'rgba(255, 255, 204, 1.0)',
				'rgba(255, 204, 255, 1.0)',
				'rgba(10, 39, 32, 0.2)',
				'rgba(75, 192, 192, 1.0)'
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


const myChartThree = new Chart(ctx3, {
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
});
	




</script>
</body>
</html>