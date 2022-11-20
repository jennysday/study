<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<html>
<head>
<meta charset="UTF-8">
<title>직무 상세 등록</title>

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
					<li><a href="regTitlemstView">직무 마스터 등록</a></li>
					<li><a href="regTitledetailView">직무 상세 등록</a></li>
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
					<li><h1>직무 상세 등록</h1></li>
					<li><span>${sessionScope.user.user_name}</span></li>
				</ul>
			</c:if>
			
			<c:if test="${sessionScope.user.user_team == null}">
				<ul>
					<li>--------------</li>
					<li><h1>직무 상세 등록</h1></li>
					<li>--------------</li>
				</ul>
			</c:if>
		</div>
		<iframe name="iframe" style="display:none;"></iframe>
		<div class="section">
			<form action="regTitledetail" method="post" name="regTitledetailForm" id="regTitledetailForm" target="iframe">
				<table>
				
				
					<tr>
						<th><span><label for="titdet_titmst_id">직무코드</label></span></th>
						<td class="left">
							<select name="titdet_titmst_id" class="teamList">
							     <c:forEach var="result" items="${result.titleMstList}">
							     	<option value="${result.titmst_id}" id="team_upteam">${result.titmst_id}  ${result.titmst_name}</option>
							    </c:forEach>
							 </select>
						</td>
					</tr>
					
					<tr>
						<th><span><label for="team_upteam">프로그램ID</label></span></th>
						<td class="left">
							<select name="titdet_pgm_id" class="teamList">
							     <c:forEach var="result" items="${result2.teamList}">
							     	<option value="${result.team_id}" id="team_upteam">${result.team_id}  ${result.team_name}</option>
							    </c:forEach>
							 </select>
						</td>
					</tr>

					<tr>
						<th><span><label for="titdet_function">주요 기능</label></span></th>
						<td class="pg_box">
							<label for="pgm_create">입력</label>
							<!-- <input type="checkbox" id="pgm_create" name="pgm_function" value="입력" onclick='getCheckboxValue(event)'>  -->
							<input type="checkbox" id="pgm_create" onclick='getCheckboxValue(event)'>
							
							<label for="pgm_read">조회</label>
							<!-- <input type="checkbox" id="pgm_read" name="pgm_function" value="조회" onclick='getCheckboxValue(event)'> --> 
							<input type="checkbox" id="pgm_read" onclick='getCheckboxValue(event)'>
							
							<label for="pgm_update">수정</label>
							<!-- <input type="checkbox" id="pgm_update" name="pgm_function" value="수정" onclick='getCheckboxValue(event)'> --> 
							<input type="checkbox" id="pgm_update" onclick='getCheckboxValue(event)'>
							
							<label for="pgm_delete">삭제</label>
							<!-- <input type="checkbox" id="pgm_delete" name="pgm_function" value="삭제" onclick='getCheckboxValue(event)'> --> 
							<input type="checkbox" id="pgm_delete" onclick='getCheckboxValue(event)'>
						</td>
						<td><input type="hidden" name="titdet_function" id="titdet_function" name="titdet_function"> </td>
						
						<td><input type="hidden" name="titdet_user_id"class="box" value="${sessionScope.user.user_id}"></td>
					</tr>

				</table>
				<div class="btn_box_reg">
					<div>
						<ul>
							<li><a href="getTitleList" class="btn">종료</a></li>
							<li><a href="javascript:regTitledetail()" class="btn">등록</a></li>
						</ul>
					</div>
				</div>
			</form>
		</div>
		<div class="msg">
			<p>MSG : <span id="result"></span></p> 
		</div>
	</div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">



//체크박스 주요기능에 value로 넣어주기
function getCheckboxValue()  {
	  
	var chk_arr = $('input[type="checkbox"]');

	var chk_data = [];
	for( var i=0; i<chk_arr.length; i++ ) {
	    if( chk_arr[i].checked == true ) {
	        chk_arr.val(1);
	    }
	    else {
	    	chk_arr.val(0);
	    }
	chk_data.push(chk_arr[i].value);
	}
	
	var string_data = chk_data.join("");
	
	//document.getElementById('result').innerText = "선택된 기능 : "+ chk_data;
	document.getElementById('result').innerText = "선택된 기능 : "+ string_data;
	$//("#titdet_function").val(chk_data);
	$("#titdet_function").val(string_data);
 
}



function regTitledetail() {
	
	
	var form = document.regTitledetailForm;
	

	
	if(${sessionScope.user.user_id != null}){
		var chk = confirm("등록 하시겠습니까?");
		
		if(chk) {
			form.submit();

			if(result.cnt == 0){
				document.getElementById("titdet_titmst_id").value = null; 
				document.getElementById("titdet_pgm_id").value = null; 
				document.getElementById("titdet_function").value = null; ;
							
				$("input[type='checkbox']").prop("checked",false);
				
				document.getElementById("result").innerHTML="등록이 완료되었습니다.";
			}
			else {
				alert("직무코드와 프로그램 아이디를 다시 선택해주세요.");
			}
			
		}
	} 	else {
			alert("로그인 해주세요!");
			location.href="login";
	}
		
}
</script>
</html>