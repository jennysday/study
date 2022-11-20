<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서 조회</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/blue_style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/green_style.css" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/reset.css?after" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="menu">
		<ul>
			<li class="left"><a href="#">사용자 조회 </a></li>
			<li class="left"><a href="getTeamList">부서 조회 </a></li>
			<li class="left"><a href="#">프로그램 조회</a></li>
			
			<c:if test="${sessionScope.userId == null}">
				<li class="right"><a href="login"> ▶ 로그인 </a></li>
				<li class="right"><a href="signUpPage"> ▶ 회원가입 </a></li>
			</c:if>
			<c:if test="${sessionScope.userId != null}">
				<li class="right"><a href="logout"> ▶ 로그아웃 </a></li>
			</c:if>
		</ul>
	</div>
	<div class="wrap">
		<div class="header">
			<c:if test="${sessionScope.user.user_team != null}">
				<ul>
					<li><span>${sessionScope.user.user_team}</span></li>
					<li><h1>부서 조회</h1></li>
					<li><span>${sessionScope.user.user_name}</span></li>
				</ul>
			</c:if>
			
			<c:if test="${sessionScope.user.user_team == null}">
				<ul>
					<li>--------------</li>
					<li><h1>부서 조회</h1></li>
					<li>--------------</li>
				</ul>
			</c:if>
		</div>
		
		<div class="msg">
		<c:if test="${sessionScope.user.user_id != null}">
			<p>MSG :<span id="result"> 환영합니다. ${sessionScope.user.user_name}님</span></p>
		</c:if>
		</div>
		
		<div class="section">
			<table id="gcTable" class="tablesorter">
				<thead id="table_menu">
					<tr>
						<th>부서코드</th>
						<th>부서명</th>
						<th>상위부서</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(result.teamList) eq 0}">
							<tr>
								<th colspan="3">게시글이 없습니다.</th>
							</tr>
						</c:when>
						
						<c:otherwise>
							<c:forEach var="team" items="${result.teamList}">
								<tr id="mouse" onClick="location.href='getTeam?team_id=${team.team_id}'">
									<td><c:out value="${team.team_id}"></c:out></td>
									<td><c:out value="${team.team_name}"></c:out></td>
									<td><c:out value="${team.team_upteam}"></c:out></td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<div class="btn_box">
				<div>
					<ul>
						<li><a href="regTeamView" class="btn">부서 등록하기</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.tablesorter.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#gcTable").tablesorter();
   
});
</script>
</html>