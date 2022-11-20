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
				<a href="getUserList">사용자 관리</a>

				<ul class="submenu">
					<li><a href="regUserView">사용자 등록</a></li>
					<li><a href="getUserList">사용자 조회</a></li>
					<!-- <li><a href="">사용자 수정/삭제</a></li> -->
					<li><a href="getUserListView">사용자 상세 조회</a></li>
				</ul>
			</li>
			<li>
				<a href="getTitleList">직무 관리</a>

				<ul class="submenu">
					<li><a href="regTitlemstView">직무 마스터 등록</a></li>
					<li><a href="regTitledetailView">직무 상세 등록</a></li>
					<li><a href="getTitleList">직무 조회</a></li>
					<!-- <li><a href="">직무 수정/삭제</a></li> -->
					<li><a href="getTitleListView">직무 상세 조회</a></li>
				</ul>
			</li>
			<li>
				<a href="getProgramList">프로그램 관리</a>

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
					<li><span>${sessionScope.user.user_titmst_id1}</span></li>
					<li><h1>프로그램 상세 조회</h1></li>
					<li><span>${sessionScope.user.user_name}</span></li>
				</ul>
			</c:if>
			
			<c:if test="${sessionScope.user.user_team == null}">
				<ul>
					<li>--------------</li>
					<li><h1>프로그램 상세 조회</h1></li>
					<li>--------------</li>
				</ul>
			</c:if>
		</div>
		
		<div class="section">
			<table id="gcTable" class="tablesorter">
				<thead id="table_menu">
					<tr>
						<th>PGM_ID</th>
						<th>프로그램명</th>
						<th>주요기능</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(result.programList) eq 0}">
							<tr>
								<th colspan="3">게시글이 없습니다.</th>
							</tr>
						</c:when>
						
						<c:otherwise>
							<c:forEach var="program" items="${result.programList}">
								<tr id="mouse" onClick="location.href='getProgramListView?pgm_id=${program.pgm_id}'">
									<td><c:out value="${program.pgm_id}"></c:out></td>
									<td><c:out value="${program.pgm_name}"></c:out></td>
									<td><c:out value="${program.pgm_status}"></c:out></td>
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
					<a href="getTeamListView?page=${result.page - 1}">[이전]</a>
				</c:if>
				
				<c:if test="${result.page <= result.endPage}">
					<c:forEach var="pageNum" begin="${result.startPage}" end="${result.endPage}"> 
						<c:choose>
							<c:when test="${pageNum eq result.page}">
								<span>
									<a style="font-weight: bold; color: #1d84df !important;" href="getTeamListView?page=${pageNum}">${pageNum}</a>
								</span>
							</c:when>
							<c:otherwise>
								<a href="getTeamListView?page=${pageNum}">${pageNum}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<c:if test="${result.page < result.endPage}">
						<a href="getTeamListView?page=${result.page + 1}">[다음]</a>
					</c:if>
				</c:if>
			</div>
		</div>
		
		
		
		<div class="section">
			<form action="updateTeam" method="post" name="TeamForm" id="TeamForm" target="iframe">
				<table class="table_left">
					<tr>
						<th>프로그램ID</th>
						<td class="left"><c:out value="${result2.program.pgm_id}"></c:out></td>
						<td><input type="hidden" name="pgm_id" id="pgm_id" value="${result2.program.pgm_id}" autocomplete="off"></td>
					</tr>
					<tr>
						<th>그룹코드</th>
						<td class="left"><c:out value="${result2.program.pgm_group}"></c:out></td>
						<td><input type="hidden" name="pgm_group" id="pgm_group" value="${result2.program.pgm_group}" autocomplete="off"></td>
					</tr>
					<tr>
						<th><label for="pgm_name">프로그램명</label></th>
						<td class="left"><input type="text" name="pgm_name" id="pgm_name" value="${result2.program.pgm_name}" class="box2" autocomplete="off" maxlength='20'></td>
					</tr>
					
					<tr>
						<th><span><label for="pgm_function">주요 기능</label></span></th>
						<td class="le_td">
							<span class="pg_box">
								<label for="pgm_create">입력</label>
								<!-- <input type="checkbox" id="pgm_create" name="pgm_function" value="입력" onclick='getCheckboxValue(event)'>  -->
								<input type="checkbox" id="pgm_create" name="pgm_create" onclick='getCheckboxValue(event)'>
								
								<label for="pgm_read">조회</label>
								<!-- <input type="checkbox" id="pgm_read" name="pgm_function" value="조회" onclick='getCheckboxValue(event)'> --> 
								<input type="checkbox" id="pgm_read" name="pgm_read" onclick='getCheckboxValue(event)'>
								
								<label for="pgm_update">수정</label>
								<!-- <input type="checkbox" id="pgm_update" name="pgm_function" value="수정" onclick='getCheckboxValue(event)'> --> 
								<input type="checkbox" id="pgm_update" name="pgm_update" onclick='getCheckboxValue(event)'>
								
								<label for="pgm_delete">삭제</label>
								<!-- <input type="checkbox" id="pgm_delete" name="pgm_function" value="삭제" onclick='getCheckboxValue(event)'> --> 
								<input type="checkbox" id="pgm_delete" name="pgm_delete" onclick='getCheckboxValue(event)'>
							</span>
						</td>
						
					</tr>
					
					<tr>
						<th><span><label for="pgm_status">상태</label></span></th>
						<td class="left"><input type="text" name="pgm_status" id="pgm_status" class="underLine" autocomplete="off" maxlength='4' value="${result2.program.pgm_status}" maxlength='1' readonly class="underLine"></td>
					</tr>
					
					
					<tr>
						<th>최종사용자</th>
						<td><input type="hidden" name="team_user_id" id="team_user_id" value="${sessionScope.user.user_id}">${sessionScope.user.user_id}</td>
					</tr>
				</table>
				
				<div class="btn_box">
					<div>
						<ul>
							<li><a href="getProgramList" class="btn">종료</a></li>
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

	$("select[name=team_upteam]").val('${result2.team.team_upteam}');
	
	$("input[name=pgm_create]").filter("[value='1']").prop("checked",true);
	$("input[name=pgm_read]").filter("[value='1']").prop("checked",true);
	$("input[name=pgm_update]").filter("[value='1']").prop("checked",true);
	$("input[name=pgm_delete]").filter("[value='1']").prop("checked",true);
	

   
});

</script>
</html>