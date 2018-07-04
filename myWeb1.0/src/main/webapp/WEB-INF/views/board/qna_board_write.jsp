<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<meta charset="UTF-8">
<title>MVC 게시판</title>

<style type="text/css">
#registForm {
	width: 500px;
	height: 610px;
	border: 1px solid red;
	margin: auto;
}

h2 {
	text-align: center;
}

table {
	margin: auto;
	width: 450px;
}

.td_left {
	width: 150px;
	background: orange;
}

.td_right {
	width: 300px;
	background: skyblue;
}

#commandCell {
	text-align: center;
}

/* 추가 : spring form 점검 메시지 */
.formErr 
{
	color : red;
	font-size : 9pt;	
}
</style>
</head>
<body>
	
	<!-- 게시판 등록 -->
	<section id="writeForm">
		
		<h2>게시판 글등록</h2>
		
		<form:form modelAttribute="board" 
			   	   action="${pageContext.request.contextPath}/board/writeAction.do" 
			       method="post"	
			       enctype="multipart/form-data"		  	   
			  	   name="boardform">
			  
			<table>
				<tr>
					<td class="td_left"><label for="boardName">글쓴이</label></td>
					<td class="td_right"><input type="text" name="boardName"
						id="boardName" required="required" />
						<form:errors path="boardName" cssClass="formErr"  />
					</td>
				</tr>
				<tr>
					<td class="td_left"><label for="boardPass">비밀번호</label></td>
					<td class="td_right"><input name="boardPass" type="password"
						id="boardPass" required="required" />
						<br><form:errors path="boardPass" cssClass="formErr" /></td>
				</tr>
				<tr>
					<td class="td_left"><label for="boardSubject">제 목</label></td>
					<td class="td_right"><input name="boardSubject" type="text"
						id="boardSubject" required="required" />
						<form:errors path="boardSubject" /></td>
				</tr>
				<tr>
					<td class="td_left"><label for="boardContent">내 용</label></td>
					<td><textarea id="boardContent" name="boardContent"
							cols="40" rows="15" required="required"></textarea>
						<form:errors path="boardContent" /></td>
				</tr>
				<tr>
					<td class="td_left"><label for="boardFile"> 파일 첨부 </label></td>
					<td class="td_right"><input name="boardFile" type="file"
						id="boardFile" /></td>
				</tr>
			</table>
			<section id="commandCell">
				<input type="submit" value="등록">&nbsp;&nbsp; 
				<input type="reset" value="다시쓰기" />
			</section>
			
			<!-- Spring Security Auth(CSRF) Token : 반드시 기입! 없으면 에러 출력됨 !-->
			<%-- <input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
					
			csrf = ${_csrf.parameterName} --%>
			
		</form:form>
		
	</section>
	<!-- 게시판 등록 //-->
</body>
</html>