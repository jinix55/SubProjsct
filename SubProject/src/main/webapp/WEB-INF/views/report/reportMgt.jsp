<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="content">
	<!-- S_검색-->
	<form id="searchFrm" action="/menu/report" method="POST">
		<input type="hidden" id="page" name="page" value="${pages.page}">
		<div class="justify-content-between">
			<div class="form-group">
				<div class="form-inline">
					<select class="select-box w150" id="searchKey" name ="searchKey">
						<option value="ALL">전체</option>
						<option value="reportId">레포트 ID</option>
						<option value="reportNm">레포트명</option>
					</select>
				</div>
				<div class="form-inline">
					<div class="search-box w250">
						<input id="searchValue" name="searchValue" value="${pages.searchValue }" type="text" class="text-input">
						<span class="search-box-append">
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
<%-- 					<col style="width: 30px;"> --%>
					<col style="width: 40px;">
					<col style="width: 150px;">
					<col style="width: 100px;">
					<col style="width: 100px;">
					<col style="width: 200px;">
					<col style="width: 60px;">
					<col style="width: 90px;">
				</colgroup>
				<thead>
					<tr class="th-bg">
<!-- 						<th><input type="checkbox" name="all" id="checkAll"></th> -->
						<th scope="col">번호</th>
						<th scope="col">레포트 ID</th>
						<th scope="col">레포트 명</th>
						<th scope="col">연동 구분</th>
						<th scope="col">연동 URL</th>
						<th scope="col">사용여부</th>
						<th scope="col">관리</th>
					</tr>
				</thead>

				<tbody>
<!-- 						<th><input type="checkbox" name="chk"></th> -->
						<c:choose>
							<c:when test="${!empty reports}">
								<c:forEach var="list" items="${reports}" varStatus="status">
									<tr>
										<td>${pages.totalCount - (status.index + (pages.page -1) * pages.pageSize)}</td>
										<td class="text-point">${list.reportId}</td>
										<td>${list.reportNm}</td>
										<td>
											<c:choose>
												<c:when test="${list.reportType eq 'T' }">
													태블로
												</c:when>
												<c:when test="${list.reportType eq 'L' }">
													로그프레소
												</c:when>
												<c:otherwise>
													기타
												</c:otherwise>
											</c:choose>
										</td>
										<td class="ellipsis" title="${list.reportUrl}">
											${list.reportUrl}
										</td>
										<td>
											<c:choose>
												<c:when test="${list.useYn eq 'Y' }">
													<button type="button" class="button-yes">YES</button>
												</c:when>
												<c:otherwise>
														<button type="button" class="button-no">NO</button>
												</c:otherwise>
											</c:choose>
										</td>
										<td>
											<div class="btn-group">
												<a href="#register" role="button" data-toggle="modal" onclick="detailView('${list.reportId}');" class="btn-icon">
													<img src="/images/icon_detail.png" alt="상세보기" class="btn-Ticon">
												</a>
												<a href="#delete" role="button" data-toggle="modal" onclick="deleteSet('${list.reportId}');" class="btn-icon del_data">
													<img src="/images/icon_delete2.png" alt="삭제하기" class="btn-Ticon02">
												</a>
											</div>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="7">
										등록된 데이터가 없습니다.
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
		<button type="button" class="button btn-success" id="registView" data-toggle="modal" href="#register">
			등록
<!-- 			<a href="#register" data-toggle="modal"></a> -->
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
				<input type="hidden" class="text-input" id="reportId" name="reportId">
				<div class="col-50" id="regDt">
					<div class="form-group">
						<label class="col-25 form-label">등록일</label>
						<div class="col-75">
							<div class="form-input">
								<input type="text" class="text-input" id="rgstDt" name="rgstDt" value="2010-10-02"
									disabled>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50" id="modDt">
					<div class="form-group">
						<label class="col-25 form-label">수정일</label>
						<div class="col-75">
							<div class="form-input">
								<input type="text" class="text-input" id="modiDt" name="modiDt" value="2010-10-02"
									disabled>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">레포트 명<em>*</em></label>
						<div class="col-75">
							<div class="form-input">
								<input type="text" class="text-input" id="reportNm" name="reportNm" >
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">연동 구분<em>*</em></label>
						<div class="col-75">
							<select class="select-box" id="reportType" name="reportType" >
								<option value="T">태블로</option>
								<option value="L">로그프레소</option>
							</select>
						</div>
					</div>
				</div>
				<div class="col-100">
