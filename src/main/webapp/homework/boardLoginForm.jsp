<%@page import="utils.JSFunction"%>
<%@page import="homework.hwDTO"%>
<%@page import="homework.hwDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if(request.getParameter("mode")!=null && request.getParameter("mode").equals("1")){
	
	String userId = request.getParameter("user_id");
	String userPwd = request.getParameter("user_pw");
	
	hwDAO dao = new hwDAO(application);
	hwDTO dto = dao.getMemberDTO(userId, userPwd);
	dao.close();
	
	
	if(dto.getId() != null) {
		//로그인에 성공한 경우라면...
		//세션영역에 회원아이디와 이름을 저장한다.
		session.setAttribute("UserId", dto.getId());
		session.setAttribute("UserName", dto.getName());
		//그리고 로그인 페이지로 '이동'한다.
		response.sendRedirect("boardList.jsp");
	}
	else{
		//로그인에 실패한 경우라면..
		//리퀘스트 영역에 에러메세지를 저장한다.
		request.setAttribute("LoginErrMsg", "로그인 오류입니다.");
		//그리고 로그인 페이지로 '포워드'한다.
		request.getRequestDispatcher("boardLoginForm.jsp");
	}
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">    
</head>
<body>
<div class="container">
    <div class="row">
    	<!-- 상단 네비게이션 인클루드 -->
        <%@ include file="./inc/top.jsp" %>
    </div>
    <div class="row">
    	<!-- 좌측 네비게이션 인클루드 -->
        <%@ include file="./inc/left.jsp" %>
        <div class="col-9 pt-3" style="text-align:center;">
		    <h2 >TJOEUN LOGIN</h2>
        	<div class="d-flex justify-content-center">
		        <!-- 로그인 폼 만들기 -->
		        <span style="color:red; font-size:1.2em;">
					<%=request.getAttribute("LoginErrMsg")==null?
							"" : request.getAttribute("LoginErrMsg")%>
				</span>
		        <form action=" " method="post" name="loginFrm"
					onsubmit="return validateForm(this);">
					<input type="hidden" name="mode" value="1">
					 아이디 : <input type="text" name="user_id" class="form-control" style="width:300px"> <br>
					 패스워드 : <input type="password" name="user_pw" class="form-control" style="width:300px"><br>
					 <button type="submit" class="form-control btn-primary" style="width:300px">로그인</button>
				</form>
        	</div>
        </div>
    </div>
    <%@ include file="./inc/bottom.jsp" %>
</div>
</body>
</html>