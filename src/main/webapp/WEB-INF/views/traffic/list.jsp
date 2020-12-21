<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<%@ taglib prefix="PageNav" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>실시간 교통정보</title>

<!-- Bootstrap 라이브러리 등록 CDN방식 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 
<style type="text/css">
.dataRow:hover {
	background: #aaa;
	cursor: pointer;
}

	MARQUEE{color: red}
</style>  


<style>
.map_wrap, .map_wrap * {
	margin: 0;
	padding: 0;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	font-size: 12px;
}

.map_wrap a, .map_wrap a:hover, .map_wrap a:active {
	color: #000;
	text-decoration: none;
}

.map_wrap {
	position: relative;
	width: 100%;
	height: 500px;
}

#menu_wrap {
	position: absolute;
	top: 0;
	left: 0;
	bottom: 0;
	width: 250px;
	margin: 10px 0 30px 10px;
	padding: 5px;
	overflow-y: auto;
	background: rgba(255, 255, 255, 0.7);
	z-index: 1;
	font-size: 12px;
	border-radius: 10px;
}

.bg_white {
	background: #fff;
}

#menu_wrap hr {
	display: block;
	height: 1px;
	border: 0;
	border-top: 2px solid #5F5F5F;
	margin: 3px 0;
}

#menu_wrap .option {
	text-align: center;
}

#menu_wrap .option p {
	margin: 10px 0;
}

#menu_wrap .option button {
	margin-left: 5px;
}

#placesList li {
	list-style: none;
}

#placesList .item {
	position: relative;
	border-bottom: 1px solid #888;
	overflow: hidden;
	cursor: pointer;
	min-height: 65px;
}

#placesList .item span {
	display: block;
	margin-top: 4px;
}

#placesList .item h5, #placesList .item .info {
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

#placesList .item .info {
	padding: 10px 0 10px 55px;
}

#placesList .info .gray {
	color: #8a8a8a;
}

#placesList .info .jibun {
	padding-left: 26px;
	background:
		url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png)
		no-repeat;
}

#placesList .info .tel {
	color: #009900;
}

#placesList .item .markerbg {
	float: left;
	position: absolute;
	width: 36px;
	height: 37px;
	margin: 10px 0 0 10px;
	background:
		url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png)
		no-repeat;
}

#placesList .item .marker_1 {
	background-position: 0 -10px;
}

#placesList .item .marker_2 {
	background-position: 0 -56px;
}

#placesList .item .marker_3 {
	background-position: 0 -102px
}

#placesList .item .marker_4 {
	background-position: 0 -148px;
}

#placesList .item .marker_5 {
	background-position: 0 -194px;
}

#placesList .item .marker_6 {
	background-position: 0 -240px;
}

#placesList .item .marker_7 {
	background-position: 0 -286px;
}

#placesList .item .marker_8 {
	background-position: 0 -332px;
}

#placesList .item .marker_9 {
	background-position: 0 -378px;
}

#placesList .item .marker_10 {
	background-position: 0 -423px;
}

#placesList .item .marker_11 {
	background-position: 0 -470px;
}

#placesList .item .marker_12 {
	background-position: 0 -516px;
}

#placesList .item .marker_13 {
	background-position: 0 -562px;
}

#placesList .item .marker_14 {
	background-position: 0 -608px;
}

#placesList .item .marker_15 {
	background-position: 0 -654px;
}

#pagination {
	margin: 10px auto;
	text-align: center;
}

#pagination a {
	display: inline-block;
	margin-right: 10px;
}

#pagination .on {
	font-weight: bold;
	cursor: default;
	color: #777;
}
</style>


<script type="text/javascript">
$(function(){
	$(".dataRow").click(function(){
		// 글번호 찾기
		var no = $(this).find(".no").text();
		location = "view.do?no="+no + "&inc=1";
	});
});
</script>

<script>
	document.getElementById('setZoomable(false)').click()
	document.getElementById('setZoomable(true)').click()
	document.getElementById('setDraggable(false)').click()
	document.getElementById('setDraggable(true)').click()