<!-- 					<div class="form-group"> -->
<!-- 						<input type="hidden" id="groupId" name="groupId" /> -->
<!-- 						<label class="col-25 form-label h60">사용자 그룹</label> -->
<!-- 						<div class="col-75 h60"> -->
<!-- 							<div class="form-input-box h60"> -->
<%-- 								<c:forEach items="${roles}" var="role"> --%>
<%-- 									<label>${role.authNm}<input type="checkbox" id="${role.authId}" name="roleCheck"></label> --%>
<%-- 								</c:forEach> --%>
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
					<div class="form-group">
						<label class="col-25 form-label">디바이스 사이즈</label>
						<div class="col-75 row">
							<div class="col-20-dev">
								<input type="text" class="text-input" id="reportSize" name="reportSize" value="1320x700">
							</div>
							<div class="col-75 pl05">
								<div class="form-input">
									<input type="text" class="text-input" id="reportUrl" name="reportUrl" value="http://wwww.">
								</div>
							</div>
							<!--<div class="row">
										<label class="col-20 form-label-none">Mobile<input type="checkbox" name="chk"></label>
										<div class="col-15">
												<input type="text" class="text-input" value="320x1200">
										</div>
										<div class="col-65 pl05">
											<div class="form-input">
												<input type="text" class="text-input" value="http://wwww.">
											</div>
										</div>
								</div>-->
						</div>
					</div>
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
					<div class="form-group">
						<label class="col-25 form-label-textarea">레포트 설명</label>
						<div class="col-75">
							<div class="form-input">
								<textarea id="reportDsc" name="reportDsc" class="textarea"></textarea>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 버튼 -->
		<div class="modal-footer btn-group">
			<button type="button" class="button btn-success insert" id="regBtn" >저장</button>
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
	var totalPage = ${pages.totalPage};
	var page = ${pages.page}; 
	var pageSize = ${pages.pageSize}; 
	
// 	totalPage = 10;
// 	page = 2; 
// 	pageSize = 10; 
	
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
			url : '/menu/report/detail/'+id,
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
		$('#companyId').attr('disabled',true);
		$('#regBtn').removeClass('edit');
		$('#regBtn').text('저장');
		$('#regBtn').addClass('save');
	}
	
	/*상세보기 눌렀을때 데이터 적용*/
	function setView(data){
		$('#reportId').val(data.reportId);
		$('#reportNm').val(data.reportNm);
		$('#reportUrl').val(data.reportUrl);
		$('#reportSize').val(data.reportSize);
		$('#reportType').val(data.reportType);
		$('#reportDsc').val(data.reportDsc);
		$('#rgstDt').val(data.rgstDt);
		$('#modiDt').val(data.modiDt);
		$('#use'+data.useYn).prop('checked',true);
	}
	
	function valyCheck(){
		if($('#reportNm').val() == ''){
			alert('레포트 이름을 입력해 주세요.');
			$('#reportNm').focus();
			return false;
		}
		if($('#reportUrl').val() == ''){
			alert('레포트 URL을 입력해 주세요.');
			$('#reportUrl').focus();
			return false;
		}
		if($('#reportSize').val() == ''){
			alert('레포트 사이즈를 설정해 주세요.');
			$('#reportSize').focus();
			return false;
		}
		if($('#reportType').val() == ''){
			alert('레포트 타입을 선택해 주세요.');
			$('#reportType').click();
			return false;
		}
		return true;
	}
	
	function insert(){
		$("input:checkbox[name=roleCheck]").each(function() {
			console.log(this.id);
			if(this.checked){
				$('#groupId').val(this.id);
			}
			
		});
		if(valyCheck()){
			var param =  $('#frm').serialize();
			insertAjax(param,'insert');
		}
	}
	
	function update(){
		if(valyCheck()){
			var param =  $('#frm').serialize();
			insertAjax(param,'update');
		}
	}
	
	function insertAjax(param,action){
		$.ajax({
		    type : 'post',
		    url : '/menu/report/insert',
		    data : param,
		    dataType : 'text',
		    error: function(xhr, status, error){
		        console.log(error);
		    },
		    success : function(result){
		    	if(result == 'Update' || result == 'Insert'){
		    		location.href = '/menu/report';
		    	}
		    }
		});
	}
	
	$('#deleteAction').click(function(){
		if(isDisabled){
			return false;
		}else{
			isDisabled = true;
			deleteAjax();
		}
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
				if(isDisabled){
					return false;
				}else{
					isDisabled = true;
					insert();
				}
			}
			if($('#regBtn').hasClass('save')){
				if(isDisabled){
					return false;
				}else{
					isDisabled = true;
					update();
				}
			}
			if($('#regBtn').hasClass('edit')){
				setEdit();
			}
		});
		
		$('.delete').click(function(){
			if(isDisabled){
				return false;
			}else{
				isDisabled = true;
				deleteAjax();
			}
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