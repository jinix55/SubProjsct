<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="content">
	<!-- S_검색-->
	<form id="searchFrm" action="/member/member" method="POST">
		<input type="hidden" id="page" name="page" value="${pages.page}">
		<div class="justify-content-between">
			<div class="form-group">
				<div class="form-inline">
					<select class="select-box w150" id="searchKey" name ="searchKey">
						<option value="ALL">전체</option>
						<option value="userId">사용자 ID</option>
						<option value="userNm">사용자 명</option>
					</select>
				</div>
				<div class="form-inline">
					<div class="search-box w250">
						<input id="searchValue" name="searchValue" value="${pages.searchValue }" type="text" class="text-input"> <span
							class="search-box-append searchKeyword">
							<button type="button" class="button-search">
								<img class="searchBtn" src="/images/icon_search.png" title="검색">
							</button>
						</span>
					</div>
				</div>
			</div>
		</div>
	</form>
	<!-- E_검색-->
	<!-- S_그리드-->
	<div class="content-table">
<!-- 		<div class="buttons-action" style="display: none"> -->
<!-- 			<div> -->
<!-- 				<a href="#Alldelete" role="button" data-toggle="modal"> -->
<!-- 					<button type="button" class="btn-alldelete"> -->
<!-- 						전체삭제<img src="/images/icon_delete.png" title="삭제"> -->
<!-- 					</button> -->
<!-- 				</a> -->
<!-- 				<button type="button" class="btn-allcancel"> -->
<!-- 					삭제취소<img src="/images/icon_cancel.png" title="취소"> -->
<!-- 				</button> -->
<!-- 			</div> -->
<!-- 			<div> -->
<!-- 				<span class="text-action">14 items selected</span> -->
<!-- 			</div> -->
<!-- 		</div> -->
		<div class="scroll-auto">
			<table class="table table-actions">
				<colgroup>
<%-- 					<col style="width: 5%;"> --%>
					<col style="width: 6%;">
					<col style="width: 12%;">
					<col style="width: 15%;">
					<col style="width: *%;">
					<col style="width: 14%;">
					<col style="width: 8%;">
					<col style="width: 8%;">
				</colgroup>
				<thead>
					<tr class="th-bg">
<!-- 						<th><input type="checkbox" name="all" id="checkAll"></th> -->
						<th scope="col">번호</th>
						<th scope="col">사용자 ID</th>
						<th scope="col">사용자 이름</th>
						<th scope="col">그룹 ID</th>
						<th scope="col">등록일</th>
						<th scope="col">사용유무</th>
						<th scope="col">관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="member" items="${members}" varStatus="status">
						<tr>
<!-- 							<th><input type="checkbox" name="chk"></th> -->
							<td>${pages.totalCount - (status.index + (pages.page -1) * pages.pageSize)}</td>
							<td class="text-point">${member.userId}</td>
							<td>${member.userNm}</td>
							<td>${member.authNm}</td>
							<td><spring:eval expression="member.rgstDt.toString().substring(0,10)" /></td>
							<td>
							<c:choose>
								<c:when test="${member.useYn eq 'Y' }">
									<button type="button" class="button-yes">YES</button>
								</c:when>
								<c:otherwise>
									<c:choose>
									<c:when test="${member.lockYn eq 'Y' }">
										<button type="button" class="button-no backColorRed">Lock</button>
									</c:when>
									<c:otherwise>
										<button type="button" class="button-no">NO</button>
									</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
							</td>
							<td>
								<div class="btn-group">
									<a href="#register" onclick="detailView('${member.userId}');" role="button" data-toggle="modal" class="btn-icon">
										<img src="/images/icon_edit.png" alt="수정하기" class="btn-Ticon02">
									</a>
									<a href="#delete" onclick="deleteSet('${member.userId}');" role="button" data-toggle="modal" class="btn-icon">
										<img src="/images/icon_delete2.png" alt="삭제하기" class="btn-Ticon02">
									</a>
								</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<!-- E_그리드-->
	<div class="btn-group pt15 tr">
		<button type="button" class="button btn-success" id="registView" href="#register"
			data-toggle="modal">
			등록
			<!-- 			<a href="#register" data-toggle="modal">등록</a> -->
		</button>
	</div>
	<!-- S_페이징-->
	<div class="board-paging">
	</div>
	<!-- E_페이징-->
