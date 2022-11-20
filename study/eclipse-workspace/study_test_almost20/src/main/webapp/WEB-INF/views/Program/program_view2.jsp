<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로그램 상세 조회</title>

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
					<li><span>Prgm1004</span></li>
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
		<iframe name="iframe" style="display:none;"></iframe>
		<div class="section">
			<form action="updateProgram" method="post" name="updateProgramForm" id="updateProgramForm" target="iframe">
				<table>
					<tr>
						<th>프로그램ID</th>
						<td class="left"><c:out value="${result.program.pgm_id}"></c:out></td>
						<td><input type="hidden" name="pgm_id" id="pgm_id" value="${result.program.pgm_id}" autocomplete="off"></td>
					</tr>
					<tr>
						<th>그룹코드</th>
						<td class="left"><c:out value="${result.program.pgm_group}"></c:out></td>
						<td><input type="hidden" name="pgm_group" id="pgm_group" value="${result.program.pgm_group}" autocomplete="off"></td>
					</tr>
					<tr>
						<th><label for="pgm_name">프로그램명</label></th>
						<td class="left"><input type="text" name="pgm_name" id="pgm_name" value="${result.program.pgm_name}" class="box" autocomplete="off" maxlength='20'></td>
					</tr>
					
					<tr>
						<th><span><label for="pgm_function">주요 기능</label></span></th>
						<td class="le_td">
							<span class="pg_box">
								<label for="pgm_create">입력</label>
								<!-- <input type="checkbox" id="pgm_create" name="pgm_function" value="입력" onclick='getCheckboxValue(event)'>  -->
								<input type="checkbox" id="pgm_create" name="pgm_create" onclick='getCheckboxValue(event)' value="${result.program.pgm_create}">
								
								<label for="pgm_read">조회</label>
								<!-- <input type="checkbox" id="pgm_read" name="pgm_function" value="조회" onclick='getCheckboxValue(event)'> --> 
								<input type="checkbox" id="pgm_read" name="pgm_read" onclick='getCheckboxValue(event)' value="${result.program.pgm_read}">
								
								<label for="pgm_update">수정</label>
								<!-- <input type="checkbox" id="pgm_update" name="pgm_function" value="수정" onclick='getCheckboxValue(event)'> --> 
								<input type="checkbox" id="pgm_update" name="pgm_update" onclick='getCheckboxValue(event)' value="${result.program.pgm_update}">
								
								<label for="pgm_delete">삭제</label>
								<!-- <input type="checkbox" id="pgm_delete" name="pgm_function" value="삭제" onclick='getCheckboxValue(event)'> --> 
								<input type="checkbox" id="pgm_delete" name="pgm_delete" onclick='getCheckboxValue(event)' value="${result.program.pgm_delete}">
							</span>
						</td>
						
					</tr>
					
					<tr>
						<th><span><label for="pgm_status">상태</label></span></th>
						<td class="left"><input type="text" name="pgm_status" id="pgm_status" class="underLine" autocomplete="off" maxlength='1' value="${result.program.pgm_status}" maxlength='1' readonly class="underLine"></td>
					</tr>

					
					<tr>
						<th>최종사용자</th>
						<td class="left"><c:out value="${result.program.pgm_user_id}"></c:out></td>
						<td><input type="hidden" name="pgm_user_id" id="pgm_user_id" value="${sessionScope.user.user_id}"></td>
					</tr>
				</table>
				<div class="btn_box">
					<div>
						<ul>
							<li><a href="getProgramList" class="btn">종료</a></li>
							<li><a href="javascript:delProgram()" class="btn">삭제</a></li>
							<li><a href="javascript:updateProgram()" class="btn">수정</a></li>
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

	$("input[name=pgm_create]").filter("[value='1']").prop("checked",true);
	$("input[name=pgm_read]").filter("[value='1']").prop("checked",true);
	$("input[name=pgm_update]").filter("[value='1']").prop("checked",true);
	$("input[name=pgm_delete]").filter("[value='1']").prop("checked",true);
	
	console.log($("input[name=pgm_create]").val());
	console.log($("input[name=pgm_read]").val());
	console.log($("input[name=pgm_update]").val());
	console.log($("input[name=pgm_delete]").val());
	

});


