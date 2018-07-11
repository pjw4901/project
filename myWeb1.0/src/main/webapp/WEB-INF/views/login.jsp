<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page session="true" pageEncoding="UTF-8"%>
<html>
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Bootstrap core CSS -->
    <link href="../htmlst/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Custom fonts for this template -->
    <link href="../htmlst/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>

    <!-- Custom styles for this template -->
	<link href="../htmlst/css/clean-blog.min.css" rel="stylesheet">

<title>로그인 페이지</title>
<style>


header.masthead{
	height: 300px;
}

header.masthead .site-heading {
    padding: 100px 0;
}

#login-box {
				width: 800px;
				padding: 20px;
				margin: 0px auto;
				background: #fff;
				-webkit-border-radius: 10px;
				-moz-border-radius: 10px;
				border-radius: 10px;
				border: 1px solid #000;
			}
.navbar-brand{
	margin: 0;
}
.lol_logo{
	padding-right: 10px;
}			

</style>

<script src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script>

$(document).ready(function() {
	
	 // 필드 공백 제거
	 $("#j_username").val().replace(/\s/g, "");
	 $("#j_password").val().replace(/\s/g, "");
	 
	 $("#login").click(function() {
		
		// 공백 여부 점검
		if ($.trim($("#j_username").val()) == "" || 
			$.trim($("#j_password").val()) == "")   {
			
			alert("공백이 입력되었습니다. 다시 입력하십시오.");
			$("#j_username").val("");
			$("#j_password").val("");
			
		} else {
			
			alert(".ajax 실행")
			
			$.ajax({
	    		url : "${pageContext.request.contextPath}/login/idCheck",
	    	    type: "get",
	    	    dataType: "text",
	        	data : {
	        		username : $("#j_username").val()
	        	},
	        	success : function(data) {
	        		
	        		if (data.trim() == "true") {
		           		 alert("아이디가 존재합니다.");
		       			 document.loginForm.submit();
		           	} else 
		       			 alert("아이디가 존재하지 않습니다."); 
	        			 $("#j_username").focus();
		        	}
	        	
	    	}); // $.ajax
		} // if
   	
   }) // login
   
}) //

</script>
</head>
<body>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
      <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/index"><img src="../htmlst/css/lolimg/logo-lol.png" class="lol_logo">LOL.DUO</a>
        <!-- 반응형 메뉴바 -->
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          Menu
          <i class="fa fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/index">홈</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/searchSubmit">전적검색</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/board/list.do/1">게시판</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">게임리스트</a>
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
        </div>
      </div>
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



		
    <!-- Main Content -->
    <div class="container">
		<div class="row">
        	<div class="col-lg-10 col-md-12 mx-auto">    

 		<!-- url은 예약 url로써 xml 설정에 따름. 별도의 사용자 정의하려면 변경 가능. -->
		<%-- <form id="loginForm"
			  name="loginForm"
			  action="<c:url value='/auth/login_check?targetUrl=${targetUrl}' />"
			  method="POST"> --%>
			  
			<form id="loginForm" name="loginForm" 
			  action="<c:url value='${pageContext.request.contextPath}/j_spring_security_check' />" method="POST">
			  
				<!-- <div id="login-box"> -->
		
						<!-- <td><input type="text" 
						  		   id="userid"
								   name="userid"
								   size="25"
								   maxlength="20"></td> -->
					
				<div class="control-group">
             		<div class="form-group floating-label-form-group controls">
                		<label>userid</label>
                		<input type="text" class="form-control" placeholder="ID" id = "j_username" name="j_username" required data-validation-required-message="Please enter your name.">
                		<p class="help-block text-danger"></p>
              		</div>
           		</div>			   
					
					<!-- <div class="input-group">
						<span class="input-group-addon"><i class="fa fa-user-o fa-lg" aria-hidden="true"></i></span>
							<input type="text" 
									   id = "j_username"	
									   name="j_username" />
					</div> -->
				<div class="control-group">
             		<div class="form-group floating-label-form-group controls">
                		<label>password</label>
                		<input type="password"  class="form-control" placeholder="PASSWORD" id="j_password" name="j_password" required data-validation-required-message="Please enter your name.">
                		<p class="help-block text-danger"></p>
              		</div>
           		</div>						
				<br>
				<br>
					<!-- <div class="input-group">
						<span class="input-group-addon"><i class="fa fa-shield fa-lg" aria-hidden="true"></i></span>
							<input type="password" 
									   id="j_password"
									   name="j_password" />
					</div> -->
				<div class="row">
					<div class="col-lg-10 col-md-12 mx-auto" align="center">
						<button type="button" id="login" name="login" class="btn btn-primary" >로그인</button>
						<!-- <input id="login" name="login" type="button" value="login"/>&nbsp; -->
						&nbsp;
						&nbsp;
						<button type="button" id="joinbtn" name="joinbtn" class="btn btn-primary"
						onclick="location.href='${pageContext.request.contextPath}/join'">회원가입</button>
						<%-- <input id="joinbtn" name="joinbtn" type="button" value="join"
						 onclick="location.href='${pageContext.request.contextPath}/join'" />	 --%>				
					</div>
				</div>
				<!-- </div> -->				
							   
			</form>
			</div>
		</div>
	</div>
    
	<hr>    
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
    
    <!-- Bootstrap core JavaScript -->
    <script src="../htmlst/vendor/jquery/jquery.min.js"></script>
    <script src="../htmlst/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Custom scripts for this template -->
    <script src="../htmlst/js/clean-blog.min.js"></script>

</body>
</html>