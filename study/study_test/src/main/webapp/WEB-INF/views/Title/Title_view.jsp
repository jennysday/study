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
					<li><h1>직무 수정/삭제</h1></li>
					<li><span>${sessionScope.user.user_name}</span></li>
				</ul>
			</c:if>
			
			<c:if test="${sessionScope.user.user_team == null}">
				<ul>
					<li>--------------</li>
					<li><h1>직무 수정/삭제</h1></li>
					<li>--------------</li>
				</ul>
			</c:if>
		</div>
		<iframe name="iframe" style="display:none;"></iframe>
		<div class="section">
			<form action="updateTitle" method="post" name="TitleForm" id="TitleForm" target="iframe">
				<table>
					
					<tr>
						<th><span><label for="titdet_titmst_id">직무코드</label></span></th>
						<td class="left">
							<c:out value="${result.title.titdet_titmst_id}"></c:out>
						</td>
					</tr>
					
					<tr>
						<th><span><label for="team_upteam">프로그램ID</label></span></th>
						<td class="left">
							<c:out value="${result.title.titdet_pgm_id}"></c:out>
						</td>
					</tr>

					<tr>
						<th><span><label for="titdet_function">주요 기능</label></span></th>
						<td class="pg_box">
						
							<!-- 아이디 중복 체크 여부 -->
				            <input type="hidden" name="checked_id" value="n">
				            
							<label for="pgm_create">입력</label>
							<!-- <input type="checkbox" id="pgm_create" name="pgm_function" value="입력" onclick='getCheckboxValue(event)'>  -->
							<input type="checkbox" id="pgm_create" name="pgm_create"  onclick='getCheckboxValue(event)'>
							
							<label for="pgm_read">조회</label>
							<!-- <input type="checkbox" id="pgm_read" name="pgm_function" value="조회" onclick='getCheckboxValue(event)'> --> 
							<input type="checkbox" id="pgm_read" name="pgm_read" onclick='getCheckboxValue(event)'>
							
							<label for="pgm_update">수정</label>
							<!-- <input type="checkbox" id="pgm_update" name="pgm_function" value="수정" onclick='getCheckboxValue(event)'> --> 
							<input type="checkbox" id="pgm_update" name="pgm_update" onclick='getCheckboxValue(event)'>
							
							<label for="pgm_delete">삭제</label>
							<!-- <input type="checkbox" id="pgm_delete" name="pgm_function" value="삭제" onclick='getCheckboxValue(event)'> --> 
							<input type="checkbox" id="pgm_delete" name="pgm_delete" onclick='getCheckboxValue(event)'>
						</td>
					</tr>
					
					<tr>
						<th><span><label for="titdet_function">기능</label></span></th>
						<td class="left"><input type="text" name="titdet_function" id="titdet_function" class="underLine" autocomplete="off" maxlength='1' value="${result.title.titdet_function}" maxlength='1' readonly class="underLine"></td>
					</tr>
					
					<tr>
						<th>최종사용자</th>
						<td class="left"><c:out value="${result.title.titdet_user_id}"></c:out></td>
						<td><input type="hidden" name="titdet_user_id" id="titdet_user_id" value="${sessionScope.user.user_id}"></td>
						
						<td><input type="hidden" name="titdet_titmst_id" id="titdet_titmst_id" value="${result.title.titdet_titmst_id}"></td>
						<td><input type="hidden" name="titdet_pgm_id" id="titdet_pgm_id" value="${result.title.titdet_pgm_id}"></td>
					</tr>
				</table>
				<div class="btn_box">
					<div>
						<ul>
							<li><a href="getTitleList" class="btn">종료</a></li>
							<li><a href="javascript:delTitle()" class="btn">삭제</a></li>
							<li><a href="javascript:updateTitle()" class="btn">수정</a></li>
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
	
	var str = ${result.title.titdet_function};

	console.log("str>>"+str);
	console.log(typeof str);
	
	str = str.toString();
	console.log(typeof str);
	console.log("str>>"+str);
	
	var result1 = str.substring(0,1);
	var result2 = str.substring(1,2);
	var result3 = str.substring(2,3);
	var result4 = str.substring(3,4);
	
	console.log("result1>>"+result1);
	console.log("result2>>"+result2);
	console.log("result3>>"+result3);
	console.log("result4>>"+result4);
	

	$("#pgm_create").val(result1);
	$("#pgm_read").val(result2);
	$("#pgm_update").val(result3);
	$("#pgm_delete").val(result4);


	$('input[type="checkbox"]').each(function() {
		
		if($(this).val() == 1) {
			$(this).prop("checked",true);
			$(this).prop("disabled",false);
		} else {
			$(this).prop("checked",false);
			$(this).prop("disabled",true);
		}

	});
	

});



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
	//$("#titdet_function").val(chk_data);
	$('input[name="titdet_function"]').val(string_data);

}



$('input[type="checkbox"]').change(function(){
    this.value = (Number(this.checked));
});








function updateTitle() {
	var form = document.TitleForm;


	if(${sessionScope.user.user_id != null}){
		var chk = confirm("수정 하시겠습니까?");
		if(chk) {
			form.submit();
			
			var str = ${result.title.titdet_function};

			console.log("str>>"+str);
			console.log(typeof str);
			
			str = str.toString();
			console.log(typeof str);
			console.log("str>>"+str);
			
			var result1 = str.substring(0,1);
			var result2 = str.substring(1,2);
			var result3 = str.substring(2,3);
			var result4 = str.substring(3,4);
			
			console.log("result1>>"+result1);
			console.log("result2>>"+result2);
			console.log("result3>>"+result3);
			console.log("result4>>"+result4);
			

			$("#pgm_create").val(result1);
			$("#pgm_read").val(result2);
			$("#pgm_update").val(result3);
			$("#pgm_delete").val(result4);


			$('input[type="checkbox"]').each(function() {
				
				if($(this).val() == 1) {
					$(this).prop("checked",true);
					$(this).prop("disabled",false);
				} else {
					$(this).prop("checked",false);
					$(this).prop("disabled",true);
				}

			});
			
			document.getElementById("result").innerHTML="수정이 완료되었습니다.";
		}
	} else {
		alert("로그인 해주세요!");
		location.href="login";
	}
			
}

function delTitle() {
	var form = document.TitleForm;
	
	if(${sessionScope.user.user_id != null}){
		var chk = confirm("정말 삭제하시겠습니까?");
		if(chk) {
			location.href="delTitle?titdet_titmst_id=${result.title.titdet_titmst_id}&titdet_pgm_id=${result.title.titdet_pgm_id}";
		}	
	} else {
		alert("로그인 해주세요!");
		location.href="login";
	}
		
}
</script>
</html>