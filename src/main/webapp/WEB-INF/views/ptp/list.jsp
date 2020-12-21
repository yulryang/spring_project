<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대중교통 건의사항 게시판</title>

  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

	<style type="text/css">
	.dataRow:hover { 
		background: #ddd;
		cursor: pointer;
	}
	</style>
	
	<script type="text/javascript">
	$(function(){
		$(".dataRow").click(function(){
			var no = $(this).find(".no").text();
			location = "view.do?no=" + no + "&inc=1"
				+ "&page=${pageObject.page}"
				+ "&perPageNum=${pageObject.perPageNum}"
				+ "&key=${pageObject.key}"
				+ "&word=${pageObject.word}";
		});
		$("#bus_Form").click(function(){
				var bus_id = $("#bus_id").val();
				location = "busListset.do?bus_id="+bus_id;
			});
	});
	</script>
<style type="text/css">
	h6{color: red}
</style>
</head>
<body>
<div class="container">
	<div>
	<h1>수도권 버스 도착정보 검색하기</h1>
	<div class="input-group">
		<input type="text" id="bus_id" class="form-control"
		width="50px" size="50px">
		<div class="input-group-btn">
		<a id="bus_Form" class="btn btn-default" >검색</a>
		</div>
	</div>
		<h6>제공받고자 하는 버스 번호를 정확하게 검색해 주세요</h6>
	</div>

	<h1>건의사항</h1>
	
	<div>
		<form class="navbar-form">
		  <div class="input-group">
		  	<div class="form-group navbar-left">
			  	<select name="key" class="form-control">
			  		<!-- selected="select" or selected -->
			  		<option value="t" ${(pageObject.key == "t")? " selected ":"" }
			  		 >제목</option>
			  		<option value="c" ${(pageObject.key == "c")? " selected ":"" }
			  		>내용</option>
			  		<option value="w" ${(pageObject.key == "w")? " selected ":"" }
			  		>작성자</option>
			  		<option value="tc" ${(pageObject.key == "tc")? " selected ":"" }
			  		>제목/내용</option>
			  		<option value="tw" ${(pageObject.key == "tw")? " selected ":"" }
			  		>제목/작성자</option>
			  		<option value="cw" ${(pageObject.key == "cw")? " selected ":"" }
			  		>내용/작성자</option>
			  		<option value="tcw" ${(pageObject.key == "tcw")? " selected ":"" }
			  		>전체</option>
			  	</select>
			    <input type="text" class="form-control" placeholder="Search"
			     name="word" value="${pageObject.word }">
		    </div>
		    <div class="input-group-btn">
		      <button class="btn btn-default" type="submit">
		        <i class="glyphicon glyphicon-search"></i>
		      </button>
		    </div>
		  </div>
		</form>
	</div>
	
	<table class="table">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<!-- 데이터가 있는 만큼 반복 처리 시작 -->
		<c:forEach items="${list }" var="vo">
			<tr class="dataRow">
				<td class="no">${vo.no }</td>
				<td>${vo.title }</td>
				<td>${vo.writer }</td>
				<td><fmt:formatDate value="${vo.writeDate }"
				 pattern="yyyy.MM.dd"/></td>
				<td>${vo.hit }</td>
			</tr>
		</c:forEach>
		<!-- 데이터가 있는 만큼 반복 처리 끝 -->
		<tr>
			<td colspan="5">
				<pageNav:pageNav listURI="list.do"
				 pageObject="${pageObject }" />
			</td>
		</tr>
		<tr>
			<td colspan="5">
				<a href="write.do" class="btn btn-default">글쓰기</a>
			</td>
		</tr>
	</table>
	<h5>※이곳에는 건의사항을 올려주세요※</h5>
	<h6>※희망하는 기능, 기능오류 등등※</h6>
	<h6>※건의사항과 관계없거나 비속어는 신고할거얌※</h6>
</div>
</body>
</html>