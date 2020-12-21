<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<c:if test="${not empty error }">
	<script type="text/javascript">
		alert('비밀번호 변경 실패. 잠시 후 다시 시도해주세요');
	</script>
</c:if>
<c:if test="!${not empty success }">
	<script type="text/javascript">
		alert('비밀번호 확인 완료');
	</script>
</c:if>
<style>
.chpw_div {
	margin-left: 40%;
	margin-top: 5%;
}

.cancel {
	margin-left: 25%;
	font-size: 1.5rem;
}
</style>
<script>
	$(function() {
		// 변경 폼 포커스
		$('#newPwd').focus();
		// 서브밋 버튼을 누른 후
		$('.chpw').submit(function() {
			// 비밀번호를 입력하지 않았을 때
			if (!$('#pw').val()) {
				$('#msg_Pw').text('비밀번호를 입력해주세요');
				$('#pw').focus();
				return false;
			}
		});
		// 취소
		$('.cancelBtn').click(function() {
			var userid = $('#userid').val();
			location = 'my.do?userid=' + userid;
		})
		
	});
</script>
</head>
<body>
	<div class="container">
		<h2 align="center">비밀번호 변경</h2>
		<form method="post" class="changeForm">
			<div class="changeDiv">
				<input type="hidden" id="userid" value="${param.userid }">
				<input type="password" name="userpw" id="userpw" class="form-control"> 
			 	<button class="btn btn-default">변경 완료</button>
			 	<button class="cancelBtn btn btn-default" type="button">변경 취소</button>
			</div>
		</form>
	</div>
</body>
</html>