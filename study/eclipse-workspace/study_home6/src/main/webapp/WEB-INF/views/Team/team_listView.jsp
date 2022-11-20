<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서 조회</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/blue_style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/green_style.css" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/reset2.css?after" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="menu">
		<ul>
			<li class="left"><a href="#">부서 관리</a></li>
			<li class="left"><a href="#">사용자 관리</a></li>
			<li class="left"><a href="getTeamList">직무 관리</a></li>
			<li class="left"><a href="#">프로그램 관리</a></li>
			
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
					<li><h1>부서 상세 조회</h1></li>
					<li><span>${sessionScope.user.user_name}</span></li>
				</ul>
			</c:if>
			
			<c:if test="${sessionScope.user.user_team == null}">
				<ul>
					<li>--------------</li>
					<li><h1>부서 상세 조회</h1></li>
					<li>--------------</li>
				</ul>
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
			
			<div class="paging">
				<c:if test="${result.page <= 0}">
					<c:set target="${result.page}" property="page" value="1"></c:set>
				</c:if>
				
				<c:if test="${result.page >= result.startPage}">
					<a href="getTeamList?page=${result.page - 1}">[이전]</a>
				</c:if>
				
				<c:if test="${result.page <= result.endPage}">
					<c:forEach var="pageNum" begin="${result.startPage}" end="${result.endPage}"> 
						<c:choose>
							<c:when test="${pageNum eq result.page}">
								<span>
									<a style="font-weight: bold; color: #1d84df !important;" href="getTeamList?page=${pageNum}">${pageNum}</a>
								</span>
							</c:when>
							<c:otherwise>
								<a href="getTeamList?page=${pageNum}">${pageNum}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<c:if test="${result.page < result.endPage}">
						<a href="getTeamList?page=${result.page + 1}">[다음]</a>
					</c:if>
				</c:if>
			</div>
		</div>
		
		
		
		<div class="section">
			<form action="updateTeam" method="post" name="TeamForm" id="TeamForm" target="iframe">
				<table>
					<tr>
						<th>부서코드</th>
						<td class="left"><c:out value="${result.team.team_id}"></c:out></td>
						<td><input type="hidden" name="team_id" id="team_id" value="${result.team.team_id}" autocomplete="off"></td>
					</tr>
					<tr>
						<th><label for="team_name">부서명</label></th>
						<td class="left"><input type="text" name="team_name" id="team_name" value="${result.team.team_name}" class="box" autocomplete="off" maxlength='20'></td>
					</tr>
					
					<tr>
						<th><span><label for="team_upteam">상위부서 리스트</label></span></th>
						<td class="left">
							<select name="team_upteam" class="teamList">
							     <c:forEach var="result" items="${result.teamList}">
							     	<option value="${result.team_id}" id="team_upteam">${result.team_id} + ${result.team_name}</option>
							    </c:forEach>
							 </select>
						</td>
					</tr>
					<tr>
						<th>등록일시</th>
						<td class="left"><fmt:formatDate value="${result.team.team_reg_date}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					</tr>
					<tr>
						<th>수정일시</th>
						<td class="left"><fmt:formatDate value="${result.team.team_update_date}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					</tr>
					<tr>
						<th>최종사용자</th>
						<td class="left"><c:out value="${result.team.team_user_id}"></c:out></td>
						<td><input type="hidden" name="team_user_id" id="team_user_id" value="${sessionScope.user.user_id}"></td>
					</tr>
				</table>
				
				<div class="btn_box">
					<div>
						<ul>
							<li><a href="getTeamList" class="btn">종료</a></li>
						</ul>
					</div>
				</div>
			</form>
		</div>	
		<div class="msg_listView">
		<div class="msg_list">
			<c:if test="${sessionScope.user.user_id != null}">
				<p class="msg_list_p">MSG :<span id="result"> 환영합니다. ${sessionScope.user.user_name}님</span></p>
			</c:if>
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