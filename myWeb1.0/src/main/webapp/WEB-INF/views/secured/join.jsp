<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
    <title>회원가입 화면</title>
    
    <style>
        #wrap{
            width:530px;
            margin-left:auto; 
            margin-right:auto;
            text-align:center;
        }
        
        table{
            border:3px solid skyblue
        }
        
        td{
            border:1px solid skyblue
        }
        
        #title{
            background-color:skyblue
        }
    </style>
</head>
<body>
    <!-- 왼쪽, 오른쪽 바깥여백을 auto로 주면 중앙정렬된다.  -->
    <div id="wrap">
        <br><br>
        <b><font size="6" color="gray">회원가입</font></b>
        <br><br><br>
        
        <form id="join" action="${pageContext.request.contextPath}/joinAction" method="post">
        
            <table>
                <tr>
                    <td id="title">아이디</td>
                    <td>
                        <input type="text" id="userid" name="userid" maxlength="20">   
                    </td>
                </tr>
                        
                <tr>
                    <td id="title">비밀번호</td>
                    <td>
                        <input type="password" id="userpw" name="userpw" maxlength="15">
                    </td>
                </tr>
                    
                <tr>
                    <td id="title">이름</td>
                    <td>
                        <input type="text" id="username" name="username" maxlength="40">
                    </td>
                </tr>

            </table>
            
            <br>
            
            <input type="submit" value="가입"/>  <input type="reset" value="다시쓰기">

        </form>
    </div>
</body>
</html>
