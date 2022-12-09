<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
session.removeAttribute("UseId");
session.removeAttribute("UseName");

session.invalidate();

response.sendRedirect("boardLoginForm.jsp");
%>