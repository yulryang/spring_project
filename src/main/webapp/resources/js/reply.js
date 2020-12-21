/**
 * 게시판 댓글 처리를 위한 객체 선언
 */
 
 // 댓글 js 모듈이 시작되고 있다.
 // console.log("Reply Module");
// alert("댓글 모듈 진행... 시작");
 
var replyService = (
 	function(){
 		
 		// 댓글 리스트 함수
 		function list(pageInfo, callback){
 			//alert("댓글 리스트 처리 진행 ..." + JSON.stringify(pageInfo));
 			// server에 데이터를 넘겨서 처리 - 브라우저의 URL을 바꾸지 않는다. - Ajax
 			$.ajax({
 				url:'/ajax/replyList.do',
 				type:'get',
 				// 서버로 보내지는 데이터
 				data:pageInfo,
 				// 보내지는 데이터의 형식 - 헤더 셋팅
 				contentType:"application/json; charset=utf-8",
 				// 받는 데이터 형식 - json
 				dataType:"json",
 				// 처리가 성공했을때 실행되는 함수
 				success: function(result, status, xhr){
 					// 
 					// 샘플데이터 찍어보기- [],[],[]
 					alert(JSON.stringify(result));
 					//alert(result[0].rno);
 					
 					// 데이터가 많으므로 반복문 처리를 한다.
 					$(result).each(function(idx, vo){ 						
 					}); 					
 					// 여기 부분이 view.js 에서 이벤트 처리 
 					
 					// 성공하면 callback 함수가 있는 경우 실행한다.
 					if(callback){
// 						callback();
 						callback(result);
 					}
 					//alert(result);
 					//alert(status);
 				},
 				// 처리가 실패했을때 실행되는 함수
 				error : function(xhr, status, er){
 					//alert(status);
 					//alert(er);
 				}
 			});
 		}
 		
 		// 댓글 쓰기 함수
 		// reply 는 JSON 객체를 문자열로 만들어서 넘겨야 한다.
 		function add(reply, callback){
 			// alert("댓글 쓰기 처리 진행 ..." + reply);
 			// server에 데이터를 넘겨서 처리 - 브라우저의 URL을 바꾸지 않는다. - Ajax
 			$.ajax({
 				url:'/ajax/replyWrite.do',
 				type:'post',
 				// 서버로 보내지는 데이터
 				data:reply,
 				// 보내지는 데이터의 형식 - 헤더 셋팅
 				contentType:"application/json; charset=utf-8",
 				// 처리가 성공했을때 실행되는 함수
 				success: function(result, status, xhr){
 					// 성공하면 callback 함수가 있는 경우 실행한다.
 					if(callback){
 						callback();
 					}
 					//alert(result);
 					//alert(status);
 				},
 				// 처리가 실패했을때 실행되는 함수
 				error : function(xhr, status, er){
 					alert(status);
 					alert(er);
 				}
 			});
 		}	
 			//p370
 		// 댓글 수정 함수
 		// reply 는 JSON 객체를 문자열로 만들어서 넘겨야 한다.
 		// reply 는 댓글 페이지가 포함되어 있어야 한다. reply.page
 		function update(reply, callback){
 			// alert("댓글 수정 처리 진행 ..." + reply);
 			// server에 데이터를 넘겨서 처리 - 브라우저의 URL을 바꾸지 않는다. - Ajax
 			$.ajax({
 				url:'/ajax/replyUpdate.do',
 				type:'patch',
 				// 서버로 보내지는 데이터
 				data:reply,
 				// 보내지는 데이터의 형식 - 헤더 셋팅
 				contentType:"application/json; charset=utf-8",
 				// 처리가 성공했을때 실행되는 함수
 				success: function(result, status, xhr){
 					// 성공하면 callback 함수가 있는 경우 실행한다.
 					if(callback){
 						callback(reply.page);
 						//현재(댓글)페이지에 해당하는 정보를 어디에 담아두어야 꺼낼 수 있다.
 						//그래서 콜백함수를 만들때 replyPage 를 만들어둔다.
 					}
 					//alert(result);
 					//alert(status);
 				},
 				// 처리가 실패했을때 실행되는 함수
 				error : function(xhr, status, er){
 					alert(status);
 					alert(er);
 				}
 			});
 		}
 		// 댓글 삭제 함수 - delete() 사용하고 있기 때문에 재사용시 오류 표시
 		function replyDelete(rno, callback){
 			// alert("댓글 삭제 처리 진행 ..." + reply);
 			// server에 데이터를 넘겨서 처리 - 브라우저의 URL을 바꾸지 않는다. - Ajax
 			$.ajax({
 				url:'/ajax/replyDelete.do?rno='+rno,
 				type:'delete',
 				// 서버로 보내지는 데이터
 				data:reply,
 				// 보내지는 데이터의 형식 - 헤더 셋팅 -> 쿼리로 만듬 위에 no->rno, ?rno='+rno
 				// contentType:"application/json; charset=utf-8",
 				// 처리가 성공했을때 실행되는 함수
 				success: function(result, status, xhr){
 					// 성공하면 callback 함수가 있는 경우 실행한다.
 					if(callback){
 						callback();
 						//현재(댓글)페이지에 해당하는 정보를 어디에 담아두어야 꺼낼 수 있다.
 						//그래서 콜백함수를 만들때 replyPage 파라미터 를 만들어둔다.
 					}
 					//alert(result);
 					//alert(status);
 				},
 				// 처리가 실패했을때 실행되는 함수
 				error : function(xhr, status, er){
 					alert(status);
 					alert(er);
 				}
 			});
 		}
 		
 		// replyService.add(reply, callback)
 		return {
 			list:list,
 			add:add,
 			update:update,
 			delete:replyDelete
 		}
 	}
 )();