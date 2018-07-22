<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

<title>관리자 페이지</title>

    <!-- Bootstrap core CSS -->
    <link href="<c:url value='/mypage/vendor/bootstrap/css/bootstrap.min.css'/> " rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link href="https://fonts.googleapis.com/css?family=Saira+Extra+Condensed:100,200,300,400,500,600,700,800,900" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script" rel="stylesheet">
    <link href="<c:url value='/mypage/vendor/font-awesome/css/font-awesome.min.css'/> " rel="stylesheet">
    <link href="<c:url value='/mypage/vendor/devicons/css/devicons.min.css'/> " rel="stylesheet">
    <link href="<c:url value='/mypage/vendor/simple-line-icons/css/simple-line-icons.css'/> " rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="<c:url value='/mypage/css/resume.min.css'/> " rel="stylesheet">
    
    <!-- Bootstrap core JavaScript -->
    <script src="<c:url value='/mypage/vendor/jquery/jquery.min.js'/> "></script>
    <script src="<c:url value='/mypage/vendor/bootstrap/js/bootstrap.bundle.min.js'/> "></script>
<style>
    textarea {
      width: 100%;
      resize: none;
      overflow-y: hidden; /* prevents scroll bar flash */
      padding: 1.1em; /* prevents text jump on Enter keypress */
      padding-bottom: 0.2em;
      line-height: 1.6;
    }
</style>

<script type="text/javascript">
	
	$(document).ready(function() {
		//게시판 삭제 펑션
		$(".deleteBtn").click(function(){
			var deleteBtn = $(this);
			var boardNum = "";
			
			// checkBtn.parent() : checkBtn의 부모는 <td>이다.
			// checkBtn.parent().parent() : <td>의 부모이므로 <tr>이다.
			var tr = deleteBtn.parent().parent();
			var td = tr.children();
			
			boardNum = td.eq(1).text();
						
			$.ajax({
				url : "${pageContext.request.contextPath}/board/delete.do",
				type : "get",
				dataType : "text",
				data : {boardNum : boardNum},
				success : function(data){
					alert("해당 데이터를 삭제했습니다.");
					location.reload();
					
				}
			});//ajax end	
		});//deleteBtn end
		
		//검색 펑션
		$(".searchBtn").click(function() {
			var userid = $('#userName').val();
			
			$.ajax({
				url : "${pageContext.request.contextPath}/board/searchuser.do",
				contentType : "application/json",
				type : "get",
				data : {userid : userid},
				success : function(json){
					
					alert("성공");
					var uservo = JSON.parse(JSON.stringify(json));
					alert(uservo.userid);
					
					$("#username").text(uservo.userid);
					$("#userid").text(uservo.summonerid);
					$("#userlv").text(uservo.commlv);
					
					var wins = uservo.commwins;
					var losses = uservo.commlosses;
					var total = wins+losses;

					 var percentage = wins/total*100;
					document.getElementById("progress").innerHTML =
	        			  '<div class="progress-bar progress-bar-striped progress-bar-animated bg-info" style="width:'+ Math.floor(percentage) + '%">' + Math.floor(percentage) + '%</div>';
					$("#usercontent").text(uservo.commcontent);
					
					$("#usercard").show();
				}
			});// ajax end
		});//검색 버튼 end
		
		//cardupdate Btn
		$("#cardupdate").click(function(){
			var cardcontent = $('#usercontent').val();
			var userid = $('#userName').val();
			$.ajax({
				url : "${pageContext.request.contextPath}/board/updateuser.do",
				contentType : "application/json",
				type : "get",
				data : {userid : userid,
						cardcontent : cardcontent},
				success : function(json){
					
					alert("성공");
					var uservo = JSON.parse(JSON.stringify(json));
					alert(uservo.userid);
					
					$("#username").text(uservo.userid);
					$("#userid").text(uservo.summonerid);
					$("#userlv").text(uservo.commlv);
					$("#usercontent").text(uservo.commcontent);

				}
			});
		});
		
		//card Close Btn
		$("#cardclose").click(function(){
			$("#usercard").hide();
		});
	});//document end
	
</script>
</head>

