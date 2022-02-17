<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="content">
	<!-- S_검색-->
	<form id="searchFrm">
		<div class="justify-content-between">
			<div class="form-group">
				<div class="form-inline">
					<select id="searchKey" name="searchKey" class="select-box w150">
						<option value="ALL">전체</option>
						<option value="supplierNm">공급업체명</option>
						<option value="supplierCode">공급업체코드</option>
					</select>
				</div>
				<div class="form-inline">
					<div class="search-box w250">
						<input id="searchVlaue" name="searchValue" type="text" class="text-input"> <span
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
			<table class="table table-actions">
				<colgroup>
					<col style="width: 30px;">
					<col style="width: 100px;">
					<col style="width: 180px;">
					<col style="width: 100px;">
					<col style="width: 80px;">
					<col style="width: 100px;">
					<col style="width: 90px;">
				</colgroup>
				<thead>
					<tr class="th-bg">
						<th></th>
						<th scope="col">공급업체 코드</th>
						<th scope="col">공급업체 명</th>
						<th scope="col">사업자번호</th>
						<th scope="col">대표자</th>
						<th scope="col">관리 책임자</th>
						<th scope="col">상세</th>
					</tr>
				</thead>

				<tbody>
					<c:forEach items="${suppliers }" var="list" varStatus="status">
						<tr>
							<th>${pages.totalCount - (status.index + (pages.page -1) * pages.pageSize)}</th>
							<td>${list.supplierCode}</td>
							<td>${list.supplierNm}</td>
							<td>${list.supplierNo}</td>
							<td>${list.representativeNm}</td>
							<td>
								<a href="#charge" role="button" onclick="selectManager('${list.managementId}');" data-toggle="modal" class="btn-icon text-point">
									<img src="/images/icon_user2.png"> ${list.managementNm }
								</a>
							</td>
							<td>
								<div class="btn-group">
									<a href="#edit" role="button" data-toggle="modal"
										onclick="detailView('${list.supplierId}');" class="btn-icon">
										<img src="/images/icon_detail.png" alt="상세보기" class="btn-Ticon">
									</a> 
								</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<!-- S_페이징-->
	<div class="board-paging"></div>
	<!-- E_페이징-->
</div>


