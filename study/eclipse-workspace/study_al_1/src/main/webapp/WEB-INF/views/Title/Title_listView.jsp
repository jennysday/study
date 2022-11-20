<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직무별 프로그램 수정 및 삭제</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/blue_style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/green_style.css" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/reset2.css?after" rel="stylesheet" type="text/css">
</head>
<body>
	
<c:set var="ok" value="false"></c:set>
<%-- 
<c:forEach var="i" items="${sessionScope.titleList}">
	
	<c:choose>
		<c:when test="${i eq 'Titl1004'}">
			 <c:out value="${i}"></c:out>
			 <c:set var="ok" value="true"></c:set>
		</c:when>
		
		<c:otherwise>
	    </c:otherwise>
    </c:choose>
</c:forEach>
--%>

<c:forEach var="i" items="${sessionScope.titleFunctionList}">
	
	<c:if test = "${fn:contains(i, 'Titl1004')}">
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
				<ul class="width_li">
					<li><span>Titl1004</span></li>
					<li class="second"><h1>직무별 프로그램 수정 및 삭제</h1></li>
					<li><span>${sessionScope.user.user_name}</span></li>
				</ul>
			</c:if>
			
			<c:if test="${sessionScope.user.user_team == null}">
				<ul>
					<li>--------------</li>
					<li><h1>직무별 프로그램 수정 및 삭제</h1></li>
					<li>--------------</li>
				</ul>
			</c:if>
		</div>
		<!-- 
		<div class="search">
			<div class="search_txt">
				<form action="searchTitleList" method="post" name="searchTitleForm" id="searchTitleForm">
					<span>직무코드 : &nbsp;</span> 
					<input class="underLine" type="text" name="titdet_titmst_id" id="titdet_titmst_id" autocomplete="off">
					<a class="btn" href="javascript:searchTitle()">조회</a>
				</form>
			</div>
		</div>
		 -->
		 
		<div class="search">
			<div class="search_txt">
				<form action="searchTitleList" method="post" name="searchTitleForm" id="searchTitleForm">
						<span>직무코드 : &nbsp;</span> 
						<select name="titdet_titmst_id" class="teamList">
						     <c:forEach var="result" items="${result3.titleMstList}">
						     	<option value="${result.titmst_id}" id="titdet_titmst_id">${result.titmst_id} &nbsp; ${result.titmst_name}</option>
						    </c:forEach>
						 </select>
					<a class="btn" href="javascript:searchTitle()">조회</a>
				</form>
			</div>
		</div>  
		 
		<div class="section title_section">
			<table id="gcTable" class="tablesorter">
				<thead id="table_menu">
					<tr>
						<th>직무코드</th>
						<th>프로그램ID</th>
						<th>프로그램명</th>
						<th>사용기능</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(result.titleList) eq 0}">
							<tr>
								<th colspan="5">게시글이 없습니다.</th>
							</tr> 
						</c:when>
						
						<c:otherwise>
							<c:forEach var="title" items="${result.titleList}">
								<tr id="mouse" onClick="location.href='getTitleListView?titdet_titmst_id=${title.titdet_titmst_id}&titdet_pgm_id=${title.titdet_pgm_id}&page=${result.page}'">
									<td><c:out value="${title.titmst_id}"></c:out></td>
									<td><c:out value="${title.titdet_pgm_id}"></c:out></td>
									<td><c:out value="${title.pgm_name}"></c:out></td>
									<td><c:out value="${title.titdet_function}"></c:out></td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			
			<div class="paging">
				<div>
					<c:if test="${result.page <= 0}">
						<c:set target="${result.page}" property="page" value="1"></c:set>
					</c:if>
					
					<c:if test="${result.page >= result.startPage}">
						<a href="getTitleListView?page=${result.page - 1}">[이전]</a>
					</c:if>
					
					<c:if test="${result.page <= result.endPage}">
						<c:forEach var="pageNum" begin="${result.startPage}" end="${result.endPage}"> 
							<c:choose>
								<c:when test="${pageNum eq result.page}">
									<span>
										<a style="font-weight: bold; color: #1d84df !important;" href="getTitleListView?page=${pageNum}">${pageNum}</a>
									</span>
								</c:when>
								<c:otherwise>
									<a href="getTitleListView?page=${pageNum}">${pageNum}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<c:if test="${result.page < result.endPage}">
							<a href="getTitleListView?page=${result.page + 1}">[다음]</a>
						</c:if>
					</c:if>
				</div>
			</div>
		</div>
		
				
		<iframe name="iframe" style="display:none;"></iframe>
		<div class="section">
			<form action="updateTitle" method="post" name="TitleForm" id="TitleForm" target="iframe">
				<table class="table_left">
					<tr>
						<th>프로그램ID</th>
						<td class="left"><c:out value="${result2.title.pgm_id}"></c:out></td>
						<td> <input type="hidden" name="titdet_titmst_id" id="titdet_titmst_id" value="${result2.title.titdet_titmst_id}"> </td>
						<td> <input type="hidden" name="titdet_pgm_id" id="titdet_pgm_id" value="${result2.title.titdet_pgm_id}"> </td>
					</tr>
					<tr>
						<th><label for="pgm_name">프로그램명</label></th>
						<td class="left"><c:out value="${result2.title.pgm_name}"></c:out></td>
					</tr>
					
					<tr>
						<th><span><label for="pgm_function">사용기능</label></span></th>
						<td class="le_td">
							<span class="pg_box">
								<label for="pgm_create">입력</label>
								<!-- <input type="checkbox" id="pgm_create" name="pgm_function" value="입력" onclick='getCheckboxValue(event)'>  -->
								<input type="checkbox" id="pgm_create" name="pgm_create" onclick='getCheckboxValue(event)' value="${result2.title.pgm_create}">
								
								<label for="pgm_read">조회</label>
								<!-- <input type="checkbox" id="pgm_read" name="pgm_function" value="조회" onclick='getCheckboxValue(event)'> --> 
								<input type="checkbox" id="pgm_read" name="pgm_read" onclick='getCheckboxValue(event)' value="${result2.title.pgm_read}">
								
								<label for="pgm_update">수정</label>
								<!-- <input type="checkbox" id="pgm_update" name="pgm_function" value="수정" onclick='getCheckboxValue(event)'> --> 
								<input type="checkbox" id="pgm_update" name="pgm_update" onclick='getCheckboxValue(event)' value="${result2.title.pgm_update}">
								
								<label for="pgm_delete">삭제</label>
								<!-- <input type="checkbox" id="pgm_delete" name="pgm_function" value="삭제" onclick='getCheckboxValue(event)'> --> 
								<input type="checkbox" id="pgm_delete" name="pgm_delete" onclick='getCheckboxValue(event)' value="${result2.title.pgm_delete}">
							</span>
						</td>
						
						
					</tr>
					
					
					<tr>
						<th>프로그램 기능</th>
						<td>${result2.title.pgm_create}${result2.title.pgm_read}${result2.title.pgm_update}${result2.title.pgm_delete}</td>
					</tr>


					<tr>
						<th>선택 기능</th>
						<td><input type="text" class="input_no" name="titdet_function" id="titdet_function" value="${result2.title.titdet_function}" readonly="readonly"> </td>
					</tr>
					
					<tr>
						<th>최종사용자</th>
						<td><input type="hidden" name="titdet_user_id" id="titdet_user_id" value="${sessionScope.user.user_id}">${result2.title.titdet_user_id}</td>
					</tr>
				</table>
				
				<div class="btn_box">
					<div>
						<ul>
							<li><a href="getTitleList" class="btn">종료</a></li>
							<li><a href="javascript:delTitle()" class="btn" id="delbtn">삭제</a></li>
							<li><a href="javascript:updateTitle()" class="btn" id="upbtn">수정</a></li>
							<!-- <li><input type="submit" value="수정" class="btn"></li> -->
						</ul>
					</div>
				</div>
			</form>
		</div>	
		<div class="msg_listView">
		<div class="msg_list">
			<c:if test="${sessionScope.user.user_id != null}">
				<p class="msg_list_p">MSG :<span id="result"></span></p>
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


	$('input[type="checkbox"]').each(function() {
		
		console.log("gg--"+$(this).val());
		console.log("gg >>"+$(this));
		
		if($(this).val() == 1) {
			$(this).prop("disabled",false);
		} else {
			$(this).prop("disabled",true);
		}

	});


	var titdet_function = $("#titdet_function").val();
	console.log("titdet_function>>"+titdet_function);
	
	var c = titdet_function.substring(0,1);
	var r = titdet_function.substring(1,2);
	var u = titdet_function.substring(2,3);
	var d = titdet_function.substring(3,4);
	
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
		} else {
			$(this).prop("checked",false);
		}

	});


	var ok = ${ok};
	if (ok == false) {
		alert('사용 권한이 없습니다.');location.href='getTeamList';
		$("#upbtn").attr('class','disabled');
		$("#delbtn").attr('class','disabled');
	} else {

       	var titdet_function = $("#function").val();
   		titdet_function = titdet_function.toString();
   		console.log("titdet_function>>"+titdet_function);
   		
   		var c = titdet_function.substring(0,1);
   		var r = titdet_function.substring(1,2);
   		var u = titdet_function.substring(2,3);
   		var d = titdet_function.substring(3,4);
   		
   		console.log("c"+c);
   		console.log("r"+r);
   		console.log("u"+u);
   		console.log("d"+d);


   		if(u == 0 && d == 0) {
   			alert('사용 권한이 없습니다.');location.href='getTeamList';
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
	document.getElementById('result').innerText = "선택된 기능  - "+ string_data;
	//$("#titdet_function").val(chk_data);
	//$("#titdet_function").val(string_data);
	$('input[name=titdet_function]').attr('value',string_data);
 
}



	
	function searchTitle() {
		var form = document.searchTitleForm;
		form.submit();
	}

	
	
	
	function updateTitle() {
		
	var form = document.TitleForm; 
		
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
	
	function delTitle() {
		var form = document.TitleForm;
		
		if(${sessionScope.user.user_id != null}){
			var chk = confirm("정말 삭제하시겠습니까?");
			if(chk) {
				location.href="delTitle?titdet_titmst_id=${result2.title.titdet_titmst_id}&titdet_pgm_id=${result2.title.titdet_pgm_id}";
			}	
		} else {
			alert("로그인 해주세요!");
			location.href="login";
		}
			
	}

</script>
</html>