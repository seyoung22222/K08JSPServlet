<%@page import="utils.JSFunction"%>
<%@page import="homework.hwDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="homework.hwDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
hwDAO dao = new hwDAO(application);

Map<String, Object> param = new HashMap<String, Object>();
String keyField = request.getParameter("keyField");
String keyString = request.getParameter("keyString");
if(keyString != null){
	param.put("keyField",keyField);
	param.put("keyString",keyString);
}

int totalCount = dao.selectCount(param);
List<hwDTO> boardLists = dao.selectList(param);
dao.close();
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
		function loginalr() {
			<%
			if(session.getAttribute("UserId")==null){
			%>
				alert("로그인 후 이용해주십시오.");
				//location.href="./boardLoginForm.jsp";
				response.sendRedirect("boardLoginForm.jsp");
			<%
			//JSFunction.alertLocation("로그인 후 이용해주십시오.","./boardLoginForm.jsp",out);
			}
			%>
			
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
            <h3>게시물 목록 - <small>자유게시판</small></h3>

            <div class="row ">
                <!-- 검색부분 -->
                <%
                if(session.getAttribute("UserId") != null &&
                		session.getAttribute("UserId").toString().equals("musthave")){
                %>
                <input type="button" value="관리자페이지">
                <%
                }
                %>
                <form>
                    <div class="input-group ms-auto" style="width: 400px;">
                        <select name="keyField" class="form-control">
                            <option value="title">제목</option>
                            <option value="id">작성자</option>
                            <option value="content">내용</option>
                        </select>
                        <input type="text" name="keyString" class="form-control" style="width: 150px;"/>
                        <div class="input-group-btn">
                            <button type="submit" class="btn btn-secondary">
                                <i class="bi bi-search" style='font-size:20px'></i>
                            </button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="row mt-3 mx-1">
                <!-- 게시판리스트부분 -->
                <table class="table table-bordered table-hover table-striped">
                    <colgroup>
                        <col width="60px" />
                        <col width="*" />
                        <col width="120px" />
                        <col width="120px" />
                        <col width="80px" />
                        <col width="60px" />
                    </colgroup>
                    <thead>
                        <tr style="background-color: rgb(133, 133, 133); " class="text-center text-white">
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                            <th>조회수</th>
                            <th>첨부</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                    if(boardLists.isEmpty()){
                    %>
                    	<tr>
                    		<td colspan="6" align="center">
                    			등록된 게시물이 없습니다.
                    		</td>
                    	</tr>
                    
                    <%
                    }
                    else{
                    	int virtualNum = 0;
                    	for(hwDTO dto : boardLists){
                    		virtualNum = totalCount--;
                    %>
                    	<tr>
                            <td class="text-center"><%=virtualNum%></td>
                            <td class="text-left" >
                            	<a href="boardView.jsp?num=<%= dto.getNum()%>" onclick="loginalr();"><%=dto.getTitle() %></a></td>
                            <td class="text-center"><%=dto.getId() %></td>
                            <td class="text-center"><%=dto.getPostdate() %></td>
                            <td class="text-center"><%=dto.getVisitcount() %></td>
                            <td class="text-center"><i class="bi bi-pin-angle-fill" style="font-size:20px"></i></td>
                        </tr>
                    <%
                    	}
                    }
                    %>
                    </tbody>
                </table>
            </div>
            <div class="row">
                <div class="col d-flex justify-content-end">
                    <!-- 각종 버튼 부분 -->
                    <button type="button" class="btn btn-primary" onclick="location.href='boardWrite.jsp';">글쓰기</button>
                </div>
            </div>
            <%@ include file="./inc/page.jsp" %>  
        </div>
    </div>
    <%@ include file="./inc/bottom.jsp" %>
</div>
</body>
</html>