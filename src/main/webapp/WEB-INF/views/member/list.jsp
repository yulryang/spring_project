<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageObject" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 리스트</title>
<style type="text/css">
.dataRow:hover {
	background: #eee;
	cursor: pointer;
}
</style>
<script type="text/javascript">
	$(function() {
		// view로 이동
		$('.dataRow').click(function() {
			var userid = $(this).find('.useridTd').text();
			var para = document.location.href.split("?");
			if(para[1] != null)
				location = 'view.do?userid=' + userid + '&' + para[1];
			if(para[1] == null)
				location = 'view.do?userid=' + userid;
		})
	})
</script>
</head>
<body>
	<div class="container">
		<h1>회원 리스트</h1>
		<%-- <sec:authentication property="principal.member.userid"/> --%>
		<div align="center">
			<form class="navbar-form">
				<div class="input-group">
					<div class="form-group navbar-left">
						<select name="key" class="form-control">
							<!-- selected="select" or selected -->
							<option value="n" ${(pageObject.key == "n")? " selected ":"" }>회원 번호</option>
							<option value="i" ${(pageObject.key == "i")? " selected ":"" }>아이디</option>
							<option value="e" ${(pageObject.key == "e")? " selected ":"" }>이메일</option>
							<option value="c" ${(pageObject.key == "c")? " selected ":"" }>회원 상태</option>
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
				<th>회원 번호</th>
				<th>아이디</th>
				<th>이메일</th>
				<th>가입 날짜</th>
				<th>회원 상태</th>
			</tr>
			<c:if test="${empty list}">
				<tr>
					<td colspan="6" align="center">가입한 회원이 없습니다</td>
				</tr>
			</c:if>
			<c:if test="${not empty list }">
				<c:forEach items="${list }" var="vo">
					<tr class="dataRow">
						<td> ${vo.no }</td>
						<td class="useridTd">${vo.userid }</td>
						<td>${vo.email }</td>
						<td>
							<fmt:formatDate value="${vo.join_date }"
							pattern="yyyy/MM/dd"/>
						</td>
						<td>${vo.enabled }</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${pageObject.totalPage > 1 }">
				<tr>
					<td colspan="6" align="center"><pageObject:pageNav
							listURI="list.do" pageObject="${pageObject }" /></td>
				</tr>
			</c:if>
			<c:if test="${not empty pageObject.word }">
				<tr>
					<td colspan="6" align="center">
						<a class="btn btn-default" href="list.do">전체 목록보기</a>
					</td>
				</tr>
			</c:if>
		</table>
	</div>
</body>
</html>