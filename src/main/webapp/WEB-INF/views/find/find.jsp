<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<style type="text/css">
.maincontainer {
	padding-top: 20px;
}
</style>
<script type="text/javascript">
	$(function() {
		// 비밀번호 찾기 버튼
		$('.findUserpwBtn').click(function() {
			$('.findUseridDiv').hide();
			$('.findUserpwDiv').show();
		})

		// 아이디 찾기 버튼
		$('.findUseridBtn').click(function() {
			$('.findUserpwDiv').hide();
			$('.findUseridDiv').show();
		})

		// 아이디 찾기
		$('.useridBtn').click(function() {
			$('#foundUserid').text('');
//			alert($('#useridEmail').val());
			var email = $('#useridEmail').val();
			$.ajax({
				url : '/check/findUserid.do?email=' + email,
				success : function(userid) {
					if(userid) {
						$('.findDiv').hide();
						$('.foundDiv').show();
						$('#foundUserid').append("회원님의 아이디는 " + userid + "입니다.");
					}
// 					else {
// 						$('.findDiv').hide();
// 						$('.foundDiv').show();
// 						$('#foundUserid').append("정보를 다시 입력해주세요.");
// 					}
				},
				error : function (XMLHttpRequest, textStatus, errorThrown){
					console.log(textStatus);
					$('.foundDiv').show();
					$('#foundUserid').append("정보를 다시 입력해주세요.");
		        }
			})
		})

		// 비밀번호 찾기
		$('.userpwBtn').click(function() {
			$('#foundUserpw').text('');
			var email = $('#userpwEmail').val();
			var userid = $('#userid').val();
			$.ajax({
				url:'/check/findUserpw.do?email=' + email + '&userid=' + userid,
				success : function(){
					location = 'change.do?userid=' + userid;
				},
				error:  function (XMLHttpRequest, textStatus, errorThrown){
					console.log(textStatus);
					$('.findDiv').show();
					$('.foundDiv').show();
					$('.foundUseridDiv').hide();
					$('.foundUserpwDiv').show();
					$('#foundUserpw').append("정보를 다시 입력해주세요.");
		        }	
			})
		})
	})
</script>
</head>
<body>
	<div class="container maincontainer">
		<div class="findDiv">
			<div class="container">
				<label class="radio-inline"> <input type="radio"
					class="findUseridBtn" checked>아이디 찾기
				</label> <label class="radio-inline"> <input type="radio"
					class="findUserpwBtn">비밀번호 찾기
				</label>
			</div>
			<div class="findUseridDiv">
				가입하신 이메일을 입력해주세요.
				<form>
					<div class="form-group">
						<label for="email">이메일</label> <input name="email"
							class="form-control" id="useridEmail">
						<button class="btn useridBtn" type="button">확인</button>
					</div>
				</form>
			</div>
			<div class="findUserpwDiv" style='display: none'>
				가입하신 아이디와 이메일을 입력해주세요.
				<form>
					<div class="form-group">
						<label for="userid">아이디</label> <input name="userid"
							class="form-control" id="userid">
					</div>
					<div class="form-group">
						<label for="email">이메일</label> <input name="eamil"
							class="form-control" id="userpwEmail">
						<button class="btn userpwBtn" type="button">확인</button>
					</div>
				</form>
			</div>
		</div>
		<div class="foundDiv" style='display: none'>
			<div class="foundUseridDiv">
				 <span id="foundUserid"></span>
			</div>
			<div class="foundUserpwDiv" style='display: none'>
				<span id="foundUserpw"></span>			
			</div>
		</div>
	</div>
</body>
</html>