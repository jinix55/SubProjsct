<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="content">
	<!-- S_검색-->
	<form>
		<div class="justify-content-between">
			<div class="form-group">
				<div class="form-inline">
					<select class="select-box w150">
						<option value="">전체</option>
						<option value="C">국가공휴일</option>
						<option value="W">주말</option>
						<option value="T">임시공휴일</option>
					</select>
				</div>
				<div class="form-inline">
					<select class="select-box w150">
						<option value="">전체</option>
						<option value="0">Yes</option>
						<option value="1">No</option>
					</select>
				</div>
				<div class="form-inline">
					<div class="search-box w250">
						<input type="text" class="text-input"> <span
							class="search-box-append">
							<button type="button" class="btn-search">
								<img src="../images/icon_search.png" title="검색">
							</button>
						</span>
					</div>
				</div>
			</div>
			<div class="form-group fr">
				<div class="form-inline">
					<label class="form-label-calendar">기간설정</label>
					<div class="search-date">
						<input type="text" id="startDt" name="dateFrom" class="text-input">
					</div>
					~
					<div class="search-date">
						<input type="text" id="endDt" name="dateTo" class="text-input">
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
						전체삭제<img src="../images/icon_delete.png" title="삭제">
					</button>
				</a>
				<button type="button" class="btn-allcancel">
					삭제취소<img src="../images/icon_cancel.png" title="취소">
				</button>
			</div>
			<div>
				<span class="text-action">14 items selected</span>
			</div>
		</div>
		<div class="scroll-auto">
			<table class="table table-actions">
				<colgroup>
					<col style="width: 30px;">
					<col style="width: 85px;">
					<col style="width: 150px;">
					<col style="width: 125px;">
					<col style="width: 230px;">
					<col style="width: 60px;">
					<col style="width: 90px;">
				</colgroup>
				<thead>
					<tr class="th-bg">
						<th><input type="checkbox" name="all" id="checkAll"></th>
						<th scope="col">일자</th>
						<th scope="col">휴일명</th>
						<th scope="col">휴일타입</th>
						<th scope="col">설명</th>
						<th scope="col">사용여부</th>
						<th scope="col">관리</th>
					</tr>
				</thead>

				<tbody>
					<tr class="tb-list">
						<th><input type="checkbox" name="chk"></th>
						<td scope="row">2021-01-01</td>
						<td class="text-point">신정</td>
						<td>국가 공휴일</td>
						<td>대체휴일</td>
						<td>
							<button type="button" class="btn-no">NO</button>
						</td>
						<td>
							<div class="btn-group">
								<a href="#detail" role="button" data-toggle="modal"
									class="btn-tbl_icon"><img src="../images/icon_detail.png"
									alt="상세보기" class="tbl-icon"></a> <a href="#edit"
									role="button" data-toggle="modal" class="btn-tbl_icon"><img
									src="../images/icon_edit.png" alt="수정하기" class="tbl-icon2"></a>
								<a href="#delete" role="button" data-toggle="modal"
									class="btn-tbl_icon"><img src="../images/icon_delete2.png"
									alt="삭제하기" class="tbl-icon2"></a>
							</div>
						</td>
					</tr>
					<tr class="tb-list">
						<th><input type="checkbox" name="chk"></th>
						<td scope="row">2021-01-02</td>
						<td class="text-point">토요일</td>
						<td>주말</td>
						<td>정기휴일</td>
						<td>
							<button type="button" class="btn-yes">YES</button>
						</td>
						<td>
							<div class="btn-group">
								<a href="#detail" role="button" data-toggle="modal"
									class="btn-tbl_icon"><img src="../images/icon_detail.png"
									alt="상세보기" class="tbl-icon"></a> <a href="#edit"
									role="button" data-toggle="modal" class="btn-tbl_icon"><img
									src="../images/icon_edit.png" alt="수정하기" class="tbl-icon2"></a>
								<a href="#delete" role="button" data-toggle="modal"
									class="btn-tbl_icon"><img src="../images/icon_delete2.png"
									alt="삭제하기" class="tbl-icon2"></a>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<!-- E_그리드-->
	<div class="btn-group pt15 tr">
		<button type="button" class="button btn-success" data-toggle="modal">
			<a href="#register" data-toggle="modal">등록</a>
		</button>
	</div>
	<!-- S_페이징-->
	<div class="board-paging">
		<ul>
			<li><a href="#" class="start">◀</a></li>
			<li class="on"><a href="#">1</a></li>
			<li><a href="#">2</a></li>
			<li><a href="#">3</a></li>
			<li><a href="#">4</a></li>
			<li><a href="#">5</a></li>
			<li><a href="#">6</a></li>
			<li><a href="#">7</a></li>
			<li><a href="#">8</a></li>
			<li><a href="#">9</a></li>
			<li><a href="#">10</a></li>
			<li><a href="#">...20</a></li>
			<li><a href="#" class="last">▶</a></li>
		</ul>
	</div>
	<!-- E_페이징-->
