<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<form id="frm">
<div class="content">
	<input type="hidden" id="largeCategory" name="largeCategory" value="${setLargeCategory }">
	<input type="hidden" id="middleCategory" name="middleCategory" value="${setMiddleCategory }">
	<input type="hidden" id="smallCategory" name="smallCategory" value="${setSmallCategory }">
	<input type="hidden" id="largeCategoryNm" name="largeCategoryNm" value="${setLargeCategoryNm }">
	<div class="row pt30">
		<!-- S_left-area -->
		<div class="pack-left-wrap">
			<h4 class="code-tit">ㆍ분류그룹등록 > 대분류</h4>
			<div class="left-area">
				<div class="content">
					<!-- S_그리드-->
					<div class="content-table">
						<div class="scroll-auto h600auto">
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
								<tbody class="selectHover">
									<c:choose>
										<c:when test="${not empty largeCodeList }">
											<c:forEach items="${largeCodeList }" var="list" varStatus="status">
												<tr>
													<td>${status.count}</td>
													<td id="tr_${list.codeId }" onclick="selectTr(this);" class="text-point">${list.codeId }</td>
													<td>${list.codeNm }</td>
													<td>
														<div class="btn-group">
															<a id="setLarge_${list.codeId }" upId="setLarge_${list.groupId }" nm="${list.codeNm }" codeKey="${list.codeKey }" codeDsc="${list.codeDsc }" ordSeq="${list.ordSeq }" href="#coderegister_b" role="button" onclick="largeViewSet(this);" data-toggle="modal" class="btn-icon">
																<img src="/images/icon_edit.png" alt="수정하기" class="btn-Ticon02">
															</a>
															<a href="#delete" role="button" onclick="deleteLargeSet('${list.groupId}','${list.codeId}');" data-toggle="modal" class="btn-icon">
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
						<button type="button" class="button btn-success" id="largeCodeInsert" data-toggle="modal" href="#coderegister_b">
							대분류 등록
<!-- 							<a href="#coderegister_m" data-toggle="modal">대분류 등록</a> -->
						</button>
					</div>
				</div>
			</div>
		</div>
		<!-- E_left-area -->
		<!-- S_right-area -->
		<div class="pack-right-wrap">
			<h4 class="code-tit">ㆍ분류그룹등록 > 중분류</h4>
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
<%-- 									<col style="width: 150px;"> --%>
									<col style="width: 90px;">
								</colgroup>
								<thead>
									<tr class="th-bg">
										<th scope="col">번호</th>
										<th scope="col">중분류코드</th>
										<th scope="col">중분류코드명</th>
<!-- 										<th scope="col">서브코드관리</th> -->
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
<!-- 													<td> -->
<%-- 														<a id="tr_${list.codeId }" nm="${list.codeNm }"href="#coderegister_s" role="button" data-toggle="modal" class="button-Csmall" onclick="smallCode(this);">내용 관리</a> --%>
<!-- 													</td> -->
													<td>
														<div class="btn-group">
															<a id="setMid_${list.codeId }" nm="${list.codeNm }" upId="setMid_${list.groupId }" codeKey="${list.codeKey }" ordSeq="${list.ordSeq }" codeDsc="${list.codeDsc }" onclick="middleViewSet(this);" href="#coderegister_m" role="button" data-toggle="modal" class="btn-icon">
																<img src="/images/icon_edit.png" alt="수정하기" class="btn-Ticon02">
															</a>
															<a onclick="deleteMiddleSet('${list.groupId}','${list.codeId}');" href="#delete" role="button" data-toggle="modal" class="btn-icon">
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
<form id="frmLarge">
<div id="coderegister_b" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width: 500px">
		<div class="modal-header">
			<h4 class="modal-title">대분류 등록</h4>
			<button type="button" class="close mid_close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-100" id="largeCodListInput">
					<input type="hidden" id="larGroupId" name="larGroupId">
					<div class="form-group">
						<label class="col-25 form-label">대분류 코드</label>
						<div class="col-75">
							<div class="form-input">
								<input id="larCodeId" name="larCodeId" type="text" class="text-input" placeholder="대분류 코드를 입력해주세요." disabled>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">대분류 명</label>
						<div class="col-75">
							<div class="form-input">
								<input id="larCodeNm" name="larCodeNm" type="text" class="text-input" placeholder="대분류 이름을 입력해주세요." disabled>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">대분류 KEY</label>
						<div class="col-75">
							<div class="form-input">
								<input id="larCodeKey" name="larCodeKey" type="text" class="text-input" placeholder="대분류 키를 입력해주세요." disabled>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">정렬 순서</label>
						<div class="col-75">
							<div class="form-input">
								<input id="larOrdSeq" name="larOrdSeq" type="text" class="text-input" placeholder="정렬 순서를 입력해주세요." disabled>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label-textarea">비고</label>
						<div class="col-75">
							<div class="form-input">
								<textarea id="larCodeDsc" name="larCodeDsc" class="textarea" placeholder="설명을 입력해주세요." disabled></textarea>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 버튼 -->
		<div class="modal-footer btn-group">
			<button type="button" class="button btn-success largeCodeInsert new" >신규</button>
			<button type="button" class="button btn-cancel largeCodeCancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>
