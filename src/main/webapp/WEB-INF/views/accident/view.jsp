<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>교통 사고 분석 글보기</title>
<!-- 엄재범 20201008 -->
<!-- Bootstrap 라이브러리 등록 CDN방식 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- 댓글 js모듈 등록 -->
<script src="/resources/js/reply.js"></script>

<script type="text/javascript">
$(function(){

	// 댓글 리스트는 이벤트가 없더라도 뿌려야 한다.
	getList(1)
	
	// 댓글 리스트를 가져오는 함수 선언 - 호출을 해야 실행된다.
	function getList(page){
		// 기본페이지 처리
		if(!page) page = 1;
		// 데이터 수집
		var pageInfo = {};
		pageInfo.page = page;
		pageInfo.no = $("#no").text();
		// ajax 객체 호출 처리 - get 방식으로 처리할 거라면 body에 안들어 가고 url에 포함이
		replyService.list(pageInfo,
// 			function(){alert("리스트가져오기 성공");})
			// 성공했을 때의 함수 -> 콜백함수로 쓸거라서 result 를 넣어줌
			function(result){
				// 샘플데이터 찍어보기- [],[],[]
				//alert(JSON.stringify(result));
				//alert(result[0].rno); //16

				//데이터를 표시할 div > ul 내용을 없앤다.
				$("#replyListDiv > ul").empty();
				
				// 데이터가 많으므로 반복문 처리를 한다.
				$(result).each(function(idx, vo){
	// ul 아래 태그 복사 양식에 맞게 수정
	  var src="";
	  src += "<li class='list-group-item rowData'>"; //closest 위로 올라가면서 찾아감
	  src += "<span class='rno'>"+vo.rno
// 	  		+ "</span>. " + vo.content;
			+ "</span>. <span class='content'>" + vo.content + "</span>";
	  src += "<span class='badge' style='background:none'>";
	  src += "<button class='replyUpdateBtn btn btn-default'>수정</button>";
	  src += "<button class='replyDeleteBtn btn btn-default'>삭제</button>";
	  src += "</span>"
	  src += "<hr/>";
// 	  src += "이름"+vo.writer+"("+vo.writeDate+")";
	  src += "<span class='writer'>" + vo.writer 
			+ "</span>(" + vo.writeDate + ")";
	  src += "</li>";
	  // 작성된 li 태그를 replyListDiv 안에 ul tag 에 추가
	  $("#replyListDiv > ul").append(src);
						
				});
			});
	}
	
	$("#deleteBtn").click(function(){
		var pw = prompt("비밀번호 입력 :");
// 		alert(pw);
		if(pw.length >= 4){
			$("#deletePw").val(pw);
// 			alert($("#deletePw").val());
			$("#deleteForm").submit();
			return;
		}
		alert("비밀번호는 4자 이상 50자 이내로 입력하셔야 합니다.");
		// 화면 이동을 막는다.
		return false;
	});
	
	//------------ 댓글 처리 이벤트 -----------
	
	
	
	//------------ 댓글 수정을 위한 모달창 여는 이벤트 -----------
// 	$(".replyUpdateBtn").click(function(){
// 		alert("댓글수정버튼클릭됨.");
// 	});// 클릭 이벤트 처리 안된다. // on 함수를 이용
	// 아작스를 통해 이벤트를 수정할 수 없다? // 지나간 버스에 손흔들기 
	// .on(event[,find(sel).click][,data],handler))
	$("#replyListDiv").on("click", ".replyUpdateBtn",
			//리플리스트디브 아이디를 찾아 on 함수 적용.
			//리플수정버튼 클래스를 찾아 클릭 이벤트 적용.
			//적용할 함수는 아래와 같다.
		function(){
			alert("댓글수정버튼클릭됨.");
			$("#myModal").find(".modal-title").text("댓글 수정");
				//수정데이터세팅
				var rowData = $(this).closest(".rowData");
// 				alert(rowData);
// 				alert(rowData.html());
// 				alert(rowData.find(".rno").text());
				$("#rno").val(rowData.find(".rno").text());
				// 데이터가 들어감을 확인했기에 hidden으로 다시 바꿔준다.
				$("#content").val(rowData.find(".content").text());
				$("#writer").val(rowData.find(".writer").text());

				// 버튼 처리
				$("#replyWriteProcessBtn").hide();
				$("#replyUpdateProcessBtn").show();

				// 모달창 보이기
			$("#myModal").modal("show");
		}
	);
	//------------ 댓글 수정 처리 이벤트 -----------
	$("#replyUpdateProcessBtn").click(function(){
		// 데이터 수집 - form 밖에 button이므로 submit이 일어나지 않는다.
		var reply = {};
		reply.rno = $("#rno").val();
		reply.content = $("#content").val();
		reply.writer = $("#writer").val();
		reply.replyPage = $("#replyPage").text();
// 		alert(reply);
// 		alert(JSON.stringify(replyVO));
		// 처리 호출 - JSON형식의 문자열로 변환
		replyService.update(JSON.stringify(reply),
// 			function(){ // 리플 페이지 처리 전
			function(replyPage){
				// 모달창 입력 란은 비운다. = 데이터가 없는 것으로 셋팅한다.
				$("#content").val("");
				$("#writer").val("");
				// 모달창 안보이기 - 닫기
				$("#myModal").modal("hide");
				alert('댓글쓰기 완료');
				// 댓글이 달리면 댓글 리스트를 다시 뿌린다.
					//리플 페이지 확인용
					alert(replyPage)
// 				getList(1); 리플페이지 처리 전
				getList(replyPage);
			});
	}); // 댓글 수정 처리 이벤트 끝
	
	//------------ 댓글 수정을 위한 모달창 여는 이벤트 -----------
	$("#replyWriteBtn").click(function(){
		$("#myModal").find(".modal-title").text("댓글쓰기");
// 		// 데이터 비우기 - 수정 시 내용이 들어가므로
		$("#rno").val("");
		$("#content").val("");
		$("#writer").val("");

		// 버튼 처리
		$("#replyWriteProcessBtn").show();
		$("#replyUpdateProcessBtn").hide();
	});
	
	//------------ 댓글 달기 처리 이벤트 -----------
	$("#replyWriteProcessBtn").click(function(){
		// 데이터 수집 - form 밖에 button이므로 submit이 일어나지 않는다.
		var reply = {};
		reply.no = $("#no").text();
		reply.content = $("#content").val();
		reply.writer = $("#writer").val();
// 		alert(reply);
// 		alert(JSON.stringify(replyVO));
		// 처리 호출 - JSON형식의 문자열로 변환
		replyService.add(JSON.stringify(reply),
			function(){
				// 모달창 입력 란은 비운다. = 데이터가 없는 것으로 셋팅한다.
				$("#content").val("");
				$("#writer").val("");
				// 모달창 안보이기 - 닫기
				$("#myModal").modal("hide");
				alert('댓글쓰기 완료');
				// 댓글이 달리면 댓글 리스트를 다시 뿌린다.
				getList(1);
			});
	});
});
</script>

