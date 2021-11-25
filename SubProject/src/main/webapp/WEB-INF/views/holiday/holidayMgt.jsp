<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="content">
	<!-- S_검색-->
	<form id="searchFrm" action="/system/holiday" method="POST">
		<input type="hidden" id="page" name="page" value="${pages.page}">
		<div class="justify-content-between">
			<div class="form-group">
				<div class="form-inline">
					<select class="select-box w150" id="holiType" name ="holiType">
						<option value="">전체</option>
						<option value="C">국가공휴일</option>
						<option value="W">주말</option>
						<option value="T">임시공휴일</option>
					</select>
				</div>
				<div class="form-inline">
					<select class="select-box w150" id="useYn" name ="useYn">
						<option value="">전체</option>
						<option value="Y">Yes</option>
						<option value="N">No</option>
					</select>
				</div>
				<div class="form-inline">
					<div class="search-box w250">
						<input id="searchValue" name="searchValue" value="${pages.searchValue }" type="text" class="text-input"> <span
							class="search-box-append">
							<button type="button" class="btn-search">
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
					<col style="width: 85px;">
					<col style="width: 150px;">
					<col style="width: 125px;">
					<col style="width: 230px;">
					<col style="width: 60px;">
					<col style="width: 90px;">
				</colgroup>
				<thead>
					<tr class="th-bg">
						<th scope="col">일자</th>
						<th scope="col">휴일명</th>
						<th scope="col">휴일타입</th>
						<th scope="col">설명</th>
						<th scope="col">사용여부</th>
						<th scope="col">관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${list}" varStatus="status">
						<tr>
							<td class="text-point">${list.solarDate}</td>
							<td>${list.holiNm}</td>
							<td>
								<c:choose>
									<c:when test="${list.holiType eq 'C' }">
										국가공휴일
									</c:when>
									<c:when test="${list.holiType eq 'T' }">
										임시공휴일
									</c:when>
									<c:otherwise>
										주말
									</c:otherwise>
								</c:choose>
							</td>
							<td>${list.memo}</td>
							<td>
							<c:choose>
								<c:when test="${list.useYn eq 'Y' }">
									<button type="button" class="btn-yes">YES</button>
								</c:when>
								<c:otherwise>
										<button type="button" class="btn-no">NO</button>
								</c:otherwise>
							</c:choose>
							</td>
							<td>
								<div class="btn-group">
									<a href="#register" onclick="detailView('${list.solarDate}');" role="button" data-toggle="modal" class="btn-tbl_icon">
										<img src="/images/icon_edit.png" alt="수정하기" class="tbl-icon2">
									</a>
									<a href="#delete" onclick="deleteSet('${list.solarDate}');" role="button" data-toggle="modal" class="btn-tbl_icon">
										<img src="/images/icon_delete2.png" alt="삭제하기" class="tbl-icon2">
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
<div id="register" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width: 800px">
		<div class="modal-header">
			<h4 class="modal-title">신규휴일등록</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="../images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">휴일일자</label>
						<div class="col-75">
							<div class="search-date search-date2">
								<input id="solarDate" name="solarDate" onkeyup="this.value = date_mask(this.value)" type="text" class="text-input2">
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">휴일명</label>
						<div class="col-75">
							<input id="holiNm" name="holiNm" type="text" class="text-input">
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">휴일타입</label>
						<div class="col-75">
						<select class="select-box" id="holiType" name="holiType">
							<option value="">전체</option>
							<option value="C">국가공휴일</option>
							<option value="W">주말</option>
							<option value="T">임시공휴일</option>
						</select>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">사용여부</label>
						<div class="col-75">
							<div class="form-input-box">
								<div class="btn-sm di-inblock">
									<input id="useY" name="useYn" type="radio" value="Y">
									<label for="useY" class="mr05">사용</label>
								</div>
								<div class="btn-sm di-inblock">
									<input id="useN" name="useYn" type="radio" value="N">
									<label for="useN" class="mr05">미사용</label>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-100">
					<div class="form-group">
						<label class="col-25 form-label-textarea">설명</label>
						<div class="col-75">
							<div class="form-input">
								<textarea id="memo" name="memo" class="textarea"></textarea>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 버튼 -->
		<div class="modal-footer btn-group">
			<button id="regBtn" type="button" class="button btn-success insert">저장</button>
			<button type="button" class="button btn-cancel cancle" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>
</form>


