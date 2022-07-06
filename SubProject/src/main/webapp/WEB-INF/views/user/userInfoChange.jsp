<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="content tc">
	<!-- S_content-->
	<div class="panel panel-chang" style="width:800px">
	<div class="modal-header">
		<h4 class="modal-title">개인정보변경</h4>
	</div>
	<form id="frm">
	<div class="modal-body">
		<div class="row pt30">
			<div class="col-50">
				<div class="form-group">
					<label class="col-25 form-label">ID</label>
					<div class="col-75">
						<c:set var="userId" value="${fn:split(memberInfo.userId, '@')}" />
						<input id="userId" name="userId" type="hidden" class="text-input" value="${memberInfo.userId}">
						<input type="text" class="text-input" value="${userId[0] }" disabled>
					</div>
				</div>
			</div>
			<div class="col-50">
				<div class="form-group">
					<label class="col-25 form-label">회사</label>
					<div class="col-75">
						<input id="companyNm" name="companyNm" type="text" class="text-input" value="${memberInfo.companyNm }" disabled>
					</div>
				</div>
			</div>
			<div class="col-50">
				<div class="form-group">
					<label class="col-25 form-label">성명</label>
					<div class="col-75">
						<input id="userNm" name="userNm" type="text" class="text-input" value="${memberInfo.userNm }" placeholder="이름을 입력해 주세요">
					</div>
				</div>
			</div>
			<div class="col-50">
				<div class="form-group">
					<label class="col-25 form-label">연락처</label>
					<div class="col-75">
						<div class="phone-number">
							<input id="phone1" name="phone1" value="${fn:split(memberInfo.phone,'-')[0]}" type="text" class="text-input" maxlength="3" placeholder="번호를 입력해 주세요" onkeypress='return checkNumber(event);'>
						</div>
						<div class="phone-number">
							<input id="phone2" name="phone2" value="${fn:split(memberInfo.phone,'-')[1]}" type="text" class="text-input" maxlength="4" placeholder="번호를 입력해 주세요" onkeypress='return checkNumber(event);'>
						</div>
						<div class="phone-number end">
							<input id="phone3" name="phone3" value="${fn:split(memberInfo.phone,'-')[2]}" type="text" class="text-input" maxlength="4" placeholder="번호를 입력해 주세요" onkeypress='return checkNumber(event);'>
						</div>
						<input type="hidden" id="phone" name="phone" />
					</div>
				</div>
			</div>
			<div class="col-50">
				<div class="form-group">
					<label class="col-25 form-label">이메일</label>
					<div class="col-75">
						<div class="email-add">
							<input id="email1" name="email1" value="${fn:split(memberInfo.email,'@')[0]}" type="text" class="text-input email">
						</div>
						<div class="email-add end">
							<input id="email2" name="email2" value="${fn:split(memberInfo.email,'@')[1]}" type="text" class="text-input email">
						</div>
						<input type="hidden" id="email" name="email" />
					</div>
				</div>
			</div>
			<div class="col-50">
				<div class="form-group">
					<label class="col-25 form-label">비밀번호</label>
					<div class="col-75">
							<button type="button" class="btn-search" onclick="location.href='/member/pwdChange';">비밀번호 변경
							</button>
						<!-- <div class="form-input-box">
							<button type="button" class="btn-form-small" onclick="location.href='/member/pwdChange';" data-dismiss="modal">비밀번호 변경</button>
						</div> -->
					</div>
				</div>
			</div>
			
			<%--<div class="col-50">
				<div class="form-group">
					<label class="col-25 form-label">본부</label>
					<div class="col-75">
						<input type="text" class="text-input" value="${myInfo.userId }" placeholder="HSL2100000001">
					</div>
				</div>
			</div>
			<div class="col-50">
				<div class="form-group">
					<label class="col-25 form-label">부서</label>
					<div class="col-75">
						<input type="text" class="text-input" value="${myInfo.userId }" placeholder="HSL2100000001">
					</div>
				</div>
			</div>
			<div class="col-50">
				<div class="form-group">
					<label class="col-25 form-label">직위</label>
					<div class="col-75">
						<input type="text" class="text-input" value="${myInfo.userId }" placeholder="HSL2100000001">
					</div>
				</div>
			</div> --%>
			
		</div>
	</div>
	</form>
	<!-- 버튼 -->
	<div class="modal-footer btn-group mb20">
		<button type="button" class="button btn-success" onclick="save();">저장</button>
<!-- 		<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button> -->
	</div>
</div>
</div>


<script type="text/javascript">
	function save(){
		$('#userId').attr('disabled',false);
		var phone = $('#phone1').val() + '-' + $('#phone2').val() + '-' + $('#phone3').val();
		var email = $('#email1').val() + '@' + $('#email2').val();
		$('#phone').val(phone);
		$('#email').val(email);
		var param = $('#frm').serialize();
		if (isDisabled) {
			return false;
		} else {
			isDisabled = true;
			updateUser(param, 'update');
		}
	}
	
	function checkNumber(event) {
		if (event.key >= 0 && event.key <= 9) {
			return true;
		}
		return false;
	}
	
	function updateUser(param, action) {
		$.ajax({
			url : '/member/member/' + action + '/userInfoChange',
			dataType : 'TEXT',
			type : "POST",
			data : param,
			error : function(xhr, status, error) {
				console.log(error);
			},
			success : function(data) {
				isDisabled = false;
				if(data == 'Update'){
					location.href='/member/userInfoChange';
				}
			}
		});
	}
	
	function validation(type){
		if ($('#userNm').val() == '') {
			alert('이름를 입력해 주세요.');
			return false;
		}
		
		if ($('#phone1').val() == '') {
			alert('연락처를 입력해 주세요.');
			return false;
		}
		if ($('#phone2').val() == '') {
			alert('연락처를 입력해 주세요.');
			return false;
		}
		if ($('#phone3').val() == '') {
			alert('연락처를 입력해 주세요.');
			return false;
		}
		if ($('#mail1').val() == '') {
			alert('메일을 입력해 주세요.');
			return false;
		}
		if ($('#mail2').val() == '') {
			alert('메일을 입력해 주세요.');
			return false;
		}
		return true;
	}
</script>