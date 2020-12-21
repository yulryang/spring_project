<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<c:set var="monaw" value="${vo.monaw }"/>
<c:set var="tueaw" value="${vo.tueaw }"/>
<c:set var="wedaw" value="${vo.wedaw }"/>
<c:set var="thuaw" value="${vo.thuaw }"/>
<c:set var="friaw" value="${vo.friaw }"/>
<c:set var="sataw" value="${vo.sataw }"/>
<c:set var="sunaw" value="${vo.sunaw }"/>
<c:set var="monpw" value="${vo.monpw }"/>
<c:set var="tuepw" value="${vo.tuepw }"/>
<c:set var="wedpw" value="${vo.wedpw }"/>
<c:set var="thupw" value="${vo.thupw }"/>
<c:set var="fripw" value="${vo.fripw }"/>
<c:set var="satpw" value="${vo.satpw }"/>
<c:set var="sunpw" value="${vo.sunpw }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주간 날씨</title>
<!-- Highchars CDN -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="http://code.highcharts.com/highcharts.js"></script>
<style>
td .col_blue {
    color: #16a7ef;
}
td .col_orange {
    color: #f21b2a;
}
.highcharts-figure, .highcharts-data-table table {
    min-width: 360px; 
    max-width: 800px;
    margin: 1em auto;
}

.highcharts-data-table table {
	font-family: Verdana, sans-serif;
	border-collapse: collapse;
	border: 1px solid #EBEBEB;
	margin: 10px auto;
	text-align: center;
	width: 100%;
	max-width: 500px;
}
.highcharts-data-table caption {
    padding: 1em 0;
    font-size: 1.2em;
    color: #555;
}
.highcharts-data-table th {
	font-weight: 600;
    padding: 0.5em;
}
.highcharts-data-table td, .highcharts-data-table th, .highcharts-data-table caption {
    padding: 0.5em;
}
.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even) {
    background: #f8f8f8;
}
.highcharts-data-table tr:hover {
    background: #f1f7ff;
}
img {
  max-width: 85%;
  height: auto;
}
</style>
<script type="text/javascript">
$(function(){Highcharts.chart('container', {
	colors: ['#16a7ef', '#f21b2a'],
    title: {
        text: '주간 기온 추이'
    },

/*     subtitle: {
        text: ''
    }, */

    yAxis: {
        title: {
            text: '기온'
        }
    },

    xAxis: {
    	categories:['월','화','수','목','금','토','일']
    },

    legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'middle'
    },

    plotOptions: {
        series: {
            label: {
                connectorAllowed: false
            },
//             pointStart: 1
        }
    },

    series: [{
        name: '최저기온',
        data: [${vo.monMin }, ${vo.tueMin }, ${vo.wedMin }, ${vo.thuMin }, ${vo.friMin }, ${vo.satMin }, ${vo.sunMin }]
    }, {
        name: '최고기온',
        data: [${vo.monMax }, ${vo.tueMax }, ${vo.wedMax }, ${vo.thuMax }, ${vo.friMax }, ${vo.satMax }, ${vo.sunMax }]
    }],

    responsive: {
        rules: [{
            condition: {
                maxWidth: 500
            },
            chartOptions: {
                legend: {
                    layout: 'horizontal',
                    align: 'center',
                    verticalAlign: 'bottom'
                }
            }
        }]
    }

});
})
</script>
</head>
<body>
<div class="container">
<h2>주간 날씨</h2>
<table class="table">
<tr>
	<th>번호</th>
	<td>${vo.baseDate }</td>
</tr>
<tr>
	<th>제목</th>
	<td><fmt:formatDate value="${vo.writeDate }"
							pattern="yyyy년 MM월 dd일" /> 발표 다음 주 날씨</td>
