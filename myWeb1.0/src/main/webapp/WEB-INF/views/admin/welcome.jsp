<%@ page language="java" 
		 contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>welcome</title>
</head>
<body>
관리자 전용 페이지 입니다. <br/>
${pageContext.request.userPrincipal.name} 님 환영합니다.<br>
<input type="button" 
	   value="로그아웃"
	   onclick="location.href='${pageContext.request.contextPath}/login/login?logout'" />
</body>
</html>