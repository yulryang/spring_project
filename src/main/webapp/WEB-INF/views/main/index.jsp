<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.viewA {
	color: black;
}

.container {
	padding-top: 20px;
}

.panel-info {
	margin-bottom: 0px;
}

.listBtn {
	margin-top: 5px;
	margin-bottom: 20px;
}
.todayDiv {
	width:350px;
	align-self: center;
	box-sizing: content-box;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row todayDiv">
			<div class="panel panel-info">
				<div class="panel-heading">현재 서울의 날씨</div>
				<div class="panel-body">
					<div class="nowseoul" align="center">
						<c:if test="${seoul.nowweath == '맑음'}">
							<img src="/resources/img/sun.png">
						</c:if>
						<c:if test="${seoul.nowweath == '구름많음'}">
							<img src="/resources/img/cloud.png">
						</c:if>
						<c:if test="${seoul.nowweath == '비'}">
							<img src="/resources/img/rain.png">
						</c:if>
						<c:if test="${seoul.nowweath == '눈'}">
							<img src="/resources/img/snow.png">
						</c:if>
						<div>${seoul.nowtemp}${seoul.nowweath}</div>
					</div>
				</div>
			</div>
			<div align="right" class="listBtn">
				<a href="/weather/list.do" class="btn btn-default">더보기</a>
			</div>
		</div>
		<div class="row">
			<div class="panel panel-info">
				<div class="panel-heading">교통 정보</div>
				<div class="panel-body">
					<ul class="list-group">
						<c:forEach items="${ts }" var="vo">
							<li class="list-group-item dataRow trafficLi"><a
								href="/traffic/view.do?inc=1&no=${vo.no }" class="viewA">
									${vo.title } </a> <span class="badge">${vo.hit }</span></li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div align="right" class="listBtn">
				<a href="/traffic/list.do" class="btn btn-default">더보기</a>
			</div>
		</div>
		<div class="row">
			<div class="panel panel-info">
				<div class="panel-heading">주간 날씨</div>
				<div class="panel-body">
					<ul class="list-group">
						<c:forEach items="${wls }" var="vo">
							<li class="list-group-item dataRow"><a
								href="/weekly/view.do?inc=1&basedate=${vo.baseDate }"
								class="viewA"> <fmt:formatDate value="${vo.writeDate }"
										pattern="yyyy년 MM월 dd일" /> 발표 다음 주 날씨
							</a> <span class="badge">${vo.hit }</span></li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div align="right" class="listBtn">
				<a href="/weekly/list.do" class="btn btn-default">더보기</a>
			</div>
		</div>
		<div class="row">
			<div class="panel panel-info">
				<div class="panel-heading">교통 사고</div>
				<div class="panel-body">
					<ul class="list-group">
						<%-- <c:forEach items="${boardList }" var="vo">
					<li class="list-group-item dataRow">
						<a href="/board/view.do?inc=1&no=${vo.no }" id="viewA"> 
							${vo.no }. ${vo.title } - ${vo.writer }(
								<fmt:formatDate value="${vo.writeDate }" pattern="yyyy.MM.dd"/>)
						</a>
						<span class="badge">${vo.hit }</span>
					</li>
				</c:forEach> --%>
					</ul>
				</div>
			</div>
			<div align="right" class="listBtn">
				<a href="/accident/list.do" class="btn btn-default">더보기</a>
			</div>
		</div>
		<div class="row">
			<div class="panel panel-info">
				<div class="panel-heading">건의 사항</div>
				<div class="panel-body">
					<ul class="list-group">
						<c:forEach items="${ptp }" var="vo">
							<li class="list-group-item dataRow"><a
								href="/ptp/view.do?inc=1&no=${vo.no }" class="viewA">
									${vo.title } - ${vo.writer } </a> <span class="badge">${vo.hit }</span>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div align="right" class="listBtn">
				<a href="/ptt/list.do" class="btn btn-default">더보기</a>
			</div>
		</div>
	</div>
</body>
</html>