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
		<h3>공지사항</h3>
	</header>
	<section>
		<div class="search-wrap">
			<div class="search-form-wrap">
				<form action="">
					<select name="" id="">
						<option value="1">제목+내용</option>
						<option value="1">제목</option>
						<option value="1">내용</option>
					</select> 
					<input type="text" placeholder="검색어를 입력해주세요.">
					<input type="button" value="검색">
				</form>
			</div>
		</div>
		<div class="pagination-count">
			<p>
				총 <strong>92</strong> 개
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
				<th>발생일시</th>
				<th>완료예정</th>
			</tr>
			<tr>
				<td>1</td>
				<td class="left">
					<a href=""> Lorem ipsum dolor sit amet,
						consectetur adipisicing elit. Libero fuga reiciendis voluptatem
						pariatur nisi cumque et recusandae itaque, autem quae velit
						dolorem adipisci repudiandae amet minus soluta quibusdam repellat
						voluptates?
					</a>
				</td>
				<td>2023.00.00</td>
				<td>2023.00.00</td>
			</tr>
		</table>
	</section>
	<!-- pagination-wrap -->
	<div class="pagination-wrap">
		<!-- pagination -->
		<div class="pagination">
			<ol>
				<!-- 이전이 없을 때 disabled 클래스 추가 이전 숫자가 있다면 제거 -->
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
				<!-- 현재 페이지 -->
				<li class="current-page">
					<a> 1 </a>
				</li>
				<!-- 현재 페이지가 아닐 때 -->
				<li>
					<a> 2 </a>
				</li>
				<li>
					<a>
						<i class="fa-solid fa-angle-right"></i>
					</a>
				</li>
				<li>
					<a>
						<i class="fa-solid fa-angles-right"></i>
					</a>
				</li>
			</ol>
		</div><!-- pagination -->
	</div><!-- pagination-wrap -->
</body>
</html>