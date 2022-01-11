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
								<tbody class="selectHover">
									<c:choose>
										<c:when test="${not empty middleCodeList }">
											<c:forEach items="${middleCodeList }" var="list" varStatus="status">
												<tr>
													<td>${status.count}</td>
													<td id="tr_${list.codeId }" onclick="selectTr(this);" class="text-point">${list.codeId }</td>
													<td>${list.codeNm }</td>
													<td>
														<div class="btn-group">
															<a id="setMid_${list.codeId }" upId="setMid_${list.groupId }" nm="${list.codeNm }" codeKey="${list.codeKey }" codeDsc="${list.codeDsc }" ordSeq="${list.ordSeq }" href="#coderegister_b" role="button" onclick="middleViewSet(this);" data-toggle="modal" class="btn-icon">
																<img src="/images/icon_edit.png" alt="수정하기" class="btn-Ticon02">
															</a>
															<a href="#delete" role="button" onclick="deleteMiddleSet('${list.groupId}','${list.codeId}');" data-toggle="modal" class="btn-icon">
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
						<button type="button" class="button btn-success" id="largeCodeInsert" data-toggle="modal" href="#coderegister_b">
							부위구분 등록
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
															<a id="setSml_${list.codeId }" nm="${list.codeNm }" upId="setSml_${list.groupId }" codeKey="${list.codeKey }" ordSeq="${list.ordSeq }" codeDsc="${list.codeDsc }" onclick="smallViewSet(this);" href="#coderegister_m" role="button" data-toggle="modal" class="btn-icon">
																<img src="/images/icon_edit.png" alt="수정하기" class="btn-Ticon02">
															</a>
															<a onclick="deleteSmallSet('${list.groupId}','${list.codeId}');" href="#delete" role="button" data-toggle="modal" class="btn-icon">
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
							용이성 등록
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
<form id="frmMiddle">
<div id="coderegister_b" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<input type="hidden" id="midRevision" name="midRevision">
	<div class="modal-content" style="width: 500px">
		<div class="modal-header">
			<h4 class="modal-title">부위구분 등록</h4>
			<button type="button" class="close mid_close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-100" id="middleCodListInput">
					<input type="hidden" id="midGroupId" name="midGroupId">
					<div class="form-group">
						<label class="col-25 form-label">부위구분 코드</label>
						<div class="col-75">
							<div class="form-input">
								<input id="midCodeId" name="midCodeId" type="text" class="text-input" placeholder="입력해주세요." disabled>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">부위구분 명</label>
						<div class="col-75">
							<div class="form-input">
								<input id="midCodeNm" name="midCodeNm" type="text" class="text-input" placeholder="입력해주세요." disabled>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">부위구분 KEY</label>
						<div class="col-75">
							<div class="form-input">
								<input id="midCodeKey" name="midCodeKey" type="text" class="text-input" placeholder="입력해주세요." disabled>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">정렬 순서</label>
						<div class="col-75">
							<div class="form-input">
								<input id="midOrdSeq" name="midOrdSeq" type="text" class="text-input" placeholder="입력해주세요." disabled>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label-textarea">비고</label>
						<div class="col-75">
							<div class="form-input">
								<textarea id="midCodeDsc" name="midCodeDsc" class="textarea" placeholder="입력해주세요." disabled></textarea>
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


