<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- Kakao Maps JavaScript API -->
 
<style>
h3 {
margin: 0 auto; /* 테이블을 가운데로 정렬 */
padding-left: 20px;
}

div {
margin: 0 auto; /* 테이블을 가운데로 정렬 */
padding-top: 20px;
padding-bottom: 20px;
width: 80%;
z-index: 1; /* 다른 요소 위에 표시 */
}

table {
margin: 0 auto; /* 테이블을 가운데로 정렬 */
padding-top: 20px;
text-align: center;
border-collapse: collapse;
width: 80%;
}
</style>
</head>

<body>
<header><h3>지하철 역사 내 편의시설 정보</h3></header>

<section>
<div>
    <canvas id="lineChart" width="800" height="400"></canvas>
</div>

<script>
// 그래픽 차트의 폰트 설정
	Chart.defaults.font.family = 'SCoreDream';

    // 서버에서 받아온 JSON 데이터 파싱
    var lineData = [
        { line: "1호선", total_elevator: 37, total_escalator: 33, total_wheelchair_lift: 8, total_hrzntlty_atmc_ftpth: 0 },
        { line: "2호선", total_elevator: 155, total_escalator: 236, total_wheelchair_lift: 12, total_hrzntlty_atmc_ftpth: 0 },
        { line: "3호선", total_elevator: 88, total_escalator: 206, total_wheelchair_lift: 2, total_hrzntlty_atmc_ftpth: 2 },
        { line: "4호선", total_elevator: 80, total_escalator: 133, total_wheelchair_lift: 10, total_hrzntlty_atmc_ftpth: 0 },
        { line: "5호선", total_elevator: 176, total_escalator: 458, total_wheelchair_lift: 16, total_hrzntlty_atmc_ftpth: 0 },
        { line: "6호선", total_elevator: 110, total_escalator: 290, total_wheelchair_lift: 32, total_hrzntlty_atmc_ftpth: 12 },
        { line: "7호선", total_elevator: 128, total_escalator: 386, total_wheelchair_lift: 40, total_hrzntlty_atmc_ftpth: 4 },
        { line: "8호선", total_elevator: 57, total_escalator: 89, total_wheelchair_lift: 6, total_hrzntlty_atmc_ftpth: 0 },
        { line: "9호선(2단계)", total_elevator: 22, total_escalator: 104, total_wheelchair_lift: 0, total_hrzntlty_atmc_ftpth: 0 },
        { line: "9호선(3단계)", total_elevator: 33, total_escalator: 97, total_wheelchair_lift: 0, total_hrzntlty_atmc_ftpth: 0 }
    ];

    // 차트에 사용할 라벨과 데이터 추출
    var lineLabels = [];
    var totalElevatorData = [];
    var totalEscalatorData = [];
    var totalWheelchairLiftData = [];
    var totalHrzntltyAtmcFtpthData = [];

    lineData.forEach(function (data) {
        lineLabels.push(data.line);
        totalElevatorData.push(data.total_elevator);
        totalEscalatorData.push(data.total_escalator);
        totalWheelchairLiftData.push(data.total_wheelchair_lift);
        totalHrzntltyAtmcFtpthData.push(data.total_hrzntlty_atmc_ftpth);
    });

    // 그래프 데이터 설정
    var ctx = document.getElementById('lineChart').getContext('2d');
    var lineChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: lineLabels,
            datasets: [
                {
                    label: '엘리베이터',
                    data: totalElevatorData,
                    backgroundColor: '#4287f5'
                },
                {
                    label: '에스컬레이터',
                    data: totalEscalatorData,
                    backgroundColor: '#1759c2'
                },
                {
                    label: '휠체어리프트',
                    data: totalWheelchairLiftData,
                    backgroundColor: '#062d6b'
                },
                {
                    label: '수평자동보도',
                    data: totalHrzntltyAtmcFtpthData,
                    backgroundColor: '#adcdff'
                }
            ]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>
<hr />

	<table border="1" id="amenityTable">
    <tr>
		<td>호선</td>
		<td>역명</td>
		<td>엘리베이터</td>
		<td>에스컬레이터</td>
		<td>휠체어리프트</td>
		<td>수평자동보도</td>
	</tr>

	<c:forEach items="${amenityinfo }" var="amenityinfo">
		<tr>
		<td>${amenityinfo.line }</td>
		<td>${amenityinfo.statn_nm }</td>
		<td>${amenityinfo.elvtr }</td>
    	<td>${amenityinfo.escltr }</td>
    	<td>${amenityinfo.wheelchair_lift }</td>
    	<td>${amenityinfo.hrzntlty_atmc_ftpth }</td>
    	</tr>
	</c:forEach>
	</table>
    	 <br/>
</section>

<script>
	document.title = "MONPIS :: 서울 지하철 내 노약자, 장애인 편의시설 현황"; 
</script>
</body>

<footer>
    <p>데이터 출처: 서울시 공공데이터 포털(<a href="">링크</a>)</p>
</footer>

<script>
console.log${sumLine};
</script>
</html>