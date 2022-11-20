<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<link href="${pageContext.request.contextPath}/resources/css/reset.css?after" rel="stylesheet" type="text/css">
</head>
<body>

	<div class="wrap">
		<div class="header">
			<ul>
				<li>--------------</li>
				<li><h1>권한 관리 로그인</h1></li>
				<li>--------------</li>
			</ul>
		</div>
	
	
	<div class="section_login">
		<div class="login_center">
		<c:choose>
			<c:when test="${empty sessionScope.userId}">
			<!-- 로그인이 안되어 있으면 -->
				<form id="loginFrm" name="loginFrm" action="loginCheck">
					<table>
						<tr>
							<th>아이디</th>
							<td><input type="text" name="user_id" id="user_id" maxlength="10" autocomplete="off"></td>
						</tr>
						<tr>
							<th>패스워드</th>
							<td><input type="password" name="user_pswd" id="user_pswd" maxlength="20" autocomplete="new-password"></td>
						</tr>
						<%-- 
						<c:if test="${msg == '실패'}">
							<tr>
								<td colspan=2>
									아이디 또는 패스워드가 틀렸습니다.
								</td>
							</tr>
						</c:if>
						--%>
					</table>
					<div class="login_btn">
						<div>
							<a type="button" id="login" class="btn" >로그인</a>
						</div>
					</div>
				</form>
			</c:when>
			<c:otherwise>
				<div class="result_page">
					<h3>${sessionScope.userId}님 환영합니다.</h3>
					<a href="logout" class="btn">로그아웃</a>
				</div>
			</c:otherwise>
		</c:choose>
		</div>
	</div>
	<div class="msg">
		<p>MSG : 등록된 사용자가 아닙니다.
		</p>
	</div>
</div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(e){
		$('#login').click(function(){

			// 입력 값 체크
			if($.trim($('#user_id').val()) == ''){
				alert("아이디를 입력해 주세요.");
				$('#user_id').focus();
				return;
			}else if($.trim($('#user_pswd').val()) == ''){
				alert("패스워드를 입력해 주세요.");
				$('#user_pswd').focus();
				return;
			}
			
			//전송
			$('#loginFrm').submit();
		});
		
	});
</script>
</html>