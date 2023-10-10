<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.ck.ck-toolbar.ck-toolbar_grouping{
	border:none;
}
.ck-blurred.ck.ck-content.ck-editor__editable {
	width: 100%;
	height: auto;
	min-height: auto;
	max-height:none;
	padding:20px 30px!important;
	border-color:#ececec;
}
#readEditor * {
	font-weight: auto;
}
.readTitle{
	background:rgb(226 232 249 / 39%);
	text-align:left;
	padding:30px;
}
.readTitle h3{
	font-weight:400;
}
</style>
</head>
<body>
	<header>
		<h3>공지사항</h3>
	</header>
	<section class="editor-wrap">
		<div class="readTitle">
			<h3>${dto.title }</h3>
		</div>
		<div id="readEditor">${dto.content}</div>
		<div class="board-pagination">
			<div class="board-prev">
				이전글 <i class="fa-solid fa-caret-up"></i>
				<c:choose>
					<c:when test="${dto.next<9999}">
						<a
							href="${pageContext.request.contextPath}/notice/view?no=${dto.next}">
							${dto.nexttitle } </a>
					</c:when>
					<c:otherwise>
						<a> 이전글이 없습니다. </a>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="board-next">
				다음글 <i class="fa-solid fa-caret-down"></i>
				<c:choose>
					<c:when test="${dto.last<9999}">
						<a
							href="${pageContext.request.contextPath}/notice/view?no=${dto.last}">
							${dto.lasttitle } </a>
					</c:when>
					<c:otherwise>
						<a> 다음글이 없습니다. </a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</section>
	<!-- board-pagination -->
	<section class="right">
		<button onclick="location.href='${pageContext.request.contextPath}/notice'">목록</button>
	</section>
	<script
		src="https://cdn.ckeditor.com/ckeditor5/40.0.0/classic/ckeditor.js"></script>
	<script
		src="https://cdn.ckeditor.com/ckeditor5/40.0.0/classic/translations/ko.js"></script>
	<script>
	ClassicEditor
    .create(document.querySelector('#readEditor'), {
        readOnly: true,
        toolbar: []
    })
    .then(editor => {
    	editor.isReadOnly; // `false`.
    	editor.enableReadOnlyMode( 'my-feature-id' );
    	editor.isReadOnly; // `true`.
    })
    .catch(error => {
        console.error('Oops, something went wrong!');
        console.error(error);
    });


</script>

</body>
</html>