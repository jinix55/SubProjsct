<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<form id="frm">
<div class="content">
	<input type="hidden" id="middleCategory" name="middleCategory" value="${setMiddleCategory }">
	<input type="hidden" id="smallCategory" name="smallCategory" value="${setSmallCategory }">
	<input type="hidden" id="smallCategoryNm" name="smallCategoryNm" value="${setSmallCategoryNm }">
	<div class="d-flex">
		<span class="pt10 pr10">ㆍ갱신일</span>
		<select class="select-box w150" id="revision" name="revision">
			<c:forEach items="${dayList }" var="list">
				<option value="${list.revisionYear}-${list.revisionMonth}" <c:if test="${setRevision eq list.revision}">selected</c:if>>${list.revisionYear}년 ${list.revisionMonth}월</option>
			</c:forEach>
		</select>
	</div>
	<div class="row pt30">
		<!-- S_left-area -->
		<div class="code-left-wrap">
			<h4 class="code-tit">ㆍ재질 > 부위구분</h4>
			<div class="left-area">
				<div class="content">
					<div class="d-flex">
						<span class="pt10 pr10">ㆍ재질</span>
						<select class="select-box w150" id="largeCategory" name="largeCategory">
							<c:forEach items="${largeCodeList }" var="list" varStatus="status">
								<option value="${list.codeId }" <c:if test="${setLargeCategory eq list.codeId }">selected</c:if>>${list.codeNm }</option>
							</c:forEach>
						</select>
					</div>
					<!-- S_그리드-->
					<div class="content-table">
						<div class="scroll-auto">
							<table class="table">
								<colgroup>
									<col style="width: 40px;">
									<col style="width: 110px;">
									<col style="width: 150px;">
									<col style="width: 90px;">
								</colgroup>
								<thead>
									<tr class="th-bg">
										<th scope="col">번호</th>
										<th scope="col">부위구분 코드</th>
										<th scope="col">부위구분 명</th>
										<th scope="col">관리</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${not empty middleCodeList }">
											<c:forEach items="${middleCodeList }" var="list" varStatus="status">
												<tr id="tr_${list.codeId }" onclick="selectTr(this);">
													<td>${status.count}</td>
													<td class="text-point">${list.codeId }</td>
													<td>${list.codeNm }</td>
													<td>
														<div class="btn-group">
															<a href="#coderegister_b" role="button" data-toggle="modal" class="btn-icon">
																<img src="/images/icon_edit.png" alt="수정하기" class="btn-Ticon02">
															</a>
															<a href="#delete" role="button" onclick="deleteSet();" data-toggle="modal" class="btn-icon">
																<img src="/images/icon_delete2.png" alt="삭제하기" class="btn-Ticon02">
															</a>
														</div>
													</td>
												</tr>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<tr>
												<td colspan="4">
													재질을 선택하지 않았거나 등록되 데이터가 없습니다.
												</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
					</div>
					<!-- E_그리드-->
					<div class="btn-group pt15 tr">
						<button type="button" class="button btn-success" id="largeCodeInsert" data-toggle="modal" href="#coderegister_m">
							대분류 등록
