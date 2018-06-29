<%@ page language="java" 
		 contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>welcome</title>
</head>
<body>

<!-- 회원 로그인 할 경우 -->
<sec:authorize access="hasRole('ROLE_USER')">
	<input type="hidden" id="id" value="'${pageContext.request.userPrincipal.name}'">
	${pageContext.request.userPrincipal.name}"님 환영합니다.<br />     
		<input type="submit" id="logout" name="logout" value="로그아웃" onclick="location.href='${pageContext.request.contextPath}/login/logout'" >
	<form id="myPage" name="myPage" action="${pageContext.request.contextPath}/login/secured/welcome">
		<%-- <input type="hidden" id="id" name="id" value="'${pageContext.request.userPrincipal.name}'"> --%>
		<input type="submit" value="마이페이지">
	</form>
</sec:authorize>


<!-- 관리자 로그인 할 경우 -->
<sec:authorize access="hasRole('ROLE_ADMIN')">
	관리자님 환영합니다.<br/>       
		<input type="submit" id="logout" name="logout" value="로그아웃" onclick="location.href='${pageContext.request.contextPath}/login/logout'" >
		<br/>
	<form id="outerForm" name="outerForm" action="${pageContext.request.contextPath}/login/admin/welcome">
		<input type="submit" value="관리자페이지">
	</form>	
</sec:authorize>

${pageContext.request.userPrincipal.name} 님 환영합니다.<br>
<input type="button" 
	   value="로그아웃"
	   onclick="location.href='${pageContext.request.contextPath}/login/login?logout'" />
</body>
</html>