</div>

<!-- 레이어 팝업 - 등록  -->
<form id="frm">
<div id="register" class="modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width: 800px">
		<div class="modal-header">
			<h4 class="modal-title">등록</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">등록일시</label>
						<div class="col-75">
							<div class="form-input">
								<input id="rgstDt" name="rgstDt" type="text" class="text-input">
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">수정일시</label>
						<div class="col-75">
							<div class="form-input">
								<input id="modiDt" name="modiDt" type="text" class="text-input">
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">사용자 ID<em>*</em></label>
						<div class="col-75">
							<div class="search-box">
								<input id="userId" name="userId" type="text" class="text-input" placeholder="ID를 입력해 주세요">
								<span class="search-box-append">
									<button type="button" class="button-search" id="idSearch">
										<a id="idSearchCheck" href="#overlap" role="button" data-toggle="modal">중복확인</a>
									</button>
								</span>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">사용자 이름<em>*</em></label>
						<div class="col-75">
							<div class="form-input">
								<input id="userNm" name="userNm" type="text" class="text-input" placeholder="이름을 입력해 주세요">
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">회사명<em>*</em></label>
						<div class="col-75">
							<select id="companyCode" name="companyCode" class="select-box">
								<option value="none">선택안함</option>
								<c:forEach items="${companys }" var="company">
									<option value="${company.companyCode}">${company.companyNm }</option>
								</c:forEach> 
							</select>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">그룹 ID<em>*</em></label>
						<div class="col-75">
							<select id="authId" name="authId" class="select-box">
								<option value="none">선택안함</option>
								<c:forEach items="${roles }" var="role">
									<option value="${role.authId}">${role.authNm }</option>
								</c:forEach> 
							</select>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">이메일 주소<em>*</em></label>
						<div class="col-75">
							<div class="form-input">
								<div class="email-add">
									<input id="email1" name="email1" type="text" class="text-input email">
								</div>
								<div class="email-add">
									<input id="email2" name="email2" type="text" class="text-input email">
								</div>
								<input type="hidden" id="email" name="email" />
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<input type="hidden" id="phone" name="phone" /> <label
							class="col-25 form-label">연락처<em>*</em></label>
						<div class="col-75">
							<div class="form-input">
								<div class="phone-number">
									<input id="phone1" name="phone1" onkeyup="this.value = setNumber(this.value)" type="text" class="text-input phone" maxlength="3">
								</div>
								<div class="phone-number">
									<input id="phone2" name="phone2" onkeyup="this.value = setNumber(this.value)" type="text" class="text-input phone" maxlength="4">
								</div>
								<div class="phone-number">
									<input id="phone3" name="phone3" onkeyup="this.value = setNumber(this.value)" type="text" class="text-input phone" maxlength="4">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">잠금상태</label>
						<div class="col-75">
							<div class="form-input-box">
