<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="content tc">
						<!-- S_content-->
						<div class="login-tltle">비밀번호 변경</div>
							<div class="login-content" style="background: none;border: 0px;">
								<div class="login-form">
									<form id="pwdChange">
										<div class="login-id h45">
											 <c:set var="userId" value="${fn:split(memberInfo.userId, '@')}" />
											 <input type="hidden" id="ch_userId" name="ch_userId"  value="${memberInfo.userId}">
											<input type="text" class="text-input pl35" value="${userId[0] }" disabled>
										</div>
										<div class="login-pw h45">
											 <input type="password" class="text-input pl35" id="ch_pwdOld" name="ch_pwdOld" placeholder="현재 비밀번호을 입력하세요.">
										</div>
										<div class="login-pw h45">
											 <input type="password" class="text-input pl35" id="ch_pwdNew" name="ch_pwdNew" placeholder="현경하실 비밀번호을 입력하세요.">
										</div>
										<div class="login-pw h45">
											 <input type="password" class="text-input pl35" id="ch_pwdNewConfirm" name="ch_pwdNewConfirm" placeholder="새 비밀번호 확인.">
										</div>
										<div class="btn-group">
											<button type="button" class="button btn-success w100"  onclick="changePassword();"><a href="javascript:void(0);">비밀번호 변경</a></button>
										</div>
									</form>
								</div>
							</div>
					</div>


<script type="text/javascript">
/**
 * 페이징 처리 공통 함수
 */
// var totalPage = ${pages.totalPage};
// var page = ${pages.page}; 
// var pageSize = ${pages.pageSize}; 

var totalPageCnt = 10;
var pageCnt = 2; 
var pageSizeCnt = 10; 

$('.paging_cont').bootpag({        // 페이징을 표시할 div의 클래스
	total: totalPageCnt,  // 페이징모델의 전체페이지수
    page: pageCnt,        // 페이징모델의 현재페이지번호
    maxVisible: pageSizeCnt,  // 보여질 최대 페이지수
    firstLastUse: true,             // first와 last사용유무
    wrapClass: 'paging',              // 페이징을 감싼 클래스명
    activeClass: 'on',              // 현재페이지의 클래스명
    disabledClass: 'disabled',      // 각 항목별 클래스 지정
    nextClass: 'next',
    prevClass: 'prev',
    lastClass: 'last',
    firstClass: 'first',
	next: ' ',
	prev: ' ',
	first: '<span aria-hidden="true"></span>',
	last: '<span aria-hidden="true"></span>'
}).on("paging_cont", function(event, num){
    $("#page").val(num);
    $("#holiBdForm").submit();
});

let dbclick = 'Y';
function changePassword(){
	if (dbclick != 'Y') {
		return;
	}
	dbclick = 'N';
	var userPwdOld = document.getElementById("ch_pwdOld").value;
	var userPwdNew = document.getElementById("ch_pwdNew").value;
	var userPwdNewConfirm = document.getElementById("ch_pwdNewConfirm").value;
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
	

	if(userPwdNewConfirm == null || userPwdNewConfirm == ''){
		alert("새 비밀번호 확인해 주세요.");
		document.getElementById("ch_pwdNewConfirm").focus();
		dbclick = 'Y';
		return;
	}
	
	if(userPwdNew != userPwdNewConfirm) {
		alert("새 비밀번호와 확인 비밀번호가 다릅니다.");
		document.getElementById("ch_pwdNewConfirm").focus();
		dbclick = 'Y';
		return;
	}
	var param = $('#pwdChange').serialize();
	$.ajax({
		url : '/member/pwdChange',
		dataType : 'JSON',
		data : param,
		type : "POST",
		async : false,
		error : function(request, status, error) {
			console.log(request.responseText);
			alert(request.responseText);
		},
		success : function(data) {
			alert(data);
			console.log(data);
		}
	});
}
</script>