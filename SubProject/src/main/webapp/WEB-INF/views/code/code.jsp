<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="content">
	<!-- S_검색-->
	<form id="searchFrm" action="system/code" method="POST">
		<div class="justify-content-between">
			<input type="hidden" id="page" name="page" value="${pages.page}">
			<div class="form-group">
				<div class="form-inline">
					<select class="select-box w150" id="searchKey" name ="searchKey">
						<option value="ALL">전체</option>
						<option value="groupId">코드그룹 ID</option>
						<option value="groupNm">코드그룹명</option>
					</select>
				</div>
				<div class="form-inline">
					<div class="search-box w250">
						<input type="text" class="text-input" id="searchValue" name="searchValue" value="${pages.searchValue }">
						<span class="search-box-append">
							<button type="button" class="button-search">
								<img src="/images/icon_search.png" title="검색">
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
		<div class="scroll-auto">
			<table class="table table-actions">
				<colgroup>
					<col style="width: 40px;">
					<col style="width: 110px;">
					<col style="width: 150px;">
					<col style="width: 150px;">
					<col style="width: 170px;">
					<col style="width: 60px;">
					<col style="width: 90px;">
				</colgroup>
				<thead>
					<tr class="th-bg">
						<th scope="col">번호</th>
						<th scope="col">코드ID</th>
						<th scope="col">코드명</th>
						<th scope="col">생성일시</th>
						<th scope="col">비고</th>
						<th scope="col">사용여부</th>
						<th scope="col">관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${codes}" var="code" varStatus="status">
						<c:if test="${code.groupId eq 'GROUP_ID' }">
							<tr>
								<td class="tr-item">${pages.totalCount - (status.index + (pages.page -1) * pages.pageSize)}</td>
								<td class="text-point tr-item">${code.codeId}</td>
								<td class="tr-item">${code.codeNm}</td>
								<td class="tr-item"><spring:eval expression="code.rgstDt" /></td>
								<td class="tr-item">${code.codeDsc}</td>
								<td class="tr-item">
									<c:choose>
										<c:when test="${code.useYn eq 'Y' }">
											<button type="button" class="button-yes">YES</button>
										</c:when>
										<c:otherwise>
												<button type="button" class="button-no">NO</button>
										</c:otherwise>
									</c:choose>
								</td>
								<td>
									<div class="btn-group">
										<a href="#register" role="button" data-toggle="modal" onclick="detailView('${code.codeId}');"  class="btn-icon">
											<img src="/images/icon_edit.png" alt="등록하기" class="btn-Ticon02">
										</a>
										<a href="#delete" role="button" data-toggle="modal" onclick="deleteSet('${code.codeId}');"  class="btn-icon del_data">
											<img src="/images/icon_delete2.png" alt="삭제하기" class="btn-Ticon02">
										</a>
									</div>
								</td>
							</tr>
						</c:if>
						
						<!-- S_히든테이블 -->
						<tr class="tr-hide">
							<td colspan="7">
								<div class="tab-box">
									<h4 class="tl">
										<span class="title-point">[상세코드 목록]</span>
									</h4>
									<table class="table">
										<colgroup>
											<col style="width: 40px;">
											<col style="width: 120px;">
											<col style="width: 150px;">
											<col style="width: 150px;">
											<col style="width: 60px;">
											<col style="width: 200px;">
											<col style="width: 60px;">
										</colgroup>
										<thead>
											<tr class="th-inbg">
												<th scope="col">번호</th>
												<th scope="col">코드ID</th>
												<th scope="col">코드명</th>
												<th scope="col">생성일시</th>
												<th scope="col">정렬순서</th>
												<th scope="col">비고</th>
												<th scope="col">사용여부</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>1</td>
												<td class="text-point tr-item">MANUAL</td>
												<td>사용문의</td>
												<td>2021-07-15 16:55:53</td>
												<td>2</td>
												<td></td>
												<td>
													<button type="button" class="button-no">NO</button>
												</td>
											</tr>
											<tr>
												<td>2</td>
												<td class="text-point tr-item">PROJECT</td>
												<td>프로젝트</td>
												<td>2021-07-15 16:55:53</td>
												<td>2</td>
												<td></td>
												<td>
													<button type="button" class="button-yes">Yes</button>
												</td>
											</tr>
											<tr>
												<td>3</td>
												<td class="text-point tr-item">ETC</td>
												<td>기타</td>
												<td>2021-07-15 16:55:53</td>
												<td>3</td>
												<td></td>
												<td>
													<button type="button" class="button-no">NO</button>
												</td>
											</tr>
										</tbody>
									</table>
									<!-- 코트등록 -->
									<h4 class="tl pt30">
										<span class="title-point">[상세코드 등록]</span>
									</h4>
									<div class="row">
										<div class="col-50">
											<div class="form-group">
												<label class="col-25 form-label">코드그룹 ID</label>
												<div class="col-75">
													<div class="form-input">
														<input type="text" class="text-input" value="FAQ_CAT"
															disabled>
													</div>
												</div>
											</div>
										</div>
										<div class="col-50">
											<div class="form-group">
												<label class="col-25 form-label">코드그룹명</label>
												<div class="col-75">
													<div class="form-input">
														<input type="text" class="text-input" value="FAQ 카테고리">
													</div>
												</div>
											</div>
										</div>
										<div class="col-50">
											<div class="form-group">
												<label class="col-25 form-label">코드 ID</label>
												<div class="col-75">
													<div class="form-input">
														<input type="text" class="text-input" value="MANUAL">
													</div>
												</div>
											</div>
										</div>
										<div class="col-50">
											<div class="form-group">
												<label class="col-25 form-label">코드명</label>
												<div class="col-75">
													<div class="form-input">
														<input type="text" class="text-input" value="사용문의">
													</div>
												</div>
											</div>
										</div>
										<div class="col-50">
											<div class="form-group">
												<label class="col-25 form-label">정렬순서</label>
												<div class="col-75">
													<div class="form-input">
														<input type="text" class="text-input" value="2">
													</div>
												</div>
											</div>
										</div>
										<div class="col-50">
											<div class="form-group">
												<label class="col-25 form-label">사용여부</label>
												<div class="col-75">
													<div class="form-input-box tl">
														<div class="button-Rsmall d-inblock">
															<input type="radio" id="radio1" name="radio"
																checked="checked"> <label for="radio1"
																class="mr05">Yes</label>
														</div>
														<div class="button-Rsmall d-inblock">
															<input type="radio" id="radio2" name="radio"> <label
																for="radio2" class="mr05">No</label>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="col-100">
											<div class="form-group">
												<label class="col-25 form-label-textarea">비고</label>
												<div class="col-75">
													<div class="form-input">
														<textarea class="textarea"></textarea>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="btn-group pt15">
										<button type="button" class="button btn-success" data-dismiss="modal">저장</button>
										<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
									</div>
								</div>
							</td>
						</tr>
						<!-- E_히든테이블 -->
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<!-- E_그리드-->
	<div class="btn-group pt15 tr">
		<button type="button" class="button btn-success" id="registView" data-toggle="modal"  href="#register">
			등록
