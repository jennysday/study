<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<meta charset="UTF-8">
<title>프로그램 등록</title>

<link href="${pageContext.request.contextPath}/resources/css/reset.css?after" rel="stylesheet" type="text/css">
</head>
<body>
	
<c:set var="ok" value="false"></c:set>
<%-- 
<c:forEach var="i" items="${sessionScope.titleList}">
	
	<c:choose>
		<c:when test="${i eq 'Prgm1001'}">
			 <c:out value="${i}"></c:out> 
			 <c:set var="ok" value="true"></c:set>
		</c:when>
		
		<c:otherwise>
	    </c:otherwise>
    </c:choose>
</c:forEach>
 --%>
 
<c:forEach var="i" items="${sessionScope.titleFunctionList}">
	
	<c:if test = "${fn:contains(i, 'Prgm1001')}">
		<c:out value="${i}" /> 
		<c:set var="ok" value="true"></c:set>
		
		<c:set var="titfunction" value="${i}" />
		
		<input type="text" id="titdet_function" value="${fn:substring(titfunction,8,14)}" readonly="readonly">
		
	</c:if>

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
					<li><span>Prgm1001</span></li>
					<li><h1>프로그램 등록</h1></li>
					<li><span>${sessionScope.user.user_name}</span></li>
				</ul>
			</c:if>
			
			<c:if test="${sessionScope.user.user_team == null}">
				<ul>
					<li>--------------</li>
					<li><h1>프로그램 등록</h1></li>
					<li>--------------</li>
				</ul>
			</c:if>
		</div>
		<iframe name="iframe" style="display:none;"></iframe>
		<div class="section">
			<form action="regProgram" method="post" name="regProgramForm" id="regProgramForm" target="iframe">
				<table>
					
					<tr>
						<th><span><label for="pgm_id">프로그램ID</label></span></th>
						<td class="left">
							<input type="text" name="pgm_id" id="pgm_id" class="box" autocomplete="off" onkeydown="myFunction()" maxlength='8'> 
							<!-- <input type="text" name="team_id" id="team_id" class="form-control" autocomplete="off"/> -->
				            <input type="button" id="btnCheck" class="btn btn-default" value="중복검사"/>
				            <!-- 아이디 중복 체크 여부 -->
				            <input type="hidden" name="checked_id" value="n">
						</td>
					</tr>
						
					
					<tr>
						<th><span><label for="pgm_group">그룹코드</label></span></th>
						<td class="left"><input type="text" name="pgm_group" id="pgm_group" class="box" autocomplete="off" maxlength='6'></td>
					</tr>
					<tr>
						<th><span><label for="pgm_name">프로그램명</label></span></th>
						<td class="left">
							<input type="text" name="pgm_name" id="pgm_name" class="box" autocomplete="off" maxlength='20'>
						</td>
						
					</tr>
					<tr>
						<th><span><label for="pgm_function">주요 기능</label></span></th>
						<td class="le_td">
							<span class="pg_box">
								<label for="pgm_create">입력</label>
								<!-- <input type="checkbox" id="pgm_create" name="pgm_function" value="입력" onclick='getCheckboxValue(event)'>  -->
								<input type="checkbox" id="pgm_create" name="pgm_create" onclick='getCheckboxValue(event)'>
								
								<label for="pgm_read">조회</label>
								<!-- <input type="checkbox" id="pgm_read" name="pgm_function" value="조회" onclick='getCheckboxValue(event)'> --> 
								<input type="checkbox" id="pgm_read" name="pgm_read" onclick='getCheckboxValue(event)'>
								
								<label for="pgm_update">수정</label>
								<!-- <input type="checkbox" id="pgm_update" name="pgm_function" value="수정" onclick='getCheckboxValue(event)'> --> 
								<input type="checkbox" id="pgm_update" name="pgm_update" onclick='getCheckboxValue(event)'>
								
								<label for="pgm_delete">삭제</label>
								<!-- <input type="checkbox" id="pgm_delete" name="pgm_function" value="삭제" onclick='getCheckboxValue(event)'> --> 
								<input type="checkbox" id="pgm_delete" name="pgm_delete" onclick='getCheckboxValue(event)'>
							</span>
						</td>
						
					</tr>
					<tr>
						<th><span><label for="pgm_status">상태</label></span></th>
						<td class="left"><input type="text" name="pgm_status" id="pgm_status"  autocomplete="off" maxlength='1' readonly class="underLine"></td>
						<td class="left"><input type="hidden" name="pgm_user_id"class="box" value="${sessionScope.user.user_id}"></td>
					</tr>
					<%-- 
					<tr>
						<th><span>최종사용자</span></th>
						<td class="left"><input type="hidden" name="pgm_user_id"class="box" value="${sessionScope.user.user_id}">${sessionScope.user.user_id}</td>
					</tr>
 					--%>
				</table>
				
				<div class="btn_box_reg">
					<div>
						<ul>
							<li><a href="getProgramList" class="btn">종료</a></li>
							<li><a href="javascript:regProgram()" class="btn" id="crbtn">등록</a></li>
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

$(document).ready(function(){
	var ok = ${ok};
	if (ok == false) {
		//alert('사용 권한이 없습니다.');location.href='getProgramList';
		$("#crbtn").attr('class','disabled');
	}  else {
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
	}
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
		  $('#result').text(selectedEls.length + "개 >> 1. 사용 가능");
		  $("#pgm_status").val("1");
	  } else {
		  //$("#pgm_status").val(selectedEls.length + " >> 2. 사용 불가");
		  $('#result').text(selectedEls.length + " >> 2. 사용 불가");
		  //$("input[name=pgm_read]").prop("checked", true);
		  $("#pgm_status").val("2");
	  } 

 
}


