<%@page import="net.webjjang.util.PageObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.XML"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URL"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html> 
<html>
<head>
<!-- 자동 새로고침 시스템 -->
<META HTTP-EQUIV="refresh" CONTENT="60">
<meta charset="UTF-8">
<title>버스도착정보 리스트</title>
 <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#bus_Form").click(function(){
		var bus_id = $("#bus_id").val();
		location = "busListset.do?bus_id="+bus_id;
	});
	$("#bus_key").click(function(){
		var bus_id = $("#bus_id").val();
		var nosun_id = $("#nosun_id").val();
		var bus_key = $("#search").val();
		var col = $("#col").val();
		location = "busList.do?bus_id="+bus_id+"&nosun_id="+nosun_id+"&bus_key="+bus_key+"&col="+col;
	});
});
</script> 
<style type="text/css">
	h6{color: #FF007F;}
	
	#arrmsg1rd{color: red;
	font-family:verdana}
	#arrmsg1{color: blue;
	font-family:verdana}
	
</style>
</head>
<body> 

<%
PageObject pageObject = new PageObject();
String bus_id = request.getParameter("bus_id");
String nosun_id = request.getParameter("nosun_id");
String bus_key = request.getParameter("bus_key");
//초록 = 11,파랑=22, 빨강=33, 마을=44
String col = request.getParameter("col");
try {
	String serviceKey = "qzYFOx%2Brg%2BG3E7Tj2e3Q3nsv%2FZ808ON%2FU3oov8XLvxdZ8ar5UkQs%2BPAr3rHHHZlVrpXL9sSym6r4m0J8okmxpQ%3D%3D";
	String busRouteId = nosun_id; // 100100084 (571번 버스 노선id)
	
	String urlStr =
			"http://ws.bus.go.kr/api/rest/arrive/getArrInfoByRouteAll?"+
	"serviceKey="+serviceKey+
	"&busRouteId="+busRouteId
	+"&_type=json";
	
	URL url = new URL(urlStr);
	BufferedReader bf;
	String line ="";
	String result = "";
	
	bf = new BufferedReader(new InputStreamReader(url.openStream()));
	while((line=bf.readLine())!=null) {
		result = result.concat(line);
	}
	org.json.JSONObject xmlJSONobj = XML.toJSONObject(result.toString());
	String result1 = xmlJSONobj.toString();
	JSONParser parser1 = new JSONParser();
	JSONObject obj = (JSONObject) parser1.parse(result1);
	JSONObject parse_response = (JSONObject) obj.get("ServiceResult");
	JSONObject parse_body = (JSONObject) parse_response.get("msgBody");
	System.out.println(parse_body);
	JSONArray parse_items = (JSONArray) parse_body.get("itemList");

	String stNm;
	JSONObject bus;
	JSONObject nextbus;
	JSONObject mkTm;
	mkTm = (JSONObject)parse_items.get(1);
%>
<div class="container">
		<h3>버스 도착정보 검색하기</h3>
	<div class="input-group">
			<div class="input-group-btn">
			<input type="text" id="bus_id" class="form-control"
			style="width:300px;display: inline" value="<%=bus_id%>">
			<a id="bus_Form" class="btn btn-default" >검색</a>
			</div>
		</div>	
			<h6>제공받고자 하는 버스 번호를 검색해 주세요</h6>
	<div>
		<table class="table">
			<tr>
				<td colspan="5">
				<h4>버스 정류장별 도착정보 검색하기</h4>
			<%if(bus_key==null){%>
			<div class="input-group">
			<input type="text" id="search" class="form-control"
			style="width:300px; display: inline" value="정류장을 검색해 주세요">
			<%
			}else{%>
			
			<div class="input-group">
			<input type="text" id="search" class="form-control"
			style="width:300px; display: inline" value="<%=bus_key %>">
			<%
			}
				%>
			<div class="input-group-btn">
			<a id="bus_key" class="btn btn-default"
			>검색</a>
			</div>
			</div>
			</div>
			<h6>제공받고자 하는 정류장 이름을 검색해 주세요</h6>
	<span><h3 style="margin: 0px; width: 60%;display: inline">제공시간 : <%=mkTm.get("mkTm") %></h3>
	<h6 style="margin: 0px;width: 20%;display: inline">60초마다 갱신됩니다.</h6></span>
				</td>
			</tr>
			<tr>
				<th>버스 번호</th>
				<th>정류장이름</th>
				<th>도착 남은시간</th>
				<th>혼잡도</th>
				<th>다음 버스 도착시간</th>
			</tr>	
	<%	
	for(int i=0;i<parse_items.size();i++){
		bus = (JSONObject)parse_items.get(i);
		nextbus = (JSONObject)parse_items.get(i+1);
	if(bus_key!=null){
	//	if((boolean) bus.get("stNm").equals(bus_key)) {
		stNm = (String)bus.get("stNm"); // 정류장 이름
		if(stNm.contains(bus_key)==true) {
		// 정수로 받아오기
		//int busId = (int) ((Long)bus.get("busRouteId")).doubleValue(); // 버스번호
		//String arrmsg1 = (String)bus.get("arrmsg1"); // 정류장 이름
		//String arrmsg2 = (String)bus.get("arrmsg2"); // 정류장 이름
		//int full = (int) ((Long)bus.get("brdrde_Num1")).doubleValue(); // 혼잡도
		%>
				<tr>
					
					<%if(col.equals("22")){ %>				
					<td><img src="https://data.ac-illust.com/data/thumbnails/bf/bf99c282ac5c542c3de5dd510d6ed2df_t.jpeg" style="display: inline;width: 20px;height: 20px;">
					<%=bus_id %></td>
					<%
					}else if(col.equals("11")){%>
					<td><img src="https://cdn.crowdpic.net/list-thumb/thumb_l_88E38F18040B6E5B49B3C4252AE6667D.png" style="display: inline;width: 20px;height: 20px;">
					<%=bus_id %></td>
					<%	
					}else if(col.equals("33")){%>
					<td><img src="https://previews.123rf.com/images/viktorijareut/viktorijareut1508/viktorijareut150800292/44024379-%EB%9F%B0%EB%8D%98-%EB%B9%A8%EA%B0%84-%EB%B2%84%EC%8A%A4-%EB%B2%A1%ED%84%B0-%EC%9D%BC%EB%9F%AC%EC%8A%A4%ED%8A%B8-%EB%A0%88%EC%9D%B4-%EC%85%98-%EB%9F%B0%EB%8D%98-%EA%B8%B0%ED%98%B8%EC%9E%85%EB%8B%88%EB%8B%A4-%EC%9D%B4%EC%B8%B5.jpg" style="display: inline;width: 20px;height: 20px;">
					<%=bus_id %></td>
					<%
					}
					else{%>
					<td><img src="https://cdn.crowdpic.net/list-thumb/thumb_l_88E38F18040B6E5B49B3C4252AE6667D.png" style="display: inline;width: 30px;height: 30px;"><h6 style="color: green">마을</h6>
					<%=bus_id %></td>
					<%
					}
						%>
					
					
					<td><%=bus.get("stNm") %><h5>↓↓↓다음 정류장↓↓↓</h5><%=nextbus.get("stNm") %></td>
					<%if(bus.get("arrmsg1").equals("곧 도착")){
						%>					
					<td><span id="arrmsg1"><%=bus.get("arrmsg1") %></span></td>					
					<% }else if(bus.get("arrmsg1").equals("출발대기")){%>
					<td><span id="arrmsg1rd"><%=bus.get("arrmsg1") %></span></td>					
					<%}else{
						%>
					<td><%=bus.get("arrmsg1") %></td>					
						<%
					}
						%>
					<td><%if((int) ((Long)bus.get("brdrde_Num1")).doubleValue()==0){
							out.print("데이터없음");	
						}else if((int) ((Long)bus.get("brdrde_Num1")).doubleValue()==3){
							out.print("여유");
						}else if((int) ((Long)bus.get("brdrde_Num1")).doubleValue()==4){
							out.print("보통");
						}else{
							out.print("혼잡");
						}
							%>
					</td>
					<td><%=bus.get("arrmsg2") %></td>
				</tr>	
		
		
		<%}
	}else{
			%>
			<tr>
				<%if(col.equals("22")){ %>				
					<td><img src="https://data.ac-illust.com/data/thumbnails/bf/bf99c282ac5c542c3de5dd510d6ed2df_t.jpeg" style="display: inline;width: 20px;height: 20px;">
					<%=bus_id %></td>
					<%
					}else if(col.equals("11")){%>
					<td><img src="https://cdn.crowdpic.net/list-thumb/thumb_l_88E38F18040B6E5B49B3C4252AE6667D.png" style="display: inline;width: 30px;height: 30px;">
					<%=bus_id %></td>
					<%	
					}else if(col.equals("33")){%>
					<td><img src="https://previews.123rf.com/images/viktorijareut/viktorijareut1508/viktorijareut150800292/44024379-%EB%9F%B0%EB%8D%98-%EB%B9%A8%EA%B0%84-%EB%B2%84%EC%8A%A4-%EB%B2%A1%ED%84%B0-%EC%9D%BC%EB%9F%AC%EC%8A%A4%ED%8A%B8-%EB%A0%88%EC%9D%B4-%EC%85%98-%EB%9F%B0%EB%8D%98-%EA%B8%B0%ED%98%B8%EC%9E%85%EB%8B%88%EB%8B%A4-%EC%9D%B4%EC%B8%B5.jpg" style="display: inline;width: 20px;height: 20px;">
					<%=bus_id %></td>
					<%
					}
					else{%>
					<td><img src="https://cdn.crowdpic.net/list-thumb/thumb_l_88E38F18040B6E5B49B3C4252AE6667D.png" style="display: inline;width: 30px;height: 30px;"><h6 style="color: green">마을</h6></td>
					<td><%=bus_id %></td>
					<%
					}
						%>				



				<td><%=bus.get("stNm") %></td>
				
				<%if(bus.get("arrmsg1").equals("곧 도착")){
						%>					
					<td><span id="arrmsg1"><%=bus.get("arrmsg1") %></span></td>					
					<% }else if(bus.get("arrmsg1").equals("출발대기")){%>
					<td><span id="arrmsg1rd"><%=bus.get("arrmsg1") %></span></td>					
						
						<%}
				else{
						%>
					<td><%=bus.get("arrmsg1") %></td>					
						<%
					}
						%>
				
				
				<td><%if((int) ((Long)bus.get("brdrde_Num1")).doubleValue()==0){
						out.print("데이터없음");	
					}else if((int) ((Long)bus.get("brdrde_Num1")).doubleValue()==3){
						out.print("여유");
					}else if((int) ((Long)bus.get("brdrde_Num1")).doubleValue()==4){
						out.print("보통");
					}else{
						out.print("혼잡");
					}
						%>
				</td>
				<td><%=bus.get("arrmsg2") %></td>
			</tr>	
	
	
	<%
			
		}// if key값을 찾는
		}// for
	
	bf.close();
	}catch (Exception e) {
		// TODO: handle exception
		//System.out.println(e.getMessage());
		//System.out.println("안됐쥬");
	}
	%>
		</table>
	</div>
	<input type="hidden" value="${bus.nosun_id }" id="nosun_id">
	<input type="hidden" value="<%out.print(bus_id); %>" id="bus_id">
	<input type="hidden" value="<%out.print(col); %>" id="col">
</div>
	<%if(nosun_id.equals("")){%>
	<script type="text/javascript">
	$(function(){
		$("#bus_Form2").click(function(){
			var bus_id = $("#bus_id2").val();
			location = "busListset.do?bus_id="+bus_id;
		});
	});
	</script>
	<div class="input-group">
			<div class="input-group-btn">
			<input type="text" id="bus_id2" class="form-control"
			style="width:300px;display: inline">
			<a id="bus_Form2" class="btn btn-default" >검색</a>
			</div>
		</div>	
			<h6>제공받고자 하는 버스 번호를 검색해 주세요</h6>
	<H1>딱봐도 없는 버스 번호라구우 제대로 입력하자</H1>
	<div><a class="btn btn-default" href="list.do">돌아가기</a></div>
	<img src="https://item.kakaocdn.net/do/1dd69ccca1d60afa0b4badcce2c6ef5615b3f4e3c2033bfd702a321ec6eda72c"
	width="600px" height="600px">
<%
	}%>
</body>
</html>