<!-- 레이어 팝업 - 중분류등록  -->
<form id="frmSmall">
<div id="coderegister_m" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<input type="hidden" id="smlRevision" name="smlRevision">
	<div class="modal-content" style="width: 500px">
		<div class="modal-header">
			<h4 class="modal-title">용이성 등록</h4>
			<button type="button" class="close sml_close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-100" id="smallCodListInput">
					<div class="form-group">
						<label class="col-25 form-label">부위구분 코드</label>
						<div class="col-75">
							<div class="form-input">
								<input id="smlGroupId" name="smlGroupId" type="text" class="text-input" placeholder="입력해주세요." disabled>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">용이성 코드</label>
						<div class="col-75">
							<div class="form-input">
								<input id="smlCodeId" name="smlCodeId" type="text" class="text-input" placeholder="입력해주세요." disabled>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">용이성 등급</label>
						<div class="col-75">
							<div class="form-input">
								<input id="smlCodeNm" name="smlCodeNm" type="text" class="text-input" placeholder="입력해주세요." disabled>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">용이성 키</label>
						<div class="col-75">
							<div class="form-input">
								<input id="smlCodeKey" name="smlCodeKey" type="text" class="text-input" placeholder="입력해주세요." disabled>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">정렬 순서</label>
						<div class="col-75">
							<div class="form-input">
								<input id="smlOrdSeq" name="smlOrdSeq" type="text" class="text-input" placeholder="입력해주세요." disabled>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label-textarea">비고</label>
						<div class="col-75">
							<div class="form-input">
								<textarea id="smlCodeDsc" name="smlCodeDsc" class="textarea" placeholder="입력해주세요." disabled></textarea>
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