<!-- 레이어 팝업 - 등록  -->
<form id="frmEdit">
	<div id="edit" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<input id="supplierId" name="supplierId" type="hidden" class="text-input">
		<div class="modal-content" style="width: 900px">
			<div class="modal-header">
				<h4 class="modal-title">공급업체 상세</h4>
				<button type="button" class="close" data-dismiss="modal">
					<img src="/images/icon_close.png">
				</button>
			</div>
			<div class="modal-body">
				<div class="tab">
					<ul class="tabnav">
						<li><a id="tabnav01" href="#tab01">기업정보</a></li>
						<li><a id="tabnav02" href="#tab02">담당자</a></li>
					</ul>
					<div class="tabcontent">
						<div id="tab01">
							<div class="row">
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label">등록일자</label>
										<div class="col-75">
											<input id="rgstDt" name="rgstDt" type="text"
												class="text-input">
										</div>
									</div>
								</div>
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label">수정일자</label>
										<div class="col-75">
											<input id="modiDt" name="modiDt" type="text"
												class="text-input">
										</div>
									</div>
								</div>
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label">업체코드</label>
										<div class="col-75">
											<input id="supplierCode" name="supplierCode" type="text"
												class="text-input">
										</div>
									</div>
								</div>
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label">사용여부</label>
										<div class="col-75">
											<select id="useYn" name="useYn" class="select-box">
												<option value="Y">예</option>
												<option value="N">아니요</option>
											</select>
										</div>
									</div>
								</div>
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label">업체명</label>
										<div class="col-75">
											<input id="supplierNm" name="supplierNm" type="text"
												class="text-input">
										</div>
									</div>
								</div>
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label">대표자명</label>
										<div class="col-75">
											<input id="representativeNm" name="representativeNm"
												type="text" class="text-input">
										</div>
									</div>
								</div>
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label">사업자번호</label>
										<div class="col-75">
											<div class="phone-number">
												<input id="supplierNo1" name="supplierNo1" type="text" class="text-input" maxlength="3" onkeypress='return checkNumber(event)'>
											</div>
											<div class="phone-number">
												<input id="supplierNo2" name="supplierNo2" type="text" class="text-input" maxlength="2" onkeypress='return checkNumber(event)'>
											</div>
											<div class="phone-number">
												<input id="supplierNo3" name="supplierNo3" type="text" class="text-input" maxlength="5" onkeypress='return checkNumber(event)'>
											</div>
											<input type="hidden" id="supplierNo" name="supplierNo" />
										</div>
									</div>
								</div>
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label">연락처</label>
										<div class="col-75">
											<div class="phone-number">
												<input id="telephoneNo1" name="telephoneNo1" type="text" class="text-input" maxlength="3" onkeypress='return checkNumber(event)'>
											</div>
											<div class="phone-number">
												<input id="telephoneNo2" name="telephoneNo2" type="text" class="text-input" maxlength="4" onkeypress='return checkNumber(event)'>
											</div>
											<div class="phone-number">
												<input id="telephoneNo3" name="telephoneNo3" type="text" class="text-input" maxlength="4" onkeypress='return checkNumber(event)'>
											</div>
											<input type="hidden" id="telephoneNo" name="telephoneNo" />
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-100">
									<div class="form-group">
										<label class="col-25 form-label">주소</label>
										<div class="col-75">
											<input id="address" name="address" type="text"
												class="text-input">
										</div>
									</div>
									<div class="form-group">
										<label class="col-25 form-label-textarea">설명</label>
										<div class="col-75">
											<div class="form-input">
												<textarea id="supplierDsc" name="supplierDsc" class="textarea"></textarea>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div id="tab02">
							<table class="table">
								<colgroup>
									<col style="width: 15%;">
									<col style="width: 10%;">
									<col style="width: 10%;">
									<col style="width: 20%;">
									<col style="width: 20%;">
									<col style="width: 5%;">
								</colgroup>
								<thead>
									<tr class="th-bg">
										<th scope="col">성명</th>
										<th scope="col">부서</th>
										<th scope="col">직위</th>
										<th scope="col">연락처</th>
										<th scope="col">메일</th>
									</tr>
								</thead>
								<tbody id="managerTable">
									<tr>
										<td colspan="6">등록된 담당자가 없습니다.</td>
									</tr>
								</tbody>
							</table>
							<div id="managerInfo" class="row pt30">
								<input id="managerId" name="managerId" type="hidden" class="text-input">
								<input id="maSupplierCode" name="maSupplierCode" type="hidden" class="text-input">
								<div class="col-100 mb10">
									<input id="managerRepresent" name="managerRepresent" type="checkbox" style="margin:0;">
									<label for="managerRepresent">대표</label>
								</div>
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label"><em>*</em>성명</label>
										<div class="col-75">
											<input id="managerNm" name="managerNm" type="text" class="text-input">
										</div>
									</div>
								</div>
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label"><em>*</em>휴대폰번호</label>
										<div class="col-75">
											<div class="phone-number">
												<input id="managerPhone1" name="managerPhone1" type="text" class="text-input" maxlength="3" onkeypress='return checkNumber(event)'>
											</div>
											<div class="phone-number">
												<input id="managerPhone2" name="managerPhone2" type="text" class="text-input" maxlength="4" onkeypress='return checkNumber(event)'>
											</div>
											<div class="phone-number">
												<input id="managerPhone3" name="managerPhone3" type="text" class="text-input" maxlength="4" onkeypress='return checkNumber(event)'>
											</div>
											<input type="hidden" id="managerPhone" name="managerPhone" />
										</div>
									</div>
								</div>
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label">부서</label>
										<div class="col-75">
											<input id="managerDept" name="managerDept" type="text"
												class="text-input">
										</div>
									</div>
								</div>
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label">직위</label>
										<div class="col-75">
											<input id="managerPstn" name="managerPstn" type="text"
												class="text-input">
										</div>
									</div>
								</div>
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label"><em>*</em>이메일</label>
										<div class="col-75">
											<div class="email-add">
												<input id="managerMail1" name="managerMail1" type="text"
													class="text-input email">
											</div>
											<div class="email-add">
												<input id="managerMail2" name="managerMail2" type="text"
													class="text-input email">
											</div>
											<input type="hidden" id="managerMail" name="managerMail" />
										</div>
									</div>
								</div>
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label">사용여부</label>
										<div class="col-75">
											<select id="maUseYn" name="maUseYn" class="select-box">
												<option value="Y">예</option>
												<option value="N">아니요</option>
											</select>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 버튼 -->
			<div class="modal-footer btn-group">
				<button type="button" class="button btn-success cancel" data-dismiss="modal">확인</button>
			</div>
		</div>
	</div>