<!-- 							<a href="#coderegister_m" data-toggle="modal">대분류 등록</a> -->
						</button>
					</div>
				</div>
			</div>
		</div>
		<!-- E_left-area -->
		<!-- S_right-area -->
		<div class="code-right-wrap">
			<h4 class="code-tit">ㆍ재질 > 부위구분 > 용이성</h4>
			<div class="right-area">
				<div class="content">
					<!-- S_그리드-->
					<div class="content-table">
						<div class="scroll-auto">
							<table class="table">
								<colgroup>
									<col style="width: 40px;">
									<col style="width: 110px;">
									<col style="width: 150px;">
									<col style="width: 150px;">
									<col style="width: 90px;">
								</colgroup>
								<thead>
									<tr class="th-bg">
										<th scope="col">번호</th>
										<th scope="col">용이성 코드</th>
										<th scope="col">용이성 등급</th>
										<th scope="col">용이성 내용</th>
										<th scope="col">관리</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${not empty smallCodeList }">
											<c:forEach items="${smallCodeList }" var="list" varStatus="status">
												<tr>
													<td>${status.count}</td>
													<td class="text-point">${list.codeId }</td>
													<td>${list.codeNm }</td>
													<td>
														<a id="tr_${list.codeId }" nm="${list.codeNm }"href="#coderegister_s" role="button" data-toggle="modal" class="button-Csmall" onclick="detailCode(this);">내용 관리</a>
													</td>
													<td>
														<div class="btn-group">
															<a href="#coderegister_m" role="button" data-toggle="modal" class="btn-icon">
																<img src="/images/icon_edit.png" alt="수정하기" class="btn-Ticon02">
															</a>
															<a href="#delete" role="button" data-toggle="modal" class="btn-icon">
																<img src="/images/icon_delete2.png" alt="삭제하기" class="btn-Ticon02">
															</a>
														</div>
													</td>
												</tr>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<tr>
												<td colspan="4">
													등록되 데이터가 없습니다.
												</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
					</div>
					<!-- E_그리드-->
					<div class="btn-group pt15 tr">
						<button type="button" class="button btn-success" data-toggle="modal" href="#coderegister_m">
							중분류 등록
<!-- 							<a href="#coderegister_m" data-toggle="modal">중분류등록</a> -->
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- E_right-area -->
</div>
</form>
<!-- 레이어 팝업 - 대분류등록  -->
<form id="">
<div id="coderegister_b" class="modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width: 500px">
		<div class="modal-header">
			<h4 class="modal-title">대분류등록</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-100">
					<div class="form-group">
						<label class="col-25 form-label">대분류코드</label>
						<div class="col-75">
							<div class="form-input">
								<input type="text" class="text-input" value="FAQ_CAT">
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">대분류코드명</label>
						<div class="col-75">
							<div class="form-input">
								<input type="text" class="text-input" value="FAQ 카테고리">
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 버튼 -->
		<div class="modal-footer btn-group">
			<button type="button" class="button btn-success largeCodeInsert" data-dismiss="modal">저장</button>
			<button type="button" class="button btn-cancel largeCodeInsert" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>
</form>


<!-- 레이어 팝업 - 중분류등록  -->
<form id="">
<div id="coderegister_m" class="modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width: 500px">
		<div class="modal-header">
			<h4 class="modal-title">중분류등록</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-100">
					<div class="form-group">
						<label class="col-25 form-label">대분류코드</label>
						<div class="col-75">
							<div class="form-input">
								<input type="text" class="text-input" disabled>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">대분류코드명</label>
						<div class="col-75">
							<div class="form-input">
								<input type="text" class="text-input" disabled>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">중분류코드</label>
						<div class="col-75">
							<div class="form-input">
								<input type="text" class="text-input">
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">중분류코드명</label>
						<div class="col-75">
							<div class="form-input">
								<input type="text" class="text-input">
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 버튼 -->
		<div class="modal-footer btn-group">
			<button type="button" class="button btn-success middleCodeInsert" data-dismiss="modal">저장</button>
			<button type="button" class="button btn-cancel middleCodeCancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>
</form>

