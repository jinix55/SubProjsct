<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String serverName = request.getServerName();
	String subdomain = "";
	if(serverName.contains(".")) {
		subdomain = serverName.split("\\.")[0];
	}else {
		subdomain = "";
	}
	if("www".equals(subdomain)) {
		subdomain = "";
	}
	System.out.println(subdomain);
	pageContext.setAttribute("subdomain", subdomain);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="/css/style.css">
<script type="text/javascript" src="/js/plugins/jquery-3.5.1.js"></script>
<script type="text/javascript" src="/js/plugins/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/plugins/bootstrap.min.js"></script>
<script type="text/javascript" src="/js/plugins/iscroll.js"></script><!-- lnb메뉴스크롤-->
<title>'PPLUS Echo'(친환경 통합관리 서비스)</title>
</head>

<script>
	$(function() {
		//Logo 조회
		var companyCode = '${subdomain}';
		if(companyCode !== '') {
			$.ajax({
			    type : 'get',
			    url : '/api/v1/company/'+companyCode+'/logo/',
			    data : {},
			    dataType : 'text',
			    error: function(xhr, status, error){
			        console.log(error);
			    },
			    success : function(result){
			    	console.log(result);
			    	$('#logonLogo').attr("src", "/api/v1/company/file/view/"+result);
			    }
			});
		}
		// 	let userInfo = '${userInfo}';
		// 	console.log(userInfo);
		// 	if (userInfo) {
		// 		$("#userId").val(userInfo);
		// 		$("#sso").val("Y");
		// 		$("#frm").submit();
		// 	}
		$('.pwdMgt').hide();
		$('.pass_reset').hide();
		$('.pass_change').hide();
		let msgs = '${result}'.split("|")[1];
		let init = '${result}'.split("|")[0];
		let resetRes = '${resetRes}';
		let changeRes = '${changeRes}';
		let msg;
		if (msgs) {
			msg = msgs.split("\n");
		}
		if (msg) {
			msg.forEach(function(text, index) {
				$('.error_text li.msg' + index).text(msg[index]);
			});
			$('.error_text').show();
// 			$('.last.init').hide();
			if(init == 1){
				$('.pwdMgt').show();
				$('.last.change').hide();
				$('.last.init').show();
			}
			if(init == 2){
				$('.pwdMgt').show();
				$('.last.init').hide();
				$('.last.change').show();
			}
		}
		
		if (!msg && init) {
			$('.error_text li.msg0').text(init);
			$('.pwdMgt').show();
			$('.error_text').show();
		}
		
		if(resetRes != '' && resetRes != undefined){
			$('#re_companyNm').val('');
			$('#re_userId').val('');
			$('#re_userNm').val('');
			alert(reset);
			location.href = "/login";
		}
		
		if(changeRes != '' && changeRes != undefined){
			$('.pwdMgt').hide();
			$('.login').hide();
			$('.pass_reset').hide();
			$("#ch_userId").val("");
			$("#ch_pwdOld").val("");
			$("#ch_pwdNew").val("");
			$('.pass_change').show();
			$('.chMsg').text(changeRes);
		}

		//엔터키
		$('#userPwd').on('keyup', function(e) {
			if (e.which == 13) {
				loginAction();
			}
		});

		//엔터키
		$('#ch_pwdNew').on('keyup', function(e) {
			if (e.which == 13) {
				pwdChange();
			}
		});

		//엔터키
		$('#re_userNm').on('keyup', function(e) {
			if (e.which == 13) {
				resetPassword();
			}
		});

	});

	let dbclick = 'Y';
	function loginAction() {
		if (dbclick != 'Y') {
			return;
		}
		dbclick = 'N';
		var userId = document.getElementById("inputUserId").value;
		var userPwd = document.getElementById("userPwd").value;
		if (userId == null || userId == '') {
			alert("사번을 입력해 주세요.");
			document.getElementById("inputUserId").focus();
			dbclick = 'Y';
			return;
		}
		if (userPwd == null || userPwd == '') {
			alert("비밀번호를 입력해 주세요.");
			document.getElementById("userPwd").focus();
			dbclick = 'Y';
			return;
		}
		
		var subdomain = '${subdomain}';
		if(subdomain !== '') {
			$('#userId').val(userId+"@"+subdomain.toUpperCase());
		}else {
			$('#userId').val(userId+"@PPLUS");
		}
		console.log($('#userId').val());
		document.getElementById('frm').submit();
	}

	function pwdChangeInitView() {
		$('.login').hide();
		$('.pass_reset').show();
		$('.pass_change').hide();
	}
	
	function pwdChangeView() {
		$('.login').hide();
		$('.pass_reset').hide();
		$("#ch_userId").val("");
		$("#ch_pwdOld").val("");
		$("#ch_pwdNew").val("");
		$('.pass_change').show();
	}
	
	function cancel() {
		$('.login').show();
		$('.pass_reset').hide();
		$('.pass_change').hide();
	}

	function resetPassword() {
		if (dbclick != 'Y') {
			return;
		}
		dbclick = 'N';
		var re_companyNm = document.getElementById("re_companyNm").value;
		var re_userId = document.getElementById("re_userId").value;
		var re_userNm = document.getElementById("re_userNm").value;
		
		if (re_companyNm == null || re_companyNm == '') {
			alert("회사명을 입력해 주세요.");
			document.getElementById("userIdInit").focus();
			dbclick = 'Y';
			return;
		}
		
		if (re_userId == null || re_userId == '') {
			alert("아이디을 입력해 주세요.");
			document.getElementById("userIdInit").focus();
			dbclick = 'Y';
			return;
		}
		
		if (re_userNm == null || re_userNm == '') {
			alert("성명을 입력해 주세요.");
			document.getElementById("userIdInit").focus();
			dbclick = 'Y';
			return;
		}
		
		document.getElementById('resetForm').submit();
	}
	
	function changePassword(){
		if (dbclick != 'Y') {
			return;
		}
		dbclick = 'N';
		var userId = document.getElementById("ch_userId").value;
		var userPwdOld = document.getElementById("ch_pwdOld").value;
		var userPwdNew = document.getElementById("ch_pwdNew").value;
		if(userId == null || userId == ''){
			alert("아이디을 입력해 주세요.");
			document.getElementById("ch_userId").focus();
			dbclick = 'Y';
			return;
		}
		if(userPwdOld == null || userPwdOld == ''){
			alert("현재 비밀번호를 입력해 주세요.");
			document.getElementById("ch_pwdOld").focus();
			dbclick = 'Y';
			return;
		}
		
		if(userPwdNew == null || userPwdNew == ''){
			alert("변경할 비밀번호를 입력해 주세요.");
			document.getElementById("ch_pwdNew").focus();
			dbclick = 'Y';
			return;
		}
		document.getElementById('changeForm').submit();
	}