<!-- 								<button type="button" id="lockYn" name ="lockYn" class="button-yes" style="height:26px;width:80px;line-height:26px;background:red;">Yes</button> -->
								<div class="button-Rsmall d-inblock">
									<input id="lockY" name="lockYn" type="radio" value="Y">
									<label for="lockY" class="mr05">활성화</label>
								</div>
								<div class="button-Rsmall d-inblock">
									<input id="lockN" name="lockYn" type="radio" value="N">
									<label for="lockN" class="mr05">비활성화</label>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">기한적용</label>
						<div class="col-75">
							<div class="form-input-box">
								<div class="button-Rsmall d-inblock">
									<input id="dtLimitY" name="dtLimitYn" type="radio" value="Y">
									<label for="dtLimitY" class="mr05">적용</label>
								</div>
								<div class="button-Rsmall d-inblock">
									<input id="dtLimitN" name="dtLimitYn" type="radio" value="N">
									<label for="dtLimitN" class="mr05">미적용</label>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">사용여부</label>
						<div class="col-75">
							<div class="form-input-box">
								<div class="button-Rsmall d-inblock">
									<input id="useY" name="useYn" type="radio" value="Y">
									<label for="useY" class="mr05">사용</label>
								</div>
								<div class="button-Rsmall d-inblock">
									<input id="useN" name="useYn" type="radio" value="N">
									<label for="useN" class="mr05">미사용</label>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">기간설정</label>
						<div class="col-75">
							<div class="search-date">
								<input onkeyup="this.value = date_mask(this.value)" type="text"
									id="startDt" name="dateFrom" class="text-input">
							</div>
							<div class="search-date">
								<input onkeyup="this.value = date_mask(this.value)" type="text"
									id="endDt" name="dateTo" class="text-input">
							</div>
						</div>
					</div>
				</div>
			</div>			
		</div>
		<!-- 버튼 -->
		<div class="modal-footer btn-group">
			<button id="regBtn" type="button" class="button btn-success insert" >저장</button>
			<button type="button" class="button btn-cancel cancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>
</form>

<!-- 레이어 팝업 아이디 중복 확인 -->
<div id="overlap" class="modal" data-backdrop-limit="1" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
	data-modal-parent="#myModal">
	<div class="modal-content" style="width: 400px">
		<div class="modal-header">
			<h4 class="modal-title">중복확인</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-100">
					<div class="form-group">
						<label class="col-25 form-label">사용자 ID<em>*</em></label>
						<div class="col-75">
							<div class="search-box">
								<input id="re_userId" name="re_userId" type="text" class="text-input">
								<span class="search-box-append">
									<button id="re_idSearch" name="re_idSearch" type="button" class="button-search">
										<img src="/images/icon_search.png" title="검색">
									</button>
								</span>
							</div>
						</div>
					</div>
					<div class="form-notice"  style="display:none">* [ww]는 사용가능한 ID입니다</div>
				</div>
			</div>
		</div>
		<!-- 버튼 -->
		<div class="modal-footer btn-group">
			<button type="button" class="button btn-success idCheck" data-dismiss="modal">확인</button>
			<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>

<!-- 레이어 팝업 - delete -->
<form action="/member/member/delete" method="POST">
<div id="delete" class="modal" data-backdrop-limit="1" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
	data-modal-parent="#myModal">
	<!-- Modal content-->
	<input type="hidden" id="del_userId" name="del_userId">
	<div class="modal-content" style="width: 400px">
		<div class="modal-header">
			<h4 class="modal-title">삭제</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-100">
					<div class="form-group">
						<div class="tc">
							<em class="text-bold delName">PEuser01</em> 삭제하시겠습니까?
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="modal-footer btn-group">
			<button type="button" class="button btn-warning delete" data-dismiss="modal">삭제</button>
			<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>
</form>
<!-- 레이어 팝업 delete All -->
<div id="Alldelete" class="modal" data-backdrop-limit="1" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
	data-modal-parent="#myModal">
	<!-- Modal content-->
	<div class="modal-content" style="width: 400px">
		<div class="modal-header">
			<h4 class="modal-title">전체삭제</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-100">
					<div class="form-group">
						<div class="tc">
							<em class="text-bold">14 items selected</em><br />삭제하시겠습니까?
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="modal-footer btn-tbl_group">
			<button type="button" class="button btn-warning" data-dismiss="modal">삭제</button>
			<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>