</form>


<!-- 레이어 팝업 - 중분류등록  -->
<form id="frmMiddle">
<div id="coderegister_m" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<input type="hidden" id="midRevision" name="midRevision">
	<div class="modal-content" style="width: 500px">
		<div class="modal-header">
			<h4 class="modal-title">중분류 등록</h4>
			<button type="button" class="close mid_close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-100" id="middleCodListInput">
					<div class="form-group">
						<label class="col-25 form-label">대분류 코드</label>
						<div class="col-75">
							<div class="form-input">
								<input id="midGroupId" name="midGroupId" type="text" class="text-input" placeholder="대분류 코드를 입력해주세요." disabled>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">중분류 코드</label>
						<div class="col-75">
							<div class="form-input">
								<input id="midCodeId" name="midCodeId" type="text" class="text-input" placeholder="중분류 코드를 입력해주세요." disabled>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">중분류 명</label>
						<div class="col-75">
							<div class="form-input">
								<input id="midCodeNm" name="midCodeNm" type="text" class="text-input" placeholder="중분류 이름을 입력해주세요." disabled>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">중분류 키</label>
						<div class="col-75">
							<div class="form-input">
								<input id="midCodeKey" name="midCodeKey" type="text" class="text-input" placeholder="중분류 키를 입력해주세요." disabled>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">정렬 순서</label>
						<div class="col-75">
							<div class="form-input">
								<input id="midOrdSeq" name="midOrdSeq" type="text" class="text-input" placeholder="정렬 순서를 입력해주세요." disabled>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label-textarea">비고</label>
						<div class="col-75">
							<div class="form-input">
								<textarea id="midCodeDsc" name="midCodeDsc" class="textarea" placeholder="설명을 입력해주세요." disabled></textarea>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 버튼 -->
		<div class="modal-footer btn-group">
			<button type="button" class="button btn-success middleCodeInsert new" >신규</button>
			<button type="button" class="button btn-cancel middleCodeCancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>
</form>

