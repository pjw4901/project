<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html">
<html lang="ko-kr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<input type="text" id="sumId" name="sumId" value="${result.id}"/>
	<input type="text" id="sumAccountid" name="sumAccountid" value="${result.accountId}"/>
	<input type="text" id="sumName" name="sumName" value="${result.name}"/>
	<input type="text" id="sumProfile" name="sumProfile" value="${result.profileIconId}"/>
	<input type="text" id="sumRedate" name="sumRedate" value="${result.revisionDate}"/>
	<input type="text" id="sumlev" name="sumSumlev" value="${result.summonerLevel}"/>

</body>
</html>