<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 확인</title>
<style>
.pwFrm_div {
	margin-left: 40%;
	margin-top: 5%;
}
</style>
<script type="text/javascript">
	$(function() {
		$('.cancelBtn').click(function() {
			history.back();
		})
	})
</script>
</head>
<body>
	<div class="container">
		<h2>비밀번호 확인</h2>
		<form method="post" class="pwForm form-group">
			<div class="form-inline">
				본인 확인을 위해 비밀번호를 입력해주세요.
			</div>
			<div class="form-inline">
				<label for="userpw" class="col-sm-2 col-form-label">비밀번호</label> 
				<input class="form-control"
					type="password" name="userpw" id="pw">
			</div>
			<div class="form-inline">
				<button class="btn btn-default">확인</button>
				<button class="btn btn-default cancelBtn" type="button">취소</button>
			</div>
		</form>
		<div>${param.msg }</div>
	</div>
</body>
</html>