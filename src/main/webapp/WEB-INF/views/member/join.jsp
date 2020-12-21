<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<style type="text/css">
.form-inline {
	margin: 15px;
	align-self: center;
}

.container {
	margin-top: 30px;
}

.btn {
	margin-left: 10px;
}

.title {
	margin-bottom: 20px;
}
</style>
<script type="text/javascript">
	$(function() {
		var id_clicked = 0;
		var email_clicked = 0;
		var email_send_clicked = 0;
		var email_conf_clicked = 0;
		// 아이디 포커스
		$('#id').focus();
		// 아이디 중복 체크
		$('.idBtn').click(function() {
			var userid = $('#id').val();
//			alert(id);
			$.ajax({
				url : "/check/id_check.do?userid=" + userid,
				success : function(result) {
					if (result == 0) {
//						alert("사용중인 아이디 입니다");
						$('#msg_id').text("이미 사용중인 아이디입니다.");
					} else {
						console.log(result);
//						alert("사용 가능한 아이디 입니다");
						$('#msg_id').text("사용 가능한 아이디입니다.");
						id_clicked++;
					}
				}
			})
		})
		
		// 비밀번호 확인
		$("#pw2").on("change keyup paste", function() {
			// 비밀번호가 다를 때
			if ($("#pw1").val() != $("#pw2").val()) {
				$('#msg_pw2').text('비밀번호가 다릅니다. 비밀번호를 확인해 주세요.');
			}
			// 비밀번호가 같을 때
			if ($("#pw1").val() == $("#pw2").val()) {
				$('#msg_pw2').text('비밀번호가 같습니다.');
			}
		})
		
		// 선택한 이메일 주소 넣기
		$("#domain").change(function () {
			$("#email2").val($("#domain > option:selected").val());
		});
		
		// 이메일 인증번호 보내기
		$('.emailBtn').click(function() {
			var emailText = $('#email1').val() + '@' + $('#email2').val();
			// 이메일 중복체크
			$.ajax({
				url : "/check/email_check.do?email=" + emailText,
				success : function(result) {
					if (result == 0) {
						$('#msg_email').text("이미 사용중인 이메일입니다.");
					} else {
						console.log(result);
						$('#msg_email').text("사용 가능한 이메일입니다. 인증번호 메일을 발송중입니다.");
						email_clicked++;
						$('.email_keyDiv').show();
//						alert('emailText:' + emailText);
//						var email = $('#email').val('""' + emailText + '""');
//						alert('email:' + email);
						// 이메일 인증
						$.ajax({
							url:'/check/email_send.do?email=' + emailText,
							success: function(result) {
								alert('이메일 전송 완료. 인증번호를 확인해주세요.');
								email_send_clicked++;
							},
							error : function(e) {
								alert('이메일 전송 실패. 잠시 후 다시 시도해주세요.');
								$('.email_keyDiv').hide();
							}
						})
					}
				}
			})
		})
		// 인증 번호 확인
		$('.email_keyBtn').click(function() {
			let email = $('#email1').val() + '@' + $('#email2').val();
			let inputCode = $('#email_key').val();
			console.log('이메일' + email);
			console.log('인증코드' + inputCode);
			$.ajax({
				url:'/check/email_conf.do?email=' + email + '&inputCode=' + inputCode,
				success:function(result) {
					console.log(result);
					if(result == 1) {
						email_conf_clicked++;
						alert('인증완료');
					}
					else {
						alert('비밀번호가 틀립니다.');
					}
				}
			})
			
		})
		
		// 지역 선택
		var area0 = [ "시/도 선택", "서울특별시", "인천광역시", "대전광역시", "광주광역시", "대구광역시",
				"울산광역시", "부산광역시", "경기도", "강원도", "충청북도", "충청남도", "전라북도", "전라남도",
				"경상북도", "경상남도", "제주도" ];
		var area1 = [ "강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구",
				"노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구",
				"성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구" ];
		var area2 = [ "계양구", "남구", "남동구", "동구", "부평구", "서구", "연수구", "중구",
				"강화군", "옹진군" ];
		var area3 = [ "대덕구", "동구", "서구", "유성구", "중구" ];
		var area4 = [ "광산구", "남구", "동구", "북구", "서구" ];
		var area5 = [ "남구", "달서구", "동구", "북구", "서구", "수성구", "중구", "달성군" ];
		var area6 = [ "남구", "동구", "북구", "중구", "울주군" ];
		var area7 = [ "강서구", "금정구", "남구", "동구", "동래구", "부산진구", "북구", "사상구",
				"사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구", "기장군" ];
		var area8 = [ "고양시", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시", "남양주시",
				"동두천시", "부천시", "성남시", "수원시", "시흥시", "안산시", "안성시", "안양시", "양주시",
				"오산시", "용인시", "의왕시", "의정부시", "이천시", "파주시", "평택시", "포천시", "하남시",
				"화성시", "가평군", "양평군", "여주군", "연천군" ];
		var area9 = [ "강릉시", "동해시", "삼척시", "속초시", "원주시", "춘천시", "태백시", "고성군",
				"양구군", "양양군", "영월군", "인제군", "정선군", "철원군", "평창군", "홍천군", "화천군",
				"횡성군" ];
		var area10 = [ "제천시", "청주시", "충주시", "괴산군", "단양군", "보은군", "영동군", "옥천군",
				"음성군", "증평군", "진천군", "청원군" ];
		var area11 = [ "계룡시", "공주시", "논산시", "보령시", "서산시", "아산시", "천안시", "금산군",
				"당진군", "부여군", "서천군", "연기군", "예산군", "청양군", "태안군", "홍성군" ];
		var area12 = [ "군산시", "김제시", "남원시", "익산시", "전주시", "정읍시", "고창군", "무주군",
				"부안군", "순창군", "완주군", "임실군", "장수군", "진안군" ];
		var area13 = [ "광양시", "나주시", "목포시", "순천시", "여수시", "강진군", "고흥군", "곡성군",
				"구례군", "담양군", "무안군", "보성군", "신안군", "영광군", "영암군", "완도군", "장성군",
				"장흥군", "진도군", "함평군", "해남군", "화순군" ];
		var area14 = [ "경산시", "경주시", "구미시", "김천시", "문경시", "상주시", "안동시", "영주시",
				"영천시", "포항시", "고령군", "군위군", "봉화군", "성주군", "영덕군", "영양군", "예천군",
				"울릉군", "울진군", "의성군", "청도군", "청송군", "칠곡군" ];
		var area15 = [ "거제시", "김해시", "마산시", "밀양시", "사천시", "양산시", "진주시", "진해시",
				"창원시", "통영시", "거창군", "고성군", "남해군", "산청군", "의령군", "창녕군", "하동군",
				"함안군", "함양군", "합천군" ];
		var area16 = [ "서귀포시", "제주시", "남제주군", "북제주군" ];

		// 시/도 선택 박스 초기화
		$("select[id^=sido]").each(
				function() {
					$selsido = $(this);
					$.each(eval(area0), function() {
						$selsido.append("<option value='"+this+"'>" + this
								+ "</option>");
					});
					$selsido.next().append("<option value=''>구/군 선택</option>");
				});

		// 시/도 선택시 구/군 설정
		$("select[id^=sido]").change(
				function() {
					var area = "area"
							+ $("option", $(this)).index(
									$("option:selected", $(this))); // 선택지역의 구군 Array
					var $gugun = $(this).next(); // 선택영역 군구 객체
					$("option", $gugun).remove(); // 구군 초기화

					if (area == "area0")
						$gugun.append("<option value=''>구/군 선택</option>");
					else {
						$.each(eval(area), function() {
							$gugun.append("<option value='"+this+"'>" + this
									+ "</option>");
						});
					}
				});

		// 폼 전송
		$('.joinForm').submit(function() {
			// id를 입력하지 않았을 때
			if (!$('#id').val()) {
				$('#msg_id').text('아이디를 입력해주세요');
				$('#id').focus();
				return false;
			}
			// id 중복체크를 하지 않았을 때
			if(id_clicked <= 0) {
				$('#msg_id').text('아이디 중복체크를 해주세요');
				return false;
			}
			// 비밀번호를 입력하지 않았을 때
			if (!$('#pw1').val()) {
				$('#msg_pw1').text('비밀번호를 입력해주세요');
				$('#pw1').focus();
				return false;
			}
			// 비밀번호 확인란을 입력하지 않았을 때
			if (!$('#pw2').val()) {
				$('#msg_pw2').text('비밀번호 확인란을 입력해주세요');
				$('#pw2').focus();
				return false;
			}
			// 비밀번호가 다를 때
			if ($("#pw1").val() != $("#pw2").val()) {
				$('#msg_pw2').text('비밀번호가 다릅니다. 비밀번호를 확인해 주세요.');
				$("#pw2").focus();
				return false;
			}
			// 별명을 입력하지 않았을 때
            if(!$('#nickname').val()) {
                 $('#msg_nickname').text('이름을 입력해주세요');
                 $('#nickname').focus();
                 return false;
             }
            // email 체크를 안했을 때
            if(email_send_clicked <= 0) {
				$('#msg_email').text('이메일 인증을 받아주세요');
				return false;
			}
            if(email_conf_clicked <= 0) {
				$('#msg_email').text('이메일 인증번호를 입력해주세요');
				return false;
			}
            // email 조합
            email = $('#email1').val() + '@' + $('#email2').val();
            $('#email').val(email);
			/* // sido와 gugun 조합
			local1 = $('#sido1').val() + " " + $('#gugun1').val();
			local2 = $('#sido2').val() + " " + $('#gugun2').val();
			local3 = $('#sido3').val() + " " + $('#gugun3').val();
			//alert(local1);
			if (local1 == "시/도 선택 구/군 선택")
				$('#local1').val('');
			else
				$('#local1').val(local1);
			if (local2 == "시/도 선택 구/군 선택")
				$('#local2').val('');
			else
				$('#local2').val(local2);
			if (local3 == "시/도 선택 구/군 선택")
				$('#local3').val('');
			else
				$('#local3').val(local3);
			//alert($('#local1').val()); */
		})
	})