<!-- 레이어 팝업 - 소분류등록  -->
<form id="frmSmall">
<div id="coderegister_s" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<input type="hidden" id="smlRevision" name="smlRevision">
	<input type="hidden" id="setSmlGroupId" name="groupId">
	<div class="modal-content" style="width: 800px">
		<div class="modal-header">
			<h4 class="modal-title">소분류 등록</h4>
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
								<th scope="col">소분류 코드</th>
								<th scope="col">소분류 명</th>
							</tr>
						</thead>
						<tbody class="selectHover" id="smallCodeList">
						</tbody>
					</table>
				</div>
				<div class="right-wrap" id="smallCodListInput">
					<div class="col-100">
						<div class="form-group">
							<label class="col-25 form-label">중분류 코드</label>
							<div class="col-75">
								<div class="form-input">
									<input id="smlGroupId" name="smlGroupId" type="text" class="text-input" placeholder="중분류 코드를 입력해주세요." disabled>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label">소분류 코드</label>
							<div class="col-75">
								<div class="form-input">
									<input id="smlCodeId" name="smlCodeId" type="text" class="text-input" placeholder="소분류 코드를 입력해주세요." disabled>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label">소분류 명</label>
							<div class="col-75">
								<div class="form-input">
									<input id="smlCodeNm" name="smlCodeNm" type="text" class="text-input" placeholder="소분류 이름을 입력해주세요." disabled>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label">소분류 키</label>
							<div class="col-75">
								<div class="form-input">
									<input id="smlCodeKey" name="smlCodeKey" type="text" class="text-input" placeholder="소분류 키를 입력해주세요." disabled>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label">정렬 순서</label>
							<div class="col-75">
								<div class="form-input">
									<input id="smlOrdSeq" name="smlOrdSeq" type="text" class="text-input" placeholder="정렬 순서를 입력해주세요." disabled>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label-textarea">비고</label>
							<div class="col-75">
								<div class="form-input">
									<textarea id="smlCodeDsc" name="smlCodeDsc" class="textarea" placeholder="설명을 입력해주세요." disabled></textarea>
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
			<button type="button" class="button btn-success smallCodeDelete" style="display:none;" 
				onclick="deleteSmallSet();" href="#delete" role="button" data-toggle="modal" >삭제</button>
			<button type="button" class="button btn-cancel smallCodeCancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>
</form>

<!-- 레이어 팝업 - delete -->
<form id="frmDelCode">
<div id="delete" class="modal" data-backdrop-limit="1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-modal-parent="#myModal">
	<input type="hidden" id="delGroupId" name="delGroupId">
	<input type="hidden" id="delCodeId" name="delCodeId">
	<input type="hidden" id="delRevision" name="delRevision">
	<input type="hidden" id="delType" name="delType">
	<!-- Modal content-->
	<div class="modal-content" style="width: 500px">
		<div class="modal-header">
			<h4 class="modal-title">삭제</h4>
			<button type="button" class="close delPopupCancel" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-100">
					<div class="form-group">
						<div class="tc">
							<em class="text-bold delName"></em>코드를 삭제하시겠습니까?
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="modal-footer btn-group">
			<button type="button" class="button btn-warning" onclick="deleteEnCode();" data-dismiss="modal">삭제</button>
			<button type="button" class="button btn-cancel delPopupCancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>
</form>