<!-- 레이어 팝업 - 소분류등록  -->
<form id="frmDetail">
<div id="coderegister_s" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<input type="hidden" id="deRevision" name="deRevision">
	<input type="hidden" id="setDeGroupId" name="groupId">
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
						<tbody class="selectHover" id="detailCodeList">
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
							<label class="col-25 form-label">정렬 순서</label>
							<div class="col-75">
								<div class="form-input">
									<input id="deOrdSeq" name="deOrdSeq" type="text" class="text-input" disabled>
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
			<button type="button" class="button btn-success detailCodeInsert new" >신규</button>
			<button type="button" class="button btn-success detailCodeDelete" style="display:none;" 
				onclick="deleteDetailSet();" href="#delete" role="button" data-toggle="modal" >삭제</button>
			<button type="button" class="button btn-cancel detailCodeCancel" data-dismiss="modal">취소</button>
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
							<div class="pt05">삭제시 데이터 복구가 불가능합니다.</div>
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
		var day = '${environmentCodeModel.revisionYear}-${environmentCodeModel.revisionMonth}';
		$('#midRevision').val(day);
		$('#smlRevision').val(day);	
		$('#smlGroupId').val('${environmentCodeModel.groupId}');	
		
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
		
		$('.middleCodeCancel, .mid_close').click(function(){
			middleInputReset();
			$('.middleCodeInsert').addClass('new');
			$('.middleCodeInsert').text('신규');
			$('.middleCodeInsert').removeClass('save');
			$('.middleCodeInsert').removeClass('edit');
		});
		
		$('.smallCodeCancel, .sml_close').click(function(){
			smallInputReset();
			$('.smallCodeInsert').addClass('new');
			$('.smallCodeInsert').text('신규');
			$('.smallCodeInsert').removeClass('save');
			$('.smallCodeInsert').removeClass('edit');
		});
		
		$('.detailCodeCancel, .de_close').click(function(){
			detailInputReset();
			$('.detailCodeInsert').addClass('new');
			$('.detailCodeInsert').text('신규');
			$('.detailCodeInsert').removeClass('save');
			$('.detailCodeInsert').removeClass('edit');
			$('.detailCodeDelete').hide();
		});
		
		$('.middleCodeInsert').click(function(){
			if($('.middleCodeInsert').hasClass('new')){
				$('.middleCodeInsert').text('저장');
				$('.middleCodeInsert').addClass('save');
				$('.middleCodeInsert').removeClass('new');
				$('#midGroupId').val($('#largeCategory').val());
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
				}
			}
		});
		
		$('.detailCodeInsert').click(function(){
			if($('.detailCodeInsert').hasClass('new')){
				$('.detailCodeInsert').text('저장');
				$('.detailCodeInsert').addClass('save');
				$('.detailCodeInsert').removeClass('new');
				$('#deCodeId').attr('disabled',false);
				$('#deCodeKey').attr('disabled',false);
				$('#deCodeNm').attr('disabled',false);
				$('#deOrdSeq').attr('disabled',false);
				$('#deCodeDsc').attr('disabled',false);
			}else{
				if($('.detailCodeInsert').hasClass('save')){
					detailCodeSave();
				}
				if($('.detailCodeInsert').hasClass('edit')){
					detailCodeEdit();
					$('.detailCodeDelete').hide();
				}
			}
		});
		
		$('.delPopupCancel').click(function(){
			$('.fontColorRed').remove();
		});
	
	});
	
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
	
	function smallViewSet(that){
		$('.smallCodeInsert').text('수정');
		$('.smallCodeInsert').removeClass('new');
		$('.smallCodeInsert').addClass('edit');
		var groupId = $(that).attr('upId').replace('setSml_','');
		var codeId = $(that).attr('id').replace('setSml_','');
		var codeNm = $(that).attr('nm');
		var codeKey = $(that).attr('codeKey');
		var ordSeq = $(that).attr('ordSeq');
		var codeDsc = $(that).attr('codeDsc');
		$('#smlGroupId').val(groupId);
		$('#smlCodeId').val(codeId);
		$('#smlCodeNm').val(codeNm);
		$('#smlCodeKey').val(codeKey);
		$('#smlOrdSeq').val(ordSeq);
		$('#smlCodeDsc').val(codeDsc);
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
		$('#smlRevision').val($('#revision').val());
		$('.smallCodeInsert').text('저장');
		$('.smallCodeInsert').removeClass('edit');
		$('.smallCodeInsert').addClass('save');
		$('#smlCodeId').attr('disabled',false);
		$('#smlCodeKey').attr('disabled',false);
		$('#smlCodeNm').attr('disabled',false);
		$('#smlOrdSeq').attr('disabled',false);
		$('#smlCodeDsc').attr('disabled',false);
	}
	
	function detailCodeEdit(){
		$('.detailCodeInsert').text('저장');
		$('.detailCodeInsert').removeClass('edit');
		$('.detailCodeInsert').addClass('save');
		$('#detailCodListInput #deCodeId').attr('disabled',false);
		$('#detailCodListInput #deCodeKey').attr('disabled',false);
		$('#detailCodListInput #deCodeNm').attr('disabled',false);
		$('#detailCodListInput #deOrdSeq').attr('disabled',false);
		$('#detailCodListInput #deCodeDsc').attr('disabled',false);
	}
	
	function middleCodeSave(){
		if(isDisabled){
			return false;
		}else{
			var action = 'insert/middle';
			var param = $('#frmMiddle').serialize();
			isDisabled = true;
			insertCodeAjax(param, action);
		}
	}
	
	function smallCodeSave(){
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
	
	function detailCodeSave(){
		if(isDisabled){
			return false;
		}else{
			$('#deGroupId').attr('disabled',false);
			var action = 'insert/detail'; 
			var param = $('#frmDetail').serialize();
			isDisabled = true;
			insertCodeAjax(param, action);
		}
	}
	
	// 중분류, 소분류 저장및 수정시 사용
	function insertCodeAjax(param, action) {
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
				if(result == 'Update' || result == 'Insert') {
					var param = $('#frm').serialize();
					$('#frm').attr('action','/system/environmentCode');
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
		$('.detailCodeInsert').text('수정');
		$('.detailCodeInsert').removeClass('new');
		$('.detailCodeInsert').removeClass('save');
		$('.detailCodeInsert').addClass('edit');
		$('#detailCodListInput #deCodeId').attr('disabled',true);
		$('#detailCodListInput #deCodeKey').attr('disabled',true);
		$('#detailCodListInput #deCodeNm').attr('disabled',true);
		$('#detailCodListInput #deOrdSeq').attr('disabled',true);
		$('#detailCodListInput #deCodeDsc').attr('disabled',true);
		if(isDisabled){
			return false;
		}else{
			isDisabled = true;
			$('#smallCategory').val($(that).attr('id').replace('tr_',''));
			$('#setDeGroupId').val($(that).attr('gpId'));
			var param = $('#frmDetail').serialize();
			var action = 'detail/select/'+$(that).attr('id').replace('tr_',''); 
			detailCoddSelectAjax(param, action);
			$('.detailCodeDelete').show();
		}
	}
	
	function makeDetailList(data){
		detailInputReset();
		var html = '';
		if(data.length > 0){
			data.forEach(function(item, index) {
				html += '<tr id="tr_'+item.codeId+'" gpId="'+item.groupId+'" onclick="detailCodeSelect(this);">';
				html += '	<td class="text-point" style="text-overflow: ellipsis; overflow:hidden;">'+item.codeId+'</td>';
				html += '	<td style="text-overflow: ellipsis; overflow:hidden;">'+item.codeNm+'</td>';
				html += '</tr>';
			});
		}
		$('#detailCodeList').append(html);
		$('#deGroupId').val($('#smallCategory').val());
		$('#deGroupNm').val($('#smallCategoryNm').val());
	}
	
	function middleInputReset(){
		$('#middleCodListInput input').val('');
		$('#middleCodListInput textarea').val('');
		$('#middleCodListInput input').attr('disabled',true);
		$('#middleCodListInput textarea').attr('disabled',true);
	}
	
	function smallInputReset(){
		$('#smallCodListInput input').val('');
		$('#smallCodListInput textarea').val('');
		$('#smallCodListInput input').attr('disabled',true);
		$('#smallCodListInput textarea').attr('disabled',true);
	}
	
	function detailInputReset(){
		$('#detailCodeList').empty();
		$('#detailCodListInput input').val('');
		$('#detailCodListInput textarea').val('');
		$('#detailCodListInput input').attr('disabled',true);
		$('#detailCodListInput textarea').attr('disabled',true);
	}
	
	function makeDetailView(data){
		$('#detailCodListInput #deCodeId').val(data.codeId);
		$('#detailCodListInput #deCodeNm').val(data.codeNm);
		$('#detailCodListInput #deCodeKey').val(data.codeKey);
		$('#detailCodListInput #deOrdSeq').val(data.ordSeq);
		$('#detailCodListInput #deCodeDsc').val(data.codeDsc);
		
	}

	function deleteMiddleSet(groupId,codeId) {
		$('.delName').text(codeId);
		$('#delGroupId').val(groupId);
		$('#delCodeId').val(codeId);
		$('#delType').val('middle');
		$('.tc').append('<div class="pt05 fontColorRed">ㆍ삭제시 하위 코드 모두 삭제 됩니다.</div>');
	}

	function deleteSmallSet(groupId,codeId) {
		$('.delName').text(codeId);
		$('#delGroupId').val(groupId);
		$('#delCodeId').val(codeId);
		$('#delType').val('small');
		$('.tc').append('<div class="pt05 fontColorRed">ㆍ삭제시 하위 코드 모두 삭제 됩니다.</div>');
	}

	function deleteDetailSet() {
		$('.delName').text($('#deCodeId').val());
		$('#delGroupId').val($('#deGroupId').val());
		$('#delCodeId').val($('#deCodeId').val());
		$('#delType').val('detail');
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

	// 내용버튼 선택시 에이작스로 리스트 가져옴
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
	
	// 내용 목록 선택시 에이작스로 데이터 가져옴
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
	
	// 내용 수정 및 저장시 사용
	function detailInsertAjax(param, action) {
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
					var param = $('#frm').serialize();
					$('#frm').attr('action','/system/environmentCode');
					$('#frm').submit();
				}
			}
		});
	}
	
	// 코드 삭제시 사용(공통)
	function deleteAjax(param, action) {
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
				if (result == 'Delete') {
					var param = $('#frm').serialize();
					$('#frm').attr('action','/system/environmentCode');
					$('#frm').submit();
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