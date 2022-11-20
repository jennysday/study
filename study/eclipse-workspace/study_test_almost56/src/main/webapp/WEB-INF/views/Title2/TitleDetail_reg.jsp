<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<html>
<head>
<meta charset="UTF-8">
<title>직무 상세 등록</title>

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
					<li><h1>직무 상세 등록</h1></li>
					<li><span>${sessionScope.user.user_name}</span></li>
				</ul>
			</c:if>
			
			<c:if test="${sessionScope.user.user_team == null}">
				<ul>
					<li>--------------</li>
					<li><h1>직무 상세 등록</h1></li>
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
							     	<option value="${result.titmst_id}" id="titdet_titmst_id">${result.titmst_id}  ${result.titmst_name}</option>
							    </c:forEach>
							 </select>
						</td>
					</tr>
					
					<tr>
						<th><span><label for="team_upteam">프로그램ID</label></span></th>
						<td class="left">
							<select name="titdet_pgm_id" class="teamList">
							     <c:forEach var="result" items="${result2.programList}">
							     	<option value="${result.pgm_id}" id="titdet_pgm_id">${result.pgm_id}  ${result.pgm_name}</option>
							    </c:forEach>
							 </select>
						</td>
					</tr>

					<tr>
						<th><span><label for="titdet_function">주요 기능</label></span></th>
						<td class="pg_box">
						
							<!-- 아이디 중복 체크 여부 -->
				            <input type="hidden" name="checked_id" value="n">
				            
							<label for="pgm_create">입력</label>
							<!-- <input type="checkbox" id="pgm_create" name="pgm_function" value="입력" onclick='getCheckboxValue(event)'>  -->
							<input type="checkbox" id="pgm_create" name="pgm_create"  onclick='getCheckboxValue(event)' disabled="disabled">
							
							<label for="pgm_read">조회</label>
							<!-- <input type="checkbox" id="pgm_read" name="pgm_function" value="조회" onclick='getCheckboxValue(event)'> --> 
							<input type="checkbox" id="pgm_read" name="pgm_read" onclick='getCheckboxValue(event)' disabled="disabled">
							
							<label for="pgm_update">수정</label>
							<!-- <input type="checkbox" id="pgm_update" name="pgm_function" value="수정" onclick='getCheckboxValue(event)'> --> 
							<input type="checkbox" id="pgm_update" name="pgm_update" onclick='getCheckboxValue(event)' disabled="disabled">
							
							<label for="pgm_delete">삭제</label>
							<!-- <input type="checkbox" id="pgm_delete" name="pgm_function" value="삭제" onclick='getCheckboxValue(event)'> --> 
							<input type="checkbox" id="pgm_delete" name="pgm_delete" onclick='getCheckboxValue(event)' disabled="disabled">
						</td>
						<td><input type="hidden" name="titdet_function" id="titdet_function" name="titdet_function"> </td>
						
						<td><input type="hidden" name="titdet_user_id"class="box" value="${sessionScope.user.user_id}"></td>
					</tr>

				</table>
				<div class="btn_box_reg">
					<div>
						<ul>
							<li><a href="getTitleList" class="btn">종료</a></li>
							<li><a href="javascript:regTitledetail()" class="btn">등록</a></li>
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

$("select[name=titdet_titmst_id]").change(function(){
	  //console.log($(this).val()); //value값 가져오기
	  //console.log($("select[name=location] option:selected").text()); //text값 가져오기
	  
	/*  
	var value = $(this).val();
	  
	console.log(">>value"+value); 
	
	// Get form
	var form = $('#regTitledetailForm')[0];
	  
	// Create an FormData object 
	var data = new FormData(form);
	
	// FormData의 key 확인
	for (var key of data.keys()) {
	     console.log("key "+key);
	}
	            
	// FormData의 value 확인
	for (var value of data.values()) {
	     console.log("value "+value);
	}
	*/
	
	var value = $(this).val();
	console.log("value>>"+value);
	

	var titdet_titmst_id = $("select[name=titdet_titmst_id] option:selected").val();	
	var titdet_pgm_id = $("select[name=titdet_pgm_id] option:selected").val();	
	
	//var titdet_titmst_id = $("select[name=titdet_titmst_id] option:selected").text();	
	//var titdet_pgm_id = $("select[name=titdet_pgm_id] option:selected").text();	
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
       // alert('부서코드를 입력하세요.');
       $('#result').text('직무코드를 선택해주세요!');
       $('#titmst_id').focus();
       return
    }
	  
	  
	  
});




$("select[name=titdet_pgm_id]").change(function(){
	//console.log($(this).val()); //value값 가져오기
	//console.log($("select[name=location] option:selected").text()); //text값 가져오기

	
	var value = $(this).val();
	console.log("value>>"+value);
	

	var titdet_titmst_id = $("select[name=titdet_titmst_id] option:selected").val();	
	var titdet_pgm_id = $("select[name=titdet_pgm_id] option:selected").val();	
	
	//var titdet_titmst_id = $("select[name=titdet_titmst_id] option:selected").text();	
	//var titdet_pgm_id = $("select[name=titdet_pgm_id] option:selected").text();	
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
          async: false,
          success: function(result) {
              if (result == '0') {
                  $('#result').text('사용 가능한 값입니다.2');
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
                  $('#result').text('이미 사용중인 값입니다.2');
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
     // alert('부서코드를 입력하세요.');
     $('#result').text('프로그램 아이디를 선택해주세요!');
     $('#titdet_pgm_id').focus();
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
						
			$("select[name=titdet_titmst_id] option:eq(0)").prop("selected", true);
			$("select[name=titdet_pgm_id] option:eq(0)").prop("selected", true);
			
			$("input[type='checkbox']").prop("checked",false);
			$("input[type='checkbox']").prop("disabled",true);
			
			document.getElementById("result").innerHTML="등록이 완료되었습니다.";

		}
	} 	else {
			alert("로그인 해주세요!");
			location.href="login";
	}
		
}
</script>
</html>