<script type="text/javascript">
	$(document).ready(function() {
		$('#midGroupId').val('${packagingCodeModel.middleCategory}');
		console.log('${packagingCodeModel}');
		
		$('.largeCodeCancel, .mid_close').click(function(){
			largeInputReset();
			$('.largeCodeInsert').addClass('new');
			$('.largeCodeInsert').text('신규');
			$('.largeCodeInsert').removeClass('save');
			$('.largeCodeInsert').removeClass('edit');
		});
		
		$('.middleCodeCancel, .mid_close').click(function(){
			middleInputReset();
			$('#midGroupId').val('${packagingCodeModel.groupId}');
			$('.middleCodeInsert').addClass('new');
			$('.middleCodeInsert').text('신규');
			$('.middleCodeInsert').removeClass('save');
			$('.middleCodeInsert').removeClass('edit');
		});
		
		$('.smallCodeCancel, .de_close').click(function(){
			smallInputReset();
			$('.smallCodeInsert').addClass('new');
			$('.smallCodeInsert').text('신규');
			$('.smallCodeInsert').removeClass('save');
			$('.smallCodeInsert').removeClass('edit');
			$('.smallCodeDelete').hide();
		});
		
		$('.largeCodeInsert').click(function(){
			if($('.largeCodeInsert').hasClass('new')){
				$('.largeCodeInsert').text('저장');
				$('.largeCodeInsert').addClass('save');
				$('.largeCodeInsert').removeClass('new');
				$('#larGroupId').val('GROUP_ID');
				$('#larCodeId').attr('disabled',false);
				$('#larCodeKey').attr('disabled',false);
				$('#larCodeNm').attr('disabled',false);
				$('#larOrdSeq').attr('disabled',false);
				$('#larCodeDsc').attr('disabled',false);
			}else{
				if($('.largeCodeInsert').hasClass('save')){
					largeCodeSave();
				}
				if($('.largeCodeInsert').hasClass('edit')){
					largeCodeEdit();
				}
			}
		});
		
		$('.middleCodeInsert').click(function(){
			if($('.middleCodeInsert').hasClass('new')){
				$('.middleCodeInsert').text('저장');
				$('.middleCodeInsert').addClass('save');
				$('.middleCodeInsert').removeClass('new');
				$('#midCodeId').attr('disabled',false);
				$('#midCodeKey').attr('disabled',false);
				$('#midCodeNm').attr('disabled',false);
				$('#midOrdSeq').attr('disabled',false);
				$('#midCodeDsc').attr('disabled',false);
			}else{
				if($('.middleCodeInsert').hasClass('save')){
					middleCodeSave();
				}
				if($('.middleCodeInsert').hasClass('edit')){
					middleCodeEdit();
				}
			}
		});
		
		$('.smallCodeInsert').click(function(){
			if($('.smallCodeInsert').hasClass('new')){
				$('.smallCodeInsert').text('저장');
				$('.smallCodeInsert').addClass('save');
				$('.smallCodeInsert').removeClass('new');
				$('#smlCodeId').attr('disabled',false);
				$('#smlCodeKey').attr('disabled',false);
				$('#smlCodeNm').attr('disabled',false);
				$('#smlOrdSeq').attr('disabled',false);
				$('#smlCodeDsc').attr('disabled',false);
			}else{
				if($('.smallCodeInsert').hasClass('save')){
					smallCodeSave();
				}
				if($('.smallCodeInsert').hasClass('edit')){
					smallCodeEdit();
					$('.smallCodeDelete').hide();
				}
			}
		});
		
		$('.delPopupCancel').click(function(){
			$('.fontColorRed').remove();
		});
	
	});
	
	function largeViewSet(that){
		$('.largeCodeInsert').text('수정');
		$('.largeCodeInsert').removeClass('new');
		$('.largeCodeInsert').addClass('edit');
		var groupId = $(that).attr('upId').replace('setLarge_','');
		var codeId = $(that).attr('id').replace('setLarge_','');
		var codeNm = $(that).attr('nm');
		var codeKey = $(that).attr('codeKey');
		var ordSeq = $(that).attr('ordSeq');
		var codeDsc = $(that).attr('codeDsc');
		$('#larGroupId').val(groupId);
		$('#larCodeId').val(codeId);
		$('#larCodeNm').val(codeNm);
		$('#larCodeKey').val(codeKey);
		$('#larOrdSeq').val(ordSeq);
		$('#larCodeDsc').val(codeDsc);
	}
	
	function middleViewSet(that){
		$('.middleCodeInsert').text('수정');
		$('.middleCodeInsert').removeClass('new');
		$('.middleCodeInsert').addClass('edit');
		var groupId = $(that).attr('upId').replace('setMid_','');
		var codeId = $(that).attr('id').replace('setMid_','');
		var codeNm = $(that).attr('nm');
		var codeKey = $(that).attr('codeKey');
		var ordSeq = $(that).attr('ordSeq');
		var codeDsc = $(that).attr('codeDsc');
		$('#midGroupId').val(groupId);
		$('#midCodeId').val(codeId);
		$('#midCodeNm').val(codeNm);
		$('#midCodeKey').val(codeKey);
		$('#midOrdSeq').val(ordSeq);
		$('#midCodeDsc').val(codeDsc);
	}
	
	function largeCodeEdit(){
		$('#larRevision').val($('#revision').val());
		$('.largeCodeInsert').text('저장');
		$('.largeCodeInsert').removeClass('edit');
		$('.largeCodeInsert').addClass('save');
		$('#larCodeId').attr('disabled',false);
		$('#larCodeKey').attr('disabled',false);
		$('#larCodeNm').attr('disabled',false);
		$('#larOrdSeq').attr('disabled',false);
		$('#larCodeDsc').attr('disabled',false);
	}
	
	function middleCodeEdit(){
		$('#midRevision').val($('#revision').val());
		$('.middleCodeInsert').text('저장');
		$('.middleCodeInsert').removeClass('edit');
		$('.middleCodeInsert').addClass('save');
		$('#midCodeId').attr('disabled',false);
		$('#midCodeKey').attr('disabled',false);
		$('#midCodeNm').attr('disabled',false);
		$('#midOrdSeq').attr('disabled',false);
		$('#midCodeDsc').attr('disabled',false);
	}
	
	function smallCodeEdit(){
		$('.smallCodeInsert').text('저장');
		$('.smallCodeInsert').removeClass('edit');
		$('.smallCodeInsert').addClass('save');
		$('#smallCodListInput #smlCodeId').attr('disabled',false);
		$('#smallCodListInput #smlCodeKey').attr('disabled',false);
		$('#smallCodListInput #smlCodeNm').attr('disabled',false);
		$('#smallCodListInput #smlOrdSeq').attr('disabled',false);
		$('#smallCodListInput #smlCodeDsc').attr('disabled',false);
	}
	
	function largeCodeSave(){
		valyCheck('large');
		if(isDisabled){
			return false;
		}else{
			var action = 'insert/large';
			var param = $('#frmLarge').serialize();
			isDisabled = true;
			insertCodeAjax(param, action);
		}
	}
	
	function middleCodeSave(){
		valyCheck('middle');
		if(isDisabled){
			return false;
		}else{
			$('#midGroupId').attr('disabled',false);
			var action = 'insert/middle'; 
			var param = $('#frmMiddle').serialize();
			isDisabled = true;
			insertCodeAjax(param, action);
		}
	}
	
	function smallCodeSave(){
		valyCheck('small');
		if(isDisabled){
			return false;
		}else{
			$('#smlGroupId').attr('disabled',false);
			var action = 'insert/small'; 
			var param = $('#frmSmall').serialize();
			isDisabled = true;
			insertCodeAjax(param, action);
		}
	}
	
	// 중분류, 소분류 저장및 수정시 사용
	function insertCodeAjax(param, action) {
		$.ajax({
			type : 'post',
			url : '/system/packagingCode/' + action,
			data : param,
			dataType : 'text',
			error : function(xhr, status, error) {
				console.log(error);
			},
			success : function(result) {
				isDisabled = false;
				if(result == 'Update' || result == 'Insert') {
					var param = $('#frm').serialize();
					$('#frm').attr('action','/system/packagingCode');
					$('#frm').submit();
				}
			}
		});
	}
	
	function selectTr(that){
		if(isDisabled){
			return false;
		}else{
			isDisabled = true;
			$('#largeCategory').val('GROUP_ID');
			$('#middleCategory').val($(that).attr('Id').replace('tr_',''));
			var param = $('#frm').serialize();
			$('#frm').attr('action','/system/packagingCode');
			$('#frm').submit();
		}
	}
	
	function smallCode(that){
		if(isDisabled){
			return false;
		}else{
			isDisabled = true;
			$('#smallCategory').val($(that).attr('id').replace('tr_',''));
			$('#smallCategoryNm').val($(that).attr('nm'));
			var param = $('#frm').serialize();
			var action = 'detail/'+$(that).attr('id').replace('tr_',''); 
			smallCodeList(param, action);
		}
	}
	
	function smallCodeSelect(that){
		$('.smallCodeInsert').text('수정');
		$('.smallCodeInsert').removeClass('new');
		$('.smallCodeInsert').removeClass('save');
		$('.smallCodeInsert').addClass('edit');
		$('#smallCodListInput #smlCodeId').attr('disabled',true);
		$('#smallCodListInput #smlCodeKey').attr('disabled',true);
		$('#smallCodListInput #smlCodeNm').attr('disabled',true);
		$('#smallCodListInput #smlOrdSeq').attr('disabled',true);
		$('#smallCodListInput #smlCodeDsc').attr('disabled',true);
		if(isDisabled){
			return false;
		}else{
			isDisabled = true;
			$('#middleCategory').val($(that).attr('id').replace('tr_',''));
			$('#setSmlGroupId').val($(that).attr('gpId'));
			var param = $('#frmSmall').serialize();
			var action = 'detail/select/'+$(that).attr('id').replace('tr_',''); 
			smallCoddSelectAjax(param, action);
			$('.smallCodeDelete').show();
		}
	}
	
	function makeSmallList(data){
		smallInputReset();
		var html = '';
		if(data.length > 0){
			data.forEach(function(item, index) {
				html += '<tr id="tr_'+item.codeId+'" gpId="'+item.groupId+'" onclick="smallCodeSelect(this);">';
				html += '	<td class="text-point" style="text-overflow: ellipsis; overflow:hidden;">'+item.codeId+'</td>';
				html += '	<td style="text-overflow: ellipsis; overflow:hidden;">'+item.codeNm+'</td>';
				html += '</tr>';
			});
		}
		$('#smallCodeList').append(html);
		$('#smlGroupId').val($('#smallCategory').val());
	}
	
	function largeInputReset(){
		$('#largeCodListInput input').val('');
		$('#largeCodListInput textarea').val('');
		$('#largeCodListInput input').attr('disabled',true);
		$('#largeCodListInput textarea').attr('disabled',true);
	}
	
	function middleInputReset(){
		$('#middleCodListInput #midCodeId').val('');
		$('#middleCodListInput #midCodeNm').val('');
		$('#middleCodListInput #midCodeKey').val('');
		$('#middleCodListInput #midOrdSeq').val('');
		$('#middleCodListInput #midCodeDsc').val('');
		$('#middleCodListInput input').attr('disabled',true);
		$('#middleCodListInput textarea').attr('disabled',true);
	}
	
	function smallInputReset(){
		$('#smallCodeList').empty();
		$('#smallCodListInput input').val('');
		$('#smallCodListInput textarea').val('');
		$('#smallCodListInput input').attr('disabled',true);
		$('#smallCodListInput textarea').attr('disabled',true);
	}
	
	function makeSmallView(data){
		$('#smallCodListInput #smlCodeId').val(data.codeId);
		$('#smallCodListInput #smlCodeNm').val(data.codeNm);
		$('#smallCodListInput #smlCodeKey').val(data.codeKey);
		$('#smallCodListInput #smlOrdSeq').val(data.ordSeq);
		$('#smallCodListInput #smlCodeDsc').val(data.codeDsc);
		
	}

	function deleteLargeSet(groupId,codeId) {
		$('.delName').text(codeId);
		$('#delGroupId').val(groupId);
		$('#delCodeId').val(codeId);
		$('#delType').val('large');
		$('.tc').append('<div class="pt05 fontColorRed">ㆍ삭제시 하위 코드 모두 삭제 됩니다.</div>');
	}

	function deleteMiddleSet(groupId,codeId) {
		$('.delName').text(codeId);
		$('#delGroupId').val(groupId);
		$('#delCodeId').val(codeId);
		$('#delType').val('middle');
	}

	function deleteSmallSet() {
		$('.delName').text($('#smlCodeId').val());
		$('#delGroupId').val($('#smlGroupId').val());
		$('#delCodeId').val($('#smlCodeId').val());
		$('#delType').val('small');
		$('.fontColorRed').remove();
	}
	
	function deleteEnCode(){
		$('#delRevision').val($('#revision').val());
		var action = 'delete';
		var	param = $('#frmDelCode').serialize();
		if(isDisabled){
			return false;
		}else{
			isDisabled = true;
			deleteAjax(param, action);
		}
	}

	// 소분류버튼 선택시 에이작스로 리스트 가져옴
	function smallCodeList(param, action) {
		$.ajax({
			type : 'post',
			url : '/system/packagingCode/' + action,
			data : param,
			dataType : 'json',
			error : function(xhr, status, error) {
				console.log(error);
			},
			success : function(result) {
				isDisabled = false;
				makeSmallList(result);
			}
		});
	}
	
	// 소분류 목록 선택시 에이작스로 데이터 가져옴
	function smallCoddSelectAjax(param, action) {
		$.ajax({
			type : 'post',
			url : '/system/packagingCode/' + action,
			data : param,
			dataType : 'json',
			error : function(xhr, status, error) {
				console.log(error);
			},
			success : function(result) {
				isDisabled = false;
				makeSmallView(result);
			}
		});
	}
	
	// 소분류 수정 및 저장시 사용
	function smallInsertAjax(param, action) {
		$.ajax({
			type : 'post',
			url : '/system/packagingCode/' + action,
			data : param,
			dataType : 'text',
			error : function(xhr, status, error) {
				console.log(error);
			},
			success : function(result) {
				isDisabled = false;
				if (result == 'Update' || result == 'Insert') {
					var param = $('#frm').serialize();
					$('#frm').attr('action','/system/packagingCode');
					$('#frm').submit();
				}
			}
		});
	}
	
	// 코드 삭제시 사용(공통)
	function deleteAjax(param, action) {
		$.ajax({
			type : 'post',
			url : '/system/packagingCode/' + action,
			data : param,
			dataType : 'text',
			error : function(xhr, status, error) {
				console.log(error);
			},
			success : function(result) {
				isDisabled = false;
				if (result == 'Delete') {
					var param = $('#frm').serialize();
					$('#frm').attr('action','/system/packagingCode');
					$('#frm').submit();
				}
			}
		});
	}

	function valyCheck(type) {
		if(type == 'large'){
			if ($('#larCodeId').val() == '') {
				alert('코드 ID을 입력해 주세요.');
				$('#larCodeId').focus();
				return false;
			}
			if ($('#larCodeNm').val() == '') {
				alert('코드 이름을 입력해 주세요.');
				$('#larCodeNm').focus();
				return false;
			}
			if ($('#larCodeKey').val() == '') {
				alert('코드 키을 입력해 주세요.');
				$('#larCodeKey').focus();
				return false;
			}
			if ($('#larOrdSeq').val() == '') {
				alert('정렬 순서를 입력해 주세요.');
				$('#larOrdSeq').focus();
				return false;
			}
		}else if(type == 'middle'){
			if ($('#midCodeId').val() == '') {
				alert('코드 ID을 입력해 주세요.');
				$('#midCodeId').focus();
				return false;
			}
			if ($('#midCodeNm').val() == '') {
				alert('코드 이름을 입력해 주세요.');
				$('#midCodeNm').focus();
				return false;
			}
			if ($('#midCodeKey').val() == '') {
				alert('코드 키을 입력해 주세요.');
				$('#midCodeKey').focus();
				return false;
			}
			if ($('#midOrdSeq').val() == '') {
				alert('정렬 순서를 입력해 주세요.');
				$('#midOrdSeq').focus();
				return false;
			}
		}else if(type == 'small'){
			if ($('#smlCodeId').val() == '') {
				alert('코드 ID을 입력해 주세요.');
				$('#smlCodeId').focus();
				return false;
			}
			if ($('#smlCodeNm').val() == '') {
				alert('코드 이름을 입력해 주세요.');
				$('#smlCodeNm').focus();
				return false;
			}
			if ($('#smlCodeKey').val() == '') {
				alert('코드 키을 입력해 주세요.');
				$('#smlCodeKey').focus();
				return false;
			}
			if ($('#smlOrdSeq').val() == '') {
				alert('정렬 순서를 입력해 주세요.');
				$('#smlOrdSeq').focus();
				return false;
			}
		}
		return true;
	}

</script>