<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서 수정 및 삭제</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/blue_style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/green_style.css" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/reset2.css?after" rel="stylesheet" type="text/css">
</head>
<body>
	
<c:set var="ok" value="false"></c:set>
<%-- 
<c:forEach var="i" items="${sessionScope.titleList}">
	
	<c:choose>
		<c:when test="${i eq 'Team1003'}">
			 <c:out value="${i}"></c:out> 
			 <c:set var="ok" value="true"></c:set>
		</c:when>
		
		<c:otherwise>
	    </c:otherwise>
    </c:choose>
</c:forEach>
--%>

<c:forEach var="i" items="${sessionScope.titleFunctionList}">
	
	<c:if test = "${fn:contains(i, 'Team1003')}">
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
					<li><span>Team1003</span></li>
					<li><h1>부서 수정 및 삭제</h1></li>
					<li><span>${sessionScope.user.user_name}</span></li>
				</ul>
			</c:if>
			
			<c:if test="${sessionScope.user.user_team == null}">
				<ul>
					<li>--------------</li>
					<li><h1>부서 수정 및 삭제</h1></li>
					<li>--------------</li>
				</ul>
			</c:if>
		</div>
		
		<div class="search">
			<div class="search_txt">
				<form action="getTeamListView" method="get" name="searchTeamForm" id="searchTeamForm">
						<span>부서명 : &nbsp;</span> 
						<select name="team_id" class="teamList">
						     <c:forEach var="result" items="${result4.teamList}">
						     	<option value="${result.team_id}" id="team_id">${result.team_id} &nbsp; ${result.team_name}</option>
						    </c:forEach>
						 </select>
					<a class="btn" href="javascript:searchTeam()">조회</a>
				</form>
			</div>
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
						<c:when test="${fn:length(result.searchList) eq 0}">
							<tr>
								<th colspan="3">게시글이 없습니다.</th>
							</tr>
						</c:when>
						
						<c:otherwise>
							<c:forEach var="team" items="${result.searchList}">
								<tr id="mouse" onClick="location.href='getTeamListView?team_id=${team.team_id}&page=${result.page}'">
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
		
		
		<iframe name="iframe" style="display:none;"></iframe>
		<div class="section">
			<form action="updateTeam" method="post" name="TeamForm" id="TeamForm" target="iframe">
				<table>
					<tr>
						<th>부서코드</th>
						<td class="left"><c:out value="${result2.team.team_id}"></c:out></td>
						<td><input type="hidden" name="team_id" id="team_id" value="${result2.team.team_id}" autocomplete="off"></td>
					</tr>
					<tr>
						<th><label for="team_name">부서명</label></th>
						<td class="left"><input type="text" name="team_name" id="team_name" value="${result2.team.team_name}" class="box" autocomplete="off" maxlength='20'></td>
					</tr>
					
					<tr>
						<th><span><label for="team_upteam">상위부서 리스트</label></span></th>
						<td class="left">
							<select name="team_upteam" class="teamList2">
							     <c:forEach var="result" items="${result3.teamList}">
							     	<option value="${result.team_id}" id="team_upteam">${result.team_id} &nbsp; ${result.team_name}</option>
							    </c:forEach>
							 </select>
						</td>
					</tr>
					<tr>
						<th>등록일시</th>
						<td class="left"><fmt:formatDate value="${result2.team.team_reg_date}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					</tr>
					<tr>
						<th>수정일시</th>
						<td class="left"><fmt:formatDate value="${result2.team.team_update_date}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					</tr>
					<tr>
						<th>최종사용자</th>
						<td class="left"><c:out value="${result2.team.team_user_id}"></c:out></td>
						<td><input type="hidden" name="team_user_id" id="team_user_id" value="${sessionScope.user.user_id}"></td>
					</tr>
				</table>
				
				<div class="btn_box">
					<div>
						<ul>
						
							<li><a href="getTeamList" class="btn">종료</a></li>
							<li><a href="javascript:delTeam()" class="btn" id="delbtn">삭제</a></li>
							<li><a href="javascript:updateTeam()" class="btn" id="upbtn">수정</a></li>
							<!-- <li><input type="submit" value="수정" class="btn"></li> -->
						</ul>
					</div>
				</div>
			</form>
		</div>	
		<div class="msg_listView">
		<div class="msg_list">
			<c:if test="${sessionScope.user.user_id != null}">
				<p class="msg_list_p">MSG :<span id="result"> ${team_id} 검색 결과입니다.</span></p>
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
	$("select[name=team_id]").val('${team_id}');
	
	var ok = ${ok};
	if (ok == false) {
		alert('사용 권한이 없습니다.');location.href='getTeamList';
		$("#upbtn").attr('class','disabled');
		$("#delbtn").attr('class','disabled');
	}
	else {

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
   		
   		
   		if(u == 0 && d == 0) {
   			alert('사용 권한이 없습니다.');location.href='getTeamList';
   			$("#upbtn").attr('class','disabled');
   			$("#delbtn").attr('class','disabled');
   		}
   		
   		if(u == 0) {
   			$("#upbtn").attr('class','disabled');
   		} else {
   			$("#upbtn").attr('class','btn');
   		}
   		
   		if(d == 0) {
   			$("#delbtn").attr('class','disabled');
   		} else {
   			$("#delbtn").attr('class','btn');
   		}
               	

		 

	}

   
});

