<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직무 상세 조회</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/blue_style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/green_style.css" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/reset.css?after" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="menu_bar">
		<ul class="menu">
			<li>
				<a href="getTeamList">부서 관리</a>

				<ul class="submenu">
					<li><a href="regTeamView">부서 등록</a></li>
					<li><a href="getTeamList">부서 조회</a></li>
					<li><a href="getTeamListView">부서 상세 조회</a></li>
				</ul>
			</li>
			<li>
				<a href="getUserList">사용자 관리</a>

				<ul class="submenu">
					<li><a href="regUserView">사용자 등록</a></li>
					<li><a href="getUserList">사용자 조회</a></li>
					<li><a href="getUserListView">사용자 수정 및 삭제</a></li>
				</ul>
			</li>
			<li>
				<a href="getTitleList">직무 마스터 관리</a>

				<ul class="submenu">
					<li><a href="regTitlemstView">직무 마스터 등록</a></li>
					<li><a href="getTitleList">직무 마스터 조회</a></li>
					<li><a href="getTitle_detail_List">직무 마스터 수정 및 삭제</a></li>
				</ul>
			</li>
			<li>
				<a href="getTitle_detail_List">직무 상세 관리</a>

				<ul class="submenu">
					<li><a href="regTitledetailView">직무 상세 등록</a></li>
					<li><a href="getTitle_detail_List">직무 상세 조회</a></li>
					<li><a href="getTitle_detail_List">직무 상세 수정 및 삭제</a></li>
				</ul>
			</li>
			<li>
				<a href="getProgramList">프로그램 관리</a>

				<ul class="submenu">
					<li><a href="regProgramView">프로그램 등록</a></li>
					<li><a href="getProgramList">프로그램 조회</a></li>
					<!-- <li><a href="">프로그램 수정/삭제</a></li> -->
					<li><a href="getProgramListView">프로그램 수정 및 삭제</a></li>
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
					<li><h1>직무 마스터 조회</h1></li>
					<li><span>${sessionScope.user.user_name}</span></li>
				</ul>
			</c:if>
			
			<c:if test="${sessionScope.user.user_team == null}">
				<ul>
					<li>--------------</li>
					<li><h1>직무 마스터 조회</h1></li>
					<li>--------------</li>
				</ul>
			</c:if>
		</div>
		
		<div class="section title_mst">
			<table id="gcTable" class="tablesorter">
				<thead id="table_menu">
					<tr>
						<th>직무코드</th>
						<th>프로그램ID</th>
						<th>기능</th>
						<th>등록일시</th>
						<th>최종수정일시</th>
						<th>최종사용자</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(result.titleList) eq 0}">
							<tr>
								<th colspan="3">게시글이 없습니다.</th>
							</tr>
						</c:when>
						
						<c:otherwise>
							<c:forEach var="title" items="${result.titleList}">
								<tr id="mouse" onClick="location.href='getTitle?titdet_titmst_id=${title.titdet_titmst_id}&titdet_pgm_id=${title.titdet_pgm_id}'">
									<td><c:out value="${title.titdet_titmst_id}"></c:out></td>
									<td><c:out value="${title.titdet_pgm_id}"></c:out></td>
									<td><c:out value="${title.titdet_function}"></c:out></td>
									<td><fmt:formatDate value="${title.titdet_reg_date}" type="both" pattern="yyyy-MM-dd"/></td>
									<td><fmt:formatDate value="${title.titdet_update_date}" type="both" pattern="yyyy-MM-dd"/></td>
									<td><c:out value="${title.titdet_user_id}"></c:out></td>
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
			
			<div class="btn_box_list">
				<div>
					<ul>
						<li>※ 상세조회 : 해당 라인 클릭</li>
						<li><a href="regTeamView" class="btn">부서 등록</a></li>
					</ul>
				</div>
			</div>
			
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