</tr>
<tr>
<td colspan="2">
<table class="table">
<tr>
<td width="*"></td>
<td width="13%">월</td>
<td width="13%">화</td>
<td width="13%">수</td>
<td width="13%">목</td>
<td width="13%">금</td>
<td width="13%" class="col_blue">토</td>
<td width="13%" class="col_orange">일</td>
</tr>
<tr>
<th>오전날씨</th>
<td>
<c:choose>
<c:when test="${monaw == '맑음'}"><img src="/resources/img/sunny.png" ></c:when>
<c:when test="${monaw == '구름많음'}"><img src="/resources/img/clouds.png" ></c:when>
<c:when test="${monaw == '흐림'}"><img src="/resources/img/cloudy.png" ></c:when>
</c:choose>
<br>
${vo.monaw }</td>
<td>
<c:choose>
<c:when test="${tueaw == '맑음'}"><img src="/resources/img/sunny.png" ></c:when>
<c:when test="${tueaw == '구름많음'}"><img src="/resources/img/clouds.png" ></c:when>
<c:when test="${tueaw == '흐림'}"><img src="/resources/img/cloudy.png" ></c:when>
</c:choose>
<br>
${vo.tueaw }</td>
<td>
<c:choose>
<c:when test="${wedaw == '맑음'}"><img src="/resources/img/sunny.png" ></c:when>
<c:when test="${wedaw == '구름많음'}"><img src="/resources/img/clouds.png" ></c:when>
<c:when test="${wedaw == '흐림'}"><img src="/resources/img/cloudy.png" ></c:when>
</c:choose>
<br>
${vo.wedaw }</td>
<td>
<c:choose>
<c:when test="${thuaw == '맑음'}"><img src="/resources/img/sunny.png" ></c:when>
<c:when test="${thuaw == '구름많음'}"><img src="/resources/img/clouds.png" ></c:when>
<c:when test="${thuaw == '흐림'}"><img src="/resources/img/cloudy.png" ></c:when>
</c:choose>
<br>
${vo.thuaw }</td>
<td>
<c:choose>
<c:when test="${friaw == '맑음'}"><img src="/resources/img/sunny.png" ></c:when>
<c:when test="${friaw == '구름많음'}"><img src="/resources/img/clouds.png" ></c:when>
<c:when test="${friaw == '흐림'}"><img src="/resources/img/cloudy.png" ></c:when>
</c:choose>
<br>
${vo.friaw }</td>
<td>
<c:choose>
<c:when test="${sataw == '맑음'}"><img src="/resources/img/sunny.png" ></c:when>
<c:when test="${sataw == '구름많음'}"><img src="/resources/img/clouds.png" ></c:when>
<c:when test="${sataw == '흐림'}"><img src="/resources/img/cloudy.png" ></c:when>
</c:choose>
<br>
${vo.sataw }</td>
<td>
<c:choose>
<c:when test="${sunaw == '맑음'}"><img src="/resources/img/sunny.png" ></c:when>
<c:when test="${sunaw == '구름많음'}"><img src="/resources/img/clouds.png" ></c:when>
<c:when test="${sunaw == '흐림'}"><img src="/resources/img/cloudy.png" ></c:when>
</c:choose>
<br>
${vo.sunaw }</td>
</tr>
<tr>
<th>오후날씨</th>
<td>
<c:choose>
<c:when test="${monpw == '맑음'}"><img src="/resources/img/sunny.png" ></c:when>
<c:when test="${monpw == '구름많음'}"><img src="/resources/img/clouds.png" ></c:when>
<c:when test="${monpw == '흐림'}"><img src="/resources/img/cloudy.png" ></c:when>
</c:choose>
<br>
${vo.monpw }</td>
<td>
<c:choose>
<c:when test="${tuepw == '맑음'}"><img src="/resources/img/sunny.png" ></c:when>
<c:when test="${tuepw == '구름많음'}"><img src="/resources/img/clouds.png" ></c:when>
<c:when test="${tuepw == '흐림'}"><img src="/resources/img/cloudy.png" ></c:when>
</c:choose>
<br>
${vo.tuepw }</td>
<td>
<c:choose>
<c:when test="${wedpw == '맑음'}"><img src="/resources/img/sunny.png" ></c:when>
<c:when test="${wedpw == '구름많음'}"><img src="/resources/img/clouds.png" ></c:when>
<c:when test="${wedpw == '흐림'}"><img src="/resources/img/cloudy.png" ></c:when>
</c:choose>
<br>
${vo.wedpw }</td>
<td>
<c:choose>
<c:when test="${thupw == '맑음'}"><img src="/resources/img/sunny.png" ></c:when>
<c:when test="${thupw == '구름많음'}"><img src="/resources/img/clouds.png" ></c:when>
<c:when test="${thupw == '흐림'}"><img src="/resources/img/cloudy.png" ></c:when>
</c:choose>
<br>
${vo.thupw }</td>
<td>
<c:choose>
<c:when test="${fripw == '맑음'}"><img src="/resources/img/sunny.png" ></c:when>
<c:when test="${fripw == '구름많음'}"><img src="/resources/img/clouds.png" ></c:when>
<c:when test="${fripw == '흐림'}"><img src="/resources/img/cloudy.png" ></c:when>
</c:choose>
<br>
${vo.fripw }</td>
<td>
<c:choose>
<c:when test="${satpw == '맑음'}"><img src="/resources/img/sunny.png" ></c:when>
<c:when test="${satpw == '구름많음'}"><img src="/resources/img/clouds.png" ></c:when>
<c:when test="${satpw == '흐림'}"><img src="/resources/img/cloudy.png" ></c:when>
</c:choose>
<br>
${vo.satpw }</td>
<td>
<c:choose>
<c:when test="${sunpw == '맑음'}"><img src="/resources/img/sunny.png" ></c:when>
<c:when test="${sunpw == '구름많음'}"><img src="/resources/img/clouds.png" ></c:when>
<c:when test="${sunpw == '흐림'}"><img src="/resources/img/cloudy.png" ></c:when>
</c:choose>
<br>
${vo.sunpw }</td>
</tr>
<tr>
<th>오전강수확률</th>
<td>${vo.monar }%</td>
<td>${vo.tuear }%</td>
<td>${vo.wedar }%</td>
<td>${vo.thuar }%</td>
<td>${vo.friar }%</td>
<td>${vo.satar }%</td>
<td>${vo.sunar }%</td>
</tr>
<tr>
<th>오후강수확률</th>
<td>${vo.monpr }%</td>
<td>${vo.tuepr }%</td>
<td>${vo.wedpr }%</td>
<td>${vo.thupr }%</td>
<td>${vo.fripr }%</td>
<td>${vo.satpr }%</td>
<td>${vo.sunpr }%</td>
</tr>
<tr>
<th>최저기온</th>
<td class="col_blue">${vo.monMin }</td>
<td class="col_blue">${vo.tueMin }</td>
<td class="col_blue">${vo.wedMin }</td>
<td class="col_blue">${vo.thuMin }</td>
<td class="col_blue">${vo.friMin }</td>
<td class="col_blue">${vo.satMin }</td>
<td class="col_blue">${vo.sunMin }</td>
</tr>
<tr>
<th>최고기온</th>
<td class="col_orange">${vo.monMax }</td>
<td class="col_orange">${vo.tueMax }</td>
<td class="col_orange">${vo.wedMax }</td>
<td class="col_orange">${vo.thuMax }</td>
<td class="col_orange">${vo.friMax }</td>
<td class="col_orange">${vo.satMax }</td>
<td class="col_orange">${vo.sunMax }</td>
</tr>
</table>
</td>
</tr>
<tr>
	<th>작성일</th>
	<td><fmt:formatDate value="${vo.writeDate }"
		pattern="yyyy.MM.dd" /></td>
</tr>
<tr>
	<th>조회수</th>
	<td>${vo.hit }</td>
</tr>
<tr>
	<td colspan="2">
		<sec:authorize access="hasRole('ROLE_ADMIN')">
		<a href="update.do?basedate=${vo.baseDate }"
		 class="btn btn-default">수정</a>
		<a href="delete.do?basedate=${vo.baseDate }"
		 class="btn btn-default" id="deleteBtn">삭제</a>
	</sec:authorize>
		<a href="list.do"
		 class="btn btn-default">리스트</a>
	</td>
</tr>

</table>
<figure class="highcharts-figure">
    <div id="container"></div>
</figure>


</div>
</body>
</html>