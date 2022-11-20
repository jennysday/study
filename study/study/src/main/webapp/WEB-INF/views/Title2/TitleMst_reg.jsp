<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<html>
<head>
<meta charset="UTF-8">
<title>프로그램 등록</title>

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
					<li><h1>직무 마스터 등록</h1></li>
					<li><span>${sessionScope.user.user_name}</span></li>
				</ul>
			</c:if>
			
			<c:if test="${sessionScope.user.user_team == null}">
				<ul>
					<li>--------------</li>
					<li><h1>직무 마스터 등록</h1></li>
					<li>--------------</li>
				</ul>
			</c:if>
		</div>
		<iframe name="iframe" style="display:none;"></iframe>
		<div class="section">
			<form action="regTitlemst" method="post" name="regTitlemstForm" id="regTitlemstForm" target="iframe">
				<table>
					
					<tr>
						<th><span><label for="titmst_id">직무코드</label></span></th>
						<td class="left">
							<input type="text" name="titmst_id" id="titmst_id" class="box" autocomplete="off" onkeydown="myFunction()" maxlength='5'> 
							<!-- <input type="text" name="team_id" id="team_id" class="form-control" autocomplete="off"/> -->
				            <input type="button" id="btnCheck" class="btn btn-default" value="중복검사"/>
				            <!-- 아이디 중복 체크 여부 -->
				            <input type="hidden" name="checked_id" value="n">
						</td>
					</tr>
					
					<tr>
						<th><span><label for="titmst_name">직무명</label></span></th>
						<td class="left">
							<input type="text" name="titmst_name" id="titmst_name" class="box" autocomplete="off" maxlength='20'>
						</td>
						
					</tr>
					<tr>
						<th><span><label for="titmst_class">직무그룹</label></span></th>
						<td class="left"><input type="text" name="titmst_class" id="titmst_class" class="box" autocomplete="off" maxlength='2' readonly></td>
						<td class="left"><input type="hidden" name="titmst_user_id"class="box" value="${sessionScope.user.user_id}"></td>
					</tr>
				</table>
				<div class="btn_box_reg">
					<div>
						<ul>
							<li><a href="getTitleList" class="btn">종료</a></li>
							<li><a href="javascript:regTitlemst()" class="btn">등록</a></li>
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
		  $("#titmst_class").val("1");
	  } else {
		  //$("#pgm_status").val(selectedEls.length + " >> 2. 사용 불가");
		  $('#result').text(selectedEls.length + " >> 2. 사용 불가");
		  $("#titmst_class").val("2");
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

	$("#titmst_id").keyup(function(){

		// 2. #out 공간에 #data의 내용이 출력된다.

		//$("#result").text($("#pgm_id").val());
		//$("#pgm_group").val($("#pgm_id").val());
		$("#titmst_class").val($("#titmst_id").val().substr(0, 2));

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
	
    if ($('#titmst_id').val() != '') {

        // 아이디를 서버로 전송 > DB 유효성 검사 > 결과 반환받기
        $.ajax({
   					
            type: 'POST',
            url: 'tmIdCheck',
            data: 'id=' + $('#titmst_id').val(),
            dataType: 'json',
            success: function(result) {
                if (result == '0') {
                	
                	//영어, 숫자만 가능한 정규식
                	var engNum =  /^[a-zA-Z0-9]*$/;
                	if (!engNum.test(document.getElementById('titmst_id').value)) { 
                		$("input[name=checked_id]").val('n');  
                		console.log(">>"+$("input[name=checked_id]").val());
                		$('#result').text('영어와 숫자만 입력 가능합니다.');
                	} else {
 
               			document.getElementById("btnCheck").style.backgroundColor = "#bcbcbc";
                   		document.getElementById("btnCheck").style.cursor = "default";
                   		$("input[name=checked_id]").val('y');
                       	console.log($("input[name=checked_id]").val());
                        $('#result').text('사용 가능한 직무코드입니다.');
                	}
                	
                } else {
                	$("input[name=checked_id]").val('');
                    $('#result').text('이미 사용중인 직무코드입니다.');
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
       $('#result').text('직무코드를 입력해주세요!');
       $('#titmst_id').focus();
       return
    }
   			
});




function regTitlemst() {
	
	
	console.log($("input[name=checked_id]").val());
	
	 if($("input[name='checked_id']").val()=='n'){
      alert('직무코드를 확인 후 중복 버튼을 눌러주세요.');
      $("input[name='checked_id']").eq(0).focus();
      return false;
  	}
	
	
	var form = document.regTitlemstForm;
	
	var blank_pattern = /[\s]/g;
	
	/*** 직무코드 유효성 검사 ***/
	var titmst_id_v = form.titmst_id.value;

	//입력을 안할 경우
	if(titmst_id_v == '' || titmst_id_v == null) {
		$('#result').text('직무코드를 입력해주세요!');
		//alert("부서코드를 입력해주세요!");
		form.titmst_id.select();
		return;
	}
	
	//공백만 입력 된 경우
	if(titmst_id_v.replace(blank_pattern,'') == "") {
		$('#result').text('공백만 입력되었습니다.');
		//alert("공백만 입력되었습니다.");
		form.titmst_id.select();
		return;
	}
	
	
	/*** 직무명 유효성 검사 ***/
	var titmst_name_v = form.titmst_name.value;
	
	//입력을 안할 경우
	if(titmst_name_v == '' || titmst_name_v == null) {
		$('#result').text('직무명을 입력해주세요!');
		//alert("부서명을 입력해주세요!");
		form.titmst_name.select();
		return;
	}
	
	//공백만 입력 된 경우
	if(titmst_name_v.replace(blank_pattern,'') == "") {
		$('#result').text('공백만 입력되었습니다.');
		//alert("공백만 입력되었습니다.");
		form.titmst_name.select();
		return;
	}
	
	//한글만 가능한 정규식
	var korean_check = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
	var engNum =  /^[a-zA-Z0-9]*$/;
	if (!korean_check.test(document.getElementById('titmst_name').value)) { 
		$('#result').text('직무명은 한글만 입력 가능합니다.');
		form.titmst_name.select();
		return;
	}
	
	if(titmst_name_v.length > 21) {
		$('#result').text('직무명은 20자 미만으로 입력해주세요.');
		//alert("부서명은 20자 미만으로 입력해주세요.");
		form.titmst_name.select();
		return;
	}
	


	
	if(${sessionScope.user.user_id != null}){
		var chk = confirm("등록 하시겠습니까?");
		
		if(chk) {
			form.submit();

			document.getElementById("titmst_id").value = null; 
			document.getElementById("titmst_name").value = null; 
			document.getElementById("titmst_class").value = null; ;
						
			document.getElementById("result").innerHTML="등록이 완료되었습니다.";
		}		
	} else {
		alert("로그인 해주세요!");
		location.href="login";
	}
		
}
</script>
</html>