<%@ page language="java" 
		 contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>logout</title>
</head>
<body>
로그아웃<br>
${pageContext.request.userPrincipal.name}<br>

<c:if test="${error eq 'true'}">
	${msg}
</c:if>

<script>
	alert("로그인 페이지로 이동합니다.");
	location.href="login";
</script>
	
</body>
</html>