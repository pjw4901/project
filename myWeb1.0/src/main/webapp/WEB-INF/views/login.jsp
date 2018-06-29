<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true" pageEncoding="UTF-8"%>
<html>
<head>
<title>Login Page</title>
<style>
.error {
			padding: 15px;
			margin-bottom: 20px;
			border: 1px solid transparent;
			border-radius: 4px;
			color: #a94442;
			background-color: #f2dede;
			border-color: #ebccd1;
		}

.msg {
		padding: 15px;
		margin-bottom: 20px;
		border: 1px solid transparent;
		border-radius: 4px;
		color: #31708f;
		background-color: #d9edf7;
		border-color: #bce8f1;
	}

#login-box {
				width: 300px;
				padding: 20px;
				margin: 0px auto;
				background: #fff;
				-webkit-border-radius: 10px;
				-moz-border-radius: 10px;
				border-radius: 10px;
				border: 1px solid #000;
			}
</style>

<script src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script>
/* 
function hasUsername() {
	
	// username 유무 점검 
    // : spring security username 점검 시간이 너무 긴 버그 패치 !
	$.ajax({
		url : 'http://localhost:8181/secureApp1/login/idCheck',
	    type: 'get',
	    dataType: 'text',
    	data : {
    		username : $('#username').val(),
    	},
    	success : function(data) {
    		//
    		alert(data);
    		//return data.trim();
    		 alert("전송성공");
    	}
	}) // 
	
	return data;
}*/

/*
 * spring security 에서의 아이디 점검 문제에서 지연이 많이 걸리기 때문에
    의도적으로 아이디 존재 여부 점검 부분을 추가하였습니다 : javateacher
 */
/* $(document).ready(function() {
	
	 // 필드 공백 제거
	 $("#userid").val().replace(/\s/g, "");
	 $("#userpw").val().replace(/\s/g, "");
	 $("#userid").focus();
	 
	 $('#login').click(function() {
		 
			// 공백 여부 점검
			if ($.trim($("#userid").val()) == "" || 
				$.trim($("#userpw").val()) == "")   {
				
				alert("공백이 입력되었습니다. 다시 입력하십시오.");
				$("#userid").val("");
				$("#userpw").val("");
				
			} else {
				
				alert("else 부분 넘어옴");
				
				$.ajax({
		    		url : '${pageContext.request.contextPath}/login/idCheck',
		    	    type: 'get',
		    	    dataType: 'text',
		        	data : {
		        		userid : $('#userid').val()
		        	},
		        	success : function(data) {
		        		
		        		if (data.trim() == 'true') {
			           		 alert("아이디가 존재합니다.");
			       			 document.loginForm.submit();
			           	} else 
			       			 alert("아이디가 존재하지 않습니다."); 
		        			 $("#userid").focus();
			        	}
		    	}); // $.ajax
				
			} // if
		 
    }) // login
    
}) //  */

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

	<div id="login-box">

		<h3>Login</h3>

		<c:if test="${not empty error}">
			<div class="error">${error}</div>
		</c:if>
		<c:if test="${not empty msg}">
			<div class="msg">${msg}</div>
		</c:if>

 		<!-- url은 예약 url로써 xml 설정에 따름. 별도의 사용자 정의하려면 변경 가능. -->
		<%-- <form id="loginForm"
			  name="loginForm"
			  action="<c:url value='/auth/login_check?targetUrl=${targetUrl}' />"
			  method="POST"> --%>
			  
			 <form id="loginForm" 
			  name="loginForm" 
			  action="<c:url value='${pageContext.request.contextPath}/j_spring_security_check' />"
			  method="POST">

			<table>
				<tr>
					<td>ID :</td>
					<!-- <td><input type="text" 
					  		   id="userid"
							   name="userid"
							   size="25"
							   maxlength="20"></td> -->
					<td><input type="text" 
							   id = "j_username"	
							   name="j_username" />
				</tr>
				<tr>
					<td>PW :</td>
					<!-- <td><input type="password" 
							   id="userpw"
							   name="userpw" 
							   size="25"
							   maxlength="20"/></td> -->
					<td><input type="password" 
							   id="j_password"
							   name="j_password" />
				</tr>

				<tr>
					<td colspan="2">
						<input id="login" 
							   name="login" 
							   type="button"
							   value="login"/>&nbsp;
					    <input id="joinbtn"
					    	   name="joinbtn" 	
					    	   type="button"
							   value="join"
							   onclick="location.href='${pageContext.request.contextPath}/join'" />
					</td>
				</tr>

			</table>

 			<!-- Spring Security CSRF Token : 필히 기입할 것 ! -->
			<%-- <input type="hidden" 
				   name="${_csrf.parameterName}"
				   value="${_csrf.token}" /> --%>

		</form>

	</div>

</body>
</html>