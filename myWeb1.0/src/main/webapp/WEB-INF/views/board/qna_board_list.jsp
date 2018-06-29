<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<meta charset="UTF-8">
<title>MVC 게시판</title>

	<!-- bootstrap CSS : 3.3.7 -->
	<link rel="stylesheet" 
		  href="<c:url value='/js/bootstrap/3.3.7/css/bootstrap.min.css/' />">
	
	<!-- jasny-bootstrap : 사설(custom) bootstrap file field 기능 추가 -->		  
	<link rel="stylesheet" 
		  href="<c:url value='/js/bootstrap/jasny-bootstrap/jasny-bootstrap.css' />">
	
	<!-- jQuery : 3.2.1 -->
	<script src="<c:url value='/js/jQuery/3.2.1/jquery-3.2.1.min.js' />"></script>
	
	<!-- bootstrap JS : 3.3.7 -->
	<script src="<c:url value='/js/bootstrap/3.3.7/js/bootstrap.min.js' />"></script>

	<!-- jasny-bootstrap : 사설(custom) bootstrap file field 기능 추가 -->
	<script src="<c:url value='/js/bootstrap/jasny-bootstrap/jasny-bootstrap.js' />"></script>
	
	<style type="text/css">
	/* 등록된 글이 없을 경우, 페이징 처리 */
	#emptyArea, #pageList  
	{
		margin: auto;
		text-align: center;
	}
		/* 필드 배경색 */
	.fld_back { background : yellow } 
	
	/* 라벨 상위 간격 */
	.label_top_padding { padding-top:4px; }
	
	/* 텍스트 필드 */
	.textarea_fld { width:85%; margin:20px; resize: none; }
	
	/* readonly 상태시 */
	*[readonly].form-control { background-color:transparent; }
	
	</style>
	<script>
	$(document).ready(function(){
		
		// 게시글 팝업(modal) 보기
		$("a[id^=boardNum_]").click(function (e) {
			
			var boardNum = e.target.id.substring(9); // "boardNum_" 뒤부분 "글번호" 취득
			alert(boardNum);
			var page = $("#nowPage").html();
			
			$.ajax ({
				url : "${pageContext.request.contextPath}/board/boardDetailJSON.do/boardNum/"
						+boardNum+"/page/"+page+"?${_csrf.parameterName}=${_csrf.token}",
				contentType : "application/json",
				type : "POST",
				success : function (json) {
				
					var article = JSON.parse(JSON.stringify(json));
					
					
					
					// 게시글 내용
					// modal
					$("#boardNum").val(article.boardNum);
					$("#boardName").val(article.boardName);
					$("#boardSubject").val(article.boardSubject);
					$("#boardContent").val(article.boardContent);
					
					var boardFile = article.boardFile==null ? 
							        "파일없음": article.boardFile;
					
					if (boardFile == '파일없음')
					  $("#boardFile").text(boardFile);
					else 
					  $("#boardFile").html("<a href=\"<c:url value='/uploadPath/"+boardFile+"'/>\" >"+boardFile+"</a>");	
					
					// 조회수 업데이트
					$tempId = "#boardReadCount_"+article.boardNum;
					$($tempId).text(article.boardReadCount);
					//alert(article.boardReadCount);
					
					// 버튼 아이디 변경 : ex) "updateContentBtn_"+article.boardNum
					$("button").attr("id", "updateContentBtn_"+article.boardNum);
			
					// 글 수정 전송 버튼 아이디 변경 : ex) "update_btn_"+article.boardNum
					$("update_btn_").attr("id", "update_submit_btn_"+article.boardNum);
					
					}
				
				}); // ajax end
			
			}); //click fun end
			
			//게시글 수정 모달 : 보기
			$("button[id^=updateContentBtn_]").click(function (e) {
				var boardNum = e.target.id.substring(17); //// "updateContentBtn_" 뒤부분 "글번호" 취득
				var page = $("#nowPage").html();
				
				alert(boardNum);
				
				$.ajax ({
					url : "${pageContext.request.contextPath}/board/boardDetailJSON.do/boardNum/"
							+boardNum+"/page/"+page+"?${_csrf.parameterName}=${_csrf.token}",
					contentType : "application/json",
					type : "POST",
					success : function(json){
						
						var article = JSON.parse(JSON.stringify(json));
						
						//기존 게시글 내용
						$("#update_boardNum").val(article.boardNum);
						$("#update_boardName").val(article.boardName);
						$("#update_boardSubject").val(article.boardSubject);
						$("#update_boardContent").val(article.boardContent);
						
						var boardFile = article.boardFile == null ? "파일없음" : article.boardFile;
						
						if (boardFile == '파일없음')
							  $("#update_boardFile").text(boardFile);
							else 
							  $("#update_boardFile").html("<a href=\"<c:url value='/uploadPath/"
									  					   +boardFile+"'/>\" >"+boardFile+"</a>");	
							
							// 조회수 업데이트
							$tempId = "#boardReadCount_"+article.boardNum;
							$($tempId).text(article.boardReadCount);
					}
				})// ajax end
			});//게시글 수정 모달 : 보기 끝
			
			//게시글 수정 모달 : 전송
			$("button[id^=update_btn_]").click(function (e) {
				alert("글수정 요청 !");
				
				var boardNum = e.target.id.substring(17);
				var page = $("#nowPage").html();
				
				var form = $("form#updateForm")[0];
				var formData = new FormData(form);
				
				//파일 필드 초기화 : 초기화 하지않으면 이전 업로드 파일이 반영됨
				$("#update_boardFile_new").val("");
				
				alert($("#update_boardFile_new").val());
				
				$.ajax ({
					url : "${pageContext.request.contextPath}/board/updateBoard.do/"+boardNum+"?${_csrf.parameterName}=${_csrf.token}",
							
					cache: false,	 
		            async: false,
		            cache: false,
		            contentType: false,
		            processData: false,
		            
					type : "POST",
					data : formData,
					
					success : function () {
						
						alert("success!");
						location.href = "${pageContext.request.contextPath}/board/list.do/"+page+"?${_csrf.parameterName}=${_csrf.token}";
						
						
					}
				});
			});//게시글 수정 모달 : 전송 끝
			
			
		}); //document ready end(보기 모달 끝)
		
		
	</script>