$('input[type="checkbox"]').change(function(){
    this.value = (Number(this.checked));
});


function getCheckboxValue()  {
	  // 선택된 목록 가져오기
	  const query = 'input[type="checkbox"]:checked';
	  const selectedEls = 
	      document.querySelectorAll(query);
	  
	  // 선택된 목록에서 value 찾기
	  let result = '';
	  selectedEls.forEach((el) => {
	    result += el.value + ' ';
	  });
	  
	  // 출력
	  //document.getElementById('result').innerText = result;
	  
	  
	  
	  
	  //$("#pgm_status").val($("#pgm_id").val());
	  //alert(selectedEls.length);
	 
	  //$("#pgm_status").val(selectedEls.length);

	  
	  var num = selectedEls.length;
	  if(num > 0) {
		  //$("#pgm_status").val(selectedEls.length + " >> 1. 사용 가능");
		  $('#result').text(selectedEls.length + " >> 1. 사용 가능");
		  $("#pgm_status").val("1");
	  } else {
		  //$("#pgm_status").val(selectedEls.length + " >> 2. 사용 불가");
		  $('#result').text(selectedEls.length + " >> 2. 사용 불가");
		  $("#pgm_status").val("2");
	  } 

 
}



/*
document.getElementsByClassName('chkbox').onclick = function() {
    var checkboxes = document.querySelectorAll('input[name="pgm_function"]:checked');
    alert(checkboxes.length);
}
*/






function updateProgram() {
	var form = document.updateProgramForm;

	var blank_pattern = /[\s]/g;
	
	/*** 프로그램 ID 유효성 검사 ***/
	var pgm_id_v = form.pgm_id.value;

	//입력을 안할 경우
	if(pgm_id_v == '' || pgm_id_v == null) {
		$('#result').text('프로그램ID를 입력해주세요!');
		//alert("부서코드를 입력해주세요!");
		form.pgm_id.select();
		return;
	}
	
	//공백만 입력 된 경우
	if(pgm_id_v.replace(blank_pattern,'') == "") {
		$('#result').text('공백만 입력되었습니다.');
		//alert("공백만 입력되었습니다.");
		form.team_id.select();
		return;
	}
	
	console.log(pgm_id_v.length);
	if(pgm_id_v.length != 8) {
		$('#result').text('프로그램 아이디는 8자로 입력해주세요.');
		//alert("부서코드는 5자 미만으로 입력해주세요.");
		form.team_id.select();
		return;
	}
	
	/*** 프로그램명 유효성 검사 ***/
	var pgm_name_v = form.pgm_name.value;
	
	//입력을 안할 경우
	if(pgm_name_v == '' || pgm_name_v == null) {
		$('#result').text('프로그램명을 입력해주세요!');
		//alert("부서명을 입력해주세요!");
		form.pgm_name.select();
		return;
	}
	
	//공백만 입력 된 경우
	if(pgm_name_v.replace(blank_pattern,'') == "") {
		$('#result').text('공백만 입력되었습니다.');
		//alert("공백만 입력되었습니다.");
		form.pgm_name.select();
		return;
	}
	
	//한글만 가능한 정규식
	var korean_check = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
	var engNum =  /^[a-zA-Z0-9]*$/;
	if (!korean_check.test(document.getElementById('pgm_name').value)) { 
		$('#result').text('프로그램명은 한글만 입력 가능합니다.');
		form.pgm_name.select();
		return;
	}
	
	if(pgm_name_v.length > 21) {
		$('#result').text('프로그램명은 20자 미만으로 입력해주세요.');
		//alert("부서명은 20자 미만으로 입력해주세요.");
		form.pgm_name.select();
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

function delProgram() {
	var form = document.TeamForm;
	
	if(${sessionScope.user.user_id != null}){
		var chk = confirm("정말 삭제하시겠습니까?");
		if(chk) {
			location.href="delProgram?pgm_id=${result.program.pgm_id}";
		}	
	} else {
		alert("로그인 해주세요!");
		location.href="login";
	}
		
}
</script>
</html>