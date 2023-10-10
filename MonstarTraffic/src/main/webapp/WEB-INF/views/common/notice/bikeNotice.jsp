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
	<!-- search-wrap -->
	<div class="search-wrap">
		<div class="search-form-wrap">
			<form action="bikeNotice">
				<select name="searchType">
					<c:choose>
						<c:when test="${btitcon }">
							<option value="btitcon" selected>제목+내용</option>
						</c:when>
						<c:otherwise>						
							<option value="btitcon">제목+내용</option>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${btitle }">
							<option value="btitle" selected>제목</option>
						</c:when>
						<c:otherwise>						
							<option value="btitle">제목</option>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${bcontent }">
							<option value="bcontent" selected>내용</option>
						</c:when>
						<c:otherwise>						
							<option value="bcontent">내용</option>
						</c:otherwise>
					</c:choose>
				</select> 
				<input type="text" placeholder="검색어를 입력해주세요." name="searchValue" value=${searchValue }>
				<input type="submit" value="검색">
			</form>
		</div>
	</div>
	<div class="pagination-count">
		<p>
			총 <strong>${totRowcnt }</strong> 개
		</p>
	</div>
	
	<!-- 공지사항 테이블 -->
	<table>
		<colgroup>
			<col width="15%">
			<col width="60%">
			<col width="25%">
		</colgroup>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>날짜</th>
		</tr>
		<c:forEach items="${dto }" var="dto">
			<tr>
				<td>${dto.bikeno }</td>
				<td align="left"><a href="bikeNoticeDetail?no=${dto.bikeno }">${dto.btitle }</a></td>
				<td><fmt:formatDate value="${dto.bdate }" pattern="yyyy.MM.dd"/></td>
			</tr>
		</c:forEach>
	</table>
</section>

<!-- pagination-wrap -->
	<div class="pagination-wrap">
		<!-- pagination -->
		<div class="pagination">
			<ol>
				<!-- 이전이 없을 때 disabled 클래스 추가 이전 숫자가 있다면 제거 -->
				<c:choose>
					<c:when test="${searchVO.page>1}">
						<li>
							<a href="bikeNotice?page=1&searchType=${searchType }&searchValue=${searchValue}"> 
								<i class="fa-solid fa-angles-left"></i>
							</a>
						</li>
						<li>
							<a href="bikeNotice?page=${searchVO.page-1 }&searchType=${searchType }&searchValue=${searchValue}">
								<i class="fa-solid fa-angle-left"></i>
							</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="disabled">
							<a> 
								<i class="fa-solid fa-angles-left"></i>
							</a>
						</li>
						<li class="disabled">
							<a>
								<i class="fa-solid fa-angle-left"></i>
							</a>
						</li>
					</c:otherwise>
				</c:choose>
				
				
				<!-- 현재 페이지 -->				
				<c:forEach begin="${searchVO.pageStart }" end="${searchVO.pageEnd }" var="i"> 
					<c:choose>
						<c:when test="${i eq searchVO.page }">
							<li class="current-page">
								<a> ${i } </a>
							</li>
						</c:when>
						<c:otherwise>
							<li>
								<a href="bikeNotice?page=${i }&searchType=${searchType }&searchValue=${searchValue}">${i }</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
	
				
				<c:choose>
					<c:when test="${searchVO.page < searchVO.totPage}">
						<li>
							<a href="bikeNotice?page=${searchVO.page+1 }&searchType=${searchType }&searchValue=${searchValue}">
								<i class="fa-solid fa-angle-right"></i>
							</a>
						</li>
						<li>
							<a href="bikeNotice?page=${searchVO.totPage }&searchType=${searchType }&searchValue=${searchValue}">
								<i class="fa-solid fa-angles-right"></i>
							</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="disabled">
							<a>
								<i class="fa-solid fa-angle-right"></i>
							</a>
						</li>
						<li class="disabled">
							<a>
								<i class="fa-solid fa-angles-right"></i>
							</a>
						</li>
					</c:otherwise>
				</c:choose>
			</ol>
		</div><!-- pagination -->
	</div><!-- pagination-wrap -->

</body>
</html>