<!-- 레이어 팝업 - 소분류등록  -->
<form id="frmDetail">
<div id="coderegister_s" class="modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<input type="hidden" id="deRevision" name="deRevision">
	<div class="modal-content" style="width: 800px">
		<div class="modal-header">
			<h4 class="modal-title">내용 등록</h4>
			<button type="button" class="close de_close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="left-wrap">
					<table class="table">
						<colgroup>
							<col style="width: 135px;">
							<col style="width: 150px;">
						</colgroup>
						<thead>
							<tr class="th-bg">
								<th scope="col">내용 코드</th>
								<th scope="col">내용 명</th>
							</tr>
						</thead>
						<tbody id="detailCodeList">
						</tbody>
					</table>
				</div>
				<div class="right-wrap" id="detailCodListInput">
					<div class="col-100">
						<div class="form-group">
							<label class="col-25 form-label">용이성 코드</label>
							<div class="col-75">
								<div class="form-input">
									<input id="deGroupId" name="deGroupId" type="text" class="text-input" disabled>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label">용이성 명</label>
							<div class="col-75">
								<div class="form-input">
									<input id="deGroupNm" name="deGroupNm" type="text" class="text-input" disabled>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label">내용 코드</label>
							<div class="col-75">
								<div class="form-input">
									<input id="deCodeId" name="deCodeId" type="text" class="text-input" disabled>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label">내용 명</label>
							<div class="col-75">
								<div class="form-input">
									<input id="deCodeNm" name="deCodeNm" type="text" class="text-input" disabled>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label">내용 키</label>
							<div class="col-75">
								<div class="form-input">
									<input id="deCodeKey" name="deCodeKey" type="text" class="text-input" disabled>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label-textarea">비고</label>
							<div class="col-75">
								<div class="form-input">
									<textarea id="deCodeDsc" name="deCodeDsc" class="textarea" disabled></textarea>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 버튼 -->
		<div class="modal-footer btn-group">
			<button type="button" class="button btn-success smallCodeInsert new" >신규</button>
			<button type="button" class="button btn-cancel smallCodeCancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>
</form>

