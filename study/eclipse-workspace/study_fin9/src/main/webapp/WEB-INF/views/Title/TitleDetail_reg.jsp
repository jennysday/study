<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<html>
<head>
<meta charset="UTF-8">
<title>직무별 프로그램 등록</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/blue_style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/green_style.css" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/reset2.css?after" rel="stylesheet" type="text/css">
</head>
<body>
	

<c:set var="ok" value="false"></c:set> 
<c:forEach var="i" items="${sessionScope.titleFunctionList}">
	
	<c:if test = "${fn:contains(i, 'Titl1002')}">
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
					<li><span>Titl1002</span></li>
					<li><h1>직무별 프로그램 등록</h1></li>
					<li><span>${sessionScope.user.user_name}</span></li>
				</ul>
			</c:if>
			
			<c:if test="${sessionScope.user.user_team == null}">
				<ul>
					<li>--------------</li>
					<li><h1>직무별 프로그램 등록</h1></li>
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
							     	<option value="${result.titmst_id}" id="titdet_titmst_id">${result.titmst_id} &nbsp; ${result.titmst_name}</option>
							    </c:forEach>
							 </select>
						</td>
					</tr>
					
					<tr>
						<th><span><label for="team_upteam">프로그램ID</label></span></th>
						<td class="left input_no">
							<input type="text" name="titdet_pgm_id" id="titdet_pgm_id" value="${result3.program.pgm_id}" autocomplete="off" style="width: 252px; border-left-width: 0;border-right-width: 0;border-top-width: 0;" readonly="readonly">
						</td>  
					</tr>
					
					<tr>
						<th><span><label for="team_upteam">프로그램명</label></span></th>
						<td class="left">
							<input type="text" name="pgm_name" id="pgm_name" value="${result3.program.pgm_name}" autocomplete="off" style="width: 252px; border-left-width: 0;border-right-width: 0;border-top-width: 0;" readonly="readonly">
						</td>  
					</tr>

					<tr>
						<th><span><label for="titdet_function">주요 기능</label></span></th>
						<td class="pg_box left">
						
							<!-- 아이디 중복 체크 여부 -->
				            <input type="hidden" name="checked_id" value="n">
				            
							<label for="pgm_create">입력</label>
							<!-- <input type="checkbox" id="pgm_create" name="pgm_function" value="입력" onclick='getCheckboxValue(event)'>  -->
							<input type="checkbox" id="pgm_create" name="pgm_create"  onclick='getCheckboxValue(event)' value="${result3.program.pgm_create}">
							
							<label for="pgm_read">조회</label>
							<!-- <input type="checkbox" id="pgm_read" name="pgm_function" value="조회" onclick='getCheckboxValue(event)'> --> 
							<input type="checkbox" id="pgm_read" name="pgm_read" onclick='getCheckboxValue(event)' value="${result3.program.pgm_read}">
							
							<label for="pgm_update">수정</label>
							<!-- <input type="checkbox" id="pgm_update" name="pgm_function" value="수정" onclick='getCheckboxValue(event)'> --> 
							<input type="checkbox" id="pgm_update" name="pgm_update" onclick='getCheckboxValue(event)' value="${result3.program.pgm_update}">
							
							<label for="pgm_delete">삭제</label>
							<!-- <input type="checkbox" id="pgm_delete" name="pgm_function" value="삭제" onclick='getCheckboxValue(event)'> --> 
							<input type="checkbox" id="pgm_delete" name="pgm_delete" onclick='getCheckboxValue(event)'  value="${result3.program.pgm_delete}">
						</td>
						<td><input type="hidden" name="titdet_function" id="titdet_function" name="titdet_function"> </td>
						
						<td><input type="hidden" name="titdet_user_id"class="box" value="${sessionScope.user.user_id}"></td>
					</tr>

				</table>
				

				<div class="btn_box2">
					<ul>
						<li><a href="javascript:regTitledetail()" class="btn" id="crbtn">등록</a></li>
						<li><a href="getTitleList" class="btn">종료</a></li>
					</ul>
				</div>
			</form>
		</div>
		

		
		<div class="section">
			<table id="gcTable" class="tablesorter">
				<thead id="table_menu">
					<tr>
						<th>프로그램ID</th>
						<th>프로그램명</th>
						<th>기능(CRUD)</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(result2.programList) eq 0}">
							<tr>
								<th colspan="6">게시글이 없습니다.</th>
							</tr>
						</c:when>
						
						<c:otherwise>
							<c:forEach var="program" items="${result2.programList}">
								<tr id="mouse" onClick="location.href='regTitledetailView?pgm_id=${program.pgm_id}&page=${result2.page}'">
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
				<div>
					<c:if test="${result2.page <= 0}">
						<c:set target="${result2.page}" property="page" value="1"></c:set>
					</c:if>
					
					<c:if test="${result2.page >= result2.startPage}">
						<a href="regTitledetailView?page=${result.page - 1}">[이전]</a>
					</c:if>
					
					<c:if test="${result2.page <= result2.endPage}">
						<c:forEach var="pageNum" begin="${result2.startPage}" end="${result2.endPage}"> 
							<c:choose>
								<c:when test="${pageNum eq result2.page}">
									<span>
										<a style="font-weight: bold; color: #1d84df !important;" href="regTitledetailView?page=${pageNum}">${pageNum}</a>
									</span>
								</c:when>
								<c:otherwise>
									<a href="regTitledetailView?page=${pageNum}">${pageNum}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<c:if test="${result2.page < result2.endPage}">
							<a href="regTitledetailView?page=${result2.page + 1}">[다음]</a>
						</c:if>
					</c:if>
				</div>
			</div>
		</div>
		
		
		
		
		
		
		
		
		
		
		<div class="msg">
			<p>MSG : <span id="result"></span></p> 
		</div>
	</div>
	
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.tablesorter.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#gcTable").tablesorter();
	
	$("select[name=titdet_titmst_id] option:selected").val();

	
	var value = $("select[name=titdet_titmst_id]").val();
	console.log("value>>"+value);
	

	var titdet_titmst_id = $("select[name=titdet_titmst_id] option:selected").val();	
	var titdet_pgm_id = $("input[name=titdet_pgm_id]").val();	
	
	console.log("titdet_titmst_id>>"+titdet_titmst_id);
	console.log("titdet_pgm_id>>"+titdet_pgm_id);
	var param = {"titdet_titmst_id":titdet_titmst_id, "titdet_pgm_id":titdet_pgm_id}

	

  if (value != '') {
      // 아이디를 서버로 전송 > DB 유효성 검사 > 결과 반환받기
      $.ajax({
      	
      	type:'POST',		
      	data: param,
          url: 'pktitCheck',
          dataType: 'json',
          success: function(result) {
              if (result == '0') {
                  //$('#result').text('사용 가능한 값입니다.');
                  //$("input[name=checked_id]").val('y'); 
              	console.log(">>"+$("input[name=checked_id]").val());
              	
              	
              	$.ajax({
            	      	
           	      	 type:'POST',		
           	          url: 'getpgmList',
           	          data : JSON.stringify(param),
           	          contentType : "application/json; charset=UTF-8",
           	          async: false,
           	          success: function(result) {
           	              
           	        	  
           	        	if(result != null){
           	        		//alert(result.list[0].pgm_id);
           	        		console.log(result);
           	        		console.log(result.list[0].pgm_id);
           	        		
           	        		var c = result.list[0].pgm_create;
           	        		var r = result.list[0].pgm_read;
           	        		var u = result.list[0].pgm_update;
           	        		var d = result.list[0].pgm_delete;

           	        		console.log(c);
           	        		console.log(r);
           	        		console.log(u);
           	        		console.log(d);

           	        		
           	        		
           	        		$("input[name=pgm_create]").val(c);
           	        		$("input[name=pgm_read]").val(r);
           	        		$("input[name=pgm_update]").val(u);
           	        		$("input[name=pgm_delete]").val(d);
           	        		
           	        		
           	        		
           	        		console.log($("input[name=pgm_create]").val()+$("input[name=pgm_read]").val()+$("input[name=pgm_update]").val()+$("input[name=pgm_delete]").val());
           	        		
								
								
								
								$('input[type="checkbox"]').each(function() {
									
									console.log("gg--"+$(this).val());
									console.log("gg >>"+$(this));
									
									if($(this).val() == 1) {
										$(this).prop("checked",true);
										$(this).prop("disabled",false);
									} else {
										$(this).prop("checked",false);
										$(this).prop("disabled",true);
									}

								});
								

								
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
								
								

           				};	

           	          },
           	          error: function(a, b, c) {
           	              console.log(a, b, c);
           	          }
           	 					
           	      });
              	
              	
              } else {
                  $('#result').text('이미 사용중인 값입니다.');
                  $("input[type='checkbox']").prop("disabled",true);
                  $("input[name=checked_id]").val('n'); 
              	console.log(">>"+$("input[name=checked_id]").val());
              }
          },
          error: function(a, b, c) {
              console.log(a, b, c);
          }
 					
      });
 				
  } else {
     $('#result').text('직무코드를 선택해주세요!');
     $('#titmst_id').focus();
     return
  }
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	var ok = ${ok};
	if (ok == false) {
		alert('사용 권한이 없습니다.');location.href='getTitleList';
		$("#crbtn").attr('class','disabled');
	} else {
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
		
		
		if(c == 0) {
			$("#crbtn").attr('class','disabled');
			alert('사용 권한이 없습니다.');location.href='getTitleList';
		} else {
			$("#crbtn").attr('class','btn');
		}
	}
});

