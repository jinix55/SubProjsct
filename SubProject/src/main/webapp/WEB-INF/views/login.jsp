<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>SIGN IN | PPlus</title>
<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet" href="/css/reset.css">
<script type="text/javascript" src="/js/plugins/jquery-3.5.1.js"></script>
<script type="text/javascript" src="/js/plugins/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/plugins/datepicker/datepicker.min.js"></script>
<script type="text/javascript" src="/js/plugins/bootstrap.min.js"></script>
</head>

<script>
	$(function() {
		// 	let userInfo = '${userInfo}';
		// 	console.log(userInfo);
		// 	if (userInfo) {
		// 		$("#userId").val(userInfo);
		// 		$("#sso").val("Y");
		// 		$("#frm").submit();
		// 	}

		let msgs = '${result}'.split("|")[1];
		let init = '${result}'.split("|")[0];
		let msg;
		if (msgs) {
			msg = msgs.split("\n");
		}
		if (msg) {
			msg.forEach(function(text, index) {
				$('.login_info li.msg' + index).text(msg[index]);
			});
			$('.login_info').show();
			if (init == 2) {
				$('.init').show();
			}
			if (init == 3) {
				$('.init_a').show();
			}
		}

		//엔터키
		$('#userPwd').on('keyup', function(e) {
			if (e.which == 13) {
				loginAction();
			}
		});

		//엔터키
		$('#userPwdNew').on('keyup', function(e) {
			if (e.which == 13) {
				pwdChange();
			}
		});

		//엔터키
		$('#userPwdOld').on('keyup', function(e) {
			if (e.which == 13) {
				pwdChange();
			}
		});

		//엔터키
		$('#userIdInit').on('keyup', function(e) {
			if (e.which == 13) {
				pwdChangeInit();
			}
		});

	});

	let dbclick = 'Y';
	function loginAction() {
		if (dbclick != 'Y') {
			return;
		}
		dbclick = 'N';
		var userId = document.getElementById("userId").value;
		var userPwd = document.getElementById("userPwd").value;
		if (userId == null || userId == '') {
			alert("사번을 입력해 주세요.");
			document.getElementById("userId").focus();
			dbclick = 'Y';
			return;
		}
		if (userPwd == null || userPwd == '') {
			alert("비밀번호를 입력해 주세요.");
			document.getElementById("userPwd").focus();
			dbclick = 'Y';
			return;
		}
		document.getElementById('frm').submit();
	}

	function pwdChangeInitView() {
		$('.login').hide();
		$('.pass_change').show();
	}
	
	function cancle() {
		$('.login').show();
		$('.pass_change').hide();
	}

	function pwdChange() {
		if (dbclick != 'Y') {
			return;
		}
		dbclick = 'N';
		var userId = document.getElementById("userIdChange").value;
		var userPwdOld = document.getElementById("userPwdOld").value;
		var userPwdNew = document.getElementById("userPwdNew").value;
		if (userId == null || userId == '') {
			alert("사번을 입력해 주세요.");
			document.getElementById("userIdChange").focus();
			dbclick = 'Y';
			return;
		}
		if (userPwdOld == null || userPwdOld == '') {
			alert("현재 비밀번호를 입력해 주세요.");
			document.getElementById("userPwdOld").focus();
			dbclick = 'Y';
			return;
		}

		if (userPwdNew == null || userPwdNew == '') {
			alert("변경할 비밀번호를 입력해 주세요.");
			document.getElementById("userPwdNew").focus();
			dbclick = 'Y';
			return;
		}
		var form = document.createElement("form");
		form.setAttribute("charset", "UTF-8");
		form.setAttribute("method", "Post");
		form.setAttribute("action", "/login/pwdChange");

		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "userId");
		hiddenField.setAttribute("value", userId);
		form.appendChild(hiddenField);

		hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "userPwdOld");
		hiddenField.setAttribute("value", userPwdOld);
		form.appendChild(hiddenField);

		hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "userPwdNew");
		hiddenField.setAttribute("value", userPwdNew);
		form.appendChild(hiddenField);

		document.body.appendChild(form);
		alert('변경 완료되었습니다.');
		form.submit();
	}

	function pwdChangeInit() {
		if (dbclick != 'Y') {
			return;
		}
		dbclick = 'N';
		var userId = document.getElementById("userIdInit").value;
		if (userId == null || userId == '') {
			alert("사번을 입력해 주세요.");
			document.getElementById("userIdInit").focus();
			dbclick = 'Y';
			return;
		}
		var form = document.createElement("form");
		form.setAttribute("charset", "UTF-8");
		form.setAttribute("method", "Post");
		form.setAttribute("action", "/login/pwdChangeInit");

		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "userId");
		hiddenField.setAttribute("value", userId);
		form.appendChild(hiddenField);

		document.body.appendChild(form);

		form.submit();
	}
</script>
<body>
	<div id="wrap">
		<div class="login">
			<h2 class="title">PPlus Echo</h2>
			<div class="login_form">
				<form id="frm" action="/lgn" method="post">
					<div class="h_45px id_box">
						<div class="h_45px">
							<input type="text" id="userId" name="userId"
								placeholder="아이디을 입력하세요.">
						</div>
					</div>
					<div class="pw_box">
						<div>
							<input type="password" id="userPwd" name="userPwd"
								placeholder="비밀번호을 입력하세요.">
						</div>
					</div>
					<div class="stn_btm">
						<div class="btn_cont center">
							<button type="button" class="btn_register"
								onclick="loginAction();">들어가기</button>
						</div>
					</div>
					<div class="stn_btm">
						<div class="btn_cont center">
							<button type="button" class="btn_default ml_6px"
								onclick="pwdChangeInitView();">패스워드 초기화 신청</button>
						</div>
					</div>
				</form>
			</div>
		</div>
		<div class="login pass_change" style="display: none;">
			<h2 class="title">초기화 신청</h2>
			<div class="login_form">
				<form>
					<div class="h_45px id_box">
						<div class="h_45px">
							<input type="text" id="pw_companyNm" name="pw_companyNm"
								placeholder="회사명을 입력하세요.">
						</div>
					</div>
					<div class="h_45px id_box">
						<div class="h_45px">
							<input type="text" id="pw_userNm" name="pw_userNm"
								placeholder="성명을 입력하세요.">
						</div>
					</div>
					<div class="h_45px id_box">
						<div class="h_45px">
							<input type="text" id="pw_userId" name="pw_userId"
								placeholder="아이디을 입력하세요.">
						</div>
					</div>
					<span style="color:red;">한번 신청을 진행하시면 취소가 불가합니다.</span>
					<div class="stn_btm">
						<div class="btn_cont center">
							<button type="button" class="btn_register" style="margin-right:10px"
								onclick="resetPassword();">신청하기</button>
							<button type="button" class="btn_register"
								onclick="cancle();">취소</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
