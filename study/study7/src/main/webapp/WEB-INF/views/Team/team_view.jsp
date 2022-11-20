<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서 상세 조회</title>

<link href="${pageContext.request.contextPath}/resources/css/reset.css?after" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="menu">
		<ul>
			<c:if test="${sessionScope.user.user_id == null}">
				<li><a href="login"> ▶ 로그인 </a></li>
				<li><a href="signUpPage"> ▶ 회원가입 </a></li>
			</c:if>
			<c:if test="${sessionScope.user.user_id != null}">
				<li><a href="logout"> ▶ 로그아웃 </a></li>
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
					<li><h1>부서 조회</h1></li>
					<li>--------------</li>
				</ul>
			</c:if>
		</div>
		
		<div class="section">
			<form action="updateTeam" method="post" name="TeamForm" id="TeamForm">
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
						<th><label for="team_upteam">상위부서</label></th>
						<td class="left"><input type="text" name="team_upteam" id="team_upteam" value="${result.team.team_upteam}" class="box" autocomplete="off" maxlength='8'></td>
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
						<td class="left"><c:out value="${sessionScope.user.user_id}"></c:out></td>
						<td><input type="hidden" name="team_user_id" id="team_user_id" value="${sessionScope.user.user_id}"></td>
					</tr>
				</table>
				<div class="btn_box">
					<div>
						<ul>
							<li><a href="javascript:delTeam()" class="btn">삭제</a></li>
							<li><a href="getTeamList" class="btn">조회</a></li>
							<li><a href="javascript:updateTeam()" class="btn">수정</a></li>
							<!-- <li><input type="submit" value="수정" class="btn"></li> -->
						</ul>
					</div>
				</div>
			</form>
		</div>
		<div class="msg">
			<p>MSG :<span id="result"></span></p>
		</div>
	</div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">

function updateTeam() {
	var form = document.TeamForm;

	var blank_pattern = /[\s]/g;
	

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
	
	//공백만 입력 된 경우
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

	var chk = confirm("수정 하시겠습니까?");
	
	if(chk) {
		form.submit();
	}		
}

function delTeam() {
	var form = document.TeamForm;
	
	var chk = confirm("정말 삭제하시겠습니까?");
	if(chk) {
		location.href="delTeam?team_id=${result.team.team_id}";
	}		
}
</script>
</html>