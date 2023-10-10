<%@page import="java.sql.DriverManager"%>

<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.servlet.jsp.jstl.sql.Result"%>
<%@page import="java.sql.PreparedStatement"%>

<%@page import="java.sql.Connection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>graph2chart</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>
<body>
<style>
/* input[type="button"],input[type="reset"] {
    background: #fff;
    border: 1px solid darkgray;
    border-radius: 4px;
    font-size: 16px;
    height: 34px;
    padding-right: 6px;
    padding-left: 6px;
    cursor: pointer;
    margin-top:10px;
    color:black;
}
input[type="button"]:hover {
    border: 1px solid #067dfd;	/*	#bdbdbd	*/
	outline:1px solid #067dfd;	/*	#2db400 */
/* 	font-weight: 900; */
}
  input[type="button"]{
	cursor:pointer;
  } */
  
.sel{
    width: 200px;
    border: 1px solid #C4C4C4;
    box-sizing: border-box;
    border-radius: 0px;
    padding: 8px 13px;
    font-family: 'Roboto';
    font-style: normal;
    font-weight: 400;
    font-size: 14px;
    line-height: 14px;
}  

.sel2{
    width: 120px;
    border: 1px solid #C4C4C4;
    box-sizing: border-box;
    border-radius: 0px;
    padding: 6px 4px;
    font-family: 'Roboto';
    font-style: normal;
    font-weight: 400;
    font-size: 14px;
    line-height: 6px;
}
.sel2:hover{
	cursor:pointer;
    border: 1px solid #067dfd;	/*	#bdbdbd	*/
	outline:1px solid #067dfd;	/*	#2db400 */
}
.sel2:blur{
	
    border: 0px solid #067dfd;	/*	#bdbdbd	*/
	outline:0px solid #067dfd;	/*	#2db400 */
}
h1{
font-size:32px;
font-weight: 600;
}
</style>


	<div class="container">
	<h1>${param.searchRegion}
	<c:if test="${param.searchRegion eq null}">구로구</c:if>
	
	  ${param.searchYear}
	 <c:if test="${param.searchYear eq null}" >2020</c:if> 
	  
	  년 자전거 사고현황</h1><br>

<form action="riderAccident">
	
	
	

			<div class="row">
				<table style="width: 1300">
				<tr>
				<td colspan="2">
				<select name="searchYear" class="sel2">

		<option value="2018"
			<c:if test="${param.searchYear eq '2018' }"> selected</c:if>>2018</option>
		<option value="2019"
			<c:if test="${param.searchYear eq '2019' }"> selected</c:if>>2019</option>
		<option value="2020"
			<c:if test="${param.searchYear eq '2020' }"> selected</c:if>>2020</option>
	</select>년도
<select name="searchRegion" class="sel2">

		<option value="관악"
			<c:if test="${param.searchRegion eq '관악' }"> selected</c:if>>관악구</option>
		<option value="구로"
			<c:if test="${param.searchRegion eq '구로' }"> selected</c:if>>구로구</option>

			<!-- 	<option value="2019">2019</option>
	<option value="2020">2020</option>	 -->
</select> 지역 
<input type="button" value="검색" onclick="form.submit();">
				
				
				</td>
				</tr>
					<tr>
						<td width="400" height="100">
							<div>
								<h1>피해자 성별</h1>
							</div>
							<canvas id="myChart1" width="400 height="100"></canvas>

						</td>
						<td width="900" height="500">
							<div>
								<h1>가해 차량종류</h1>
							</div>
							<canvas id="myChart2" width="400 height="100">
</div>

					
						
						</td>
						<!-- <td width=30%>
</td>	 -->
					</tr>
					<tr>
						<td colspan="2">
							<div>
								<h1>월별 부상/사망 수</h1>
							</div>
							<canvas id="myChart3" width="400 height="100">

					
						
						</td>
					</tr>
				</table>
			</div>
			<div class="row">
				<br>
				<div width="400" height="400" class="col-md-12">
					<div>
						<h1>연령별 사고 건수</h1>
					</div>
					<canvas id="myChart4"></canvas>
				</div>
			</div>
		</div>
		<br>
		<div>
			<h1>시간별 부상/사망 건수</h1>
		</div>
		<div width="400" height="400" class="col-md-12">
			<canvas id="myChart5"></canvas>
		</div>
	</form>
	<script>


	var jArray1=new Array();
	jArray1='${arr1}';
	jArray1=JSON.parse(jArray1);

	var jArray1List = new Array();
	var jArray1List2 = new Array();
	for(var i = 0; i<jArray1.length; i++) {
		var d = jArray1[i];
		jArray1List.push(d.manSex);
		jArray1List2.push(d.sexSum);
		
	}


	var jArray2=new Array();
	jArray2='${arr2}';
	jArray2=JSON.parse(jArray2);
	
	var jArray2List = new Array();
	var jArray2List2 = new Array();
	for(var i = 0; i<jArray2.length; i++) {
		var d = jArray2[i];
		jArray2List.push(d.accidentvehicle);
		jArray2List2.push(d.vehicleSum);
		
	}


	var jArray3=new Array();
	jArray3='${arr3}';
	jArray3=JSON.parse(jArray3);
	
	for(key in jArray3){
		//console.log(jArray2[key].yyyymm);
		//console.log(jArray2[key].injurySum);
		//console.log(jArray2[key].deadSum);
		}
	
	var labelList = new Array();
	var valueList2 = new Array();
	var valueList3 = new Array();
	var colorList = new Array();
	var colorList2 = new Array();
	function colorize() {
		var r = Math.floor(Math.random()*200);
		var g = Math.floor(Math.random()*200);
		var b = Math.floor(Math.random()*200);
		var color = 'rgba(' + r + ', ' + g + ', ' + b + ', 0.7)';
		return color;
	}
	function colorize2() {
		var r = Math.floor(Math.random()*200);
		var g = Math.floor(Math.random()*200);
		var b = Math.floor(Math.random()*200);
		var color2 = 'rgba(' + r + ', ' + g + ', ' + b + ', 0.7)';
		return color2;
	}
			
	for(var i = 0; i<jArray3.length; i++) {
		var d = jArray3[i];
		labelList.push(d.yyyymm);
		valueList2.push(d.injurySum);
		valueList3.push(d.deadSum);
		colorList.push(colorize());
		colorList2.push(colorize2());
	}
	
	//4
	var jArray4ColorList = new Array();
	var jArray4=new Array();
	jArray4='${arr4}';
	jArray4=JSON.parse(jArray4);
	for(var i = 0; i<10; i++) {
	
	
		jArray4ColorList.push(colorize());
	
	}
	//4	
	var jArray5ColorList = new Array();
	var jArray5=new Array();
	jArray5='${arr5}';
	jArray5=JSON.parse(jArray5);
	for(var i = 0; i<jArray5.length; i++) {
	
	
		jArray5ColorList.push(colorize());
	
	} 

