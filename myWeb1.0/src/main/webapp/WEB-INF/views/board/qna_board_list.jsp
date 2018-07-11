<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
    
    <!-- Custom fonts for this template -->
    <link rel="stylesheet" type="text/css" href="<c:url value='/htmlst/vendor/font-awesome/css/font-awesome.min.css' /> ">
 
	<!-- Custom styles for this template -->
	<link href="<c:url value='/htmlst/css/clean-blog_board.css'/> " rel="stylesheet">
	
	<style type="text/css">
	
	#mainNav {
	    position: relative;
	    min-height: 50px;
	    margin-bottom: 0px;
	    border: 0px;
	    background: linear-gradient(52deg, #5383e8, #3991ef 31%, #3892f0 32%, #3594f1 36%, #3594f1);
	    border-radius: 0px;
	}
    .navbar-brand{
		margin: 0;
	}
	.lol_logo{
		padding-right: 10px;
	}	

	
	</style>
	<script>
	$(document).ready(function(){
		
		// 게시글 팝업(modal) 보기
		$("a[id^=boardNum_]").click(function (e) {
			
			var boardNum = e.target.id.substring(9); // "boardNum_" 뒤부분 "글번호" 취득
			alert(boardNum);
			var page = /* $("#nowPage").html() */${pageInfo.page};
			
			$.ajax ({
				url : "${pageContext.request.contextPath}/board/boardDetailJSON.do/boardNum/"
						+boardNum+"/page/"+page,
				contentType : "application/json",
				type : "POST",
				success : function (json) {
				
					alert("성공")
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

<body>

	<!-- <form class="navbar-form navbar-left" role="search">
	        <div class="form-group">
	          <input type="text" class="form-control" placeholder="Search">
	        </div>
	        <button type="submit" class="btn btn-default">Submit</button>
	      </form> -->
	      
	 <!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
	  <div class="container-fluid">
	    <!-- Brand and toggle get grouped for better mobile display -->
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
	        <i class="fa fa-bars"></i>
	      </button>
	      <a class="navbar-brand" href="${pageContext.request.contextPath}/index"><img src="<c:url value='/htmlst/css/lolimg/logo-lol.png" class="lol_logo' />" style="display: inline-block;">LOL.DUO</a>
	    </div>

	    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	      <ul class="nav navbar-nav navbar-right">
	       <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/index">홈</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="about.html">전적검색</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/board/list.do/1">게시판</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="contact.html">게임리스트</a>
            </li>
            
<sec:authorize access="!isAuthenticated()">
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/login">
              <i class="fa fa-user-circle-o" aria-hidden="true"></i>로그인
              </a>
            </li>
</sec:authorize>            
<sec:authorize access="hasRole('ROLE_USER')">
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/login/secured/welcome">
              <i class="fa fa-user-circle-o" aria-hidden="true"></i>사용자님
              </a>
            </li>
</sec:authorize>
<sec:authorize access="hasRole('ROLE_ADMIN')">
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/login/admin/welcome">
              <i class="fa fa-user-circle-o" aria-hidden="true"></i>관리자님
              </a>
            </li>
</sec:authorize>
            
            
	      </ul>
	    </div><!-- /.navbar-collapse -->
	  </div><!-- /.container-fluid -->
	</nav>	    
    <!-- Page Header -->
    <header class="masthead">
      <div class="overlay"></div>
      <div class="container">
        <div class="row">
          <div class="col-lg-10 col-md-10 mx-auto">
            <div class="site-heading">
              <h1><i class="fa fa-handshake-o" aria-hidden="true"></i>&nbsp;&nbsp;LOL.DUO</h1>
            </div>
          </div>
        </div>
      </div>
    </header>
    
 	<!-- 인자들 -->
 	<div class="hidden">
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

    <!-- Main Content -->
    <div class="container" ng-app="boardUploadModal">
      <div class="row">
        <div class="col-lg-12 col-md-12 mx-auto">
        	
	<h2 align="center">글 목록 </h2>
	<br>
	
	<!-- 게시판 리스트 시작 -->
	<section id="listForm" style=" margin:auto;">
		
    	<c:if test="${not empty articleList && pageInfo.listCount > 0}">
		
			<!-- 게시글 부분 시작 -->
			<table id="board_tbl" class="table table-hover table-bordered">
				<thead>
				<tr id="tr_top">
				    <td>번호</td>
					<td>글번호</td>
					<td>제목</td>
					<td>작성자</td>
					<td>날짜</td>
					<td>조회수</td>
				</tr>
				</thead>
	
				<c:forEach var="article" items="${articleList}" varStatus="st">
					
					<tr>
						<td>${st.count + (pageInfo.page-1)*10}</td>
						<td>${article.boardNum}</td>
		
						<td class="boardsubjectcl">
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
							<c:if test="${article.boardReadCount >= 20}">
                  				<!-- <span class="hit">hit!</span> -->
                  				<i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
               				</c:if>
						</td>
		
						<td class="boardnamecl"><a>${article.boardName}</a></td>
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
			<div style="display: block; text-align: right;">
				<button class="btn btn-info btn-sm" onclick= "location.href='${pageContext.request.contextPath}/board/write.do'">게시판글쓰기</button>
			</div>
		    <!-- 페이징(paging) -->
			<section id="pageList" style="text-align: center;">
			    
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
			<section id="emptyArea" style="text-align: center;">등록된 글이 없습니다.
				<br />
				<button class="btn btn-info btn-sm" onclick= "location.href='${pageContext.request.contextPath}/board/write.do'">게시판글쓰기</button>
			</section>
		</c:if> 
	
	</section>
	<!-- 게시판 리스트 끝 -->
	
			</div>
		</div>
	</div>
	
	<hr />
    <!-- Footer -->
    <footer>
      <div class="container">
        <div class="row">
          <div class="col-lg-8 col-md-10 mx-auto">
            <ul class="list-inline text-center">
              <li class="list-inline-item">
                <a href="#">
                  <span class="fa-stack fa-lg">
                    <i class="fa fa-circle fa-stack-2x"></i>
                    <i class="fa fa-twitter fa-stack-1x fa-inverse"></i>
                  </span>
                </a>
              </li>
              <li class="list-inline-item">
                <a href="#">
                  <span class="fa-stack fa-lg">
                    <i class="fa fa-circle fa-stack-2x"></i>
                    <i class="fa fa-facebook fa-stack-1x fa-inverse"></i>
                  </span>
                </a>
              </li>
              <li class="list-inline-item">
                <a href="#">
                  <span class="fa-stack fa-lg">
                    <i class="fa fa-circle fa-stack-2x"></i>
                    <i class="fa fa-github fa-stack-1x fa-inverse"></i>
                  </span>
                </a>
              </li>
            </ul>
            <p class="copyright text-muted">Copyright &copy; LOL.DUO Website 2018</p>
          </div>
        </div>
      </div>
    </footer>					
	
</body>
</html>