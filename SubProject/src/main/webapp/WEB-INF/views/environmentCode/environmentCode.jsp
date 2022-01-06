<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="content">
	<div class="d-flex">
		<span class="pt10 pr10">ㆍ코드변경시점</span> <select class="select-box w150">
			<option value="0">2021년 1월</option>
			<option value="1">2021년 8월</option>
			<option value="3">2022년 1월</option>
		</select>
	</div>
	<div class="row pt30">
		<!-- S_left-area -->
		<div class="code-left-wrap">
			<h4 class="code-tit">ㆍ환경부코드등록 > 대분류</h4>
			<div class="left-area">
				<div class="content">
					<div class="d-flex">
						<span class="pt10 pr10">ㆍ재질</span> <select class="select-box w150">
							<option value="0">선택</option>
							<option value="0">종이팩</option>
							<option value="1">유리병</option>
							<option value="3">금속팩</option>
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
										<th scope="col">대분류코드</th>
										<th scope="col">대분류코드명</th>
										<th scope="col">관리</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td class="text-point">01</td>
										<td>종이팩</td>
										<td>
											<div class="btn-group">
												<a href="#edit" role="button" data-toggle="modal"
													class="btn-icon"><img src="../images/icon_edit.png"
													alt="수정하기" class="btn-Ticon02"></a> <a href="#delete"
													role="button" data-toggle="modal" class="btn-icon"><img
													src="../images/icon_delete2.png" alt="삭제하기"
													class="btn-Ticon02"></a>
											</div>
										</td>
									</tr>
									<tr>
										<td>2</td>
										<td class="text-point">02</td>
										<td>유리병</td>
										<td>
											<div class="btn-group">
												<a href="#edit" role="button" data-toggle="modal"
													class="btn-icon"><img src="../images/icon_edit.png"
													alt="수정하기" class="btn-Ticon02"></a> <a href="#delete"
													role="button" data-toggle="modal" class="btn-icon"><img
													src="../images/icon_delete2.png" alt="삭제하기"
													class="btn-Ticon02"></a>
											</div>
										</td>
									</tr>
									<tr>
										<td>3</td>
										<td class="text-point">03</td>
										<td>금속캔(철캔)</td>
										<td>
											<div class="btn-group">
												<a href="#edit" role="button" data-toggle="modal"
													class="btn-icon"><img src="../images/icon_edit.png"
													alt="수정하기" class="btn-Ticon02"></a> <a href="#delete"
													role="button" data-toggle="modal" class="btn-icon"><img
													src="../images/icon_delete2.png" alt="삭제하기"
													class="btn-Ticon02"></a>
											</div>
										</td>
									</tr>
									<tr>
										<td>4</td>
										<td class="text-point">04</td>
										<td>금속캔(알루미늄)</td>
										<td>
											<div class="btn-group">
												<a href="#edit" role="button" data-toggle="modal"
													class="btn-icon"><img src="../images/icon_edit.png"
													alt="수정하기" class="btn-Ticon02"></a> <a href="#delete"
													role="button" data-toggle="modal" class="btn-icon"><img
													src="../images/icon_delete2.png" alt="삭제하기"
													class="btn-Ticon02"></a>
											</div>
										</td>
									</tr>
									<tr>
										<td>5</td>
										<td class="text-point">05</td>
										<td>일반 발포합성수지 단일·복합재질</td>
										<td>
											<div class="btn-group">
												<a href="#edit" role="button" data-toggle="modal"
													class="btn-icon"><img src="../images/icon_edit.png"
													alt="수정하기" class="btn-Ticon02"></a> <a href="#delete"
													role="button" data-toggle="modal" class="btn-icon"><img
													src="../images/icon_delete2.png" alt="삭제하기"
													class="btn-Ticon02"></a>
											</div>
										</td>
									</tr>
									<tr>
										<td>6</td>
										<td class="text-point">06</td>
										<td>폴리스티렌페이퍼(PSP)</td>
										<td>
											<div class="btn-group">
												<a href="#edit" role="button" data-toggle="modal"
													class="btn-icon"><img src="../images/icon_edit.png"
													alt="수정하기" class="btn-Ticon02"></a> <a href="#delete"
													role="button" data-toggle="modal" class="btn-icon"><img
													src="../images/icon_delete2.png" alt="삭제하기"
													class="btn-Ticon02"></a>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<!-- E_그리드-->
					<div class="btn-group pt15 tr">
						<button type="button" class="button btn-success" data-toggle="modal" href="#coderegister_m">
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
			<h4 class="code-tit">ㆍ환경부코드등록 > 중분류</h4>
			<div class="right-area">
				<div class="content">
				<!-- S_검색-->
					<form>
						<div class="justify-content-between">
							<div class="form-group">
								<div class="form-inline">
									<select class="select-box w150">
										<option value="0">사용자 ID</option>
										<option value="1">그룹 ID</option>
									</select>
								</div>
								<div class="form-inline">
									<div class="search-box w250">
										<input type="text" class="text-input"> <span
											class="search-box-append">
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
										<th scope="col">중분류코드</th>
										<th scope="col">중분류코드명</th>
										<th scope="col">서브코드관리</th>
										<th scope="col">관리</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td class="text-point">01</td>
										<td>몸체</td>
										<td><a href="#coderegister_s" role="button"
											data-toggle="modal" class="button-Csmall">코드등록</a></td>
										<td>
											<div class="btn-group">
												<a href="#edit" role="button" data-toggle="modal"
													class="btn-icon"><img src="../images/icon_edit.png"
													alt="수정하기" class="btn-Ticon02"></a> <a href="#delete"
													role="button" data-toggle="modal" class="btn-icon"><img
													src="../images/icon_delete2.png" alt="삭제하기"
													class="btn-Ticon02"></a>
											</div>
										</td>
									</tr>
									<tr>
										<td>2</td>
										<td class="text-point">02</td>
										<td>마개및잡자재</td>
										<td><a href="#coderegister_s" role="button"
											data-toggle="modal" class="button-Csmall">코드등록</a></td>
										<td>
											<div class="btn-group">
												<a href="#edit" role="button" data-toggle="modal"
													class="btn-icon"><img src="../images/icon_edit.png"
													alt="수정하기" class="btn-Ticon02"></a> <a href="#delete"
													role="button" data-toggle="modal" class="btn-icon"><img
													src="../images/icon_delete2.png" alt="삭제하기"
													class="btn-Ticon02"></a>
											</div>
										</td>
									</tr>
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
					<!-- S_페이징
									<div class="board-paging">
										<ul>
											<li><a href="#" class="start">◀</a></li>
											<li class="on"><a href="#">1</a></li>
											<li><a href="#">2</a></li>
											<li><a href="#">3</a></li>
											<li><a href="#">4</a></li>
											<li><a href="#">5</a></li>
											<li><a href="#" class="last">▶</a></li>
										</ul>
									</div>
									 E_페이징-->
				</div>
			</div>
		</div>
	</div>
	<!-- E_right-area -->
