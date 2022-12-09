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

String num =request.getParameter("num");

hwDTO dto = new hwDTO();
hwDAO dao = new hwDAO(application);
dto = dao.selectView(num);

String sessionId = session.getAttribute("UserId").toString();

int delResult = 0;

if(sessionId.equals(dto.getId())){
	dto.setNum(num);
	delResult = dao.boardDelete(dto);
	dao.close();
	
	if(delResult == 1){
		JSFunction.alertLocation("삭제되었습니다.", "boardList.jsp", out);
	}
	else{
		JSFunction.alertBack("삭제에 실패하였습니다.", out);
	}
}
else{
	JSFunction.alertBack("본인만 삭제할 수 있습니다.", out);
	return;
}
%>