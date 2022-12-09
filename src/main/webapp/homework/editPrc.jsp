<%@page import="homework.hwDAO"%>
<%@page import="homework.hwDTO"%>
<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if(session.getAttribute("UserId")==null){
	JSFunction.alertLocation("로그인 후 이용가능합니다.",
							"boardLoginForm.jsp",out);
	return;
}
//수정폼에서 입력한 내용을 파라미터로 받는다.
String num = request.getParameter("num");
String title = request.getParameter("title");
String content = request.getParameter("content");

//DTO객체에 수정할 내용을 세팅한다.
hwDTO dto = new hwDTO();
dto.setNum(num);
dto.setTitle(title);
dto.setContent(content);

//DAO객체 생성을 통해 오라클에 연결한다.
hwDAO dao = new hwDAO(application);
//update쿼리문을 실행하여 게시물을 수정한다.
int affected = dao.updateEdit(dto);
//자원해제
dao.close();

if(affected ==1){
	/* 
	수정이 완료되었으면 수정된 내용을 확인하기 위해 주로 내용보기
	페이지로 이동한다.
	*/
	response.sendRedirect("boardView.jsp?num=" +dto.getNum());
}
else{
	//수정에 실패하면 뒤로 이동한다.
	JSFunction.alertBack("수정하기에 실패하였습니다", out);
}
%>