<body id="page-top">

    <nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top" id="sideNav">
      <a class="navbar-brand js-scroll-trigger" href="#page-top">
        <span class="d-block d-lg-none">AdminPage</span>
        <span class="d-none d-lg-block">
          <img class="img-fluid img-profile rounded-circle mx-auto mb-2" src="<c:url value='/mypage/img/profile.png'/> " alt="">
        </span>
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="#about">About</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger korean" href="#userscard">회원정보 관리</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger korean" href="#boardlist">게시물 관리</a>
          </li>
        </ul>
      </div>
    </nav>

    <div class="container-fluid p-0">

	<!-- 어드민 시작페이지 -->
      <section class="resume-section p-3 p-lg-5 d-flex d-column" id="about">
        <div class="my-auto">
          <h1 class="mb-0">Hello Admin  :)
          </h1>
          <div class="subheading mb-5">@Copyright lol.duo · (031) 123-1234 ·
            <a href="#">pmw4901@naver.com</a>
          </div>
          <p class="mb-5">관리자 페이지 입니다. 현재는 게시물 수정/삭제, 회원 정보 변경이 가능합니다. 꾸준히 업데이트를 할 예정에 있습니다.</p>
          <ul class="list-inline list-social-icons mb-0">
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
                  <i class="fa fa-twitter fa-stack-1x fa-inverse"></i>
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
          <br/><br/>
          <input type="submit" class="btn btn-secondary" id="logout" name="logout" value="로그아웃" onclick="location.href='${pageContext.request.contextPath}/login/logout'" >
        </div>
      </section>

	<!-- 회원정보관리페이지 -->
      <section class="resume-section p-3 p-lg-5 d-flex flex-column" id="userscard">
        <div class="my-auto">
          <h2 class="mb-5" lang="ko">회원정보관리 페이지</h2>

          <div class="resume-item d-flex flex-column flex-md-row mb-5">
            <div class="resume-content mr-auto">
            
              <div class="subheading mb-5">
              	<div class="input-group mb-4 col-lg-4" style="padding: 0; position: absolute;">
				  <input type="text" id="userName" name="userName" class="form-control" placeholder="사용자명을 검색합니다.">
				  <span class="input-group-btn">
					<button class="btn btn-secondary searchBtn">.DUO</button>
				  </span>
				</div>
			  </div>
			  
             	<div class="card bg-light col-lg-6" id="usercard" style="padding-top: 15px; padding-bottom: 15px; margin: auto; display: none">
             	  <img class="card-img-top" src="http://ddragon.leagueoflegends.com/cdn/img/champion/splash/Aatrox_0.jpg" alt="Card image">
				  <div class="card-body">
				  
				    <h4 class="card-title" id="username"></h4>
				    <lable lang="ko">게임아이디 :</lable><p class="card-text" id="userid" style="display: inline-block;"></p><br/>
				    <label lang="ko">커뮤니티승률</label>
				    <div class="progress" id="progress">
					</div><br />
					<label lang="ko">자기소개글</label><br/>
					<textarea rows="4" cols="60" id="usercontent">
					</textarea>
				    
				  </div>
				  
				  <div class="card-footer" style="background-color: #ffffff00; border: none;">
					<div class="btn-group btn-block" role="group">
					  <button id="cardupdate" type="button" class="btn btn-outline-secondary w-100">수정</button>
					  <button id="cardclose" type="button" class="btn btn-outline-secondary w-100">닫기</button>
					</div>
				  </div>
             	</div>
             	             	
             	
            </div>
          </div>
        </div>

      </section>

	<!-- 게시물관리페이지 -->
      <section class="resume-section p-3 p-lg-5 d-flex flex-column" id="boardlist">
        <div class="my-auto">
          <h2 class="mb-5" lang="ko">게시물관리페이지</h2>
            <!-- 인자들 -->
		 	<div hidden>
				총 게시글 수 : ${pageInfo.listCount}<br>
				현재 페이지 : <span id="nowPage">${pageInfo.page}</span><br>
				총 페이지 : ${pageInfo.maxPage}<br>
				시작 페이지 : ${pageInfo.startPage}<br>
				끝 페이지 : ${pageInfo.endPage}
			</div>
          <div class="resume-item d-flex flex-column flex-md-row mb-5" style="overflow: scroll; height: 600px;"> 
			<!-- 등록글 없을 경우 -->
			<c:if test="${empty articleList || pageInfo.listCount==0}">
				<section id="emptyArea" style="text-align: center;">등록된 글이 없습니다.
					<br />
					<button class="btn btn-info btn-sm" onclick= "location.href='${pageContext.request.contextPath}/board/list.do/1'">게시판</button>
				</section>
			</c:if>
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
						<td>삭제</td>
					</tr>
					</thead>
					
					<tbody>
					<c:forEach var="article" items="${articleList}" varStatus="st">
						
						<tr>
							<td>${st.count}</td>
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
								<a> ${article.boardSubject} </a>
							</td>
			
							<td class="boardnamecl"><a>${article.boardName}</a></td>
							<td> <%-- boardDate Format 맞추기 --%>
								<fmt:parseDate var="tmp" value="${article.boardDate}" pattern="yyyy-MM-dd HH:mm:ss" />
								<fmt:formatDate value="${tmp}" pattern="yyyy년MM월dd일 HH:mm:ss"/>
							</td>
							<!-- 교정 : boardReadCount -> boardReadCount_${article.boardName} -->    			    
							<td><span id="boardReadCount_${article.boardNum}">
								${article.boardReadCount}</span></td>
							<td style="text-align: center;">
								<button class="btn btn-warning deleteBtn">삭제</button>
							</td>
						</tr>
						
					</c:forEach>
					</tbody>
						
				</table>

			</c:if>
          </div>

	<!--<div class="resume-item d-flex flex-column flex-md-row">
            <div class="resume-content mr-auto">
              <h3 class="mb-0">James Buchanan High School</h3>
              <div class="subheading mb-3">Technology Magnet Program</div>
              <p>GPA: 3.56</p>
            </div>
            <div class="resume-date text-md-right">
              <span class="text-primary">August 2002 - May 2006</span>
            </div>
          </div> -->

        </div>
      </section>
    </div>

    <!-- Plugin JavaScript -->
    <script src="<c:url value='/mypage/vendor/jquery-easing/jquery.easing.min.js'/> "></script>

    <!-- Custom scripts for this template -->
    <script src="<c:url value='/mypage/js/resume.min.js'/> "></script>   
 
</body>
</html>