</form>

<!-- 레이어 팝업 - 담당자  -->
<div id="charge" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width: 720px">
		<div class="modal-header">
			<h4 class="modal-title">담당자 정보</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<input id="pop_managerId" name="pop_managerId" type="hidden"
					class="text-input" disabled> <input
					id="pop_managerRepresent" name="pop_managerRepresent" value="Y"
					type="hidden" class="text-input" disabled>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">성명</label>
						<div class="col-75">
							<input id="pop_managerNm" name="pop_managerNm" type="text"
								class="text-input" value="홍나리" disabled>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">휴대폰번호</label>
						<div class="col-75">
							<input id="pop_managerPhone" name="pop_managerPhone" type="text"
								class="text-input" value="010-123-4567">
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">부서</label>
						<div class="col-75">
							<input id="pop_managerDept" name="pop_managerDept" type="text"
								class="text-input" value="홍보">
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">직위</label>
						<div class="col-75">
							<input id="pop_mmanagerPstn" name="pop_mmanagerPstn" type="text"
								class="text-input" value="과장">
						</div>
					</div>
				</div>
				<div class="col-100">
					<div class="form-group">
						<label class="col-25 form-label">이메일</label>
						<div class="col-75">
							<input id="pop_managerMail" name="pop_managerMail" type="text"
								class="text-input" value="PPlueEco@PlueEc.co.kr">
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



