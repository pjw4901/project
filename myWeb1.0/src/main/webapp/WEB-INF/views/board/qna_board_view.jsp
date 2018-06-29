<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<meta charset="UTF-8">
<title>MVC 게시판</title>
<style>
#articleForm {
	width: 500px;
	height: 500px;
	border: 1px solid red;
	margin: auto;
}

h2 {
	text-align: center;
}

#basicInfoArea {
	height: 40px;
	text-align: center;
}

#articleContentArea {
	background: orange;
	margin-top: 20px;
	height: 350px;
	text-align: center;
	overflow: auto;
}

#commandList {
	margin: auto;
	width: 500px;
	text-align: center;
}
</style>
</head>

<body>
	<!-- 게시글 보기-->
	<section id="articleForm">
		<h2>글 내용 상세보기</h2>
		<section id="basicInfoArea">
			제 목 :
			${article.boardSubject}
			첨부파일 :
			<c:if test="${not empty article.boardFile}">
				<a href="file:///E:/lsh/fileupload/${article.boardFile}"> 
					${article.boardFile}
				</a>
			</c:if>
		</section>
		<section id="articleContentArea">
			${article.boardContent}
		</section>
	</section>
	<section id="commandList">
		<a
			href="boardReplyForm.bo?board_num=${article.boardNum}&page=${nowPage}">
			[답변] </a> <a
			href="boardModifyForm.bo?board_num=${article.boardNum}">
			[수정] </a> <a
			href="boardDeleteForm.bo?board_num=${article.boardNum}&page=${nowPage}">
			[삭제] </a> <a href="${pageContext.request.contextPath}/board/list.do/${nowPage}">[목록]</a>&nbsp;&nbsp;
	</section>
</body>
</html>