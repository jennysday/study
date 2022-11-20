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
	<div class="menu_bar">
		<ul class="menu">
			<li>
				<a href="getTeamList">부서 관리</a>

				<ul class="submenu">
					<li><a href="regTeamView">부서 등록</a></li>
					<li><a href="getTeamList">부서 조회</a></li>
					<li><a href="getTeam">부서 수정/삭제</a></li>
					<li><a href="getTeamListView">부서 상세 조회</a></li>
				</ul>
			</li>
			<li>
				<a href="">사용자 관리</a>

				<ul class="submenu">
					<li><a href="">사용자 등록</a></li>
					<li><a href="">사용자 조회</a></li>
					<li><a href="">사용자 수정/삭제</a></li>
					<li><a href="">사용자 상세 조회</a></li>
				</ul>
			</li>
			<li>
				<a href="">직무 관리</a>

				<ul class="submenu">
					<li><a href="">직무 등록</a></li>
					<li><a href="">직무 조회</a></li>
					<li><a href="">직무 수정/삭제</a></li>
					<li><a href="">직무 상세 조회</a></li>
				</ul>
			</li>
			<li>
				<a href="">프로그램 관리</a>

				<ul class="submenu">
					<li><a href="">프로그램 등록</a></li>
					<li><a href="">프로그램 조회</a></li>
					<li><a href="">프로그램 수정/삭제</a></li>
					<li><a href="">프로그램 상세 조회</a></li>
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
					<li><h1>부서 수정/삭제</h1></li>
					<li><span>${sessionScope.user.user_name}</span></li>
				</ul>
			</c:if>
			
			<c:if test="${sessionScope.user.user_team == null}">
				<ul>
					<li>--------------</li>
					<li><h1>부서 수정/삭제</h1></li>
					<li>--------------</li>
				</ul>
			</c:if>
		</div>
		<iframe name="iframe" style="display:none;"></iframe>
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
							<li><a href="javascript:delTeam()" class="btn">삭제</a></li>
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

$(document).ready(function(){
	$("select[name=team_upteam]").val('${result.team.team_upteam}');
});

$("select[name=team_upteam]").change(function(){
  console.log($(this).val()); //value값 가져오기
  console.log($("select[name=location] option:selected").text()); //text값 가져오기
});


/* 키보드를 누르면 중복키를 누르게끔 설정 */
/*
function upteam_chk() {
	//document.getElementById("btnCheck").style.backgroundColor = "pink";
	$("input[name=upteam_id]").val('n');  
	console.log($("input[name=upteam_id]").val());
}

function checkUpteam(){
    var team_upteam = $("input[name=team_upteam]").val(); //name값이 "team_upteam"인 입력란의 값을 저장
    console.log("team_upteam>>"+team_upteam);
    
    $.ajax({
        url:'upteamCheck', //Controller에서 요청 받을 주소
        type:'post', //POST 방식으로 전달
        data:{team_upteam:team_upteam},
        success:function(cnt){ //컨트롤러에서 넘어온 cnt값을 받는다 
            if(cnt == 0){ //cnt가 1이 아니면(=0일 경우) -> 사용 불가 
            	 console.log("team_upteam2>>"+team_upteam);
            	 $("input[name=upteam_id]").val('n');  
                 $('#result').text('상위부서명이 존재하지 않습니다.');
            } else { // cnt가 1일 경우 -> 이미 존재하는 부서코드
            	$("input[name=upteam_id]").val('y');  
                $('#result').text('상위부서명이 존재합니다.');
            }
        },
        error:function(){
            alert("에러입니다");
        }
    });
};
*/

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
	
	if(${sessionScope.user.user_id != null}){
		var chk = confirm("수정 하시겠습니까?");
		if(chk) {
			form.submit();
			
			document.getElementById("result").innerHTML="수정이 완료되었습니다.";
		}
	} else {
		alert("로그인 해주세요!");
		location.href="login";
	}
			
}

function delTeam() {
	var form = document.TeamForm;
	
	if(${sessionScope.user.user_id != null}){
		var chk = confirm("정말 삭제하시겠습니까?");
		if(chk) {
			location.href="delTeam?team_id=${result.team.team_id}";
		}	
	} else {
		alert("로그인 해주세요!");
		location.href="login";
	}
		
}
</script>
</html>