<script type="text/javascript">
	/**
	 * 페이징 처리 공통 함수
	 */
	var totalPage = ${pages.totalPage};
	var page = ${pages.page};
	var pageSize = ${pages.pageSize};

	// 	var totalPage = 1;
	// 	var page = 2; 
	// 	var pageSize = 10;

	var setSupplierCode = '';
	var setManager = 'N';
	var setTab = 'S';
	var setManagerList;

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
		$("#holiBdForm").submit();
	});

	function insertSupplier(){
		validation('register');
		if (isDisabled) {
			return false;
		} else {
			isDisabled = true;
			var supplierNo = $('#register #supplierNo1').val()+'-'+$('#register #supplierNo2').val()+'-'+$('#register #supplierNo3').val();
			var telephoneNo = $('#register #telephoneNo1').val()+'-'+$('#register #telephoneNo2').val()+'-'+$('#register #telephoneNo3').val();
			$('#register #supplierNo').val(supplierNo);
			$('#register #telephoneNo').val(telephoneNo);
			var managerPhone = $('#register #managerPhone1').val()+'-'+$('#register #managerPhone2').val()+'-'+$('#register #managerPhone3').val();
			var managerMail = $('#register #managerMail1').val()+'@'+$('#register #managerMail2').val();
			$('#register #managerPhone').val(managerPhone);
			$('#register #managerMail').val(managerMail);
			if($('#register #managerRepresent').is(':checked')){
				$('#register #managerRepresent').val('Y');
			}else{
				$('#register #managerRepresent').val('');
			}
			var param = $('#frmRegister').serialize();
			insertSupplierAjax(param, 'insert');
		}
	}
	
	// 대표매니저 검색
	function selectManager(id) {
		if (isDisabled) {
			return false;
		} else {
			isDisabled = true;
			$.ajax({
				url : '/product/supplier/detail/manager/' + id,
				dataType : 'JSON',
				type : "POST",
				error : function(xhr, status, error) {
					console.log(error);
				},
				success : function(data) {
					managerDetailView(data);
				}
			});
		}
	}

	function managerDetailView(data) {
		$('#pop_managerId').val(data.managerId);
		$('#pop_managerNm').val(data.managerNm);
		$('#pop_managerPhone').val(data.managerPhone);
		$('#pop_managerMail').val(data.managerMail);
		$('#pop_managerDept').val(data.managerDept);
		$('#pop_managerPstn').val(data.managerPstn);
		$('#pop_managerRepresent').val(data.managerRepresent);
		isDisabled = false;
	}

	function detailView(id) {
		if (isDisabled) {
			return false;
		} else {
			isDisabled = true;
			$.ajax({
				url : '/product/supplier/detail/' + id,
				dataType : 'JSON',
				type : "POST",
				error : function(xhr, status, error) {
					console.log(error);
				},
				success : function(data) {
					detailViewMake(data);
					isDisabled = false;
				}
			});
		}
	}

	function detailViewMake(data) {
		$('#edit input').attr('disabled', true);
		$('#edit select').attr('disabled', true);
		$('#edit textarea').attr('disabled', true);
		setSupplierCode = data.supplierCode;
		var telephoneNo = data.telephoneNo.split('-');
		var telephoneNo1 = telephoneNo[0];
		var telephoneNo2 = telephoneNo[1];
		var telephoneNo3 = telephoneNo[2];
		var supplierNo = data.supplierNo.split('-');
		var supplierNo1 = supplierNo[0];
		var supplierNo2 = supplierNo[1];
		var supplierNo3 = supplierNo[2];
		$('#edit #supplierId').val(data.supplierId);
		$('#edit #supplierCode').val(data.supplierCode);
		$('#edit #supplierNo').val(data.supplierNo);
		$('#edit #supplierNo1').val(supplierNo1);
		$('#edit #supplierNo2').val(supplierNo2);
		$('#edit #supplierNo3').val(supplierNo3);
		$('#edit #supplierNm').val(data.supplierNm);
		$('#edit #supplierDsc').val(data.supplierDsc);
		$('#edit #address').val(data.address);
		$('#edit #telephoneNo').val(data.telephoneNo);
		$('#edit #telephoneNo1').val(telephoneNo1);
		$('#edit #telephoneNo2').val(telephoneNo2);
		$('#edit #telephoneNo3').val(telephoneNo2);
		if(data.representativeNm == 'Y'){
			$('#edit #managerRepresent').prop('checked',true);
		}else{
			$('#edit #managerRepresent').prop('checked',false);
		}
		$('#edit #representativeNm').val(data.representativeNm);
		$('#edit #note').val(data.note);
		$('#edit #useYn').val(data.useYn);
		$('#edit #rgstDt').val(data.rgstDt);
		$('#edit #modiDt').val(data.modiDt);
	}

	// 담당자 검색
	function managersView(id) {
		setManager = 'Y';
		if (isDisabled) {
			return false;
		} else {
			isDisabled = true;
			$.ajax({
				url : '/product/supplier/detail/managers/' + id,
				dataType : 'JSON',
				type : "POST",
				error : function(xhr, status, error) {
					console.log(error);
				},
				success : function(data) {
					managersViewMake(data);
					isDisabled = false;
				}
			});
		}
	}
	
	function setManagerView(index){
		$('#edit input').attr('disabled', true);
		$('#edit select').attr('disabled', true);
		$('#edit textarea').attr('disabled', true);
		if(setManagerList[index].managerRepresent == 'Y'){
			$('#managerInfo #managerRepresent').prop('checked',true);
			$('#managerInfo #managerRepresent').val('Y');
		}else{
			$('#managerInfo #managerRepresent').prop('checked',false);
			$('#managerInfo #managerRepresent').val('N');
		}
		$('#managerInfo #maSupplierCode').val(setManagerList[index].supplierCode);
		$('#managerInfo #managerDept').val(setManagerList[index].managerDept);
		$('#managerInfo #managerDept').val(setManagerList[index].managerDept);
		$('#managerInfo #managerPstn').val(setManagerList[index].managerPstn);
		$('#managerInfo #managerPhone1').val(setManagerList[index].managerPhone.split('-')[0]);
		$('#managerInfo #managerPhone2').val(setManagerList[index].managerPhone.split('-')[1]);
		$('#managerInfo #managerPhone3').val(setManagerList[index].managerPhone.split('-')[2]);
		$('#managerInfo #managerPhone').val(setManagerList[index].managerPhone);
		$('#managerInfo #managerMail1').val(setManagerList[index].managerMail.split('@')[0]);
		$('#managerInfo #managerMail2').val(setManagerList[index].managerMail.split('@')[1]);
		$('#managerInfo #managerMail').val(setManagerList[index].managerMail);
		$('#managerInfo #managerNm').val(setManagerList[index].managerNm);
		$('#managerInfo #managerId').val(setManagerList[index].managerId);
		$('#managerInfo #maUseYn').val(setManagerList[index].useYn);
		
	}

	function managersViewMake(data) {
		setManagerList = data
		$('#managerTable').empty();
		console.log(data.length);
		var html = '';
		if (data.length > 0) {
			data.forEach(function(item, index) {
				html += '<tr >';
				html += '	<td class="text-point selectTdHover" onclick="setManagerView(\''+index+'\');">' + item.managerNm + '</td>';
				html += '	<td>' + item.managerDept + '</td>';
				html += '	<td>' + item.managerPstn + '</td>';
				html += '	<td>' + item.managerPhone + '</td>';
				html += '	<td>' + item.managerMail + '</td>';
				html += '</tr>';
			});
		} else {
			html += '<tr>';
			html += '	<td colspan="6">등록된 담당자가 없습니다.</td>';
			html += '</tr>';
		}
		$('#managerTable').append(html);
	}
	
	function resetInput1(){
		$('#tab01 input').attr('disabled', false);
		$('#tab01 select').attr('disabled', false);
		$('#tab01 textarea').attr('disabled', false);
		$('#tab01 #rgstDt').attr('disabled', true);
		$('#tab01 #modiDt').attr('disabled', true);
		$('#tab01 #supplierCode').attr('disabled', true);
		$('#edit .btn-success').text('저장');
		$('#edit .btn-success').removeClass('edit');
		$('#edit .btn-success').addClass('save');
	}
	
	function resetInput2(){
		$('#tab02 input').attr('disabled', true);
		$('#tab02 select').attr('disabled', true);
		$('#tab02 textarea').attr('disabled', true);
		$('#tab02 input').val('');
		$('#tab02 #maUseYn').val('Y');
		$('#edit .btn-success').text('확인');
	}
	
	function editInput(){
		$('#tab02 input').attr('disabled', true);
		$('#tab02 select').attr('disabled', true);
		$('#tab02 textarea').attr('disabled', true);
	}
	
	$(document).ready(function() {
		var searchKey = '${pages.searchKey}';
		if (searchKey) {
			$('#searchKey').val('${pages.searchKey}');
		}

		$('#tabnav01').click(function() {
			setTab = 'S';
		});

		$('#tabnav02').click(function() {
			setTab = 'M';
			if (setManager == 'N') {
				managersView(setSupplierCode);
			}
			resetInput2();
		});
		
		$('#suppDetailBtn').click(function() {
			if($('#suppDetailBtn').hasClass('edit')){
				if(setTab == 'S'){
					resetInput1();
				}else{
					editInput();
				}
			}
			
		});

		$('#edit .close, #edit .cancel').click(function() {
			setSupplierCode = '';
			setManager = 'N';
			setTab = 'S';
			$('.active').removeClass('active');
			$('#tab02').css('display', 'none');
			$('#tab01').css('display', 'block');
			$('#tabnav01').addClass('active');
			$('#edit #supplierId').val('');
			$('#edit #supplierCode').val('');
			$('#edit #supplierNo').val('');
			$('#edit #supplierNo1').val('');
			$('#edit #supplierNo2').val('');
			$('#edit #supplierNo3').val('');
			$('#edit #supplierNm').val('');
			$('#edit #note').val('');
			$('#edit #address').val('');
			$('#edit #telephoneNo').val('');
			$('#edit #telephoneNo1').val('');
			$('#edit #telephoneNo2').val('');
			$('#edit #telephoneNo3').val('');
			$('#edit #representativeNm').val('');
			$('#edit #note').val('');
			$('#edit #useYn').val('');
			$('#edit #rgstDt').val('');
			$('#edit #modiDt').val('');
			$('#edit .btn-success').text('수정');
			$('#edit .btn-success').removeClass('save');
			$('#edit .btn-success').addClass('edit');
			$('#managerInfo #managerId').val('');
		});
		
		$('.search-box-append').click(function(){
			if(isDisabled){
				return false;
			}else{
				isDisabled = true;
				$('#searchFrm').submit();
			}
		});

	});

</script>