</div>

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
			<button type="button" class="button btn-success" data-dismiss="modal">저장</button>
			<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>

<!-- 레이어 팝업 - 대분류등록  -->
<div id="edit" class="modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width: 500px">
		<div class="modal-header">
			<h4 class="modal-title">수정</h4>
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
								<input type="text" class="text-input" value="FAQ_CAT" disabled>
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
			<button type="button" class="button btn-success" data-dismiss="modal">확인</button>
		</div>
	</div>
</div>

<!-- 레이어 팝업 - 중분류등록  -->
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
								<input type="text" class="text-input" value="FAQ_CAT" disabled>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">대분류코드명</label>
						<div class="col-75">
							<div class="form-input">
								<input type="text" class="text-input" value="FAQ_CAT" disabled>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">중분류코드</label>
						<div class="col-75">
							<div class="form-input">
								<input type="text" class="text-input" value="FAQ_CAT">
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">중분류코드명</label>
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
			<button type="button" class="button btn-success" data-dismiss="modal">저장</button>
			<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>

<!-- 레이어 팝업 - 소분류등록  -->
<div id="coderegister_s" class="modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width: 800px">
		<div class="modal-header">
			<h4 class="modal-title">소분류 코드 등록</h4>
			<button type="button" class="close" data-dismiss="modal">
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
								<th scope="col">소분류코드</th>
								<th scope="col">소분류코드명</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>FAQ_CAT</td>
								<td>FAQ 카테고리</td>
							</tr>
							<tr>
								<td>FAQ_CAT</td>
								<td>FAQ 카테고리</td>
							</tr>
							<tr>
								<td>FAQ_CAT</td>
								<td>FAQ 카테고리</td>
							</tr>
							<tr>
								<td>FAQ_CAT</td>
								<td>FAQ 카테고리</td>
							</tr>
							<tr>
								<td>FAQ_CAT</td>
								<td>FAQ 카테고리</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="right-wrap">
					<div class="col-100">
						<div class="form-group">
							<label class="col-25 form-label">중분류코드</label>
							<div class="col-75">
								<div class="form-input">
									<input type="text" class="text-input" value="FAQ_CAT" disabled>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label">중분류코드명</label>
							<div class="col-75">
								<div class="form-input">
									<input type="text" class="text-input" value="FAQ_CAT" disabled>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label">소분류코드</label>
							<div class="col-75">
								<div class="form-input">
									<input type="text" class="text-input" value="FAQ_CAT">
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label">소분류코드명</label>
							<div class="col-75">
								<div class="form-input">
									<input type="text" class="text-input" value="FAQ 카테고리">
								</div>
							</div>
						</div>
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
			</div>
		</div>
		<!-- 버튼 -->
		<div class="modal-footer btn-group">
			<button type="button" class="button btn-success" data-dismiss="modal">저장</button>
			<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>

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
	/**
	 * 페이징 처리 공통 함수
	 */
	var totalPage = $
	{
		pages.totalPage
	};
	var page = $
	{
		pages.page
	};
	var pageSize = $
	{
		pages.pageSize
	};
	var setGrpId;
	var setCodeId;
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
	function resetView() {
		$('#register .modal-title').text('등록');
		$('#register input').attr('disabled', true);
		$('#register select').attr('disabled', true);
		$('#regBtn').removeClass('insert');
		$('#regBtn').addClass('edit');
		$('#regBtn').text('수정');
	}

	/*취소 또는 닫기를 눌렀을때*/
	function resetInput() {
		$('#register input').attr('disabled', false);
		$('#register select').attr('disabled', false);
		$('#register textarea').attr('disabled', false);
		$('#register input').val('');
		$('#register textarea').val('');
		$('#useY').val('Y');
		$('#useN').val('N');
		$('#useY').prop('checked', true);
		$('#regBtn').removeClass('edit');
		$('#regBtn').removeClass('save');
		$('#regBtn').addClass('insert');
	}

	/*수정을 눌렀을때*/
	function setEdit() {
		$('#register .modal-title').text('수정');
		$('#register input').attr('disabled', false);
		$('#register textarea').attr('disabled', false);
		$('#register select').attr('disabled', false);
		$('#rgstDt').attr('disabled', true);
		$('#modiDt').attr('disabled', true);
		$('#register #codeId').attr('disabled', true);
		$('#regBtn').removeClass('edit');
		$('#regBtn').text('저장');
		$('#regBtn').addClass('save');
	}

	/*상세보기 눌렀을때 데이터 적용*/
	function setView(data) {
		$('#register #codeId').val(data.codeId);
		$('#register #codeNm').val(data.codeNm);
		$('#register #codeDsc').val(data.codeDsc);
		$('#register #rgstDt').val(data.rgstDt);
		$('#register #modiDt').val(data.modiDt);
		$('#register #use' + data.useYn).prop('checked', true);
	}

	function insert() {
		if (valyCheck()) {
			var param = $('#frm').serialize();
			insertAjax(param, 'insert');
		}
	}

	function insertCode(id) {
		$('#tr_' + setGrpId + '_input #groupId').attr('disabled', false);
		if (valyCheck()) {
			var param = $('#inputFrm_' + setGrpId).serialize();
			insertAjax(param, 'insert/code');
		}
	}

	function update() {
		$('#register #codeId').attr('disabled', false);
		if (valyCheck()) {
			var param = $('#frm').serialize();
			insertAjax(param, 'insert');
		}
	}

	function insertAjax(param, action) {
		$.ajax({
			type : 'post',
			url : '/system/code/' + action,
			data : param,
			dataType : 'text',
			error : function(xhr, status, error) {
				console.log(error);
			},
			success : function(result) {
				if (result == 'Update' || result == 'Insert') {
					location.href = '/system/code';
				}
			}
		});
	}

	/*삭제를 눌렀을때*/
	function deleteSet(codeId) {
		$('.delName').text(codeId);
		$('#codeId').val(codeId);
	}

	/*상세를 눌렀을때*/
	function upCodeList(id, nm) {
		$.ajax({
			url : '/system/code/detail/code/' + id,
			dataType : 'json',
			type : "POST",
			async : false,
			success : function(data) {
				var result = data;
				console.log(result);
				makeUpCodeList(data, id, nm);
			}
		});
	}

	function makeUpCodeList(data, id, nm) {
		$('#tr_' + id + '_tb').empty();
		var html = '';
		if (data.length > 0) {
			data
					.forEach(function(item, index) {
						var ordSeq = '';
						var codeDsc = '';
						html += '<tr onclick="selectTr(\'' + item.groupId
								+ '\',\'' + item.codeId + '\',\'' + item.codeNm
								+ '\',\'' + item.useYn + '\',\'' + item.codeDsc
								+ '\',\'' + item.ordSeq + '\');">';
						html += '	<td>' + (index + 1) + '</td>';
						html += '	<td class="text-point tr-item">'
								+ item.codeId + '</td>';
						html += '	<td>' + item.codeNm + '</td>';
						html += '	<td>' + item.rgstDt + '</td>';
						if (item.ordSeq == null) {
							ordSeq = '-';
						} else {
							ordSeq = item.ordSeq;
						}

						if (item.codeDsc == null) {
							codeDsc = '-';
						} else {
							codeDsc = item.codeDsc;
						}

						html += '	<td>' + ordSeq + '</td>';
						html += '	<td>' + codeDsc + '</td>';
						html += '	<td>';
						if (item.useYn == 'Y') {
							html += '		<button type="button" class="button-yes">YES</button>';
						} else {
							html += '		<button type="button" class="button-no">NO</button>';
						}
						html += '	</td>';
						html += '</tr>';
					});
			$('#tr_' + id + '_tb').append(html);
		} else {
			html += '<tr>';
			html += '	<td colspan="7">';
			html += '		등록된 코드가 없습니다.';
			html += '	</td>';
			html += '</tr>';
			$('#tr_' + id + '_tb').append(html);
		}
		makeInputList(data, id, nm);
	}

	function makeInputList(data, groupId, grpNm) {
		$('.row-grp').empty();
		$('.btn-grp').empty();
		var html = '';
		html += '	<div class="col-50">';
		html += '		<div class="form-group">';
		html += '			<label class="col-25 form-label">코드그룹 ID</label>';
		html += '			<div class="col-75">';
		html += '				<div class="form-input">';
		html += '					<input id="groupId" name="groupId" type="text" class="text-input" value="'+groupId+'" disabled>';
		html += '				</div>';
		html += '			</div>';
		html += '		</div>';
		html += '	</div>';
		html += '	<div class="col-50">';
		html += '		<div class="form-group">';
		html += '			<label class="col-25 form-label">코드그룹명</label>';
		html += '			<div class="col-75">';
		html += '				<div class="form-input">';
		html += '					<input id="grpNm" name="grpNm" type="text" class="text-input" value="'+grpNm+'" disabled>';
		html += '				</div>';
		html += '			</div>';
		html += '		</div>';
		html += '	</div>';
		html += '	<div class="col-50">';
		html += '		<div class="form-group">';
		html += '			<label class="col-25 form-label">코드 ID</label>';
		html += '			<div class="col-75">';
		html += '				<div class="form-input">';
		html += '					<input id="codeId" name="codeId" type="text" class="text-input" value="">';
		html += '				</div>';
		html += '			</div>';
		html += '		</div>';
		html += '	</div>';
		html += '	<div class="col-50">';
		html += '		<div class="form-group">';
		html += '			<label class="col-25 form-label">코드명</label>';
		html += '			<div class="col-75">';
		html += '				<div class="form-input">';
		html += '					<input id="codeNm" name="codeNm" type="text" class="text-input" value="">';
		html += '				</div>';
		html += '			</div>';
		html += '		</div>';
		html += '	</div>';
		html += '	<div class="col-50">';
		html += '		<div class="form-group">';
		html += '			<label class="col-25 form-label">정렬순서</label>';
		html += '			<div class="col-75">';
		html += '				<div class="form-input">';
		html += '					<input id="ordSeq" name="ordSeq" type="text" class="text-input" value="">';
		html += '				</div>';
		html += '			</div>';
		html += '		</div>';
		html += '	</div>';
		html += '	<div class="col-50">';
		html += '		<div class="form-group">';
		html += '			<label class="col-25 form-label">사용여부</label>';
		html += '			<div class="col-75">';
		html += '				<div class="form-input-box tl">';
		html += '					<div class="button-Rsmall d-inblock">';
		html += '						<input type="radio" id="code_useY" name="code_useYn" value="Y" checked="checked">';
		html += '						<label for="code_useY" class="mr05">Yes</label>';
		html += '					</div>';
		html += '					<div class="button-Rsmall d-inblock">';
		html += '						<input type="radio" id="code_useN" name="code_useYn" value="N">';
		html += '						<label for="code_useN" class="mr05">No</label>';
		html += '					</div>';
		html += '				</div>';
		html += '			</div>';
		html += '		</div>';
		html += '	</div>';
		html += '	<div class="col-100">';
		html += '		<div class="form-group">';
		html += '			<label class="col-25 form-label-textarea">비고</label>';
		html += '			<div class="col-75">';
		html += '				<div class="form-input">';
		html += '					<textarea id="codeDsc" name="codeDsc" class="textarea"></textarea>';
		html += '				</div>';
		html += '			</div>';
		html += '		</div>';
		html += '	</div>';
		$('#tr_' + groupId + '_input').append(html);
		$('#code_useY').prop('checked', true);
		makeBtn(groupId, grpNm, data.codeId);
	}

	function makeBtn(groupId, grpNm, codeId) {
		var html = '';
		html += '<button type="button" class="button btn-success" id="insertBtn" onclick="insertBtn('
				+ groupId
				+ ','
				+ grpNm
				+ ');" data-dismiss="modal">신규</button>';
		html += '<button type="button" class="button btn-success" id="modifyBtn" onclick="insertCode('
				+ groupId + ');" data-dismiss="modal">저장</button>';
		html += '<button type="button" class="button btn-cancel" id="deleteBtn" onclick="deleteBtn('
				+ groupId + ');" data-dismiss="modal">삭제</button>';
		html += '<button type="button" class="button btn-cancel" id="cancelBtn" onclick="cancelBtn();" data-dismiss="modal">취소</button>';
		$('#tr_' + groupId + '_btn').append(html);
		$('#insertBtn').hide();
		$('#deleteBtn').hide();
	}

	function selectTr(grp, id, nm, yn, dsc, seq) {
		setCodeId = id;
		setGrpId = grp;
		var orSeq = '';
		var codeDsc = '';
		var useYn = '';
		if (seq == 'null') {
			orSeq = '';
		} else {
			orSeq = seq;
		}
		if (dsc == 'null') {
			codeDsc = '';
		} else {
			codeDsc = dsc;
		}
		if (yn == 'null') {
			useYn = 'N';
		} else {
			useYn = 'Y';
		}
		$('#tr_' + grp + '_input #groupId').val(grp);
		$('#tr_' + grp + '_input #codeId').val(id);
		$('#tr_' + grp + '_input #codeNm').val(nm);
		$('#tr_' + grp + '_input #code_use' + useYn).prop('checked', true);
		$('#tr_' + grp + '_input #codeDsc').val(dsc);
		$('#tr_' + grp + '_input #ordSeq').val(orSeq);
		$('#insertBtn').show();
		$('#deleteBtn').show();
	}

	function insertBtn(groupId, grpNm) {
		$('#tr_' + groupId + '_input #groupId').val(groupId);
		$('#tr_' + groupId + '_input #groupNm').val(grpNm);
		$('#tr_' + groupId + '_input #codeId').val('');
		$('#tr_' + groupId + '_input #codeNm').val('');
		$('#tr_' + groupId + '_input #code_useY').prop('checked', true);
		$('#tr_' + groupId + '_input #codeDsc').val('');
		$('#tr_' + groupId + '_input #ordSeq').val('');
		$('#insertBtn').hide();
		$('#deleteBtn').hide();
	}

	function deleteBtn(groupId) {
		param = {
			groupId : groupId,
			codeId : setCodeId
		}

		$.ajax({
			type : 'post',
			url : '/system/code/delete/code',
			data : param,
			dataType : 'text',
			error : function(xhr, status, error) {
				console.log(error);
			},
			success : function(result) {
				if (result == 'Delete') {
					location.href = '/system/code';
				}
			}
		});
	}

	function cancelBtn(groupId) {
		$('#insertBtn').hide();
		$('#deleteBtn').hide();
		$('.tr-show').addClass('tr-hide');
		$('.tr-hide').removeClass('tr-show');
	}

	/*상세를 눌렀을때*/
	function detailView(id) {
		resetView();
		$('#register .input').attr('disabled', true);
		$('#register .textarea').attr('disabled', true);
		$('#regDt').show();
		$('#modDt').show();

		$.ajax({
			url : '/system/code/detail/' + id,
			dataType : 'json',
			type : "POST",
			async : false,
			success : function(data) {
				var result = data;
				console.log(result);
				setView(data);
			}
		});
	}

	$('#deleteAction').click(function() {
		if (isDisabled) {
			return false;
		} else {
			isDisabled = true;
			deleteAjax();
		}
	});

	function deleteAjax() {
		param = {
			codeId : $('#codeId').val()
		}
		$.ajax({
			type : 'post',
			url : '/system/code/delete',
			data : param,
			dataType : 'text',
			error : function(xhr, status, error) {
				console.log(error);
			},
			success : function(result) {
				if (result == 'Delete') {
					location.href = '/system/code';
				}
				if (result == 'UseCodeId') {
					alert('상세코드에 사용중인 코드가 있습니다.');
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

	$(document).ready(function() {
		var searchKey = '${pages.searchKey}';
		if (searchKey) {
			$('#searchKey').val('${pages.searchKey}');
		}

		$('#insertBtn').hide();
		$('#deleteBtn').hide();

		$('#registView').click(function() {
			resetInput();
			$('#register .modal-title').text('등록');
			$('#register .insert').text('저장');
			$('#regDt').hide();
			$('#modDt').hide();
		});

		$('.close, .cancel').click(function() {
			resetInput();
		});

		$('#regBtn').click(function() {
			if ($('#regBtn').hasClass('insert')) {
				if (isDisabled) {
					return false;
				} else {
					isDisabled = true;
					insert();
				}
			}
			if ($('#regBtn').hasClass('save')) {
				if (isDisabled) {
					return false;
				} else {
					isDisabled = true;
					update();
				}
			}
			if ($('#regBtn').hasClass('edit')) {
				setEdit();
			}
		});

		$('.delete').click(function() {
			if (isDisabled) {
				return false;
			} else {
				isDisabled = true;
				insert();
			}
		});

		$('#insertCode').click(function() {
			if (isDisabled) {
				return false;
			} else {
				isDisabled = true;
				insertCode();
			}
		});

		$('.tr-item').click(function() {
			setGrpId = $(this).parent().attr('id');
			upCodeList(setGrpId, $(this).parent().attr('nm'));
		});

		$('.search-box-append').click(function() {
			if (isDisabled) {
				return false;
			} else {
				isDisabled = true;
				$('#searchFrm').submit();
			}
		});
	});
</script>