</script>
</head>
<body>
	<div class="container">
		<h2 class="title">회원 가입</h2>
		<form method="post" class="form-group joinForm" action="/member/join.do">
			<div class="form-inline">
				<label for="userid" class="col-sm-2 col-form-label">아이디</label> <input
					class="form-control" id="id" name="userid"
					pattern=".{6,20}" maxlength="20">
				<button class="btn btn-default idBtn" type="button">중복 확인</button>
				<span id="msg_id"></span>
				<div>아이디는 6글자 이상 20글자 이하로 입력해주세요.</div>
			</div>
			<div class="form-inline">
				<label for="pw1" class="col-sm-2 col-form-label">비밀번호</label> <input
					type="password" class="form-control" id="pw1" name="userpw"
					pattern=".{8,50}" maxlength="50"> <span
					id="msg_pw1"></span>
				<div>비밀번호는 8글자 이상 50글자 이하로 입력해주세요.</div>
			</div>
			<div class="form-inline">
				<label for="pw2" class="col-sm-2 col-form-label">비밀번호 확인</label> <input
					type="password" class="form-control" id="pw2"
					pattern=".{8,50}" maxlength="50"> <span
					id="msg_pw2"></span>
			</div>
			<!-- 본인확인 이메일 -->
			<div class="form-inline">
				<label for="email" class="col-sm-2 col-form-label">이메일</label> <input
					class="form-control" id="email1" name="email1" 
					pattern=".{6,20}" maxlength="90"> @ 
					<input class="form-control" id="email2" name="email2" 
					pattern=".{6,20}" maxlength="90">
					<select class="form-control" id="domain">
						<option>직접 입력</option>
						<option>naver.com</option>
						<option>gmail.com</option>
						<option>daum.net</option>
						<option>nate.com</option>
					</select>
					<input type="hidden" name="email" id="email">
				<button class="btn btn-default emailBtn" type="button">
					인증번호 받기</button>
				<span id="msg_email"></span>
				<div>인증번호 발송을 위한 이메일 입력입니다. 정확하게 입력해주세요.</div>
			</div>
			<div class="form-inline email_keyDiv" style="display: none">
				<label for="email_key" class="col-sm-2 col-form-label">인증번호</label>
				<input class="form-control" id="email_key" name="email_key">
				<button class="btn btn-default email_keyBtn" type="button">
					인증번호 확인</button>
			</div>
			<div class="form-inline">
				<label for="nickname" class="col-sm-2 col-form-label">별명</label> <input
					class="form-control" id="nickname" name="nickname"
					pattern=".{2,30}" maxlength="30">
					<span id="msg_nickname"></span>
			</div>
			<div class="form-inline">
				<label for="local1" class="col-sm-2 col-form-label">선호 지역1</label> <select
					id="sido1" class="form-control" name="sido1"></select> <select id="gugun1"
					class="form-control" name="gugun1"></select> 
					<!-- <input name="local1" type="hidden" id="local1"> -->
			</div>
			<div class="form-inline">
				<label for="local2" class="col-sm-2 col-form-label">선호 지역2</label> <select
					id="sido2" class="form-control" name="sido2"></select> <select id="gugun2"
					class="form-control" name="gugun2"></select> 
					<!-- <input name="local2" type="hidden" id="local2"> -->
			</div>
			<div class="form-inline">
				<label for="local3" class="col-sm-2 col-form-label">선호 지역3</label> <select
					id="sido3" class="form-control" name="sido3"></select> <select id="gugun3"
					class="form-control" name="gugun3"></select> 
					<!-- <input name="local3" type="hidden" id="local3"> -->
			</div>
			<div class="form-inline">
				<button class="btn btn-default">작성 완료</button>
				<button class="btn btn-default" type="reset">다시 작성</button>
				<a href="/" class="btn btn-default"> 작성 취소 </a>
			</div>
		</form>
	</div>
</body>
</html>