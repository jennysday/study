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
	<div class="menu_bar">
		<ul class="menu">
			<li>
				<a href="getTeamList">부서 관리</a>

				<ul class="submenu">
					<li><a href="regTeamView">부서 등록</a></li>
					<li><a href="getTeamList">부서 조회</a></li>
					<!-- <li><a href="getTeam">부서 수정/삭제</a></li> -->
					<li><a href="getTeamListView">부서 상세 조회</a></li>
				</ul>
			</li>
			<li>
				<a href="">사용자 관리</a>

				<ul class="submenu">
					<li><a href="regUserView">사용자 등록</a></li>
					<li><a href="getUserList">사용자 조회</a></li>
					<!-- <li><a href="">사용자 수정/삭제</a></li> -->
					<li><a href="getUserListView">사용자 상세 조회</a></li>
				</ul>
			</li>
			<li>
				<a href="">직무 관리</a>

				<ul class="submenu">
					<li><a href="">직무 등록</a></li>
					<li><a href="">직무 조회</a></li>
					<!-- <li><a href="">직무 수정/삭제</a></li> -->
					<li><a href="">직무 상세 조회</a></li>
				</ul>
			</li>
			<li>
				<a href="">프로그램 관리</a>

				<ul class="submenu">
					<li><a href="regProgramView">프로그램 등록</a></li>
					<li><a href="getProgramList">프로그램 조회</a></li>
					<!-- <li><a href="">프로그램 수정/삭제</a></li> -->
					<li><a href="getProgramListView">프로그램 상세 조회</a></li>
				</ul>
			</li>
		</ul>

		
		
		<ul class="right">	
			<c:if test="${sessionScope.userId == null}">
				<li><a href="login"> ▶ 로그인 </a></li>
				<li><a href="signUpPage"> ▶ 회원가입 </a></li>
			</c:if>
			<c:if test="${sessionScope.userId != null}">
				<li><a href="logout"> ▶ 로그아웃 </a></li>
			</c:if>
		</ul>
	</div>
	<div class="wrap">
		<div class="header">
			<c:if test="${sessionScope.user.user_team != null}">
				<ul>
					<li><span>${sessionScope.user.user_team}</span></li>
					<li><h1>사용자 상세 조회</h1></li>
					<li><span>${sessionScope.user.user_name}</span></li>
				</ul>
			</c:if>
			
			<c:if test="${sessionScope.user.user_team == null}">
				<ul>
					<li>--------------</li>
					<li><h1>사용자 상세 조회</h1></li>
					<li>--------------</li>
				</ul>
			</c:if>
		</div>
		
		<div class="section">
			<table id="gcTable" class="tablesorter">
				<thead id="table_menu">
					<tr>
						<th>사용자 아이디</th>
						<th>부서코드</th>
						<th>자료접근권한</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(result.userList) eq 0}">
							<tr>
								<th colspan="3">게시글이 없습니다.</th>
							</tr>
						</c:when>
						
						<c:otherwise>
							<c:forEach var="user" items="${result.userList}">
								<tr id="mouse" onClick="location.href='getUserListView?user_id=${user.user_id}'">
									<td><c:out value="${user.user_id}"></c:out></td>
									<td><c:out value="${user.user_team}"></c:out></td>
									<td><c:out value="${user.user_dataaccess}"></c:out></td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			
			<div class="paging">
				<div>
					<c:if test="${result.page <= 0}">
						<c:set target="${result.page}" property="page" value="1"></c:set>
					</c:if>
					
					<c:if test="${result.page >= result.startPage}">
						<a href="getUserList?page=${result.page - 1}">[이전]</a>
					</c:if>
					
					<c:if test="${result.page <= result.endPage}">
						<c:forEach var="pageNum" begin="${result.startPage}" end="${result.endPage}"> 
							<c:choose>
								<c:when test="${pageNum eq result.page}">
									<span>
										<a style="font-weight: bold; color: #1d84df !important;" href="getUserList?page=${pageNum}">${pageNum}</a>
									</span>
								</c:when>
								<c:otherwise>
									<a href="getUserList?page=${pageNum}">${pageNum}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<c:if test="${result.page < result.endPage}">
							<a href="getUserList?page=${result.page + 1}">[다음]</a>
						</c:if>
					</c:if>
				</div>
			</div>
		</div>
		
		
		
		<div class="section">
			<form action="updateTeam" method="post" name="TeamForm" id="TeamForm" target="iframe">
				<table>
					<tr>
						<th>사용자 아이디</th>
						<td class="left"><c:out value="${result2.user.user_id}"></c:out></td>
						<td><input type="hidden" name="user_id" id="user_id" value="${result2.user.user_id}" autocomplete="off"></td>
					</tr>
					<tr>
						<th><label for="user_name">사용자명</label></th>
						<td class="left"><input type="text" name="user_name" id="user_name" value="${result2.user.user_name}" class="box" autocomplete="off" maxlength='20'></td>
					</tr>

					<tr>
						<th><span><label for="user_team">부서코드</label></span></th>
						<td class="left">
							<select name="user_team" class="teamList2">
							     <c:forEach var="result" items="${result3.teamList}">
							     	<option value="${result.team_id}" id="user_team">${result.team_id} + ${result.team_name}</option>
							    </c:forEach>
							 </select>
						</td>
					</tr>
					
					<tr>
						<th><span><label for="user_titmst_id1">직무코드1</label></span></th>
						<td class="left">
							<input type="text" name="user_titmst_id1" id="user_titmst_id1" value="${result2.user.user_titmst_id1}" class="box" autocomplete="off" maxlength='8' onkeydown="upteam_chk()" oninput = "checkTitmst()">
							<input type="hidden" name="user_titmst_id1" value="n">
						</td>
					</tr>
					<tr>
						<th><span><label for="user_titmst_id2">직무코드2</label></span></th>
						<td class="left">
							<input type="text" name="user_titmst_id2" id="user_titmst_id2" value="${result2.user.user_titmst_id2}" class="box" autocomplete="off" maxlength='8' onkeydown="upteam_chk()" oninput = "checkTitmst()">
							<input type="hidden" name="user_titmst_id2" value="n">
						</td>
					</tr>
					<tr>
						<th><span><label for="user_titmst_id3">직무코드3</label></span></th>
						<td class="left">
							<input type="text" name="user_titmst_id3" id="user_titmst_id3" value="${result2.user.user_titmst_id3}" class="box" autocomplete="off" maxlength='8' onkeydown="upteam_chk()" oninput = "checkTitmst()">
							<input type="hidden" name="user_titmst_id3" value="n">
						</td>
					</tr>

					
					<tr>
						<th><span><label for="user_dataaccess">자료접근권한</label></span></th>
						<td class="left"><input type="text" name="user_dataaccess" id="user_dataaccess" value="${result2.user.user_dataaccess}" class="box" autocomplete="off" maxlength='20'></td>
					</tr>
					
					<%-- 
					<tr>
						<th><label for="team_upteam">상위부서</label></th>
						<td class="left">
							<input type="text" name="team_upteam" id="team_upteam" value="${result.team.team_upteam}" class="box" autocomplete="off" maxlength='8' oninput = "checkUpteam()" onkeydown="upteam_chk()">
							<input type="hidden" name="upteam_id" value="y">
						</td>
					</tr>
					 --%>
					<tr>
						<th>등록일시</th>
						<td class="left"><fmt:formatDate value="${result2.user.user_reg_date}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					</tr>
					<tr>
						<th>수정일시</th>
						<td class="left"><fmt:formatDate value="${result2.user.user_update_date}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					</tr>
					<tr>
						<th>최종사용자</th>
						<td class="left"><c:out value="${result2.user.user_user_id}"></c:out></td>
						<td><input type="hidden" name="team_user_id" id="team_user_id" value="${sessionScope.user.user_id}"></td>
					</tr>
				</table>
				<div class="btn_box">
					<div>
						<ul>
							<li><a href="getUserList" class="btn">종료</a></li>
							<li><a href="javascript:delUser()" class="btn">삭제</a></li>
							<li><a href="javascript:updateUser()" class="btn">수정</a></li>
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

	$("select[name=user_team]").val('${result2.user.user_team}');

   
});
</script>
</html>