</script>
<body>
	<div class="wrapper">
		<!-- S_본문-->
		<section class="container">
			<div class="logon-logo"><img id="logonLogo" src="/images/${subdomain}logo_03.png" alt="회사로고" style="width:140px;" onerror="if (this.src != 'error.jpg') this.src = 'error.jpg';"></div>
<!-- 			<h2 class="com-title" style="margin-bottom:20px;">희성전자</h2> -->
			<div class="login-tltle login" style="margin-bottom:20px;">로그인</div>
			<div class="login-tltle pass_reset" style="margin-bottom:20px;">비밀번호 초기화</div>
			<div class="login-tltle pass_change" style="margin-bottom:20px;">비밀번호 변경</div>
			<div class="login-content login">
				<div class="login-form">
					<form id="frm" action="/lgn" method="post">
						<div class="login-id h45">
							 <input type="hidden" id="userId" name="userId">
							 <input type="text" class="text-input pl35" id="inputUserId" name="inputUserId" placeholder="아이디을 입력하세요.">
						</div>
						<div class="login-pw h45">
							 <input type="password" class="text-input pl35" id="userPwd" name="userPwd" placeholder="비밀번호을 입력하세요.">
						</div>
						<div class="error_text" style="margin-top:10px; margin-bottom:10px;">
							<span style="color:red;"></span>
							<ul>
								<li class="msg0" style="color:red;"></li>
								<li class="msg1" style="color:red;"></li>
								<li class="msg2" style="color:red;"></li>
							</ul>
						</div>
						<div class="btn-group">
							<button type="button" class="button btn-success w100" onclick="loginAction();">확인</button>
							<ul class="pwdMgt">
								<li class="last init" onclick="pwdChangeInitView();"><a href="javascript:void(0);">비밀번호 초기화 신청</a></li>
								<li class="last change" onclick="pwdChangeView();" style="display:none;" ><a href="javascript:void(0);">비밀번호 변경</a></li>
							</ul>
						</div>
					</form>
				</div>
			</div>
			
			<div class="login-content pass_reset" style="display: none;">
				<div class="login-form">
					<form id="resetForm" action="/login/pwdChangeInit" method="post">
						<div class="login-id h45">
							 <input type="text" class="text-input pl35" id="re_companyNm" name="re_companyNm" placeholder="회사명을 입력하세요.">
						</div>
						<div class="login-pw h45">
							 <input type="text" class="text-input pl35" id="re_userId" name="re_userId" placeholder="아이디을 입력하세요.">
						</div>
						<div class="login-pw h45">
							 <input type="text" class="text-input pl35" id="re_userNm" name="re_userNm" placeholder="비밀번호을 입력하세요.">
						</div>
						<div style="margin-top:10px; margin-bottom:10px;">
							<span style="color:red;">한번 신청을 진행하시면 취소가 불가합니다.</span>
						</div>
						<div class="btn-group">
							<button type="button" class="button btn-success w100" onclick="resetPassword();">신청하기</button>
							<ul>
								<li class="last change" onclick="cancel();"><a href="javascript:void(0)">취소</a></li>
							</ul>
						</div>
					</form>
				</div>
			</div>
			
			<div class="login-content pass_change" style="display: none;">
				<div class="login-form">
					<form id="changeForm" action="/login/pwdChange" method="post">
						<div class="login-id h45">
							 <input type="text" class="text-input pl35" id="ch_userId" name="ch_userId" placeholder="아이디을 입력하세요.">
						</div>
						<div class="login-pw h45">
							 <input type="password" class="text-input pl35" id="ch_pwdOld" name="ch_pwdOld" placeholder="현재 비밀번호을 입력하세요.">
						</div>
						<div class="login-pw h45">
							 <input type="password" class="text-input pl35" id="ch_pwdNew" name="ch_pwdNew" placeholder="현경하실 비밀번호을 입력하세요.">
						</div>
						<div style="margin-top:10px; margin-bottom:10px;">
							<span class="chMsg" style="color:red;"></span>
						</div>
						<div class="btn-group">
							<button type="button" class="button btn-success w100" onclick="changePassword();">변경하기</button>
							<ul>
								<li class="last change" onclick="cancel();"><a href="javascript:void(0)">취소</a></li>
							</ul>
						</div>
					</form>
				</div>
			</div>
			<div class="mt10 desc02">Copyright© PPlusEco. All Rights Reserved.</div>
		</section>
	  <!-- E_본문-->
	</div>
</body>
</html>
