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
		<h3>공지사항 글작성</h3>
	</header>
	<section>
		<form action="${pageContext.request.contextPath}/notice/insert" method="post" enctype="multipart/form-data" class="form">
			<input type="text" name="title" placeholder="제목을 입력해주세요." />
			<div style="width: 100%;">
				<textarea name="content" id="editor"></textarea>
			</div>
			<input type="submit" value="작성">
		</form>
	</section>


	<!-- ck에디터 -->
	<script
		src="https://cdn.ckeditor.com/ckeditor5/40.0.0/classic/ckeditor.js"></script>
	<script
		src="https://cdn.ckeditor.com/ckeditor5/40.0.0/classic/translations/ko.js"></script>
	<script>
		ClassicEditor.create(document.querySelector('#editor'), {
			language : "ko",
			encoding: "utf-8",
			ckfinder:{
				uploadUrl : 'ckUpload',
				fileNameEncoding: 'utf-8'
			},
		});
	</script>
</body>
</html>