</div>

<!-- 레이어 팝업 - 등록  -->
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
						<div class="col-75">
							<input type="text" class="text-input">
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
							<select class="select-box">
								<option value="1">Yes</option>
								<option value="2">No</option>
							</select>
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

<!-- 레이어 팝업 - 상세 -->
<div id="detail" class="modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width: 800px">
		<div class="modal-header">
			<h4 class="modal-title">상세정보</h4>
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
							<input type="text" class="text-input" value="2021-10-18" disabled>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">휴일명</label>
						<div class="col-75">
							<input type="text" class="text-input" value="신정" disabled>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">휴일타입</label>
						<div class="col-75">
							<input type="text" class="text-input" value="국가공휴일" disabled>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">사용여부</label>
						<div class="col-75">
							<input type="text" class="text-input" value="yes" disabled>
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
			<button type="button" class="button btn-success" data-dismiss="modal">확인</button>
		</div>
	</div>
</div>

<!-- 레이어 팝업 - 수정 -->
<div id="edit" class="modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width: 800px">
		<div class="modal-header">
			<h4 class="modal-title">수정하기</h4>
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
							<input type="text" class="text-input" value="2021-10-18">
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">휴일명</label>
						<div class="col-75">
							<select class="select-box">
								<option value="1">신정</option>
								<option value="2">토요일</option>
							</select>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">휴일타입</label>
						<div class="col-75">
							<select class="select-box">
								<option value="1">국가 공휴일</option>
								<option value="2">주말</option>
							</select>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">사용여부</label>
						<div class="col-75">
							<select class="select-box">
								<option value="1">Yes</option>
								<option value="2">No</option>
							</select>
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
			<button type="button" class="button btn-success" data-dismiss="modal">확인</button>
		</div>
	</div>
</div>
<!-- 레이어 팝업 - delete -->
<div id="delete" class="modal" data-backdrop-limit="1" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
	data-modal-parent="#myModal">
	<!-- Modal content-->
	<div class="modal-content" style="width: 400px">
		<div class="modal-header">
			<h4 class="modal-title">삭제</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="../images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-100">
					<div class="form-group">
						<div class="tc">
							휴일 지정일을(<em class="text-bold">2021-10-18</em>)삭제합니다.
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
<!-- 레이어 팝업 delete All -->
<div id="Alldelete" class="modal" data-backdrop-limit="1" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
	data-modal-parent="#myModal">
	<!-- Modal content-->
	<div class="modal-content" style="width: 400px">
		<div class="modal-header">
			<h4 class="modal-title">전체삭제</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="../images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-100">
					<div class="form-group">
						<div class="tc">
							<em class="text-bold">14 items selected</em><br />삭제하시겠습니까?
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="modal-footer btn-tbl_group">
			<button type="button" class="button btn-warning" data-dismiss="modal">삭제</button>
			<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>

<script type="text/javascript">
	/**
	 * 페이징 처리 공통 함수
	 */
	// var totalPage = ${pages.totalPage};
	// var page = ${pages.page}; 
	// var pageSize = ${pages.pageSize}; 
	var totalPageCnt = 10;
	var pageCnt = 2;
	var pageSizeCnt = 10;

	$('.paging_cont').bootpag({ // 페이징을 표시할 div의 클래스
		total : totalPageCnt, // 페이징모델의 전체페이지수
		page : pageCnt, // 페이징모델의 현재페이지번호
		maxVisible : pageSizeCnt, // 보여질 최대 페이지수
		firstLastUse : true, // first와 last사용유무
		wrapClass : 'paging', // 페이징을 감싼 클래스명
		activeClass : 'on', // 현재페이지의 클래스명
		disabledClass : 'disabled', // 각 항목별 클래스 지정
		nextClass : 'next',
		prevClass : 'prev',
		lastClass : 'last',
		firstClass : 'first',
		next : ' ',
		prev : ' ',
		first : '<span aria-hidden="true"></span>',
		last : '<span aria-hidden="true"></span>'
	}).on("paging_cont", function(event, num) {
		$("#page").val(num);
		$("#holiBdForm").submit();
	});
</script>