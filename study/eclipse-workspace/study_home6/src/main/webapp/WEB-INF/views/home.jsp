<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
<a href="getTeamList"> ▶ 부서 조회 </a>
<a href="login"> ▶ 로그인 </a>
<a href="signUpPage"> ▶ 회원가입 </a>
<a href="getTeamListView"> ▶ 부서 상세 조회 </a>

</body>
</html>
