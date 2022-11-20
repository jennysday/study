<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서 조회</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/blue_style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/green_style.css" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/reset2.css?after" rel="stylesheet" type="text/css">
</head>
<body>
	
<c:set var="ok" value="false"></c:set>
<%-- 
<c:forEach var="i" items="${sessionScope.titleList}">
	
	<c:choose>
		<c:when test="${i eq 'Prgm1003'}">
			 <c:out value="${i}"></c:out> 
			 <c:set var="ok" value="true"></c:set>
		</c:when>
		
		<c:otherwise>
	    </c:otherwise>
    </c:choose>
</c:forEach>
 --%>
 
<c:forEach var="i" items="${sessionScope.titleFunctionList}">
	
	<c:if test = "${fn:contains(i, 'Prgm1003')}">
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
					<li><span>Prgm1003</span></li>
					<li><h1>프로그램 수정 및 삭제</h1></li>
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
		
		<div class="search">
			<div class="search_txt">
				<form action="getProgramListView" method="post" name="searchPrgmForm" id="searchPrgmForm">
						<span>프로그램명 : &nbsp;</span> 
						<select name="pgm_id" class="teamList">
						     <c:forEach var="result" items="${result2.programList}">
						     	<option value="${result.pgm_id}" id="pgm_id">${result.pgm_id} &nbsp; ${result.pgm_name}</option>
						    </c:forEach>
						 </select>
					<a class="btn" href="javascript:searchPrgm()">조회</a>
				</form>
			</div>
		</div>
		
		<div class="section">
			<table id="gcTable" class="tablesorter">
				<thead id="table_menu">
					<tr>
						<th>PGM_ID</th>
						<th>프로그램명</th>
						<th>주요기능</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(result3.searchList) eq 0}">
							<tr>
								<th colspan="3">게시글이 없습니다.</th>
							</tr>
						</c:when>
						
						<c:otherwise>
							<c:forEach var="program" items="${result3.searchList}">
								<tr id="mouse" onClick="location.href='getProgramListView?pgm_id=${program.pgm_id}&page=${result.page}'">
									<td><c:out value="${program.pgm_id}"></c:out></td>
									<td><c:out value="${program.pgm_name}"></c:out></td>
									<td><c:out value="${program.pgm_create}${program.pgm_read}${program.pgm_update}${program.pgm_delete}"></c:out></td>
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
					<a href="searchPrgmListView?page=${result.page - 1}">[이전]</a>
				</c:if>
				
				<c:if test="${result.page <= result.endPage}">
					<c:forEach var="pageNum" begin="${result.startPage}" end="${result.endPage}"> 
						<c:choose>
							<c:when test="${pageNum eq result.page}">
								<span>
									<a style="font-weight: bold; color: #1d84df !important;" href="searchPrgmListView?page=${pageNum}">${pageNum}</a>
								</span>
							</c:when>
							<c:otherwise>
								<a href="searchPrgmListView?page=${pageNum}">${pageNum}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<c:if test="${result.page < result.endPage}">
						<a href="searchPrgmListView?page=${result.page + 1}">[다음]</a>
					</c:if>
				</c:if>
			</div>
		</div>
		
		
		<iframe name="iframe" style="display:none;"></iframe>
		<div class="section">
			<form action="updateProgram" method="post" name="updateProgramForm" id="updateProgramForm" target="iframe">
				<table class="table_left">
					<tr>
						<th>프로그램ID</th>
						<td class="left"><c:out value="${result4.program.pgm_id}"></c:out></td>
						<td><input type="hidden" name="pgm_id" id="pgm_id" value="${result4.program.pgm_id}" autocomplete="off"></td>
					</tr>
					<tr>
						<th>그룹코드</th>
						<td class="left"><c:out value="${result4.program.pgm_group}"></c:out></td>
						<td><input type="hidden" name="pgm_group" id="pgm_group" value="${result4.program.pgm_group}" autocomplete="off"></td>
					</tr>
					<tr>
						<th><label for="pgm_name">프로그램명</label></th>
						<td class="left"><input type="text" name="pgm_name" id="pgm_name" value="${result4.program.pgm_name}" class="box2" autocomplete="off" maxlength='20'></td>
					</tr>
					
					<tr>
						<th><span><label for="pgm_function">주요 기능</label></span></th>
						<td class="le_td">
							<span class="pg_box">
								<label for="pgm_create">입력</label>
								<!-- <input type="checkbox" id="pgm_create" name="pgm_function" value="입력" onclick='getCheckboxValue(event)'>  -->
								<input type="checkbox" id="pgm_create" name="pgm_create" onclick='getCheckboxValue(event)' value="${result4.program.pgm_create}">
								
								<label for="pgm_read">조회</label>
								<!-- <input type="checkbox" id="pgm_read" name="pgm_function" value="조회" onclick='getCheckboxValue(event)'> --> 
								<input type="checkbox" id="pgm_read" name="pgm_read" onclick='getCheckboxValue(event)' value="${result4.program.pgm_read}">
								
								<label for="pgm_update">수정</label>
								<!-- <input type="checkbox" id="pgm_update" name="pgm_function" value="수정" onclick='getCheckboxValue(event)'> --> 
								<input type="checkbox" id="pgm_update" name="pgm_update" onclick='getCheckboxValue(event)' value="${result4.program.pgm_update}">
								
								<label for="pgm_delete">삭제</label>
								<!-- <input type="checkbox" id="pgm_delete" name="pgm_function" value="삭제" onclick='getCheckboxValue(event)'> --> 
								<input type="checkbox" id="pgm_delete" name="pgm_delete" onclick='getCheckboxValue(event)' value="${result4.program.pgm_delete}">
							</span>
						</td>
						
					</tr>
					
					<tr>
						<th><span><label for="pgm_status">상태</label></span></th>
						<td class="left"><input type="text" name="pgm_status" id="pgm_status" class="underLine" autocomplete="off" maxlength='4' value="${result4.program.pgm_status}" maxlength='1' readonly class="underLine"></td>
					</tr>
					
					
					<tr>
						<th>최종사용자</th>
						<td class="left"><c:out value="${result4.program.pgm_user_id}"></c:out></td>
						<td><input type="hidden" name="pgm_user_id" id="pgm_user_id" value="${sessionScope.user.user_id}"></td>
					</tr>
				</table>
				
				<div class="btn_box">
					<div>
						<ul>
							<li><a href="getProgramList" class="btn">종료</a></li>
							<li><a href="javascript:delProgram()" class="btn" id="delbtn">삭제</a></li>
							<li><a href="javascript:updateProgram()" class="btn" id="upbtn">수정</a></li>
							<!-- <li><input type="submit" value="수정" class="btn"></li> -->
						</ul>
					</div>
				</div>
			</form>
		</div>	
		<div class="msg_listView">
		<div class="msg_list">
			<c:if test="${sessionScope.user.user_id != null}">
				<p class="msg_list_p">MSG :<span id="result"> ${pgm_id} 검색 결과입니다.</span></p>
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

	$("select[name=pgm_id]").val('${pgm_id}');
	
	
	$("input[name=pgm_create]").filter("[value='1']").prop("checked",true);
	$("input[name=pgm_read]").filter("[value='1']").prop("checked",true);
	$("input[name=pgm_update]").filter("[value='1']").prop("checked",true);
	$("input[name=pgm_delete]").filter("[value='1']").prop("checked",true);
	

	var ok = ${ok};
	if (ok == false) {
		alert('사용 권한이 없습니다.');location.href='getProgramList';
		$("#upbtn").attr('class','disabled');
		$("#delbtn").attr('class','disabled');
	}  else {

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
   			alert('사용 권한이 없습니다.');location.href='getProgramList';
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
			var queryString = $("form[name=updateProgramForm]").serialize() ;
			console.log(queryString);
			
			$.ajax({
					
	            type: 'POST',
	            url: 'updateProgram',
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





function delProgram() {
	
	if(${sessionScope.user.user_id != null}){
		var chk = confirm("정말 삭제하시겠습니까?");
		if(chk) {
			
			var pgm_id = $("input[name=pgm_id]").val();
			console.log(pgm_id);
			
			$.ajax({
					
	            type: 'POST',
	            url: 'delProgram',
	            data: 'pgm_id=' + pgm_id,
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

function searchPrgm() {
	var form = document.searchPrgmForm;
	form.submit();
}
</script>
</html>