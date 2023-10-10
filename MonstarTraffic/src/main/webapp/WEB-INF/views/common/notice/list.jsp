<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<header>
		<h3>공지사항</h3>
	</header>
	<section>
		<div class="search-wrap">
			<div class="search-form-wrap">
				<form action="${ctx }/notice" method="post" >
					<select name="searchType" id="searchType">
						<option value="titcon" ${titcon ? 'selected' : ''}>제목+내용</option>
						<option value="title" ${title ? 'selected' : ''}>제목</option>
						<option value="content" ${content ? 'selected' : ''}>내용</option>
					</select> 
					<input type="text" name="sk" placeholder="검색어를 입력해주세요." value="${searchKey }">
					<input type="submit" value="검색">
				</form>
			</div>
		</div>
		<div class="pagination-count">
			<p>
				총 <strong>${totRowcnt }</strong> 개
			</p>
		</div>
		<table>
			<colgroup>
				<col width="100px">
				<col width="">
				<col width="120px">
				<col width="120px">
			</colgroup>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>조회수</th>
				<th>작성일</th>
			</tr>
			<c:forEach var="dto" items="${list }">
			<tr>
				<td>${dto.no }</td>
				<td class="left">
					<a href="${ctx }/notice/view?no=${dto.no}">
					${dto.title }
					</a>
				</td>
				<td>${dto.hit }</td>
				<td>${dto.regdate }</td>
			</tr>
			</c:forEach>
		</table>
	</section>
	<!-- pagination-wrap -->
	<div class="pagination-wrap">
		<!-- pagination -->
		<div class="pagination">
			<ol>
				<c:choose>
					<c:when test="${searchVO.page>1}">
						<li><a href="${ctx }/notice?page=1"><i
								class="fa-solid fa-angles-left"></i></a></li>
						<li><a
							href="${ctx }/notice?page=${searchVO.page-1 }"><i
								class="fa-solid fa-angle-left"></i></a></li>
					</c:when>
					<c:otherwise>
						<li class="disabled"><a> <i
								class="fa-solid fa-angles-left"></i>
						</a></li>
						<li class="disabled"><a> <i
								class="fa-solid fa-angle-left"></i>
						</a></li>
					</c:otherwise>
				</c:choose>
				<!-- 14 -->
				<c:forEach begin="${searchVO.pageStart }" end="${searchVO.pageEnd }"
					var="i">
					<c:choose>
						<c:when test="${i eq searchVO.page }">
							<!-- 내가 클릭한 페이지의 숫자랑 같냐 -->
							<li class="current-page"><a> ${i } </a></li>
						</c:when>
						<c:otherwise>
							<li><a
								href="${ctx }/notice?page=${i }&sk=${searchKey }&title=${title==true?'title':''}&content=${content==true?'content':''}">${i }</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:choose>
					<c:when test="${searchVO.page < searchVO.totPage}">
						<li><a
							href="${ctx }/notice?page=${searchVO.page+1 }"><i
								class="fa-solid fa-angle-right"></i></a></li>
						<li><a
							href="${ctx }/notice?page=${searchVO.totPage }"><i
								class="fa-solid fa-angles-right"></i></a></li>
					</c:when>
					<c:otherwise>
						<li class="disabled"><a> <i
								class="fa-solid fa-angle-right"></i>
						</a></li>
						<li class="disabled"><a> <i
								class="fa-solid fa-angles-right"></i>
						</a></li>
					</c:otherwise>
				</c:choose>
			</ol>
		</div>
		<!-- pagination -->
	</div>
	<!-- pagination-wrap -->
</body>
</html>