<!-- 			<a href="#register" data-toggle="modal">등록</a> -->
		</button>
	</div>
	<!-- S_페이징-->
	<div class="board-paging"></div>
	<!-- E_페이징-->
</div>


<!-- 레이어 팝업 - 등록  -->
<form id="frm">
<div id="register" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<input type="hidden" class="text-input" id="groupId" value="GROUP_ID">
	<div class="modal-content" style="width: 800px">
		<div class="modal-header">
			<h4 class="modal-title">등록</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-50" id="regDt">
					<div class="form-group">
						<label class="col-25 form-label">등록일시</label>
						<div class="col-75">
							<div class="form-input">
								<input id="rgstDt" name="rgstDt" type="text" class="text-input" disabled>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50" id="modDt">
					<div class="form-group">
						<label class="col-25 form-label">수정일시</label>
						<div class="col-75">
							<div class="form-input">
								<input id="modiDt" name="modiDt" type="text" class="text-input" disabled>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">코드 ID</label>
						<div class="col-75">
							<div class="form-input">
								<input id="codeId" name="codeId" type="text" class="text-input" disabled>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">코드명</label>
						<div class="col-75">
							<div class="form-input">
								<input id="codeNm" name="codeNm" type="text" class="text-input" disabled>
							</div>
						</div>
					</div>
				</div>
				<div class="col-100">
					<div class="form-group">
						<label class="col-25 form-label">사용여부</label>
						<div class="col-75">
							<div class="form-input-box">
								<div class="button-Rsmall d-inblock">
									<input type="radio" id="useY" name="useYn" value="Y">
									<label for="useY" class="mr05">Yes</label>
								</div>
								<div class="button-Rsmall d-inblock">
									<input type="radio" id="useN" name="useYn" value="N">
									<label for="useN" class="mr05">No</label>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label-textarea">비고</label>
						<div class="col-75">
							<div class="form-input">
								<textarea id="codeDsc" name="codeDsc" class="textarea"></textarea>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 버튼 -->
		<div class="modal-footer btn-group">
			<button type="button" class="button btn-success insert" id="regBtn">저장</button>
			<button type="button" class="button btn-cancel cancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>
