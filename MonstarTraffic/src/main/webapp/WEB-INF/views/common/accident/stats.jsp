<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>월별 교통사고 통계</title>
<!--     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> -->
    
    <style>
    a{
    text-decoration-line:none;
   
    }
    
    link{
     justify-content: space-between;
     }
    </style>
</head>
<body>
<header>
    <h3>${year}년 월별 교통사고 통계</h3>
</header>
<section>
    <canvas id="Chart"></canvas>
</section>

<script>
    // JSON 데이터를 안전하게 JavaScript로 전달
    var jArray = ${jsonList}; 
    
 // JSON 데이터에서 sum 값을 가져옴
    console.log(jArray);
    
    var accidentsum = jArray[0].sum;
    console.log(accidentsum)

    // 월별 데이터 추출
    var months = ['january', 'february', 'march', 'april', 'may', 'june', 'july', 'august', 'september', 'october', 'november', 'december'];
    
    // 월별 교통사고 통계 데이터를 그래프에 적용
    const ctx = document.getElementById('Chart').getContext('2d');
    const myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: months,
            datasets: [{
            	label: '사고 건수 (합계: ' + accidentsum + ')',


                data: months.map(function (month) {
                    return jArray[0][month];
                }),
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 2
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
    
 // `${year}` 문자열을 정수로 변환
    var Year = parseInt("${year}");

/*     if (!isNaN(currentYear)) {
        // 이전 연도와 다음 연도 계산
        var previousYear = currentYear - 1;
        var nextYear = currentYear + 1;

        // 이전 연도와 다음 연도의 href 생성
        var previousYearHref = previousYear + "-1년 데이터";
        var nextYearHref = nextYear + "+1년 데이터";

        // 링크를 HTML에 추가
        document.querySelector('a[href*="${year}-1년 데이터"]').setAttribute('href', previousYearHref);
        document.querySelector('a[href*="${year}+1년 데이터"]').setAttribute('href', nextYearHref);
    } */

</script>

<div class="btn-wrap" style="display: flex; justify-content: space-between;">
    <a href="${year - 1}">${year - 1}년 데이터</a>
    <a href="${year + 1}">${year + 1}년 데이터</a>
</div>


</body>
</html>
