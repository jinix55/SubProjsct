<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<form id="frm">
<div class="content">
	<div class="d-flex">
		<span class="pt10 pr10">ㆍ갱신일</span>
		<input type="hidden" id="revisionYear" name="revisionYear" value="${revisionYear }">
		<input type="hidden" id="revisionMonth" name="revisionMonth" value="${revisionMonth }">
		<input type="hidden" id="codeId" name="codeId" value="${codeId }">
		<input type="hidden" id="groupId" name="groupId" value="groupId">
		<select class="select-box w150">
			<c:forEach items="${dayList }" var="list">
				<option value="${list.revisionYear}-${list.revisionMonth}">${list.revisionYear}년 ${list.revisionMonth}월</option>
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
												<tr>
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
														<a href="#coderegister_s" role="button" data-toggle="modal" class="button-Csmall">내용 관리</a>
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
			<button type="button" class="button btn-success middleCodeInsert" data-dismiss="modal">저장</button>
			<button type="button" class="button btn-cancel middleCodeCancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>
</form>

<!-- 레이어 팝업 - 소분류등록  -->
<form id="">
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
			<button type="button" class="button btn-success smallCodeInsert" data-dismiss="modal">저장</button>
			<button type="button" class="button btn-cancel smallCodeInsert" data-dismiss="modal">취소</button>
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
			var param = $('#frm').serialize();
			$('#frm').attr('action','/system/environmentCode');
			$('#frm').submit();
		});
	
	});
	
	//코드 입력창을 초기화한다.
	function clearInputCode() {
		$('#codeId').val('');
		$('#codeId').removeAttr('readonly');
		$('#codeNm').val('');
		$('#codeDsc').val('');
		$('#ordSeq').val('');
		$("input:radio[name='useYn']").prop("checked", false);
	}
	
	function resetInput(){
		
	}

	function insertCode() {
		if (valyCheck()) {
			var param = $('#frm').serialize();
			insertAjax(param, 'insert');
		}
	}
	

	function updateCode() {
		if (valyCheck()) {
			var param = $('#frm').serialize();
			insertAjax(param, 'insert');
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
			insertAjax(param, 'insert');
		}
	}
	

	function actionAjax(param, action) {
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