</head>

<body ng-app="boardUploadModal">

	<!-- 인자들 -->
 	<div>
		총 게시글 수 : ${pageInfo.listCount}<br>
		현재 페이지 : <span id="nowPage">${pageInfo.page}</span><br>
		총 페이지 : ${pageInfo.maxPage}<br>
		시작 페이지 : ${pageInfo.startPage}<br>
		끝 페이지 : ${pageInfo.endPage}
	</div> 
	
	<!-- 게시글정보 보기(팝업) 시작 -->
	<%@ include file="boardViewModal.jsp" %>
	<!-- 게시글정보 보기(팝업) 끝 -->
	
	<!-- 게시글정보 수정(팝업) 시작 -->
	<%@ include file="boardUpdateModal.jsp" %>
	<!-- 게시글정보 수정(팝업) 끝 -->
	
	<h3 align="center">
		글 목록   &nbsp;<a href="${pageContext.request.contextPath}/board/write.do">게시판글쓰기</a>
	</h3>
	<br>
	
	<!-- 게시판 리스트 시작 -->
	<section id="listForm" style="width:800px; margin:auto;">
		
    	<c:if test="${not empty articleList && pageInfo.listCount > 0}">
		
			<!-- 게시글 부분 시작 -->
			<table id="board_tbl" class="table table-striped table-hover">
			
				<tr id="tr_top">
				    <td>번호</td>
					<td>글번호</td>
					<td>제목</td>
					<td>작성자</td>
					<td>날짜</td>
					<td>조회수</td>
				</tr>
	
				<c:forEach var="article" items="${articleList}" varStatus="st">
					
					<tr>
						<td>${st.count + (pageInfo.page-1)*10}</td>
						<td>${article.boardNum}</td>
		
						<td>
							<c:choose>
								<c:when test="${article.boardReLev != 0}">
									<c:forEach var="a" 
											   begin="0" 
											   end="${article.boardReLev * 2}" 
											   step="1" 
											   varStatus="st">
										&nbsp;
									</c:forEach>
									 	▶ 
								</c:when>
								<c:otherwise>
									▶ 
								</c:otherwise> 
							</c:choose>
							
							<%-- <a href="${pageContext.request.contextPath}/board/boardDetail.do/boardNum/${article.boardNum}/page/${pageInfo.page}">
								${article.boardSubject}
							</a> 일반적인 게시판 --%>
							<a href="#" id="boardNum_${article.boardNum}" 
										data-toggle="modal" 
										data-target="#myModal">
								${article.boardSubject}
							</a>
						</td>
		
						<td>${article.boardName}</td>
						<td> <%-- boardDate Format 맞추기 --%>
							<fmt:parseDate var="tmp" value="${article.boardDate}" pattern="yyyy-MM-dd HH:mm:ss" />
							<fmt:formatDate value="${tmp}" pattern="yyyy년MM월dd일 HH:mm:ss"/>
						</td>
						<!-- 교정 : boardReadCount -> boardReadCount_${article.boardName} -->    			    
						<td><span id="boardReadCount_${article.boardNum}">
							${article.boardReadCount}</span></td>
					</tr>
					
				</c:forEach>
					
			</table>
			<!-- 게시글 부분 끝 -->
		
		    <!-- 페이징(paging) -->
			<section id="pageList">
			    
			    <ul class="pagination">
			    
				    <c:choose>
				    	<c:when test="${pageInfo.page <= 1}">
				    		<!-- 주의) 이 부분에서 bootstrap 페이징 적용시 불가피하게 <a> 기입. <a>없으면 적용 안됨. -->	
							<li><a href="${pageContext.request.contextPath}/board/list.do/1">이전</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="${pageContext.request.contextPath}/board/list.do/${pageInfo.page -1}">이전</a></li>
						</c:otherwise>	
					</c:choose>
					
					<c:forEach var="a" 
							   begin="${pageInfo.startPage}"
							   end="${pageInfo.endPage}">
	
						<c:choose>
							<c:when test="${a == pageInfo.page}">
							    <!-- 주의) 이 부분에서 bootstrap 페이징 적용시 불가피하게 <a> 기입. <a>없으면 적용 안됨. -->		
								<li class="active"><a href="${pageContext.request.contextPath}/board/list.do/${a}">${a}</a></li>
							</c:when>	
							<c:otherwise>
								<li><a href="${pageContext.request.contextPath}/board/list.do/${a}">${a}</a></li>
							</c:otherwise>
						</c:choose>
						
					</c:forEach>
			
					<c:choose>
						<c:when test="${pageInfo.page >= pageInfo.maxPage}">
							 <!-- 주의) 이 부분에서 bootstrap 페이징 적용시 불가피하게 <a> 기입. <a>없으면 적용 안됨.
							                      링크 교정 => page=${pageInfo.page} -->
							<li><a href="${pageContext.request.contextPath}/board/list.do/${pageInfo.page}">다음</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="${pageContext.request.contextPath}/board/list.do/${pageInfo.page + 1}">다음</a></li>
						</c:otherwise>
					</c:choose>	
				
				</ul>
				
			</section>
			<!-- 페이징 끝 -->	
		
		</c:if>
	
		<!-- 등록글 없을 경우 -->
		<c:if test="${empty articleList || pageInfo.listCount==0}">
			<section id="emptyArea">등록된 글이 없습니다.</section>
		</c:if> 
		
		<!-- Spring Security Auth(CSRF) Token : 반드시 기입! 없으면 에러 출력됨 !-->
			<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
	
	</section>
	<!-- 게시판 리스트 끝 -->
	

					
	
</body>
</html>