<!-- 레이어 팝업 - delete -->
<div id="delete" class="modal" data-backdrop-limit="1" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
	data-modal-parent="#myModal">
	<!-- Modal content-->
	<div class="modal-content" style="width: 500px">
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
							(<em class="text-bold">PEuser01</em>)삭제합니다.
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="modal-footer btn-group">
			<button type="button" class="button btn-warning" data-dismiss="modal">삭제</button>
			<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		var searchKey = '${pages.searchKey}';
		if (searchKey) {
			$('#searchKey').val('${pages.searchKey}');
		}
		
		$('#largeCategory').change(function(){
			$('#middleCategory').val('');
			var param = $('#frm').serialize();
			$('#frm').attr('action','/system/environmentCode');
			$('#frm').submit();
		});
		
		$('#revision').change(function(){
			var param = $('#frm').serialize();
			$('#frm').attr('action','/system/environmentCode');
			$('#frm').submit();
		});
		
		$('.smallCodeCancel, .de_close').click(function(){
			detailInputReset();
			$('.smallCodeInsert').addClass('new');
			$('.smallCodeInsert').text('신규');
			$('.smallCodeInsert').removeClass('save');
			$('.smallCodeInsert').removeClass('edit');
		});
		
		$('.smallCodeInsert').click(function(){
			if($('.smallCodeInsert').hasClass('new')){
				
			}
			if($('.smallCodeInsert').hasClass('edit')){
				detailCodeEdit();
			}
			if($('.smallCodeInsert').hasClass('save')){
				
			}
		});
	
	});
	
	function detailCodeEdit(){
		$('.smallCodeInsert').text('저장');
		$('.smallCodeInsert').removeClass('edit');
		$('.smallCodeInsert').addClass('save');
		$('#detailCodListInput #deCodeId').attr('disabled',false);
		$('#detailCodListInput #deCodeKey').attr('disabled',false);
		$('#detailCodListInput #deCodeNm').attr('disabled',false);
		$('#detailCodListInput #deCodeDsc').attr('disabled',false);
	}
	
	function selectTr(that){
		if(isDisabled){
			return false;
		}else{
			isDisabled = true;
			$('#middleCategory').val($(that).attr('id').replace('tr_',''));
			var param = $('#frm').serialize();
			$('#frm').attr('action','/system/environmentCode');
			$('#frm').submit();
		}
	}
	
	function detailCode(that){
		if(isDisabled){
			return false;
		}else{
			isDisabled = true;
			$('#smallCategory').val($(that).attr('id').replace('tr_',''));
			$('#smallCategoryNm').val($(that).attr('nm'));
			$('#deRevision').val($('#revision').val());
			var param = $('#frm').serialize();
			var action = 'detail/'+$(that).attr('id').replace('tr_',''); 
			detailCodeList(param, action);
		}
	}
	
	function detailCodeSelect(that){
		$('.smallCodeInsert').text('수정');
		$('.smallCodeInsert').removeClass('new');
		$('.smallCodeInsert').addClass('edit');
		if(isDisabled){
			return false;
		}else{
			isDisabled = true;
			$('#smallCategory').val($(that).attr('id').replace('tr_',''));
			var param = $('#frmDetail').serialize();
			var action = 'detail/select/'+$(that).attr('id').replace('tr_',''); 
			detailCoddSelectAjax(param, action);
		}
	}
	
	function makeDetailList(data){
		detailInputReset();
		var html = '';
		if(data.length > 0){
			data.forEach(function(item, index) {
				html += '<tr style="cursor: pointer;" id="tr_'+item.codeId+'" onclick="detailCodeSelect(this);">';
				html += '	<td style="text-overflow: ellipsis; overflow:hidden;">'+item.codeId+'</td>';
				html += '	<td style="text-overflow: ellipsis; overflow:hidden;">'+item.codeNm+'</td>';
				html += '</tr>';
			});
		}
		$('#detailCodeList').append(html);
		$('#deGroupId').val($('#smallCategory').val());
		$('#deGroupNm').val($('#smallCategoryNm').val());
	}
	
	function detailInputReset(){
		$('#detailCodeList').empty();
		$('#detailCodListInput input').val('');
		$('#detailCodListInput textarea').val('');
	}
	
	function makeDetailView(data){
		console.log(data)
		$('#detailCodListInput #deCodeId').val(data.codeId);
		$('#detailCodListInput #deCodeNm').val(data.codeNm);
		$('#detailCodListInput #deCodeKey').val(data.codeKey);
		$('#detailCodListInput #deCodeDsc').val(data.codeDsc);
		
	}

	function insertCode() {
		if (valyCheck()) {
			var param = $('#frm').serialize();
			actionAjax(param, 'insert');
		}
	}
	

	function updateCode() {
		if (valyCheck()) {
			var param = $('#frm').serialize();
			actionAjax(param, 'insert');
		}
	}
	
	/*삭제를 눌렀을때*/
	function deleteSet(codeId) {
		$('.delName').text(codeId);
		$('#codeId').val(codeId);
	}
	
	function deleteCode() {
		if (valyCheck()) {
			var param = $('#frm').serialize();
			actionAjax(param, 'insert');
		}
	}
	

	function detailCodeList(param, action) {
		$.ajax({
			type : 'post',
			url : '/system/environmentCode/' + action,
			data : param,
			dataType : 'json',
			error : function(xhr, status, error) {
				console.log(error);
			},
			success : function(result) {
				isDisabled = false;
				makeDetailList(result);
			}
		});
	}
	
	function detailCoddSelectAjax(param, action) {
		$.ajax({
			type : 'post',
			url : '/system/environmentCode/' + action,
			data : param,
			dataType : 'json',
			error : function(xhr, status, error) {
				console.log(error);
			},
			success : function(result) {
				isDisabled = false;
				makeDetailView(result);
			}
		});
	}
	
	function actionAjax(param, action) {
		$.ajax({
			type : 'post',
			url : '/system/environmentCode/' + action,
			data : param,
			dataType : 'text',
			error : function(xhr, status, error) {
				console.log(error);
			},
			success : function(result) {
				isDisabled = false;
				if (result == 'Update' || result == 'Insert') {
					location.href = '/system/code';
				}
			}
		});
	}

	function valyCheck() {
		if ($('#codeId').val() == '') {
			$('#groupId').attr('disabled', true);
			alert('코드 ID을 입력해 주세요.');
			$('#codeId').focus();
			return false;
		}
		if ($('#codeNm').val() == '') {
			$('#groupId').attr('disabled', true);
			alert('코드 명을 입력해 주세요.');
			$('#codeNm').focus();
			return false;
		}
		return true;
	}

</script>