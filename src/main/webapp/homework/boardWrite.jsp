<%@page import="java.sql.Date"%>
<%@page import="utils.JSFunction"%>
<%@page import="homework.hwDAO"%>
<%@page import="homework.hwDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if(session.getAttribute("UserId")==null){
	JSFunction.alertLocation("로그인 후 이용가능합니다.",
							"boardLoginForm.jsp",out);
	return;
}

if(request.getParameter("mode") != null&& request.getParameter("mode").equals("1")){
	
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	
	hwDTO dto = new hwDTO();
	dto.setTitle(title);
	dto.setContent(content);
	dto.setId(session.getAttribute("UserId").toString());
	
	hwDAO dao = new hwDAO(application);
	int iResult = dao.insertWrite(dto);
	dao.close();
	
	if(iResult ==1){
		JSFunction.alertLocation("글쓰기 저장 성공", "boardList.jsp", out);
	}else{
		JSFunction.alertBack("글쓰기저장에 실패하였습니다.", out);
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
	<script type="text/javascript">
		function validateForm(form) {
		    if (form.title.value == "") {
		        alert("제목을 입력하세요.");
		        form.title.focus();
		        return false;
		    }
		    if (form.content.value == "") {
		        alert("내용을 입력하세요.");
		        form.content.focus();
		        return false;
		    }
		}
	</script>
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
        <div class="col-9 pt-3">
            <h3>게시물 작성 - <small>자유게시판</small></h3>

            <form action="" method="post" onsubmit="return validateForm(this);">
            	<input type="hidden" name="mode" value="1">
                <table class="table table-bordered">
                <colgroup>
                    <col width="20%"/>
                    <col width="*"/>
                </colgroup>
                <tbody>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">작성자</th>
                        <td>
                            <input type="text" class="form-control" 
                                style="width:100px;" readOnly
                                value = "<%=session.getAttribute("UserId").toString()%>" />
                        </td>
                    </tr>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">제목</th>
                        <td>
                            <input type="text" class="form-control" name="title"/>
                        </td>
                    </tr>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">내용</th>
                        <td>
                            <textarea rows="5" class="form-control" name="content"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">첨부파일</th>
                        <td>
                            <input type="file" class="form-control" />
                        </td>
                    </tr>
                </tbody>
                </table>
                
                <div class="row">
                    <div class="col text-right mb-4">
                        <!-- 각종 버튼 부분 -->
                        <button type="button" class="btn btn-warning"
                        	onclick="location.href='boardList.jsp'">리스트보기</button>
                        <button type="submit" class="btn btn-danger">작성완료</button>
                        <button type="reset" class="btn btn-dark">Reset</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <%@ include file="./inc/bottom.jsp" %>
</div>
</body>
</html>