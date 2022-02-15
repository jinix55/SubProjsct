<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="content">
	<!-- S_검색-->
	<form id="searchFrm" action="/alarm/alarm" method="POST">
		<div class="justify-content-between">
			<input type="hidden" id="page" name="page" value="${pages.page}">
			<div class="form-group">
				<div class="form-inline">
					<select class="select-box w150" id="searchKey" name ="searchKey">
						<option value="ALL">전체</option>
						<option value="sj">제목</option>
						<option value="cn">내용</option>
						<option value="senderId">보낸사람</option>
					</select>
				</div>
				<div class="form-inline">
					<div class="search-box w250">
						<input id="searchValue" name="searchValue" value="${pages.searchValue }" type="text" class="text-input"> <span
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
		<div class="buttons-action" style="display: none">
			<div>
				<a href="#Alldelete" role="button" data-toggle="modal">
					<button type="button" class="btn-alldelete">
						전체삭제<img src="/images/icon_delete.png" title="삭제">
					</button>
				</a>
				<button type="button" class="btn-allcancel">
					삭제취소<img src="/images/icon_cancel.png" title="취소">
				</button>
			</div>
			<div>
				<span class="text-action">14 items selected</span>
			</div>
		</div>
		<div class="scroll-auto">
			<table class="table table-actions">
				<colgroup>
					<col style="width: 85px;">
					<col style="width: 80px;">
					<col style="width: 150px;">
					<col style="width: 275px;">
					<col style="width: 60px;">
					<col style="width: 90px;">
				</colgroup>
				<thead>
					<tr class="th-bg">
						<th scope="col">일자</th>
						<th scope="col">보낸 사람</th>
						<th scope="col">제목</th>
						<th scope="col">내용</th>
						<th scope="col">확인(유/무)</th>
						<th scope="col">관리</th>
					</tr>
				</thead>

				<tbody>
					<c:forEach var="alarm" items="${alarms}" varStatus="status">
						<tr>
							<td><spring:eval expression="alarm.rgstDt.toString().substring(0,10)" /></td>
							<td class="text-point">${alarm.senderId}</td>
							<td>${alarm.sj}</td>
							<td class="ellipsis">${alarm.cn}</td>
							<td>
								<c:choose>
									<c:when test="${alarm.checkYn eq 'Y' }">
										<button type="button" class="button-yes alarmNo${alarm.alarmId }">YES</button>
									</c:when>
									<c:otherwise>
											<button type="button" class="button-no backColorRed alarmNo${alarm.alarmId }">NO</button>
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<div class="btn-group">
									<a href="#detail" onclick="detailView('${alarm.alarmId}');" role="button" data-toggle="modal" class="btn-Ticon02"><img src="/images/icon_detail.png" alt="상세보기" class="btn-Ticon02"></a>
								</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<!-- E_그리드-->
	<!-- S_페이징-->
	<div class="board-paging">
	</div>
	<!-- E_페이징-->
</div>


<!-- 레이어 팝업 - 상세 -->
<div id="detail" class="modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width: 800px">
		<div class="modal-header">
			<h4 class="modal-title">상세</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">일시</label>
						<div class="col-75">
							<input id="rgstDt" name="rgstDt" type="text" class="text-input" value="2021-10-18" disabled>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">보낸사람</label>
						<div class="col-75">
							<input id="senderId" name="senderId" type="text" class="text-input" value="신정" disabled>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">제목</label>
						<div class="col-75">
							<input id="sj" name="sj" type="text" class="text-input" value="국가공휴일" disabled>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">확인여부</label>
						<div class="col-75">
							<input id="checkYn" name="checkYn" type="text" class="text-input" value="yes" disabled>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-100">
					<div class="form-group">
						<label class="col-25 form-label-textarea">내용</label>
						<div class="col-75">
							<div class="form-input">
								<textarea id="cn" name="cn" class="textarea"></textarea>
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

<script type="text/javascript">
	$(document).ready(function() {
		var searchKey = '${pages.searchKey}';
		if(searchKey){
			$('#searchKey').val('${pages.searchKey}');
		}
		
		$('.search-box-append').click(function(){
			$('#searchFrm').submit();
		});
	});
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
	    wrapClass: 'paging',              // 페이징 을 감싼 클래스명
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
	
	function detailView(id){
		resetView();
		$.ajax({
			url : '/alarm/alarm/detail/'+id,
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
	
	function resetView(){
		$('#detail .modal-title').text('상세');
		$('#detail input').attr('disabled',true);
		$('#detail textarea').attr('disabled',true);
		$('#detail input').val('');
		$('#detail textarea').val('');
	}
	
	function setView(data){
		$('.alarmNo'+data.alarmId).text('YES');
		$('.alarmNo'+data.alarmId).addClass('button-yes');
		$('.alarmNo'+data.alarmId).removeClass('button-no');
		$('.alarmNo'+data.alarmId).removeClass('backColorRed');
		$('#sj').val(data.sj);
		$('#cn').val(data.cn);
		$('#senderId').val(data.senderId);
		$('#checkYn').val(data.checkYn);
		$('#userNm').val(data.userNm);
		$('#rgstDt').val(data.rgstDt);
	}
</script>