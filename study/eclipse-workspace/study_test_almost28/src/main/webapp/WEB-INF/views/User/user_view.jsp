<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 상세 조회</title>

<link href="${pageContext.request.contextPath}/resources/css/reset.css?after" rel="stylesheet" type="text/css">
</head>
<body>
	
<c:set var="ok" value="false"></c:set>
<c:forEach var="i" items="${sessionScope.titleList}">
	
	<c:choose>
		<c:when test="${i eq 'User1004'}">
			 <c:out value="${i}"></c:out> 
			 <c:set var="ok" value="true"></c:set>
		</c:when>
		
		<c:otherwise>
	    </c:otherwise>
    </c:choose>
</c:forEach>

<c:out value="${funct.titdet_function}" /> 
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
					<li><span>User1004</span></li>
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
		<iframe name="iframe" style="display:none;"></iframe>
		<div class="section">
			<form action="updateUser" method="post" name="UserForm" id="UserForm" target="iframe">
				<table>
					<tr>
						<th>사용자 아이디</th>
						<td class="left"><c:out value="${result.user.user_id}"></c:out></td>
						<td><input type="hidden" name="user_id" id="user_id" value="${result.user.user_id}" autocomplete="off"></td>
					</tr>
					<tr>
						<th><label for="user_name">사용자명</label></th>
						<td class="left"><input type="text" name="user_name" id="user_name" value="${result.user.user_name}" class="box" autocomplete="off" maxlength='20'></td>
					</tr>
					<tr>
						<th><label for="user_pswd">비밀번호</label></th>
						<td class="left"><input type="text" name="user_pswd" id="user_pswd" value="${result.user.user_pswd}" class="box" autocomplete="off" maxlength='20'></td>
					</tr>

					<tr>
						<th><span><label for="user_team">부서코드</label></span></th>
						<td class="left">
							<select name="user_team" class="teamList">
							     <c:forEach var="result" items="${result2.teamList}">
							     	<option value="${result.team_id}" id="user_team">${result.team_id} &nbsp; ${result.team_name}</option>
							    </c:forEach>
							 </select>
						</td>
					</tr>
					
					<tr>
						<th><span><label for="user_titmst_id1">직무코드1</label></span></th>
						<td class="left">
							<select name="user_titmst_id1" class="teamList">
							     <c:forEach var="result" items="${result3.titleMstList}">
							     	<option value="${result.titmst_id}" id="user_titmst_id1">${result.titmst_id} &nbsp; ${result.titmst_name}</option>
							    </c:forEach>
							 </select>
						</td>
					</tr>
					<tr>
						<th><span><label for="user_titmst_id2">직무코드2</label></span></th>
						<td class="left">
							<select name="user_titmst_id2" class="teamList">
							     <c:forEach var="result" items="${result3.titleMstList}">
							     	<option value="${result.titmst_id}" id="user_titmst_id2">${result.titmst_id} &nbsp; ${result.titmst_name}</option>
							    </c:forEach>
							 </select>
						</td>
					</tr>
					<tr>
						<th><span><label for="user_titmst_id3">직무코드3</label></span></th>
						<td class="left">
							<select name="user_titmst_id3" class="teamList">
							     <c:forEach var="result" items="${result3.titleMstList}">
							     	<option value="${result.titmst_id}" id="user_titmst_id3">${result.titmst_id} &nbsp; ${result.titmst_name}</option>
							    </c:forEach>
							 </select>
						</td>
					</tr>

					
					<tr>
						<th><span><label for="user_dataaccess">자료접근권한</label></span></th>
						<td class="left">
							<input type="text" name="user_dataaccess" id="user_dataaccess" value="${result.user.user_dataaccess}" class="box3" autocomplete="off" maxlength='1'>
							<span>1(담당) 2(파트장) 3(팀장) 4(부문) 5(본부장) 6(ADMIN)</span>
						</td>
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
						<td class="left"><fmt:formatDate value="${result.user.user_reg_date}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					</tr>
					<tr>
						<th>수정일시</th>
						<td class="left"><fmt:formatDate value="${result.user.user_update_date}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					</tr>
					<tr>
						<th>최종사용자</th>
						<td class="left"><c:out value="${result.user.user_user_id}"></c:out></td>
						<td><input type="hidden" name="user_user_id" id="user_user_id" value="${sessionScope.user.user_id}"></td>
					</tr>
				</table>
				
				<input type="hidden" id="titdet_function" value="${funct.titdet_function}" readonly="readonly">
				<div class="btn_box">
					<div>
						<ul>
							<li><a href="getUserList" class="btn">종료</a></li>
							<li><a href="javascript:delUser()" class="btn" id="delbtn">삭제</a></li>
							<li><a href="javascript:updateUser()" class="btn" id="upbtn">수정</a></li>
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
	$("select[name=user_team]").val('${result.user.user_team}');
	$("select[name=user_titmst_id1]").val('${result.user.user_titmst_id1}');
	$("select[name=user_titmst_id2]").val('${result.user.user_titmst_id2}');
	$("select[name=user_titmst_id3]").val('${result.user.user_titmst_id3}');
	

	$("select[name=user_team]").change(function(){
	  console.log($(this).val()); //value값 가져오기
	  console.log($("select[name=location] option:selected").text()); //text값 가져오기
	});

	$("select[name=user_titmst_id1]").change(function(){
		  console.log($(this).val()); //value값 가져오기
		  console.log($("select[name=location] option:selected").text()); //text값 가져오기
	});
	$("select[name=user_titmst_id2]").change(function(){
		  console.log($(this).val()); //value값 가져오기
		  console.log($("select[name=location] option:selected").text()); //text값 가져오기
	});
	$("select[name=user_titmst_id3]").change(function(){
		  console.log($(this).val()); //value값 가져오기
		  console.log($("select[name=location] option:selected").text()); //text값 가져오기
	});
	
	var ok = ${ok};
	if (ok == false) {
		//alert('사용 권한이 없습니다.');location.href='getUserList';
		$("#upbtn").attr('class','disabled');
		$("#delbtn").attr('class','disabled');
	}
	else {
		 $.ajax({	
	            type: 'GET',
	            url: 'getTitledetail_function',
	            data: 'titdet_pgm_id=' + 'User1004',
	            dataType: 'json',
	            success: function(result) {
	                if (result == 1) {
	                	console.log("성공")
	                	console.log(result);
	                	
	                	var titdet_function = $("#titdet_function").val();
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
	                	
	                } else {
	                	console.log("실패");
	                }
	            },
	            error: function(a, b, c) {
	                console.log(a, b, c);
	            }
	   					
	       });
		
	}
	
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