$('input[type="checkbox"]').change(function(){
    this.value = (Number(this.checked));
});



	
$("select[name=titdet_titmst_id]").change(function(){

	
	var value = $(this).val();
	console.log("value>>"+value);
	

	var titdet_titmst_id = $("select[name=titdet_titmst_id] option:selected").val();	
	var titdet_pgm_id = $("input[name=titdet_pgm_id]").val();	
	
	console.log("titdet_titmst_id>>"+titdet_titmst_id);
	console.log("titdet_pgm_id>>"+titdet_pgm_id);
	var param = {"titdet_titmst_id":titdet_titmst_id, "titdet_pgm_id":titdet_pgm_id}

	

  if (value != '') {
      // 아이디를 서버로 전송 > DB 유효성 검사 > 결과 반환받기
      $.ajax({
      	
      	type:'POST',		
      	data: param,
          url: 'pktitCheck',
          dataType: 'json',
          success: function(result) {
              if (result == '0') {
                  $('#result').text('사용 가능한 값입니다.');
                  $("input[name=checked_id]").val('y'); 
              	console.log(">>"+$("input[name=checked_id]").val());
              	
              	
              	$.ajax({
            	      	
           	      	 type:'POST',		
           	          url: 'getpgmList',
           	          data : JSON.stringify(param),
           	          contentType : "application/json; charset=UTF-8",
           	          async: false,
           	          success: function(result) {
           	              
           	        	  
           	        	if(result != null){
           	        		//alert(result.list[0].pgm_id);
           	        		console.log(result);
           	        		console.log(result.list[0].pgm_id);
           	        		
           	        		var c = result.list[0].pgm_create;
           	        		var r = result.list[0].pgm_read;
           	        		var u = result.list[0].pgm_update;
           	        		var d = result.list[0].pgm_delete;

           	        		console.log(c);
           	        		console.log(r);
           	        		console.log(u);
           	        		console.log(d);

           	        		
           	        		
           	        		$("input[name=pgm_create]").val(c);
           	        		$("input[name=pgm_read]").val(r);
           	        		$("input[name=pgm_update]").val(u);
           	        		$("input[name=pgm_delete]").val(d);
           	        		
           	        		
           	        		
           	        		console.log($("input[name=pgm_create]").val()+$("input[name=pgm_read]").val()+$("input[name=pgm_update]").val()+$("input[name=pgm_delete]").val());
           	        		
								
								
								
								$('input[type="checkbox"]').each(function() {
									
									console.log("gg--"+$(this).val());
									console.log("gg >>"+$(this));
									
									if($(this).val() == 1) {
										$(this).prop("checked",true);
										$(this).prop("disabled",false);
									} else {
										$(this).prop("checked",false);
										$(this).prop("disabled",true);
									}

								});
								

								
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
								
								

           				};	

           	          },
           	          error: function(a, b, c) {
           	              console.log(a, b, c);
           	          }
           	 					
           	      });
              	
              	
              } else {
                  $('#result').text('이미 사용중인 값입니다.');
                  $("input[type='checkbox']").prop("disabled",true);
                  $("input[name=checked_id]").val('n'); 
              	console.log(">>"+$("input[name=checked_id]").val());
              }
          },
          error: function(a, b, c) {
              console.log(a, b, c);
          }
 					
      });
 				
  } else {
     $('#result').text('직무코드를 선택해주세요!');
     $('#titmst_id').focus();
     return
  }
	  
	  
	  
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
	$//("#titdet_function").val(chk_data);
	$("#titdet_function").val(string_data);
 
}



function regTitledetail() {
	
	
	var form = document.regTitledetailForm;
	
	console.log($("input[name=checked_id]").val());
	
	 if($("input[name='checked_id']").val()=='n'){
      alert('중복된 값이 있습니다.');
      $("input[name='checked_id']").eq(0).focus();
      return false;
  	}
	
	if(${sessionScope.user.user_id != null}){
		var chk = confirm("등록 하시겠습니까?");
		
		if(chk) {
			form.submit();
						
			//$("select[name=titdet_titmst_id] option:eq(0)").prop("selected", true);
			
			$("input[type='checkbox']").prop("checked",false);
			$("input[type='checkbox']").prop("disabled",true);
			//document.getElementById("titdet_pgm_id").value = null; 
			//document.getElementById("pgm_name").value = null; ;
			
			document.getElementById("result").innerHTML="등록이 완료되었습니다.";

		}
	} 	else {
			alert("로그인 해주세요!");
			location.href="login";
	}
		
}
</script>
</html>