</script>
</head>
<body>
	<!-- 움직이는 텍스트 -->
	<MARQUEE scrollamount="8"> 5분 일찍 가려다 50년 빨리 갑니다.&nbsp&nbsp&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp&nbsp&nbsp교통사고에 순서는 없습니다.&nbsp&nbsp&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp&nbsp&nbsp 더 큰 지도 화면을 원하신다면 <a href="http://localhost/traffic/traffic.do"/> 클릭해주세요.	</MARQUEE>
	
	<p>
	<div class="map_wrap">
		<div id="map"
			style="width: 98%; height: 95%; position: relative; overflow: hidden; 
					display: block; margin: auto;"></div>

		<p style="text-align:center">
			<!-- 지도 타입 바꾸기2 -->
			<input type="checkbox" id="chkTraffic"
				onclick="setOverlayMapTypeId()" /> 실시간 교통 상황 보기 <input type="checkbox"
				id="chkBicycle" onclick="setOverlayMapTypeId()" /> 주변 자전거도로 정보 보기

			<!-- 지도 확대 축소 막기 -->
			<button id="setZoomable(true)" onclick="setZoomable(true)">지도 확대 / 축소 ON</button>
			<button id="setZoomable(false)" onclick="setZoomable(false)">지도 확대 / 축소 OFF</button>

			<!-- 지도 이동 막기 -->
			<button id="setDraggable(true)" onclick="setDraggable(true)">지도 드래그 이동 ON</button>
			<button id="setDraggable(false)" onclick="setDraggable(false)">지도 드래그 이동 OFF</button>
		</p>

		<div id="menu_wrap" class="bg_white">
			<div class="option">
				<div>
					<form onsubmit="searchPlaces(); return false;">
						위치 : <input type="text" value="" id="keyword" size="15">
						<button type="submit">검색</button>
					</form>
				</div>
			</div>
			<hr>
			<ul id="placesList"></ul>
			<div id="pagination"></div>
		</div>
	</div>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0a98373938fbeba2d25a97a39146877d&libraries=services"></script>
	<script>
		// 마커를 담을 배열입니다
		function setZoomable(zoomable) {
			// 마우스 휠로 지도 확대,축소 가능
			map.setZoomable(zoomable);
		}
		function setDraggable(draggable) {
			// 마우스 드래그로 지도 이동 가능
			map.setDraggable(draggable);
		}

		// ---------- 지도 타입 바꾸기2 ----------
		// 지도 타입 정보를 가지고 있을 객체입니다
		// map.addOverlayMapTypeId 함수로 추가된 지도 타입은
		// 가장 나중에 추가된 지도 타입이 가장 앞에 표시
		// 이 예제에서는 지도 타입을 추가할 때 교통정보, 자전거도로 정보 순으로 추가하므로
		// 교통정보 및 자전거도로 선택 시 자전거 도로 정보가 가장 상위에 표시
		var mapTypes = {
			traffic : kakao.maps.MapTypeId.TRAFFIC,
			bicycle : kakao.maps.MapTypeId.BICYCLE,
		};

		// 체크 박스를 선택하면 호출되는 함수
		function setOverlayMapTypeId() {
			var chkTraffic = document.getElementById('chkTraffic'), chkBicycle = document
					.getElementById('chkBicycle');

			// 지도 타입을 제거
			for ( var type in mapTypes) {
				map.removeOverlayMapTypeId(mapTypes[type]);
			}

			// 교통정보 체크박스가 체크되어있으면 지도에 교통정보 지도타입을 추가
			if (chkTraffic.checked) {
				map.addOverlayMapTypeId(mapTypes.traffic);
			}

			// 자전거도로정보 체크박스가 체크되어있으면 지도에 자전거도로정보 지도타입을 추가
			if (chkBicycle.checked) {
				map.addOverlayMapTypeId(mapTypes.bicycle);
			}
		}

		var markers = [];
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div
		mapOption = {
			center : new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 생성
		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 장소 검색 객체를 생성
		var ps = new kakao.maps.services.Places();

		// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성
		var infowindow = new kakao.maps.InfoWindow({
			zIndex : 1
		});

		// 키워드로 장소를 검색
		searchPlaces();

		// 키워드 검색을 요청하는 함수
		function searchPlaces() {

			var keyword = document.getElementById('keyword').value;

			/*
			----------**팝업 메시지 사용 여부는 추후 결정**----------
			if (!keyword.replace(/^\s+|\s+$/g, '')) {
				alert('교통상황을 확인하고자 하는 지역을 입력해주세요!');
				return false;
			}
			*/

			// 장소검색 객체를 통해 키워드로 장소검색을 요청
			ps.keywordSearch(keyword, placesSearchCB);
		}

		// 장소검색이 완료됐을 때 호출되는 콜백함수
		function placesSearchCB(data, status, pagination) {
			if (status === kakao.maps.services.Status.OK) {

				// 정상적으로 검색이 완료됐으면
				// 검색 목록과 마커를 표출
				displayPlaces(data);

				// 페이지 번호를 표출
				displayPagination(pagination);

			} else if (status === kakao.maps.services.Status.ZERO_RESULT) {

				alert('검색 결과가 존재하지 않습니다.');
				return;

			} else if (status === kakao.maps.services.Status.ERROR) {

				alert('검색 결과 중 오류가 발생했습니다.');
				return;

			}
		}

		// 검색 결과 목록과 마커를 표출하는 함수
		function displayPlaces(places) {

			var listEl = document.getElementById('placesList'), menuEl = document
					.getElementById('menu_wrap'), fragment = document
					.createDocumentFragment(), bounds = new kakao.maps.LatLngBounds(), listStr = '';

			// 검색 결과 목록에 추가된 항목들을 제거
			removeAllChildNods(listEl);

			// 지도에 표시되고 있는 마커를 제거
			removeMarker();

			for (var i = 0; i < places.length; i++) {

				// 마커를 생성하고 지도에 표시
				var placePosition = new kakao.maps.LatLng(places[i].y,
						places[i].x), marker = addMarker(placePosition, i), itemEl = getListItem(
						i, places[i]); // 검색 결과 항목 Element를 생성

				// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
				// LatLngBounds 객체에 좌표를 추가
				bounds.extend(placePosition);

				// 마커와 검색결과 항목에 mouseover 했을때
				// 해당 장소에 인포윈도우에 장소명을 표시
				// mouseout 했을 때는 인포윈도우를 닫음
				(function(marker, title) {
					kakao.maps.event.addListener(marker, 'mouseover',
							function() {
								displayInfowindow(marker, title);
							});

					kakao.maps.event.addListener(marker, 'mouseout',
							function() {
								infowindow.close();
							});

					itemEl.onmouseover = function() {
						displayInfowindow(marker, title);
					};

					itemEl.onmouseout = function() {
						infowindow.close();
					};
				})(marker, places[i].place_name);

				fragment.appendChild(itemEl);
			}

			// 검색결과 항목들을 검색결과 목록 Elemnet에 추가
			listEl.appendChild(fragment);
			menuEl.scrollTop = 0;

			// 검색된 장소 위치를 기준으로 지도 범위를 재설정
			map.setBounds(bounds);
		}

		// 검색결과 항목을 Element로 반환하는 함수
		function getListItem(index, places) {

			var el = document.createElement('li'), itemStr = '<span class="markerbg marker_'
					+ (index + 1)
					+ '"></span>'
					+ '<div class="info">'
					+ '   <h5>' + places.place_name + '</h5>';

			if (places.road_address_name) {
				itemStr += '    <span>' + places.road_address_name + '</span>'
						+ '   <span class="jibun gray">' + places.address_name
						+ '</span>';
			} else {
				itemStr += '    <span>' + places.address_name + '</span>';
			}

			itemStr += '  <span class="tel">' + places.phone + '</span>'
					+ '</div>';

			el.innerHTML = itemStr;
			el.className = 'item';

			return el;
		}

		// 마커를 생성하고 지도 위에 마커를 표시하는 함수
		function addMarker(position, idx, title) {
			var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 사용
			imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
			imgOptions = {
				spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
				spriteOrigin : new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
				offset : new kakao.maps.Point(13, 37)
			// 마커 좌표에 일치시킬 이미지 내에서의 좌표
			}, markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
					imgOptions), marker = new kakao.maps.Marker({
				position : position, // 마커의 위치
				image : markerImage
			});

			marker.setMap(map); // 지도 위에 마커를 표출
			markers.push(marker); // 배열에 생성된 마커를 추가

			return marker;
		}

		// 지도 위에 표시되고 있는 마커를 모두 제거
		function removeMarker() {
			for (var i = 0; i < markers.length; i++) {
				markers[i].setMap(null);
			}
			markers = [];
		}

		// 검색결과 목록 하단에 페이지번호를 표시는 함수
		function displayPagination(pagination) {
			var paginationEl = document.getElementById('pagination'), fragment = document
					.createDocumentFragment(), i;

			// 기존에 추가된 페이지번호를 삭제
			while (paginationEl.hasChildNodes()) {
				paginationEl.removeChild(paginationEl.lastChild);
			}

			for (i = 1; i <= pagination.last; i++) {
				var el = document.createElement('a');
				el.href = "#";
				el.innerHTML = i;

				if (i === pagination.current) {
					el.className = 'on';
				} else {
					el.onclick = (function(i) {
						return function() {
							pagination.gotoPage(i);
						}
					})(i);
				}

				fragment.appendChild(el);
			}
			paginationEl.appendChild(fragment);
		}

		// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수
		// 인포윈도우에 장소명을 표시
		function displayInfowindow(marker, title) {
			var content = '<div style="padding:5px;z-index:1;">' + title
					+ '</div>';

			infowindow.setContent(content);
			infowindow.open(map, marker);
		}

		// 검색결과 목록의 자식 Element를 제거하는 함수
		function removeAllChildNods(el) {
			while (el.hasChildNodes()) {
				el.removeChild(el.lastChild);
			}
		}
	</script>
