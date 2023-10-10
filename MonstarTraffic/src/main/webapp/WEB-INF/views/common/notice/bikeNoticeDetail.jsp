<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<header>
	<h3>서울시 공공자전거 공지사항</h3>
</header>
<section>
	<!-- 디테일 테이블 -->
	<table>
		<colgroup>
			<col width="80%">
			<col width="20%">
		</colgroup>
		<tr>
			<th class="left">${dto.btitle }</th>
			<td><fmt:formatDate value="${dto.bdate }" pattern="yyyy.MM.dd"/></td>
		</tr>
		<tr>
			<td colspan="2" align="left"><pre>${dto.bcontent }</pre></td>
		</tr>
		<c:if test="${dto.bimg ne null}">
			<tr>			
				<td colspan="2"><img src="${pageContext.request.contextPath}/resources/assets/imgs/bike/${dto.bimg }" alt="공지사항 이미지" /></td>			
			</tr>
		</c:if>
	</table>
	
	<!-- 이전글 다음글 -->
	<div align="left">
		<div style="margin:10px 0;">
			<i class="fa-solid fa-angle-up"></i> 이전글
			<c:choose>
				<c:when test="${move.last ne 9999 }">
					<a href="bikeNoticeDetail?no=${move.last }">${move.lasttitle}</a>			
				</c:when>
				<c:otherwise>
					이전글이 없습니다.
				</c:otherwise>
			</c:choose>
		</div>
		
		<div>
			<i class="fa-solid fa-angle-down"></i> 다음글
			<c:choose>
				<c:when test="${move.next ne 9999 }">
					<a href="bikeNoticeDetail?no=${move.next }">${move.nexttitle }</a>				
				</c:when>
				<c:otherwise>
					다음글이 없습니다.
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<button onclick="location.href='bikeNotice'">목록</button>
</section>

</body>
</html>