</head>
<body>
<div class="container">
<h1>교통사고분석 글보기</h1>
<table class="table">
<tr>
	<th>번호</th>
	<td id="no">${vo.no }</td>
</tr>
<tr>
	<th>제목</th>
	<td>${vo.title }</td>
</tr>
<tr>
	<th>내용</th>
	<td><pre style="border: none;">${vo.content }</pre></td>
</tr>
<tr>
	<th>작성자</th>
	<td>${vo.writer }</td>
</tr>
<tr>
	<th>작성일</th>
	<td>
		<fmt:formatDate value="${vo.writeDate }"
		 pattern="yyyy.MM.dd"/>
	</td>
</tr>
<tr>
	<th>조회수</th>
	<td>${vo.hit }</td>
</tr>
<tr>
	<td colspan="2">
		<a href="update.do?no=${vo.no }" class="btn btn-defualt">수정</a>
		<a href="#" class="btn btn-defualt" id="deleteBtn">삭제</a>
		<a href="list.do" class="btn btn-defualt">리스트</a>
	</td>
</tr>
</table>
<!-- 댓글처리를 위한 div -->
<div>
<!-- 
	<button type="button" class="btn btn-default"
	 data-toggle="modal" data-target="#myModal"
	 id="replyWriteBtn"
	 >댓글달기</button>
	 <span id="replyPage">1</span>
	 -->
</div>

<!-- 댓글 리스트 -->
<div id="replyListDiv">
  <ul class="list-group">
  	<!--
	  <li class="list-group-item rowData">
	  	<span class="rno">번호</span>. 내용 입력
	  	<hr/>
	  	이름(작성일)
	  	<span class="badge">
	  	 <button class="replyUpdateBtn btn btn-default">수정</button>
	  	 <button class="replyDeleteBtn btn btn-default">삭제</button>
	  	</span>
	  </li>
	-->
  </ul>
</div>

</div><!-- end of container -->
<!-- 삭제를 위한 form tag : 보이지 않는다.-->
<form action="delete.do" method="post" id="deleteForm">
	<input type="hidden" name="no" value="${vo.no }" />
	<input type="hidden" name="pw" id="deletePw"/>
</form>

<!-- Modal : 처음에는 안보이다가 이벤트가 발생되면 나타나는 창 -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <!-- 댓글달기를 클릭하면 "댓글쓰기로" 댓글 수정을 클릭하면 "댓글수정"으로 제목 변경 -->
        <h4 class="modal-title">댓글쓰기</h4>
      </div>
      <div class="modal-body">
        <p>
        	<form id="replyWriteForm">
        		<!-- 댓글 수정하려면 댓글번호가 필요하다 input tag로 설정 -->
        		<input type="hidden" id="rno" /><!-- 댓글쓸때 보이니까 좀 그래서 나중에 hidden으로 -->
        		<div class="form-group">
				  <label for="content">내용</label>
				  <textarea class="form-control" rows="5"
				   id="content"></textarea>
				</div>
				<div class="form-group">
				  <label for="writer">작성자</label>
				  <input type="text" class="form-control" 
				  id="writer">
				</div>
				
        	</form>
        </p>
      </div>
      <div class="modal-footer">
      	<button id="replyWriteProcessBtn"
      	 class="btn btn-default">등록</button>
      	<button id="replyUpdateProcessBtn"
      	 class="btn btn-default">수정</button>
        <button type="button" class="btn btn-default"
         data-dismiss="modal">닫기</button>
      </div>
    </div>

  </div>
</div>


</body>
</html>