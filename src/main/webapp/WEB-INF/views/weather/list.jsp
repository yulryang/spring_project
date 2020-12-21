<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<!-- Bootstrap 라이브러리 등록 CDN방식 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
.dataRow:hover {
	background: #ccc;
	cursor: pointer;
}
.titleRow {
	font-size: 20px;
}
</style>

<script type="text/javascript">
$(function(){
	$(".dataRow").click(function(){
		// 글번호 찾기
		var no = $(this).find(".no").text();
		location = "view.do?no="+ no + "&inc=1";
	});
});
</script>
</head>
<body>
<div class="container">
	<form class="navbar-form">
    <div class="input-group">
     <div class="form-group navbar-left">
      <select name="key" class="form-control">
       <!-- selected="select" or selected -->
       <option value="l" ${(pageObject2.key == "l")? " selected ":"" }
        >지역</option>
      </select>
       <input type="text" class="form-control" placeholder="Search"
        name="word" value="${pageObject2.word }">
      </div>
      <div class="input-group-btn">
        <button class="btn btn-default" type="submit">
          <i class="glyphicon glyphicon-search"></i>
        </button>
      </div>
      <div> 원하시는 지역을 검색해주세요</div>
     </div>
  </form>
  <div class="row titleRow">
			<div class="col-sm-2">지역</div>
			<div class="col-sm-2">날씨</div>
			<div class="col-sm-2">온도</div>
			<div class="col-sm-2">습도</div>
		</div>
<c:forEach items="${todaylist }" var="vo">

		<div class="row">
			<div class="col-sm-2">${vo.local }</div>
			<div class="col-sm-2">${vo.weather }</div>
			<div class="col-sm-2">${vo.temp }</div>
			<div class="col-sm-2">${vo.humid }</div>
		</div>
</c:forEach>
</div>
<div class="container">
<h1>날씨자유게시판</h1>




<table class="table">
<tr>
	<th>번호</th>
	<th>제목</th>
	<th>작성자</th>
	<th>작성일</th>
	<th>조회수</th>
</tr>
<c:if test="${empty list }">
	<!-- 만약에 데이터가 없으면 데이터 없음을 표시한다 -->
	<tr>
		<td colspan="5">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>
<c:if test="${!empty list }">
	<!-- 데이터가 존재하면 데이터의 갯수 만큼 반복되어 지는 부분 -->
	<c:forEach items="${list }" var="vo">
	<tr class="dataRow">
		<td class="no">${vo.no }</td>
		<td>${vo.title }</td>
		<td>${vo.writer }</td>
		<td>
			<fmt:formatDate value="${vo.writeDate }"
			 pattern="yyyy.MM.dd"/>
		</td>
		<td>${vo.hit }</td>
	</tr>
	</c:forEach>
</c:if>
<c:if test="${pageObject.totalPage > 1 }">
	<!-- 전체 페이지가 2페이지 이상이면 보여주는 부분 -->
	<tr>
		<td colspan="5">
			<pageNav:pageNav listURI="list.do" 
				pageObject="${pageObject }" />
		</td>
	</tr>
</c:if>
<tr>
	<td colspan="5">
		<a href="write.do" class="btn btn-default">글쓰기</a>
	</td>
</tr>
</table>
</div>
</body>
</html>