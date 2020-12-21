<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script type="text/javascript">
	$(function() {
		$('.findBtn').click(function() {
//			alert();
			popupOpen();
		})

		// 팝업 함수
		function popupOpen(){
			var url= "/find/find.do";    //팝업창 페이지 URL
			var winWidth = 700;
		    var winHeight = 500;
		    var popupOption= "width="+winWidth+", height="+winHeight;    //팝업창 옵션(optoin)
			window.open(url,"",popupOption);
		}
	})
</script>
</head>
<body>
	<div class="container" align="center">
		<form method="post" action="/login">
			<div class="form-row">
				<div class="form-group col-mb-2">
					<label for="username">아이디</label>
					<input name="username" class="form-control" id="username">
				</div>
			</div>
			<div class="form-row">
				<div class="form-group col-mb-2">
					<label for="password">비밀번호</label>
					<input type="password" name="password" class="form-control"
					id="password">
				</div>
			</div>
			<div class="form-row">
				<div class="form-group col-mb-2">
					<button class="btn btn-default">로그인</button>
				</div>
			</div>
			<!-- <div>
				<input type="checkbox" name="remember-me"> Remember Me
			</div> -->
			<input type="hidden" name="${_csrf.parameterName }"
				value="${_csrf.token }">
		</form>
		<div>${error }</div>
		<div>
			<a href="join.do">회원 가입</a>
 			<a href="#" class="findBtn">아이디/비밀번호 찾기</a>
		</div>
	</div>
</body>
</html>