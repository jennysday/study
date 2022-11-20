<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href="${pageContext.request.contextPath}/resources/css/reset.css?after" rel="stylesheet" type="text/css">

</head>
<body>
	<div class="wrap">
		<div class="header">
			<ul>
				<li>--------------</li>
				<li><h1>로그인 페이지</h1></li>
				<li>--------------</li>
			</ul>
		</div>
	
		<form id="signFrm" name="signFrm" action="signUp">
			<table>
				<tbody>
					<tr>
						<td>아이디</td>
						<td><input type="text" id="user_id" name="user_id" ></td>
						<td><input type="button" id="check" value="중복체크"></td>
					</tr>
					<tr>
						<td colspan=3 id="idCheck"></td>
					</tr>
					<tr>
						<td>패스워드</td>
						<td colspan="2"><input id="user_pswd" name="user_pswd" type="password"></td>
					</tr>
					<tr>
						<td>패스워드 확인</td>
						<td colspan="2"><input id="passwdCheck" name="passwdCheck" type="password"></td>
					</tr>
					
					<tr>
						<td colspan="3"><input type="button" id="signUp" value="회원가입"></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(e){
		
		var idx = false;
		
		$('#signUp').click(function(){
			if($.trim($('#user_id').val()) == ''){
				alert("아이디 입력.");
				$('#user_id').focus();
				return;
			}else if($.trim($('#user_pswd').val()) == ''){
				alert("패스워드 입력.");
				$('#user_pswd').focus();
				return;
			}
			//패스워드 확인
			else if($('#user_pswd').val() != $('#passwdCheck').val()){
				alert('패스워드가 다릅니다.');
				$('#user_pswd').focus();
				return;
			}
			
			if(idx==false){
				alert("아이디 중복체크를 해주세요.");
				return;
			}else{
				$('#signFrm').submit();
			}
		});
		
		$('#check').click(function(){
			$.ajax({
				url: "${pageContext.request.contextPath}/idCheck",
				type: "GET",
				data:{
					"userId":$('#user_id').val()
				},
				success: function(data){
					if (data == 0 && $.trim($('#user_id').val()) != '' ) {
						idx=true;
						$('#user_id').attr("readonly",true);
						var html="<tr><td colspan='3' style='color: green'>사용가능</td></tr>";
						$('#idCheck').empty();
						$('#idCheck').append(html);
					}
					else {

						var html="<tr><td colspan='3' style='color: red'>사용불가능한 아이디 입니다.</td></tr>";
						$('#idCheck').empty();
						$('#idCheck').append(html);
					}
				},
				error: function(){
					alert("서버에러");
				}
			});
			

		});
		
	});
</script>
</html>