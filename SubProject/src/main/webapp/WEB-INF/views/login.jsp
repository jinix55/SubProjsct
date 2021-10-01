<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>SIGN IN | 알티데이터랩</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon">
	<link href="/css/common.css" rel="stylesheet" type="text/css" />
    <link href="/webjars/jquery-ui/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/jquery-ui/jquery-ui.min.js"></script>
	<script src="/js/common.js"></script>
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
	if(msgs){
		msg = msgs.split("\n");
	}
	if (msg) {
		msg.forEach(function(text,index){
			$('.login_info li.msg'+index).text(msg[index]);
		});
		$('.login_info').show();
		if(init == 2){
			$('.init').show();
		}
		if(init == 3){
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
	if(userId == null || userId == ''){
		alert("사번을 입력해 주세요.");
		document.getElementById("userId").focus();
		dbclick = 'Y';
		return;
	}
	if(userPwd == null || userPwd == ''){
		alert("비밀번호를 입력해 주세요.");
		document.getElementById("userPwd").focus();
		dbclick = 'Y';
		return;
	}
	document.getElementById('frm').submit();
}

function pwdChangeView() {
	$('.login_dl').hide();
	$('.pass_change').show();
}

function pwdChangeInitView() {
	$('.login_dl').hide();
	$('.pass_change_init').show();
}

function pwdChange(){
	if (dbclick != 'Y') {
		return;
	}
	dbclick = 'N';
	var userId = document.getElementById("userIdChange").value;
	var userPwdOld = document.getElementById("userPwdOld").value;
	var userPwdNew = document.getElementById("userPwdNew").value;
	if(userId == null || userId == ''){
		alert("사번을 입력해 주세요.");
		document.getElementById("userIdChange").focus();
		dbclick = 'Y';
		return;
	}
	if(userPwdOld == null || userPwdOld == ''){
		alert("현재 비밀번호를 입력해 주세요.");
		document.getElementById("userPwdOld").focus();
		dbclick = 'Y';
		return;
	}
	
	if(userPwdNew == null || userPwdNew == ''){
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

function pwdChangeInit(){
	if (dbclick != 'Y') {
		return;
	}
	dbclick = 'N';
	var userId = document.getElementById("userIdInit").value;
	if(userId == null || userId == ''){
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
<body <c:if test='${not empty userInfo}'>style="display:none;"</c:if>>
	<div class="login login_admin">
		<div class="login_con">
			<div class="login_dl">
				<dl>
					<dt class="logo">
<!-- 						<img src="/images/logo_text.png"/> -->
					</dt>
					<dd>
						<form id="frm" action="/lgn" method="post">
						<div class="inputBox">
							<label for="userId" class="hidden">ID</label>
							<span>ID</span>
							<input type="text" class="input" id="userId" name="userId" placeholder="사번" />
						</div>
						<div class="inputBox">
							<label for="userPwd" class="hidden">PASS</label>
							<span>PASS</span>
							<input type="password" class="input" id="userPwd" name="userPwd" placeholder="비밀번호" />
						</div>
						<div class="btn_wrap set_logo">
							<!-- <img src="/images/logo.png"/> --><input class="btn purple full" type="button" value="Login" onclick="loginAction();">
						</div>
 						<div class="login_info" style="display:none;">
<!--  						<div class="login_info" > -->
	 						<div class="error_text">
								<ul>
									<li class="msg0 classColor red"></li>
									<li class="msg1 classColor red"></li>
									<li class="msg2 classColor red"></li>
								</ul>
							</div>						
							<div class="init" style="display:none;" >
<!-- 							<div class="init"> -->
								<a onclick="pwdChangeView()" href="javascript:void(0)">[변경]</a>
							</div>
							<div class="init_a" style="display:none;" >
<!-- 							<div class="init"> -->
								<a onclick="pwdChangeInitView()" href="javascript:void(0)">[초기화]</a>
							</div>
						</div>
<!-- 						<input type="hidden" class="input" id="sso" name="sso" value="N" /> -->
						</form>
					</dd>
				</dl>
			</div>
			<div class="pass_change" style="display:none;">
				<dl>
					<dt class="classColor sky">비밀번호 변경</dt>
					<dd>
						<form>
						<div class="inputBox">
							<label for="userIdChange" class="hidden">ID</label>
							<span>ID</span>
							<input type="text" class="input" id="userIdChange" name="userIdChange" placeholder="사번">
						</div>
						<div class="inputBox">
							<label for="userPwdOld" class="hidden">현재 비밀번호</label>
							<span>현재 비밀번호</span>
							<input type="password" class="input" id="userPwdOld" name="userPwdOld" placeholder="현재 비밀번호">
						</div>
						<div class="inputBox">
							<label for="userPwdNew" class="hidden">변경할 비밀번호</label>
							<span>변경 비밀번호</span>
							<input type="password" class="input" id="userPwdNew" name="userPwdNew" placeholder="변경할 비밀번호">
						</div>
		
						<div class="btn_wrap set_logo">
							<input class="btn purple full" type="button" value="변경" onclick="pwdChange()">
						</div>
						</form>
					</dd>
				</dl>
			</div>
			
			<div class="pass_change_init" style="display:none;">
				<dl>
					<dt class="classColor sky">초기화</dt>
					<dd>
						<form>
						<div class="inputBox">
							<label for="userIdChange" class="hidden">ID</label>
							<span>ID</span>
							<input type="text" class="input" id="userIdInit" name="userIdInit" placeholder="사번">
						</div>
		
						<div class="btn_wrap">
							<input class="btn purple full" type="button" value="확인" onclick="pwdChangeInit()">
						</div>
						</form>
					</dd>
				</dl>
			</div>
		</div>
<!-- 		<div class="login_foot">COPYRIGHT©2020 RTDATA. ALL RIGHTS RESERVED.</div> -->
	</div>
<!-- 	<div class="modal fade" id="staticBackdrop" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true"> <div class="modal-dialog" role="document"> <div class="modal-content"> <div class="modal-header"> <h5 class="modal-title" id="staticBackdropLabel">Modal title</h5> <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span> </button> </div> <div class="modal-body"> ... </div> <div class="modal-footer"> <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button> <button type="button" class="btn btn-primary">Understood</button> </div> </div> </div> </div> -->
</body>
</html>
