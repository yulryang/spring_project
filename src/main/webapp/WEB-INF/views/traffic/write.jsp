<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글쓰기</title>

<!-- Bootstrap 라이브러리 등록 CDN방식 -->
<!--  <meta name="viewport" content="width=device-width, initial-scale=1">  -->
<!--  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">  -->
<!--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>  -->
<!--  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>  -->

</head>
<body>
<div class="container">
	<h1>게시판 글쓰기</h1>
	<form method="post">
		<div class="form-group">
			<label for="title">제목:</label>
			<input type="text" class="form-control" id="title"
			name="title" required="required" pattern=".{4,100}"
			maxlength="100">
		</div>
  
		<div class="form-group">
			<label for="content">내용:</label>
			<textarea class="form-control" rows="5" id="content"
			name="content"></textarea>
		</div>

		
 <!--  		
		<div class="form-group">
			<label for="content">오전 06시:</label>
			<textarea class="form-control" rows="5" id="content"
			name="content"></textarea>
		</div>
		<div class="form-group">
			<label for="content">오전 07시:</label>
			<textarea class="form-control" rows="5" id="content"
			name="content"></textarea>
		</div>
		<div class="form-group">
			<label for="content">오전 08시:</label>
			<textarea class="form-control" rows="5" id="content"
			name="content"></textarea>
		</div>
		<div class="form-group">
			<label for="content">오전 09시:</label>
			<textarea class="form-control" rows="5" id="content"
			name="content"></textarea>
		</div>
		<div class="form-group">
			<label for="content">오전 10시:</label>
			<textarea class="form-control" rows="5" id="content"
			name="content"></textarea>
		</div>
		<div class="form-group">
			<label for="content">오전 11시:</label>
			<textarea class="form-control" rows="5" id="content"
			name="content"></textarea>
		</div>
		<div class="form-group">
			<label for="content">낮 12시:</label>
			<textarea class="form-control" rows="5" id="content"
			name="content"></textarea>
		</div>
		<div class="form-group">
			<label for="content">오후 13시:</label>
			<textarea class="form-control" rows="5" id="content"
			name="content"></textarea>
		</div>
		<div class="form-group">
			<label for="content">오후 14시:</label>
			<textarea class="form-control" rows="5" id="content"
			name="content"></textarea>
		</div>
		<div class="form-group">
			<label for="content">오후 15시:</label>
			<textarea class="form-control" rows="5" id="content"
			name="content"></textarea>
		</div>
		<div class="form-group">
			<label for="content">오후 16시:</label>
			<textarea class="form-control" rows="5" id="content"
			name="content"></textarea>
		</div>
		<div class="form-group">
			<label for="content">오후 17시:</label>
			<textarea class="form-control" rows="5" id="content"
			name="content"></textarea>
		</div>
		<div class="form-group">
			<label for="content">오후 18시:</label>
			<textarea class="form-control" rows="5" id="content"
			name="content"></textarea>
		</div>
		<div class="form-group">
			<label for="content">오후 19시:</label>
			<textarea class="form-control" rows="5" id="content"
			name="content"></textarea>
		</div>
		<div class="form-group">
			<label for="content">오후 20시:</label>
			<textarea class="form-control" rows="5" id="content"
			name="content"></textarea>
		</div>
		<div class="form-group">
			<label for="content">오후 21시:</label>
			<textarea class="form-control" rows="5" id="content"
			name="content"></textarea>
		</div>
		<div class="form-group">
			<label for="content">오후 22시:</label>
			<textarea class="form-control" rows="5" id="content"
			name="content"></textarea>
		</div>
-->			
		<div class="form-group">
			<label for="writer">작성자:</label>
			<input type="text" class="form-control" id="writer"
			name="writer" required="required" pattern="[가-힣a-zA-Z]{2,10}"
			maxlength="10">
		</div>
		
		<div class="form-group">
			<label for="pw">비밀번호:</label>
			<input type="password" class="form-control" id="pw"
			name="pw" required="required" pattern=".{3,50}"
			maxlength="50">
		</div>
	
		<button>등록</button>
	</form>
</div>
</body>
</html>