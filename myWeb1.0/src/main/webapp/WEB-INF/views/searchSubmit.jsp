<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html">
<html lang="ko-kr">
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="<c:url value ='/htmlst/vendor/bootstrap/css/bootstrap.min.css' /> ">
    
    <!-- Custom fonts for this template -->
    <link rel="stylesheet" type="text/css" href="<c:url value ='/htmlst/vendor/font-awesome/css/font-awesome.min.css'/> ">
    <link href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>

    <!-- Custom styles for this template -->
	<link rel="stylesheet" href="<c:url value ='/htmlst/css/clean-blog.min.css' /> ">

    <!-- Bootstrap core JavaScript -->
    <script src="<c:url value ='/htmlst/vendor/jquery/jquery.min.js'/> "></script>
    <script src="<c:url value ='/htmlst/vendor/bootstrap/js/bootstrap.bundle.min.js'/> "></script>

    <!-- Custom scripts for this template -->
    <script src="<c:url value ='/htmlst/js/clean-blog.min.js'/> "></script>
    
<title>전적 검색</title>

    <style>
    
    header.masthead{
	height: 300px;
	}
	
	header.masthead .site-heading {
	    padding: 100px 0;
	}
	
	/* 에러 메시지 출력 팝업 */
	.msg-popup 
	{
		background-color:yellow;
		color:red;
		padding:10px;
		border-radius:7px;
		border:2px solid cyan;
		z-index:2;
	}
	.btn{
		font-size: 20px;
		padding : 6px 12px;
		background: linear-gradient(52deg, #5383e8, #3991ef 31%, #3892f0 32%, #3594f1 36%, #3594f1);
	}
    </style>

</head>
<body>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
      <div class="container">
        <a class="navbar-brand" href="index.html">LOL.DUO</a>
        <!-- 반응형 메뉴바 -->
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          Menu
          <i class="fa fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/html/index.html">홈</a>
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
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/login">
              <i class="fa fa-user-circle-o" aria-hidden="true"></i>로그인
              </a>
            </li>
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
        	<form id="searchForm" name="searchForm" action="<c:url value='/search' />" method="POST">

				<div class="input-group col-lg-8 mx-auto">
				  <input type="text" id="sumName" name="sumName" class="form-control" placeholder="소환사명을 입력합니다.">
				  <span class="input-group-btn">
					<button class="btn btn-secondary" type="submit">.DUO</button>
				  </span>
				</div>
			
			
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

</body>
</html>