function updateTeam() {
	var form = document.TeamForm;

	var blank_pattern = /[\s]/g;
	
	/*
	 if($("input[name='upteam_id']").val()=='n'){
       alert('상위부서코드가 존재하지 않습니다.');
       $("input[name='upteam_id']").eq(0).focus();
       return false;
   	}
	*/
	
	/*** 부서명 유효성 검사 ***/
	var team_name_v = form.team_name.value;
	
	//입력을 안할 경우
	if(team_name_v == '' || team_name_v == null) {
		$('#result').text('부서명을 입력해주세요!');
		//alert("부서명을 입력해주세요!");
		form.team_name.select();
		return;
	}
	
	//공백만 입력 된 경우
	if(team_name_v.replace(blank_pattern,'') == "") {
		$('#result').text('공백만 입력되었습니다.');
		//alert("공백만 입력되었습니다.");
		form.team_name.select();
		return;
	}
	
	if(team_name_v.length > 21) {
		$('#result').text('부서명은 20자 미만으로 입력해주세요.');
		//alert("부서명은 20자 미만으로 입력해주세요.");
		form.team_name.select();
		return;
	}
	
	/*** 상위부서 유효성 검사 ***/
	var team_upteam_v = form.team_upteam.value;
	
	//입력을 안할 경우
	if(team_upteam_v == '' || team_upteam_v == null) {
		$('#result').text('상위부서를 입력해주세요!');
		//alert("상위부서를 입력해주세요!");
		form.team_upteam.select();
		return;
	}
	
/* 	
  
  ///공백만 입력 된 경우
	if(team_upteam_v.replace(blank_pattern,'') == "") {
		$('#result').text('공백만 입력되었습니다.');
		//alert("공백만 입력되었습니다.");
		form.team_upteam.select();
		return;
	}
	
	if(team_upteam_v.length > 9) {
		$('#result').text('상위부서는 9자 미만으로 입력해주세요.');
		//alert("상위부서는 9자 미만으로 입력해주세요.");
		form.team_upteam.select();
		return;
	} 
*/
	
	if(${sessionScope.user.user_id != null}){
		var chk = confirm("수정 하시겠습니까?");
		if(chk) {

			var queryString = $("form[name=TeamForm]").serialize() ;
			
			var team_id = $("input[name=team_id]").val();
			console.log(queryString);
			
			$.ajax({
					
	            type: 'POST',
	            url: 'updateTeam',
	            data: queryString,
	            dataType: 'text',
	            success: function(result) {
	            	console.log("성공")
	            	

	            	//수정 성공
	            	sessionStorage.setItem("수정유무","yes");
	            	location.reload();

	            	
	            }

			});	
			
		}
	} else {
		alert("로그인 해주세요!");
		location.href="login";
	}
			
}


document.addEventListener("DOMContentLoaded", function() {
	const isReloadByDelete = sessionStorage.getItem("삭제유무");
	if(isReloadByDelete) {
		document.getElementById("result").innerHTML="삭제가 완료되었습니다.";
		sessionStorage.removeItem("삭제유무");
	}
});


document.addEventListener("DOMContentLoaded", function() {
	const isReloadByUpdate = sessionStorage.getItem("수정유무");
	if(isReloadByUpdate) {
		document.getElementById("result").innerHTML="수정이 완료되었습니다.";
		sessionStorage.removeItem("수정유무");
	}
});





function delTeam() {
	var form = document.TeamForm;
	
	if(${sessionScope.user.user_id != null}){
		var chk = confirm("정말 삭제하시겠습니까?");
		if(chk) {
			//location.href="delTeam2?team_id=${result2.team.team_id}";

			var team_id = $("input[name=team_id]").val();
			console.log(team_id);
			
			$.ajax({
					
	            type: 'POST',
	            url: 'delTeam2',
	            data: 'team_id=' + team_id,
	            dataType: 'text',
	            success: function(result) {
	            	console.log("성공")
	            	

	            	//삭제 성공
	            	sessionStorage.setItem("삭제유무","yes");
	            	location.reload();

	            	
	            }
	   					
	        });

		}	
	} else {
		alert("로그인 해주세요!");
		location.href="login";
	}
	
	
		
}

function searchTeam() {
	var form = document.searchTeamForm;
	form.submit();
}
</script>
</html>