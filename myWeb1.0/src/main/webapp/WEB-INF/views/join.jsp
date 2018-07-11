<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
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
    
    	<!-- 폼 점검(form validation) -->
	<script src="<c:url value='/js/memberJoinAngularValidator.js' /> "></script>
	
	<!-- AngularJS lib -->
	<!-- <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.10/angular.min.js"></script> -->
	<script src="<c:url value='/js/angular/1.6.10/angular.min.js'/> "></script>


    <title>회원가입</title>
    
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
    .navbar-brand{
		margin: 0;
	}
	.lol_logo{
		padding-right: 10px;
	}
		
    </style>

<!-- AngularJS -->
<script>
var app = angular.module('memberJoinBody', []);

	app.controller('memberJoinAngularController', 
			       ['$scope', function ($scope) {
				
	    // TODO
	    // 아이디 중복 점검
	    /* $scope.idBtnHandler = function() {
	        
	    	// 아이디 필드 점검 
	        if ($scope.memberJoin.id_fld.$valid == true) {
	         //  sendId(); // 비동기적 폼 점검 
	        }   
	    };  */
	
	}]);

// jQuery : 아이디 폼 점검과 중복 점검 메시지 충돌 방지을 위한 초기화
$(function() {
	
	$("#id_fld").focus(function(){
		$("#id_msg2").text(""); // 메시지 초기화
	}); //
});
	
</script>
   
 
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

	<div ng-app="memberJoinBody" 
	  	  ng-controller="memberJoinAngularController"> 

    <!-- Main Content -->
    <div class="container">
		<div class="row">
        	<div class="col-lg-10 col-md-12 mx-auto">    
        
		        <form id="join" name="join" action="${pageContext.request.contextPath}/joinAction" method="post">
		        <h2 class="post-title">회원가입</h2>
		        <br />
		 
		                <!-- 아이디 시작 -->
						<div class="control-group">
		             		<div class="form-group floating-label-form-group controls">
		                		<label>로그인ID</label>
		                		<input type="text" class="form-control" placeholder="ID" id = "userid" name="userid" required data-validation-required-message="Please enter your ID."
		                		ng-model="userid" ng-pattern="/^[a-zA-Z]{1}\w{6,19}$/">
		                		<p class="help-block text-danger"></p>
		              		</div>
		              	</div>

			            <!-- 아이디 중복 여부 메시지 출력 -->        
			            <div id="id_msg">
			            
			            	<!-- 아이디 필드 점검 -->	              		
		              		<div id="id_msg1" ng-model="id_msg1" ng-show="join.userid.$error.pattern">
		              			아이디는 8~20로 작성해야합니다.		              		
		              		</div>
		              		
		              		 <!-- 보완 : 아이디 중복 메시지용 -->
			            	 <div id="id_msg2"
			            	 	  ng-model="id_msg2"
			            	 	  ng-hide="memberJoin.id_fld.$error.pattern"
			            	 	  style="position:relative; top:-6px">
			            	 </div>
		           		</div>	


		                <!-- 패쓰워드 시작 -->
						<div class="control-group">
		             		<div class="form-group floating-label-form-group controls">
		                		<label>password</label>
		                		<input type="password" class="form-control" placeholder="비밀번호" id = "userpw" name="userpw" required data-validation-required-message="Please enter your password."
		                		ng-model="userpw" ng-pattern="/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{8,20}$/">
		                		<p class="help-block text-danger"></p>
		              		</div>
		           		</div>	
		                <!-- 패쓰워드 끝 -->
		                
		                <!-- 패쓰워드 점검 메시지 출력 -->        
			            <div id="pw_msg" 
			            	 ng-show="join.userpw.$error.pattern">
		     				  특수/대소문자,숫자  각 1자 이상  8~20자로 입력하십시오
						</div>
		                
		                <!-- 패쓰워드 확인 -->
						<div class="control-group">
		             		<div class="form-group floating-label-form-group controls">
		                		<label>password</label>
		                		<input type="password" class="form-control" placeholder="비밀번호 확인" id = "userpw2" name="userpw2" required data-validation-required-message="Please enter your password.">
		                		<p class="help-block text-danger"></p>
		              		</div>
		           		</div>	
		                <!-- 패쓰워드 확인 -->		                
		               
		                <!-- 이름 시작 -->
						<div class="control-group">
		             		<div class="form-group floating-label-form-group controls">
		                		<label>password</label>
		                		<input type="text" class="form-control" placeholder="이름" id = "username" name="username" required data-validation-required-message="Please enter your name."
		                		ng-model="username" ng-pattern="/^[가-힣]{2,50}$/">
		                		<p class="help-block text-danger"></p>
		              		</div>
		           		</div>
		                <!-- 이름 끝 -->
		                
		                <!-- 이름 점검 메시지 출력 -->        
			            <div id="name_msg" 
			            	 ng-show="join.username.$error.pattern">
		     				  이름은 한글로만 2~50자까지 가능합니다.
						</div>
		                
		                <!-- 게임아이디 시작 -->
						<div class="control-group">
		             		<div class="form-group floating-label-form-group controls">
		                		<label>password</label>
		                		<input type="text" class="form-control" placeholder="게임아이디" id = "lolname" name="lolname" required data-validation-required-message="Please enter your LOLnickname.">
		                		<p class="help-block text-danger"></p>
		              		</div>
		           		</div>
		                <!-- 게임아이디 끝 -->	
		                <br/>
		                <br/>

			         	<div class="row">
							<div class="col-lg-10 col-md-12 mx-auto" align="center">
								<input type="submit" class="btn btn-primary" value="회원가입" ng-disabled="join.$invalid"></input>
								&nbsp;
								&nbsp;
								<input type="reset" class="btn btn-default" value="다시쓰기"></input>		
							</div>
						</div>
		        
		        </form>
    		</div>
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