<script>

	var totalPage = ${pages.totalPage};
	var page = ${pages.page}; 
	var pageSize = ${pages.pageSize}; 
	
	// var totalPage = 10;
	// var page = 2; 
	// var pageSize = 10; 
	
	$('.board-paging').bootpag({        // 페이징을 표시할 div의 클래스
		total: totalPage,  // 페이징모델의 전체페이지수
	    page: page,        // 페이징모델의 현재페이지번호
	    maxVisible: pageSize,  // 보여질 최대 페이지수
	    firstLastUse: true,             // first와 last사용유무
	    wrapClass: 'paging',              // 페이징을 감싼 클래스명
	    activeClass: 'on',              // 현재페이지의 클래스명
	    disabledClass: 'disabled',      // 각 항목별 클래스 지정
	    nextClass: 'next',
	    prevClass: 'prev',
	    lastClass: 'last',
	    firstClass: 'first',
	}).on("page", function(event, num){
	    $("#page").val(num);
	    $("#searchFrm").submit();
	});
	
	function deleteSet(userId){
		$('#del_userId').val(userId);
		$('.delName').text(userId);
	}
	
	function detailView(id){
		resetView();
		$('#rgstDt').attr('disabled',true);
		$('#rgstDt').parents('.col-50').show();
		$('#modiDt').attr('disabled',true);
		$('#modiDt').parents('.col-50').show();
		$('#register input').attr('disabled',true);
		
		$.ajax({
			url : '/member/member/detail/'+id,
			dataType : 'json',
			type : "POST",
			async: false,
			success : function(data) {
				var result = data;
				console.log(result);
				setView(data);
			}
		});
	}
	
	function setView(data){
		var phone1 = '';
		var phone2 = '';
		var email1 = '';
		var email2 = '';
		var companyCd = 'none';
		var authId = 'none';
		var useYn = 'N';
		var lockYn = 'N';
		var dtLimitYn = 'N';
		
		if(data.phone){
			phone1 = data.phone.split("-")[0];
			phone2 = data.phone.split("-")[1];
			phone3 = data.phone.split("-")[2];
		}
		
		if(data.email){
			email1 = data.email.split("@")[0];
			email2 = data.email.split("@")[1];
		}
		
		if(data.useYn != ''){
			useYn = data.useYn;
		}
		
		if(data.lockYn != ''){
			lockYn = data.lockYn;
		}
		
		if(data.dtLimitYn != ''){
			dtLimitYn = data.dtLimitYn;
		}
		
		if(data.companyCode){
			companyCd = data.companyCode;
		}
		
		if(data.authId){
			authId = data.authId;
		}
		
		$('#userId').val(data.userId);
		$('#userNm').val(data.userNm);
		$('#email1').val(email1);
		$('#email2').val(email2);
		$('#email').val(data.email);
		$('#phone1').val(phone1);
		$('#phone2').val(phone2);
		$('#phone3').val(phone3);
		$('#phone').val(data.phone);
		$('#companyCode').val(companyCd);
		$('#authId').val(authId);
		$('#use'+useYn).prop('checked',true);
// 		if(data.lockYn == 'Y'){
// 			$('#lockYn').addClass('button-yes');
// 			$('#lockYn').text('Yes');
// 			$('#lockYn').css('background','red');
// 			$('#lockYn').css('cursor',' pointer');
// 		}else{
// 			$('#lockYn').addClass('button-no');
// 			$('#lockYn').text('No');
// 			$('#lockYn').css('background','darkgray');
// 			$('#lockYn').css('background','darkgray');
// 			$('#lockYn').css('cursor',' unset');
// 		}
		$('#lock'+lockYn).prop('checked',true);
		$('#dtLimit'+dtLimitYn).prop('checked',true);
		$('#startDt').val(data.startDt);
		$('#endDt').val(data.endDt);
		$('#rgstDt').val(data.rgstDt);
		$('#modiDt').val(data.modiDt);
	}
	
	function date_mask(objValue) {
		var v = objValue.replace("--", "-");
	    if (v.match(/^\d{4}$/) !== null) {
	        v = v + '-';
	    } else if (v.match(/^\d{4}\-\d{2}$/) !== null) {
	        v = v + '-';
	    }
	    return v;
	}
	
	function resetInput(){
		$('#register input').attr('disabled',false);
		$('#register select').attr('disabled',false);
		$('.search-box-append').show();
		$('#register input').val('');
		$('#lockY').val('Y');
		$('#lockN').val('N');
		$('#dtLimitY').val('Y');
		$('#dtLimitN').val('N');
		$('#useY').val('Y');
		$('#useN').val('N');
		$('#companyCode').val('none');
		$('#authId').val('none');
		$('#lockN').prop('checked',true);
		$('#dtLimitY').prop('checked',true);
		$('#useY').prop('checked',true);
		$('#regBtn').removeClass('edit');
		$('#regBtn').removeClass('save');
		$('#regBtn').addClass('insert');
	}
	
	function resetView(){
		$('.search-box-append').hide();
		$('#rgstDt').attr('disabled',true);
		$('#rgstDt').parents('.col-50').show();
		$('#modiDt').attr('disabled',true);
		$('#modiDt').parents('.col-50').show();
		$('#register .modal-title').text('상세');
		$('#register input').attr('disabled',true);
		$('#register select').attr('disabled',true);
		$('#regBtn').removeClass('insert');
		$('#regBtn').addClass('edit');
		$('#regBtn').text('수정');
	}
	
	function idSearch(){
		var idSearch = $('#userId').val();
		if(idSearch){
			$('#re_userId').val(idSearch);
			searchIdAction(idSearch);
		}else{
			$('#re_userId').val('');
			$('.form-notice').text("확인이 필요합니다.");
			$('.form-notice').hide();
		}
	}
	
	function re_idSearch(){
		var re_idSearch = $('#re_userId').val();
		if(re_idSearch){
			searchIdAction(re_idSearch);
		}
	}
	
	function searchIdAction(idSearch){
		$.ajax({
		    type : 'post',
		    url : '/member/member/detail/popup/'+idSearch,
		    data : {memberId:idSearch},
		    dataType : 'text',
		    error: function(xhr, status, error){
		        console.log(error);
		    },
		    success : function(result){
		    	console.log(result)
		    	if(result == 'none'){
		    		$('.form-notice').text("이미 사용중인 아이디 입니다.");
		    		$('.form-notice').addClass("colorRed");
		    		$('#idSearch').removeClass('search-Success');
		    		$('#idSearch').addClass('search-Fail');
		    		$('#idSearchCheck').text('다시확인');
		    	}else{
		    		$('.form-notice').text("사용 가능한 아이디 입니다.");
		    		$('.form-notice').addClass("fontColorBlue");
		    		$('#userId').val(result);
		    		$('#re_userId').val(result);
		    		$('#idSearch').addClass('search-Success');
		    	}
		    		$('.form-notice').show();
		    }
		});
	}
	
	function idCheckReset(){
		$('.form-notice').text("확인이 필요합니다.");
		$('.form-notice').hide();
		$('.form-notice').hide();
		if($('#re_userId').val() == ''){
			$('#idSearch').removeClass('search-Success');
		}
	}
	
	function setEdit(){
		$('#register input').attr('disabled',false);
		$('#register select').attr('disabled',false);
		$('#userId').attr('disabled',true);
		$('#userNm').attr('disabled',true);
		$('#rgstDt').attr('disabled',true);
		$('#modiDt').attr('disabled',true);
		$('#regBtn').text('저장');
		$('#regBtn').removeClass('edit');
		$('#regBtn').addClass('save');
	}
	
	function validation(){
		if($('#userId').val() == ''){
			alert('아이디를 입력해 주세요..');
			return false;
		}
		if($('#userNm').val() == ''){
			alert('이름을 입력해 주세요..');
			return false;
		}
		if($('#companyCode').val() == 'none'){
			alert('회사를 선택해 주세요..');
			return false;
		}
		if($('#authId').val() == 'none'){
			alert('그룹을 선택해 주세요..');
			return false;
		}
		if($('#email1').val() == ''){
			alert('메일을 입력해 주세요..');
			return false;
		}
		if($('#email2').val() == ''){
			alert('메일을 입력해 주세요..');
			return false;
		}
		if($('#phone1').val() == ''){
			alert('연락처를 입력해 주세요..');
			return false;
		}
		if($('#phone2').val() == ''){
			alert('연락처를 입력해 주세요..');
			return false;
		}
		if($('#phone3').val() == ''){
			alert('연락처를 입력해 주세요..');
			return false;
		}
		return true;
	}
	
	function userInsert(){
		var has = $('#idSearch').hasClass('search-Success');
		if(!has && ($('#regBtn').hasClass('save') || $('#regBtn').hasClass('insert'))){
			alert('아이디 중복 학인이 필요합니다.');
			return false;
		}
		
		if(validation()){
			isDisabled = true;
			var param =  $('#frm').serialize();
			insertAjax(param,'insert');
		}
		
	}
	
	function userUpdate(){
		$('#userId').prop('disabled',false);
		var param =  $('#frm').serialize();
		
		if(validation()){
			isDisabled = true;
			insertAjax(param,'update');
		}
	}
	
	function insertAjax(param,action){
		isDisabled = true;
		$.ajax({
		    type : 'post',
		    url : '/member/member/'+action,
		    data : param,
		    dataType : 'text',
		    error: function(xhr, status, error){
		        console.log(error);
		    },
		    success : function(result){
		    	if(result == 'Update' || result == 'Insert'){
		    		location.href = '/member/member';
		    	}
		    }
		});
	}
	
	function deleteAjax(param,action){
		isDisabled = true;
		param = {
				userId : $('#del_userId').val()
		}
		$.ajax({
		    type : 'post',
		    url : '/member/member/delete',
		    data : param,
		    dataType : 'text',
		    error: function(xhr, status, error){
		        console.log(error);
		    },
		    success : function(result){
		    	if(result == 'Delete'){
		    		location.href = '/member/member';
		    	}
		    }
		});
	}
	
	function setPhoneNo(){
		var phone = $('#phone1').val()+'-'+$('#phone2').val()+'-'+$('#phone3').val(); 
		$('#phone').val(phone);
	}
	
	function setEmail(){
		var email = $('#email1').val()+'@'+$('#email2').val(); 
		$('#email').val(email);
	}
	
	function setNumber(objValue){
		str = objValue.replace(/[^0-9]/gi,"").toUpperCase();
	    return str;
	}
	
	$(document).ready(function() {
		$('#registView').click(function(){
			resetInput();
			$('#register .modal-title').text('등록');
			$('#register .insert').text('저장');
			$('#rgstDt').attr('disabled',true);
			$('#rgstDt').parents('.col-50').hide();
			$('#modiDt').attr('disabled',true);
			$('#modiDt').parents('.col-50').hide();
		});
		
		$("#idSearch").keyup(function(e) {
	        if(e.keyCode == '13'){
	        	$("#idSearchCheck").click();
	        	idSearch();
	        }
	    });
		
		$("#idSearch, #idSearchCheck").mouseup(function(e) {
			$("#idSearchCheck").click();
			idSearch();
	    });
		
		$('#re_idSearch').click(function(){
			re_idSearch();
		});
		
		$('.idCheck').click(function(){
			idCheckReset();
		});
		
		$('.close, .cancel').click(function(){
			resetInput();
		});
		
		$('#regBtn').click(function(){
			if($('#regBtn').hasClass('insert')){
				if(isDisabled){
					return false;
				}else{
					userInsert();
				}
			}
			if($('#regBtn').hasClass('save')){
				if(isDisabled){
					return false;
				}else{
					userUpdate();
				}
			}
			if($('#regBtn').hasClass('edit')){
				setEdit();
			}
		});
		
		$('.email').keyup(function(){
			setEmail();
		});
		
		$('.phone').keyup(function(){
			setPhoneNo();
		});
		
		$('.delete').click(function(){
			if(isDisabled){
				return false;
			}else{
				deleteAjax();
			}
		});
		
		$('.searchKeyword').click(function(){
			if(isDisabled){
				return false;
			}else{
				$('#searchFrm').submit();
			}
		});
	});
</script>