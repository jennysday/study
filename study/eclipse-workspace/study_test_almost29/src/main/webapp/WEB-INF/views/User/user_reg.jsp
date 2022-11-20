<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<html>
<head>
<meta charset="UTF-8">
<title>부서 등록</title>

<link href="${pageContext.request.contextPath}/resources/css/reset.css?after" rel="stylesheet" type="text/css">
</head>
<body>
	
<c:set var="ok" value="false"></c:set>
<c:forEach var="i" items="${sessionScope.titleList}">
	
	<c:choose>
		<c:when test="${i eq 'User1001'}">
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
					<li><span>User1001</span></li>
					<li><h1>사용자 등록</h1></li>
					<li><span>${sessionScope.user.user_name}</span></li>
				</ul>
			</c:if>
			
			<c:if test="${sessionScope.user.user_team == null}">
				<ul>
					<li>--------------</li>
					<li><h1>사용자 등록</h1></li>
					<li>--------------</li>
				</ul>
			</c:if>
		</div>
		<iframe name="iframe" style="display:none;"></iframe>
		<div class="section">
			<form action="regUser" method="post" name="regUserForm" id="regUserForm" target="iframe">
				<table>
					<tr>
						<th><span><label for="user_id">사용자 아이디</label></span></th>
						<td class="left">
							<input type="text" name="user_id" id="user_id" class="form-control" autocomplete="off" onkeydown="myFunction()" maxlength='8'/> 
				            
				            <input type="button" id="btnCheck" class="btn btn-default" value="중복검사"/>
				            <!-- 아이디 중복 체크 여부 -->
				            <input type="hidden" name="checked_id" value="n">
						</td>
					</tr>
					<tr>
						<th><span><label for="user_name">사용자명</label></span></th>
						<td class="left"><input type="text" name="user_name" id="user_name" class="box" autocomplete="off" maxlength='20'></td>
					</tr>

					<tr>
						<th><span><label for="user_pswd">비밀번호</label></span></th>
						<td class="left"><input type="password" name="user_pswd" id="user_pswd" class="box" autocomplete="off" maxlength='20'></td>
					</tr>

					<tr>
						<th><span><label for="user_team">부서코드</label></span></th>
						<td class="left">
							<select name="user_team" class="teamList">
							     <c:forEach var="result" items="${result.teamList}">
							     	<option value="${result.team_id}" id="user_team">${result.team_id} &nbsp; ${result.team_name}</option>
							    </c:forEach>
							 </select>
						</td>
					</tr>
					
					
					

					<tr>
						<th><span><label for="user_titmst_id1">직무코드1</label></span></th>
						<td class="left">
							<select name="user_titmst_id1" class="teamList">
							     <c:forEach var="result" items="${result2.titleMstList}">
							     	<option value="${result.titmst_id}" id="user_titmst_id1">${result.titmst_id} &nbsp; ${result.titmst_name}</option>
							    </c:forEach>
							 </select>
						
							<input type="hidden" name="checked_id1" value="n">
						</td>
					</tr>
					<tr>
						<th><span><label for="user_titmst_id2">직무코드2</label></span></th>
						<td class="left">
							<select name="user_titmst_id2" class="teamList">
							     <c:forEach var="result" items="${result2.titleMstList}">
							     	<option value="${result.titmst_id}" id="user_titmst_id2">${result.titmst_id} &nbsp; ${result.titmst_name}</option>
							    </c:forEach>
							 </select>
							 
							<input type="hidden" name="checked_id2" value="n">
						</td>
					</tr>
					<tr>
						<th><span><label for="user_titmst_id3">직무코드3</label></span></th>
						<td class="left">
							<select name="user_titmst_id3" class="teamList">
							     <c:forEach var="result" items="${result2.titleMstList}">
							     	<option value="${result.titmst_id}" id="user_titmst_id3">${result.titmst_id} &nbsp; ${result.titmst_name}</option>
							    </c:forEach>
							 </select>
						
							<input type="hidden" name="checked_id3" value="n">
						</td>
					</tr>

					
					<tr>
						<th><span><label for="user_dataaccess">자료접근권한</label></span></th>
						<td class="left">
							<input type="text" name="user_dataaccess" id="user_dataaccess" class="box3" autocomplete="off" maxlength='1'>
							<span class="access_span">1(담당) 2(파트장) 3(팀장) 4(부문) 5(본부장) 6(ADMIN)</span>
						</td>
					</tr>

					
					<tr>
						<th><span>최종사용자</span></th>
						<td class="left"><input type="hidden" name="user_user_id"class="box" value="${sessionScope.user.user_id}"></td>
					</tr>

				</table>
				
				<input type="hidden" id="titdet_function" value="${funct.titdet_function}" readonly="readonly">
				<div class="btn_box_reg">
					<div>
						<ul>
							<li><a href="getUserList" class="btn">종료</a></li>
							<!-- <li><a href="getTeamList" class="btn">조회</a></li> -->
							<li><a href="javascript:regUser()" class="btn" id="crbtn">등록</a></li>
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
	var ok = ${ok};
	if (ok == false) {
		//alert('사용 권한이 없습니다.');location.href='getUserList';
		$("#crbtn").attr('class','disabled');
	} 
	else {
		 $.ajax({	
	            type: 'GET',
	            url: 'getTitledetail_function',
	            data: 'titdet_pgm_id=' + 'User1001',
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
	        			
	        			
	        			if(c == 0) {
	        				$("#crbtn").attr('class','disabled');
	        			} else {
	        				$("#crbtn").attr('class','btn');
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


var form = document.regUserForm;
  
$("select[name=user_team]").change(function(){
  console.log($(this).val()); //value값 가져오기
  console.log($("select[name=location] option:selected").text()); //text값 가져오기
});



/* 키보드를 누르면 중복키를 누르게끔 설정 */
function myFunction() {
	document.getElementById("btnCheck").style.backgroundColor = "pink";
	$("input[name=checked_id]").val('n');  
	console.log($("input[name=checked_id]").val());
}
/*
function upteam_chk() {
	//document.getElementById("btnCheck").style.backgroundColor = "pink";
	$("input[name=upteam_id]").val('n');  
	console.log($("input[name=upteam_id]").val());
}
*/
$('#btnCheck').click(function () {
	
    if ($('#user_id').val() != '') {

        // 아이디를 서버로 전송 > DB 유효성 검사 > 결과 반환받기
        $.ajax({
   					
            type: 'POST',
            url: 'userIdCheck',
            data: 'id=' + $('#user_id').val(),
            dataType: 'json',
            success: function(result) {
                if (result == '0') {
                	
                	/*** 부서코드 유효성 검사 ***/
                	var team_id_v = $('#user_id').val();
                	
                	//영어, 숫자만 가능한 정규식
                	var engNum =  /^[a-zA-Z0-9]*$/;
                	if (!engNum.test(document.getElementById('user_id').value)) { 
                		$("input[name=checked_id]").val('n');  
                		console.log(">>"+$("input[name=checked_id]").val());
                		$('#result').text('영어와 숫자만 입력 가능합니다.');
                	} else {
                		document.getElementById("btnCheck").style.backgroundColor = "#bcbcbc";
                		document.getElementById("btnCheck").style.cursor = "default";
                		$("input[name=checked_id]").val('y');
                    	console.log($("input[name=checked_id]").val());
                        $('#result').text('사용 가능한 아이디입니다.');
                	}
                	
                } else {
                	$("input[name=checked_id]").val('');
                    $('#result').text('이미 사용중인 아이디입니다.');
                    $("input[name=checked_id]").val('n'); 
                	console.log(">>"+$("input[name=checked_id]").val());
                }
            },
            error: function(a, b, c) {
                console.log(a, b, c);
            }
   					
        });
   				
    } else {
       $('#result').text('사용자 아이디를 입력해주세요!');
       form.user_id.select();
       $('#user_id').focus();
       return
    }
   			
});


function checkTitmst(){
    var user_titmst_id1 = $("input[name=user_titmst_id1]").val(); //name값이 "team_upteam"인 입력란의 값을 저장
    console.log("user_titmst_id1>>"+user_titmst_id1);
    console.log(">>"+$("input[name=user_titmst_id1]").val());
    
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

function regUser() {
	
	var form = document.regUserForm;
	
	console.log($("input[name=checked_id]").val());
	
	 if($("input[name='checked_id']").val()=='n'){
       alert('부서코드를 확인 후 중복 버튼을 눌러주세요.');
       $("input[name='checked_id']").eq(0).focus();
       return false;
   	}
	 

	
	var blank_pattern = /[\s]/g;
	
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
	
	//글자수 제약
	if(user_pswd_v.length < 8) {
		$('#result').text('비밀번호는 8자 이상으로 입력해주세요.');
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

	
	if(${sessionScope.user.user_id != null}){
		var chk = confirm("등록 하시겠습니까?");
		
		if(chk) {
			form.submit();

			document.getElementById("user_id").value = null; 
			document.getElementById("user_name").value = null; ;
			document.getElementById("user_pswd").value = null; ;
			document.getElementById("user_team").value = null; ;
			
			document.getElementById("user_titmst_id1").value = null; ;
			document.getElementById("user_titmst_id2").value = null; ;
			document.getElementById("user_titmst_id3").value = null; ;
			document.getElementById("user_dataaccess").value = null; ;
			
			document.getElementById("result").innerHTML="등록이 완료되었습니다.";
		}		
	} else {
		alert("로그인 해주세요!");
		location.href="login";
	}
		
}
</script>
</html>