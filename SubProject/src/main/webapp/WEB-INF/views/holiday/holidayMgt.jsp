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
					<select class="select-box w150" id="searchKey" name ="searchKey">
						<option value="">전체</option>
						<option value="C">국가공휴일</option>
						<option value="W">주말</option>
						<option value="T">임시공휴일</option>
					</select>
				</div>
				<div class="form-inline">
					<select class="select-box w150" id="uesYn" name ="uesYn">
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
<div id="register" class="modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
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
						<div class="search-date">
							<div class="col-75">
								<input id="solarDate" name="solarDate" type="text" class="text-input2">
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">휴일명</label>
						<div class="col-75">
							<input type="text" class="text-input">
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">휴일타입</label>
						<div class="col-75">
							<input type="text" class="text-input">
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
								<textarea class="textarea"></textarea>
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
</form>


<!-- 레이어 팝업 - delete -->
<form action="/system/holiday/delete" method="POST">
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
</form>

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
		$('#rgstDt').attr('disabled',true);
		$('#rgstDt').parents('.col-50').show();
		$('#modiDt').attr('disabled',true);
		$('#modiDt').parents('.col-50').show();
		$('#register input').attr('disabled',true);
		
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
		$('#userNm').val(data.userNm);
		$('#use'+data.useYn).prop('checked',true);
// 		if(data.lockYn == 'Y'){
// 			$('#lockYn').addClass('btn-yes');
// 			$('#lockYn').text('Yes');
// 			$('#lockYn').css('background','red');
// 			$('#lockYn').css('cursor',' pointer');
// 		}else{
// 			$('#lockYn').addClass('btn-no');
// 			$('#lockYn').text('No');
// 			$('#lockYn').css('background','darkgray');
// 			$('#lockYn').css('background','darkgray');
// 			$('#lockYn').css('cursor',' unset');
// 		}
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
	
	function setEdit(){
		$('#register input').attr('disabled',false);
		$('#register select').attr('disabled',false);
		$('#solarDate').attr('disabled',true);
		$('#userNm').attr('disabled',true);
		$('#rgstDt').attr('disabled',true);
		$('#modiDt').attr('disabled',true);
		$('#regBtn').text('저장');
		$('#regBtn').removeClass('edit');
		$('#regBtn').addClass('save');
	}
	
	function dateInsert(){
		var param =  $('#frm').serialize();
		insertAjax(param,'insert');
	}
	
	function dateUpdate(){
		var param =  $('#frm').serialize();
		insertAjax(param,'update');
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
	
	function deleteAjax(param,action){
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
		$('#registView').click(function(){
			resetInput();
			$('#register .modal-title').text('등록');
			$('#register .insert').text('저장');
			$('#rgstDt').attr('disabled',true);
			$('#rgstDt').parents('.col-50').hide();
			$('#modiDt').attr('disabled',true);
			$('#modiDt').parents('.col-50').hide();
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