<!-- 레이어 팝업 - delete -->
<div id="delete" class="modal" data-backdrop-limit="1" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
	data-modal-parent="#myModal">
	<!-- Modal content-->
	<input type="hidden" id="del_data" name="del_data">
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
							<em class="text-bold delName"></em> 삭제하시겠습니까?
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
	
	function deleteSet(solarDate){
		$('#del_data').val(solarDate);
		$('.delName').text(solarDate);
	}
	
	function detailView(id){
		resetView();
		$('#register input').attr('disabled',true);
		$('#register .ui-datepicker-trigger').attr('disabled',true);
		$('#register textarea').attr('disabled',true);
		
		$.ajax({
			url : '/system/holiday/detail/'+id,
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
		$('#solarDate').val(data.solarDate);
		$('#memo').val(data.memo);
		$('#holiNm').val(data.holiNm);
		$('#holiType').val(data.holiType);
		$('#userNm').val(data.userNm);
		$('#use'+data.useYn).prop('checked',true);
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
		$('#register textarea').attr('disabled',false);
		$('#register .ui-datepicker-trigger').attr('disabled',false);
		$('#register input').val('');
		$('#register textarea').val('');
		$('#holiType').val('');
		$('#useY').val('Y');
		$('#useN').val('N');
		$('#useY').prop('checked',true);
		$('#regBtn').removeClass('edit');
		$('#regBtn').removeClass('save');
		$('#regBtn').addClass('insert');
	}
	
	function resetView(){
		$('#register .modal-title').text('상세');
		$('#register input').attr('disabled',true);
		$('#register select').attr('disabled',true);
		$('#regBtn').removeClass('insert');
		$('#regBtn').addClass('edit');
		$('#regBtn').text('수정');
	}
	
	function setEdit(){
		$('#register input').attr('disabled',false);
		$('#register select').attr('disabled',false);
		$('#register textarea').attr('disabled',false);
		$('#register #solarDate').attr('disabled',true);
		$('#register .ui-datepicker-trigger').attr('disabled',true);
		$('#solarDate').attr('disabled',true);
		$('#regBtn').text('저장');
		$('#regBtn').removeClass('edit');
		$('#regBtn').addClass('save');
	}
	
	function valyCheck(){
		if($('#solarDate').val() == ''){
			alert('일자를 입력되지 않았습니다.');
			$('#solarDate').focus();
			return false;
		}
		if($('#holiNm').val() == ''){
			alert('휴일명이 입력되지 않았습니다.');
			$('#holiNm').focus();
			return false;
		}
		if($('#holiType').val() == ''){
			alert('휴일타입이 입력되지 않았습니다.');
			$('#holiType').click();
			return false;
		}
		return true;
	}
	
	function dateInsert(){
		if(valyCheck()){
			var param =  $('#frm').serialize();
			insertAjax(param,'insert');
		}
	}
	
	function dateUpdate(){
		if(valyCheck()){
			$('#solarDate').attr('disabled',false);
			var param =  $('#frm').serialize();
			insertAjax(param,'update');
		}
	}
	
	function insertAjax(param,action){
		$.ajax({
		    type : 'post',
		    url : '/system/holiday/'+action,
		    data : param,
		    dataType : 'text',
		    error: function(xhr, status, error){
		        console.log(error);
		    },
		    success : function(result){
		    	if(result == 'Update' || result == 'Insert'){
		    		location.href = '/system/holiday';
		    	}
		    }
		});
	}
	
	function deleteAjax(){
		param = {
				solarDate : $('#del_data').val()
		}
		$.ajax({
		    type : 'post',
		    url : '/system/holiday/delete',
		    data : param,
		    dataType : 'text',
		    error: function(xhr, status, error){
		        console.log(error);
		    },
		    success : function(result){
		    	if(result == 'Delete'){
		    		location.href = '/system/holiday';
		    	}
		    }
		});
	}
	
	function setNumber(objValue){
		str = objValue.replace(/[^0-9]/gi,"").toUpperCase();
	    return str;
	}
	
	$(document).ready(function() {
		var useYn = '${pages.useYn}';
		var holiType = '${pages.holiType}';
		if(useYn){
			$('.content #useYn').val('${pages.useYn}');
		}
		if(holiType){
			$('.content #holiType').val('${pages.holiType}');
		}
		
		$('#registView').click(function(){
			resetInput();
			$('#register .modal-title').text('등록');
			$('#register .insert').text('저장');
		});
		
		$('.close, .cancle').click(function(){
			resetInput();
		});
		
		$('#regBtn').click(function(){
			if($('#regBtn').hasClass('insert')){
				dateInsert();
			}
			if($('#regBtn').hasClass('save')){
				dateUpdate();
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