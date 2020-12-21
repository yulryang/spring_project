<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘의 날씨</title>
  <!-- Bootstrap / jQuery 라이브러리 등록 : CDN -->
<!--   <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<!--   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> -->
<!--   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<!--   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> -->


</head>
<body>
<div class="container">
<h1>오늘의 날씨2</h1>
<table class="table">
<div class="container">
  <div class="row">
    <div class="col-xs-2*"></div>
    1
    <div class="col-xs-4*"></div>
  	2
  </div>
  <div class="row">
    <div class="col-xs-6*"></div>
    3
    <div class="col-xs-8"></div>
    4
    <div class="col-xs-10"></div>
  	5
  </div>
  <div class="row">
    ...
  </div>
</div>
<tr>
	<th>지역</th>
	<td id="no">${vo.local }</td>
</tr>
<tr>
	<th>날씨</th>
	<td>${vo.weather }</td>
</tr>
<tr>
	<th>온도</th>
	<td>${vo.temp }</td>
</tr>
<tr>
	<th>습도</th>
	<td>${vo.humid }</td>
</tr>

</table>
</div>


</body>
</html>