<!--  
<div class="container">
		<div>
			<form class="navbar-form">
				<div class="input-group">
					<div class="form-group navbar-left">
						<select name="key" class="form-control">
							<!-- selected="select" or selected
							<option value="t" ${(pageObject.key == "t")? " selected ":"" }>제목</option>
							<option value="c" ${(pageObject.key == "c")? " selected ":"" }>내용</option>
							<option value="w" ${(pageObject.key == "w")? " selected ":"" }>작성자</option>
							<option value="tc" ${(pageObject.key == "tc")? " selected ":"" }>제목/내용</option>
							<option value="tw" ${(pageObject.key == "tw")? " selected ":"" }>제목/작성자</option>
							<option value="cw" ${(pageObject.key == "cw")? " selected ":"" }>내용/작성자</option>
							<option value="tcw"
								${(pageObject.key == "tcw")? " selected ":"" }>전체</option>
						</select> <input type="text" class="form-control" placeholder="Search"
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
-->
<div class="container">
		<h1>[서울 전체 평균 교통속도]</h1>
	<table class="table">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		
	<c:if test="${empty list }">
		<!-- 만약에 데이터가 없으면 데이터 없음을 표시한다. -->
			<tr>
				<td colspan="5">데이터가 존재하지 않습니다.</td>
			</tr>
	</c:if>
		
	<c:if test="${!empty list }">
		<!-- 데이터의 존재하면 갯수만큼 반복되어 지는 부분 -->
		<c:forEach items="${list }" var="vo">
			<tr class="dataRow">
				<td class="no">${vo.no }</td>
				<td>${vo.title }</td>
				<td>${vo.writer }</td>
				<td>
					<fmt:formatDate value="${vo.writeDate }" pattern="yyyy.MM.dd"/>
				</td>
				<td>${vo.hit }</td>
			</tr>
		</c:forEach>
	</c:if>
		
		<c:if test="${pageObject.totalPage > 1 }">
			<!-- 전체 페이지가 2페이지 이상이면 보여주는 부분 -->
			<tr>
				<td colspan="5">
					<PageNav:pageNav listURI="list.do" pageObject="${pageObject }" />
				</td>
			</tr>
		</c:if>
		
		<tr>
			<td colspan="5">
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<a href="write.do" class="btn btn-default">글쓰기</a>
			</sec:authorize>
			</td>
		</tr>
	</table>
<!--  	
	<h5>※교통정보에 대한 내용만 작성하여 주세요.</h5>
	<h6>※음주단속, 재난, 사고 등등</h6>
	<h6>※교통정보와 관계없거나 비속어는 통보없이 삭제됩니다.</h6>
-->
</div>
</body>
</html>