/* 키보드를 누르면 중복키를 누르게끔 설정 */
function myFunction() {
	document.getElementById("btnCheck").style.backgroundColor = "pink";
	$("input[name=checked_id]").val('n');  
	console.log($("input[name=checked_id]").val());
}


$(document).ready(function(){

	// 입력란에 입력을 하면 입력내용에 내용이 출력

	// 1. #data 공간에서 keyup이라는 이벤트가 발생했을 때

	$("#pgm_id").keyup(function(){

		// 2. #out 공간에 #data의 내용이 출력된다.

		//$("#result").text($("#pgm_id").val());
		//$("#pgm_group").val($("#pgm_id").val());
		$("#pgm_group").val($("#pgm_id").val().substr(0, 6));

		// #out의 위치에 text로 데이터를 받는다.(setter)

		// 들어가는 데이터는 #data의 값(.val())이다. (getter)

		// 메서드 괄호 안에 아무것도 없으면 getter, 파라미터가 있으면 setter이다.

	});

});



/*
function printName()  {
	 const name = document.getElementById('pgm_id').value;
	 //document.getElementById("result").innerText = name;
	 document.getElementById("result").innerText = name;
}




function is_checked() {
  
  // 1. checkbox element를 찾습니다.
  const checkbox = document.getElementById('pgm_create');

  // 2. checked 속성을 체크합니다.
  const is_checked = checkbox.checked;  

  // 3. 결과를 출력합니다.
  document.getElementById('result').innerText = checkbox;
 
  
}
*/ 


/*
function getCheckboxValue()  {
	  // 선택된 목록 가져오기
	  const query = 'input[name="pgm_function"]:checked';
	  const selectedEls = 
	      document.querySelectorAll(query);
	  
	  // 선택된 목록에서 value 찾기
	  let result = '';
	  selectedEls.forEach((el) => {
	    result += el.value + ' ';
	  });
	  
	  // 출력
	  document.getElementById('result').innerText
	    = result;
}
*/


$('#btnCheck').click(function () {
	
    if ($('#pgm_id').val() != '') {

        // 아이디를 서버로 전송 > DB 유효성 검사 > 결과 반환받기
        $.ajax({
   					
            type: 'POST',
            url: 'pgmIdCheck',
            data: 'id=' + $('#pgm_id').val(),
            dataType: 'json',
            success: function(result) {
                if (result == '0') {
                	
                	//영어, 숫자만 가능한 정규식
                	var engNum =  /^[a-zA-Z0-9]*$/;
                	if (!engNum.test(document.getElementById('pgm_id').value)) { 
                		$("input[name=checked_id]").val('n');  
                		console.log(">>"+$("input[name=checked_id]").val());
                		$('#result').text('영어와 숫자만 입력 가능합니다.');
                	} else {
                		
                		/*** 프로그램명 유효성 검사 ***/
                		var pgm_id_v = document.getElementById('pgm_id').value;
                		
                		if(pgm_id_v.length != 8) {
                			$('#result').text('프로그램 아이디는 8자로 입력해주세요.');
                			//alert("부서코드는 5자 미만으로 입력해주세요.");
                			form.team_id.select();
                			return;
                		} else {
                			document.getElementById("btnCheck").style.backgroundColor = "#bcbcbc";
                    		document.getElementById("btnCheck").style.cursor = "default";
                    		$("input[name=checked_id]").val('y');
                        	console.log($("input[name=checked_id]").val());
                            $('#result').text('사용 가능한 부서코드입니다.');
                		}

                	}
                	
                } else {
                	$("input[name=checked_id]").val('');
                    $('#result').text('이미 사용중인 부서코드입니다.');
                    $("input[name=checked_id]").val('n'); 
                	console.log(">>"+$("input[name=checked_id]").val());
                }
            },
            error: function(a, b, c) {
                console.log(a, b, c);
            }
   					
        });
   				
    } else {
       // alert('부서코드를 입력하세요.');
       $('#result').text('부서코드를 입력해주세요!');
       $('#pgm_id').focus();
       return
    }
   			
});




function regProgram() {
	
	
	console.log($("input[name=checked_id]").val());
	
	 if($("input[name='checked_id']").val()=='n'){
      alert('부서코드를 확인 후 중복 버튼을 눌러주세요.');
      $("input[name='checked_id']").eq(0).focus();
      return false;
  	}
	
	
	var form = document.regProgramForm;
	
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
	
	/*** 프로그램명 유효성 검사 ***/
	var pgm_status_v = form.pgm_status.value;
	
	//입력을 안할 경우
	if(pgm_status_v == '' || pgm_status_v == null) {
		$("#pgm_status").val("2");
	}
	
	//공백만 입력 된 경우
	if(pgm_status_v.replace(blank_pattern,'') == "") {
		$("#pgm_status").val("2");
	}
	
	//숫자만 입력 가능
	var check = /^[0-9]+$/; 
	if (!check.test(document.getElementById('pgm_status').value)) {
		$('#result').text('상태에는 숫자만 입력 가능합니다.');
		form.pgm_status.select();
		return;
	}
	

	
	if(${sessionScope.user.user_id != null}){
		var chk = confirm("등록 하시겠습니까?");
		
		if(chk) {
			form.submit();

			document.getElementById("pgm_id").value = null; 
			document.getElementById("pgm_group").value = null; 
			document.getElementById("pgm_name").value = null; ;
			document.getElementById("pgm_status").value = null; 
						
			$("input[type='checkbox']").prop("checked",false);
			
			document.getElementById("result").innerHTML="등록이 완료되었습니다.";
		}		
	} else {
		alert("로그인 해주세요!");
		location.href="login";
	}
		
}
</script>
</html>