const ctx1=document.getElementById("myChart1").getContext("2d");
const ctx2=document.getElementById("myChart2").getContext("2d");
const ctx3=document.getElementById("myChart3").getContext("2d"); 
const ctx4 =document.getElementById('myChart4').getContext("2d");
const ctx5 = document.getElementById('myChart5').getContext("2d");


const myChart1=new Chart(ctx1,{
		type:'doughnut',
		data:{
			labels:jArray1List,
			datasets:[{
				label:'남/여',
				data:jArray1List2,
				backgroundColor:[
					'#36a2eb',
					'#ff6384'

				],
				borderColor:[
					'rgb(255,99,9,1)',
					'rgb(55,11,161,0.7)'
	
				],
				borderWidth:1
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
	
 const myChart2=new Chart(ctx2,{
	type:'bar',
	data:{
		labels:jArray2List,
		datasets:[{
			label:'사고차량',
			data:jArray2List2,
			backgroundColor:[
				'rgb(255,123,132,0.5)',
				'rgb(55,11,161,0.7)',
				'rgb(155,66,255,1.0)',
				'rgb(95,211,77,1.0)',
				'#0000ff'
			],
			borderColor:[
				'rgb(255,99,9,1)',
				'rgb(55,11,161,0.7)',
				'rgb(55,11,161,0.7)',
				'rgb(55,11,161,0.7)',
				'rgb(55,11,161,0.7)'
			],
			borderWidth:1
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

const myChart3=new Chart(ctx3,{
	type:'bar',
	data:{
		labels:
			labelList 
			,
		datasets:[{
			
			label:'사고',
			data:valueList2
				,
			backgroundColor:
				colorList
			,
			borderColor:
				colorList
			,
			borderWidth:1
		}
  
	,
{
		label:'사망',
		data:valueList3
			,
		backgroundColor:
			colorList2
		,
		borderColor:
			colorList2
		,
		borderWidth:1
	}]
	},
	options:{
		scales:{
			 y: {
				 beginAtZero:true
			      }
		}
	}
	
});
  
  new Chart(ctx4, {
	  type: 'bar',
	  data: {
	    labels: ['영아', '10대', '20대', '30대', '40대', '50대',
	  	       '60대','70대','80대','90대'],
	    datasets: [{
	      label: '연령별 사고 건수',
	       borderColor:'#ff6384',
	      backgroundColor:'#ff6384', 
	    data: [jArray4[0].manHour1,jArray4[0].manHour2,jArray4[0].manHour3,jArray4[0].manHour4,
	    	  jArray4[0].manHour5,jArray4[0].manHour6,jArray4[0].manHour7,jArray4[0].manHour8,
	    	  jArray4[0].manHour9,jArray4[0].manHour10],
	      
	      backgroundColor:jArray4ColorList

	      }]
	  },
	  options: {
	    scales: {
	      y: {
	        beginAtZero: false
	      }
	    }
	  }
	}); 

  new Chart(ctx5, {
	    type: 'line',
	    data: {
	      labels: ['01~02', '03~04', '05~06', '07~08', '09~10', '11~12',
	    	       '13~14','15~16','17~18','19~20','21~22','23~24'],
	      datasets: [{
	        label: '시간별 사고 건수',
	        borderColor:'#ff6384',
	        backgroundColor:'#ff6384',
	        data: [jArray5[0].injuryHour1, jArray5[0].injuryHour3, jArray5[0].injuryHour5, jArray5[0].injuryHour7, jArray5[0].injuryHour9, jArray5[0].injuryHour11,
	        	   jArray5[0].injuryHour13,jArray5[0].injuryHour15,jArray5[0].injuryHour17,jArray5[0].injuryHour19,jArray5[0].injuryHour21,jArray5[0].injuryHour23],
	        borderWidth: 2},
	 		{
	          label: '시간별 사망 건수',
	          borderColor:'#0d6efd',
	          backgroundColor:'#0d6efd',
	          data: [jArray5[0].deadHour1, jArray5[0].deadHour3, jArray5[0].deadHour5, jArray5[0].deadHour7, jArray5[0].deadHour9, jArray5[0].deadHour11,
	          	   jArray5[0].deadHour13,jArray5[0].deadHour15,jArray5[0].deadHour17,jArray5[0].deadHour19,jArray5[0].deadHour21,jArray5[0].deadHour23],
	          borderWidth: 1
	        }]
	    },
	    options: {
	      scales: {
	        y: {
	          beginAtZero: false
	        }
	      }
	    }
	  });   
</script>
</body>


</html>