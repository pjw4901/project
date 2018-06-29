<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>mainpage</title>
</head>
<body>
${msg}

	<input id="loginbtn"
    	   name="loginbtn" 	
    	   type="button"
		   value="login"
		   onclick="location.href='${pageContext.request.contextPath}/login/login'" />
	<input id="boardlist_btn"
    	   name="boardlist_btn" 	
    	   type="button"
		   value="게시판"
		   onclick="location.href='${pageContext.request.contextPath}/board/list.do/1'" />
		   
	

</body>
</html>