function updateUser() {
	var form = document.UserForm;

	var blank_pattern = /[\s]/g;
	
	/*
	 if($("input[name='upteam_id']").val()=='n'){
       alert('상위부서코드가 존재하지 않습니다.');
       $("input[name='upteam_id']").eq(0).focus();
       return false;
   	}
	*/
	
	/*** 사용자 아이디 유효성 검사 ***/
	var user_id_v = form.user_id.value;

	//입력을 안할 경우
	if(user_id_v == '' || user_id_v == null) {
		$('#result').text('사용자 아이디를 입력해주세요!');
		form.user_id.select();
		return;
	}
	
	//공백만 입력 된 경우
	if(user_id_v.replace(blank_pattern,'') == "") {
		$('#result').text('공백만 입력되었습니다.');
		//alert("공백만 입력되었습니다.");
		form.user_id.select();
		return;
	}
	
	if(user_id_v.length > 5) {
		$('#result').text('부서코드는 5자 미만으로 입력해주세요.');
		form.user_id.select();
		return;
	}
	
	/*** 사용자명 유효성 검사 ***/
	var user_name_v = form.user_name.value;
	
	//입력을 안할 경우
	if(user_name_v == '' || user_name_v == null) {
		$('#result').text('사용자명을 입력해주세요!');
		form.user_name.select();
		return;
	}
	
	//공백만 입력 된 경우
	if(user_name_v.replace(blank_pattern,'') == "") {
		$('#result').text('공백만 입력되었습니다.');
		//alert("공백만 입력되었습니다.");
		form.user_name.select();
		return;
	}
	
	if(user_name_v.length > 21) {
		$('#result').text('사용자명은 20자 미만으로 입력해주세요.');
		form.user_name.select();
		return;
	}
	
	/*** 비밀번호 유효성 검사 ***/
	var user_pswd_v = form.user_pswd.value;
	
	//입력을 안할 경우
	if(user_pswd_v == '' || user_pswd_v == null) {
		$('#result').text('비밀번호를 입력해주세요!');
		form.user_pswd.select();
		return;
	}
	
	//공백만 입력 된 경우
	if(user_pswd_v.replace(blank_pattern,'') == "") {
		$('#result').text('공백만 입력되었습니다.');
		form.user_pswd.select();
		return;
	}
	
	//한글 제약
	var engNum =  /^[a-zA-Z0-9]*$/;
	if (!engNum.test(document.getElementById('user_pswd').value)) { 
		$('#result').text('영어와 숫자만 입력 가능합니다.');
		form.user_pswd.select();
		return;
	} 
	
	//글자수 제약
	if(user_pswd_v.length < 8) {
		$('#result').text('비밀번호는 8자 이상으로 입력해주세요.');
		form.user_pswd.select();
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

function delUser() {
	var form = document.UserForm;
	
	if(${sessionScope.user.user_id != null}){
		var chk = confirm("정말 삭제하시겠습니까?");
		if(chk) {
			location.href="delUser?user_id=${result.user.user_id}";
		}	
	} else {
		alert("로그인 해주세요!");
		location.href="login";
	}
		
}
</script>
</html>