<%@ page language="java" 
		 contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko-kr">

  <head>
	
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>lol.duo</title>

	
    <!-- Bootstrap core CSS -->
    <link href="<c:url value='htmlst/vendor/bootstrap/css/bootstrap.min.css' /> " rel="stylesheet">
    
    <!-- Custom fonts for this template -->
    <link href="<c:url value='htmlst/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet' /> " type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>

    <!-- Custom styles for this template -->
	<link href="<c:url value='htmlst/css/clean-blog.min.css' /> " rel="stylesheet">
	
	<!-- Bootstrap core JavaScript -->
    <script src="<c:url value='htmlst/vendor/jquery/jquery.min.js' /> "></script>
    <script src="<c:url value='htmlst/vendor/bootstrap/js/bootstrap.bundle.min.js'/> "></script>

    <!-- Custom scripts for this template -->
    <script src="<c:url value='htmlst/js/clean-blog.min.js'/> "></script>
	
<style>
	#progressMain{
		background: none;
		height: auto;
	}
	#increaseLine {
      animation-name: blink;
      animation-duration: 1.5s;
      animation-timing-function: linear;
      animation-iteration-count: infinite;
    }
    
    @keyframes blink {
      from {color: white;}
      30% {color: #ffe687a3;}
      to {color: #FE5A12;}

    }
    .navbar-brand{
		margin: 0;
	}
	.lol_logo{
		padding-right: 10px;
	}
</style>
  </head>

  <body>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
      <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/index"><img src="htmlst/css/lolimg/logo-lol.png" class="lol_logo">LOL.DUO</a>
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
        <div class="col-lg-10 col-md-10 mx-auto">
          <div class="post-preview">
            <a href="#">
              <h2 class="post-title">
                	롤 듀오 커뮤니티 입니다.
              </h2>
              <h3 class="post-subtitle">
                	<small>스트레스 받지말고 승률을 올려보자!</small> <big><strong style="color: #FE5A12">평균 승률 15% 상승 <i class="fa fa-long-arrow-up fa-2x" id="increaseLine" aria-hidden="true"></i></strong></big>
              </h3>
              <div class="progress" id="progressMain">
              	<div class="progress-bar progress-bar-striped" role="progressbar" style="width:47%; height: 40px">평균 RANK 승률 47%</div>
              	<div class="progress-bar progress-bar-striped bg-warning progress-bar-animated" role="progressbar" style="width:15%; height: 40px">LOL.DUO 평균 65%</div>
              </div>
            </a>
          </div>
          <br/><br/>
          
          <!-- Pager -->
          <div class="clearfix">
            <a class="btn btn-primary float-right" href="${pageContext.request.contextPath}/join">참여하기 &rarr;</a>
          </div>
        </div>
      </div>
    </div>

    <hr>

    <!-- Footer -->
    <footer>
      <div class="container">
        <div class="row" style="text-align: center;">
          <div class="col-lg-8 col-md-10 mx-auto" style="display: inline-block;">
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
