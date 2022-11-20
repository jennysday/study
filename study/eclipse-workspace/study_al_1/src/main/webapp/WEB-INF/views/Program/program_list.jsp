<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로그램 조회</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/blue_style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/green_style.css" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/reset.css?after" rel="stylesheet" type="text/css">
</head>
<body>
<%-- 	
<c:forEach var="i" items="${sessionScope.titleList}">

<c:choose>
	<c:when test="${i eq 'Prgm1002'}">
		 <c:out value="${i}"></c:out> 
		 <c:set var="ok" value="true"></c:set>
	</c:when>
	
	<c:otherwise>
    </c:otherwise>
   </c:choose>
</c:forEach>
 --%>
<c:set var="ok2" value="false"></c:set> 
<c:forEach var="i" items="${sessionScope.titleFunctionList}">
	
	<c:if test = "${fn:contains(i, 'Prgm1002')}">
		<c:out value="${i}" /> 
		<c:set var="ok2" value="true"></c:set>
		
		<c:set var="titfunction2" value="${i}" />
		
		<input type="text" id="function2" value="${fn:substring(titfunction2,8,14)}" readonly="readonly">
		
	</c:if>

</c:forEach> 
<c:out value="${ok2}" /> 



<c:set var="ok" value="false"></c:set> 
<c:forEach var="i" items="${sessionScope.titleFunctionList}">
	
	<c:if test = "${fn:contains(i, 'Prgm1001')}">
		<c:out value="${i}" /> 
		<c:set var="ok" value="true"></c:set>
		
		<c:set var="titfunction" value="${i}" />
		
		<input type="text" id="function" value="${fn:substring(titfunction,8,14)}" readonly="readonly">
		
	</c:if>

</c:forEach> 
<c:out value="${ok}" /> 
	
	
	<div class="menu_bar">
		<ul class="menu">
			<li>
				<a href="getTeamList">부서 관리</a>

				<ul class="submenu">
					<li><a href="regTeamView">부서 등록</a></li>
					<li><a href="getTeamList">부서 조회</a></li>
					<li><a href="getTeamListView">부서 수정 및 삭제</a></li>
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
				<a href="getTitleList">직무 관리</a>

				<ul class="submenu">
					<li><a href="regTitlemstView">직무 등록</a></li>
					<li><a href="regTitledetailView">직무별 프로그램 등록</a></li>
					<li><a href="getTitleList">직무별 프로그램 조회</a></li>
					<li><a href="getTitleMstListView">직무 수정 및 삭제</a></li>
					<li><a href="getTitleListView">직무별 프로그램 수정 및 삭제</a></li>
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
					<li><span>Prgm1002</span></li>
					<li><h1>프로그램 조회</h1></li>
					<li><span>${sessionScope.user.user_name}</span></li>
				</ul>
			</c:if>
			
			<c:if test="${sessionScope.user.user_team == null}">
				<ul>
					<li>--------------</li>
					<li><h1>프로그램 조회</h1></li>
					<li>--------------</li>
				</ul>
			</c:if>
		</div>
		
		<div class="section prgm_section">
			<table id="gcTable" class="tablesorter">
				<thead id="table_menu">
					<tr>
						<th>프로그램ID</th>
						<th>프로그램명</th>
						<th>그룹</th>
						<th>기능(CRUD)</th>
						<th>상태</th>
						<th>최종수정일자</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(result.programList) eq 0}">
							<tr>
								<th colspan="6">게시글이 없습니다.</th>
							</tr>
						</c:when>
						
						<c:otherwise>
							<c:forEach var="program" items="${result.programList}">
								<tr id="mouse" onClick="location.href='getProgram?pgm_id=${program.pgm_id}'">
									<td><c:out value="${program.pgm_id}"></c:out></td>
									<td><c:out value="${program.pgm_name}"></c:out></td>
									<td><c:out value="${program.pgm_group}"></c:out></td>
									<td><c:out value="${program.pgm_create}${program.pgm_read}${program.pgm_update}${program.pgm_delete}"></c:out></td>
									<td><c:out value="${program.pgm_status}"></c:out></td>
									<td><fmt:formatDate value="${program.pgm_update_date}" type="both" pattern="yyyy-MM-dd"/></td>
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
						<a href="getProgramList?page=${result.page - 1}">[이전]</a>
					</c:if>
					
					<c:if test="${result.page <= result.endPage}">
						<c:forEach var="pageNum" begin="${result.startPage}" end="${result.endPage}"> 
							<c:choose>
								<c:when test="${pageNum eq result.page}">
									<span>
										<a style="font-weight: bold; color: #1d84df !important;" href="getProgramList?page=${pageNum}">${pageNum}</a>
									</span>
								</c:when>
								<c:otherwise>
									<a href="getProgramList?page=${pageNum}">${pageNum}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<c:if test="${result.page < result.endPage}">
							<a href="getProgramList?page=${result.page + 1}">[다음]</a>
						</c:if>
					</c:if>
				</div>
			</div>
			
			<div class="btn_box_list">
				<div>
					<ul>
						<li>※ 상세조회 : 해당 라인 클릭</li>
						<li><a href="regProgramView" class="btn" id="crbtn">프로그램 등록</a></li>
					</ul>
				</div>
			</div>
			
			<div class="msg_list">
			<c:if test="${sessionScope.user.user_id != null}">
				<p class="msg_list_p">MSG :<span id="result"></span></p>
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
   
	
	var ok2 = ${ok2};
	if (ok2 == false) {
		alert('사용 권한이 없습니다.');location.href='getTeamList';
		$("#crbtn").attr('class','disabled');
	} else {
		var titdet_function2 = $("#function2").val();
		titdet_function2 = titdet_function2.toString();
		console.log("titdet_function2>>"+titdet_function2);
		
		var c = titdet_function2.substring(0,1);
		var r = titdet_function2.substring(1,2);
		var u = titdet_function2.substring(2,3);
		var d = titdet_function2.substring(3,4);
		
		console.log(c);
		console.log(r);
		console.log(u);
		console.log(d);
		
		
		if(r == 0) {
			alert('사용 권한이 없습니다.');location.href='getTeamList';
			$("#crbtn").attr('class','disabled');
		} else {
			$("#crbtn").attr('class','btn');
		}
	}
	
	var ok = ${ok};
	if (ok == false) {
		$("#crbtn").attr('class','disabled');
	} else {
		var titdet_function = $("#function").val();
		titdet_function = titdet_function.toString();
		console.log("titdet_function>>"+titdet_function);
		
		var c = titdet_function.substring(0,1);
		var r = titdet_function.substring(1,2);
		var u = titdet_function.substring(2,3);
		var d = titdet_function.substring(3,4);
		
		console.log(c);
		console.log(r);
		console.log(u);
		console.log(d);
		
		
		if(c == 0) {
			$("#crbtn").attr('class','disabled');
		} else {
			$("#crbtn").attr('class','btn');
		}
	}
});
</script>
</html>