</form>

<!-- 레이어 팝업 - delete -->
<div id="delete" class="modal" data-backdrop-limit="1" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
	data-modal-parent="#myModal">
	<!-- Modal content-->
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
							<em class="text-bold delName">PEuser01</em> 삭제합니다.
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="modal-footer btn-group">
			<button type="button" class="button btn-warning" id="deleteAction" data-dismiss="modal">삭제</button>
			<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>

<script type="text/javascript">
	/**
	 * 페이징 처리 공통 함수
	 */
	var totalPage = ${pages.totalPage};
	var page = ${pages.page};
	var pageSize = ${pages.pageSize};

	// var totalPageCnt = 10;
	// var pageCnt = 2; 
	// var pageSizeCnt = 10; 

	$('.board-paging').bootpag({ // 페이징을 표시할 div의 클래스
		total : totalPage, // 페이징모델의 전체페이지수
		page : page, // 페이징모델의 현재페이지번호
		maxVisible : pageSize, // 보여질 최대 페이지수
		firstLastUse : true, // first와 last사용유무
		wrapClass : 'paging', // 페이징을 감싼 클래스명
		activeClass : 'on', // 현재페이지의 클래스명
		disabledClass : 'disabled', // 각 항목별 클래스 지정
		nextClass : 'next',
		prevClass : 'prev',
		lastClass : 'last',
		firstClass : 'first',
	}).on("page", function(event, num) {
		$("#page").val(num);
		$("#searchFrm").submit();
	});

	//코드를 조회한다.
	function viewCode(groupCd, groupNm, groupDesc, groupUseYn) {
		$.getJSON("/system/code/detail/" + groupCd, function(codes) {
			printCode(groupCd, groupNm, groupDesc, groupUseYn, codes,
					$('#codeDiv'), codeTemplate);
		});
	}

	// 그룹 코드에 대한 하위 코드를 출력한다.
	function printCode(groupCd, groupNm, groupDesc, groupUseYn, codeArr,
			targetId, templateId) {
		let codeTemplate = Handlebars.compile(templateId);
		let html = codeTemplate(codeArr);
		targetId.html(html);

		// 코드 입력 화면을 클리어 한다.
		clearInputCode();

		// 그룹 코드 셋팅
		$('#groupCodeId').val(groupCd);
		$('#groupCodeId').attr('readonly', true);
		$('#groupCodeNm').val(groupNm);
		$('#groupCodeDsc').val(groupDesc);
		$("input:radio[name='groupCodeUseYn'][value='" + groupUseYn + "']")
				.prop("checked", true);

		// 코드 입력 창에 값을 셋팅한다.
		$('#groupId').val(groupCd);
		$('#groupNm').val(groupNm);
		$('#codeInput').show();
		$('#codeDiv').show();
		$('#saveCode').show();
		//$('#addCode').hide();
	}

	//코드 입력창을 초기화한다.
	function clearInputCode() {
		$('#codeId').val('');
		$('#codeId').removeAttr('readonly');
		$('#codeNm').val('');
		$('#codeDsc').val('');
		$('#ordSeq').val('');
		$("input:radio[name='useYn']").prop("checked", false);
	}
	
	/*상세을 눌렀을때*/
	function resetView(){
		$('#register .modal-title').text('등록');
		$('#register input').attr('disabled',true);
		$('#register select').attr('disabled',true);
		$('#regBtn').removeClass('insert');
		$('#regBtn').addClass('edit');
		$('#regBtn').text('수정');
	}
	
	/*취소 또는 닫기를 눌렀을때*/
	function resetInput(){
		$('#register input').attr('disabled',false);
		$('#register select').attr('disabled',false);
		$('#register textarea').attr('disabled',false);
		$('#register input').val('');
		$('#register textarea').val('');
		$('#useY').val('Y');
		$('#useN').val('N');
		$('#useY').prop('checked',true);
		$('#regBtn').removeClass('edit');
		$('#regBtn').removeClass('save');
		$('#regBtn').addClass('insert');
	}
	
	/*수정을 눌렀을때*/
	function setEdit(){
		$('#register .modal-title').text('수정');
		$('#register input').attr('disabled',false);
		$('#register textarea').attr('disabled',false);
		$('#register select').attr('disabled',false);
		$('#rgstDt').attr('disabled',true);
		$('#modiDt').attr('disabled',true);
		$('#register #codeId').attr('disabled',true);
		$('#regBtn').removeClass('edit');
		$('#regBtn').text('저장');
		$('#regBtn').addClass('save');
	}
	
	/*상세보기 눌렀을때 데이터 적용*/
	function setView(data){
		$('#codeId').val(data.codeId);
		$('#codeNm').val(data.codeNm);
		$('#codeDsc').val(data.codeDsc);
		$('#rgstDt').val(data.rgstDt);
		$('#modiDt').val(data.modiDt);
		$('#use'+data.useYn).prop('checked',true);
	}
	
	function insert(){
		if(valyCheck()){
			var param =  $('#frm').serialize();
			insertAjax(param,'insert');
		}
	}
	
	function update(){
		$('#register #codeId').attr('disabled',false);
		if(valyCheck()){
			var param =  $('#frm').serialize();
			insertAjax(param,'update');
		}
	}
	
	function insertAjax(param,action){
		$.ajax({
		    type : 'post',
		    url : '/system/code/insert',
		    data : param,
		    dataType : 'text',
		    error: function(xhr, status, error){
		        console.log(error);
		    },
		    success : function(result){
		    	if(result == 'Update' || result == 'Insert'){
		    		location.href = '/system/code';
		    	}
		    }
		});
	}
	
	/*삭제를 눌렀을때*/
	function deleteSet(reportId){
		$('.delName').text(reportId);
		$('#reportId').val(reportId);
	}
	
	/*상세를 눌렀을때*/
	function detailView(id){
		resetView();
		$('#register .input').attr('disabled',true);
		$('#register .textarea').attr('disabled',true);
		$('#regDt').show();
		$('#modDt').show();
		
		$.ajax({
			url : '/system/code/detail/'+id,
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
	
	$('#deleteAction').click(function(){
		deleteAjax();
	});
	
	function deleteAjax(){
		param = {
				reportId : $('#reportId').val()
		}
		$.ajax({
		    type : 'post',
		    url : '/menu/report/delete',
		    data : param,
		    dataType : 'text',
		    error: function(xhr, status, error){
		        console.log(error);
		    },
		    success : function(result){
		    	if(result == 'Delete'){
		    		location.href = '/menu/report';
		    	}
		    }
		});
	}
	
	function valyCheck(){
		if($('#codeId').val() == ''){
			alert('코드 ID을 입력해 주세요.');
			$('#codeId').focus();
			return false;
		}
		if($('#codeNm').val() == ''){
			alert('코드 명을 입력해 주세요.');
			$('#codeNm').focus();
			return false;
		}
		return true;
	}
	
	$(document).ready(function() {
		var searchKey = '${pages.searchKey}';
		if(searchKey){
			$('#searchKey').val('${pages.searchKey}');
		}
		
		$('#registView').click(function(){
			resetInput();
			$('#register .modal-title').text('등록');
			$('#register .insert').text('저장');
			$('#regDt').hide();
			$('#modDt').hide();
		});
		
		$('.close, .cancel').click(function(){
			resetInput();
		});
		
		$('#regBtn').click(function(){
			if($('#regBtn').hasClass('insert')){
				insert();
			}
			if($('#regBtn').hasClass('save')){
				update();
			}
			if($('#regBtn').hasClass('edit')){
				setEdit();
			}
		});
		
		$('.delete').click(function(){
			deleteAjax();
		});
		
		$('.search-box-append').click(function(){
			$('#searchFrm').submit();
		});
	});
</script>