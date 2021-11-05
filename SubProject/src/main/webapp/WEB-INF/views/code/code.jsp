<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="content">
	<div class="row">
	<!-- S_left-area -->
		<div class="col-50 pr10">
			<div class="left-area">
				<div class="area-tlt d-flex justify-content-between">
					<h5>코드그룹목록</h5>
				</div>
				<div class="content-table pt0">
					<div class="scroll-auto">
						<table class="table table-actions">
							<colgroup>
								<col style="width: 40px;">
								<col style="width: 150px;">
								<col style="width: 150px;">
								<col style="width: 150px;">
								<col style="width: 85px;">
								<col style="width: 60px;">
							</colgroup>
							<thead>
								<tr class="th-bg">
									<th scope="col">번호</th>
									<th scope="col">코드그룹ID</th>
									<th scope="col">코드그룹명</th>
									<th scope="col">설명</th>
									<th scope="col">생성일시</th>
									<th scope="col">사용여부</th>
								</tr>
							</thead>
							<tbody>
								<tr class="tb-list">
									<td>1</td>
									<td class="text-point">DATE_LIMIT_YN</td>
									<td>기간 시용 적용 여부</td>
									<td>기간 시용 적용 여부</td>
									<td>2020-04-09</td>
									<td>
										 <button type="button" class="btn-yes">Yes</button>
									</td>
								</tr>
								<tr class="tb-list">
									<td>2</td>
									<td class="text-point">FILE</td>
									<td>대용량 파일 설정</td>
									<td>배치에서 사용</td>
									<td>2020-04-09</td>
									<td>
										 <button type="button" class="btn-yes">Yes</button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="btn-group pt15 tr">
					<button type="button" class="button btn-success" data-toggle="modal"><a href="#register" data-toggle="modal">등록</a></button>
				</div>
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
			</div>
		</div>
	<!-- E_left-area -->
	<!-- S_right-area -->
	<div class="col-50">
		<div class="right-area">
			<div class="area-tlt d-flex justify-content-between">
				<h5>코드목록정보</h5>
			</div>
			<div class="content-table pt0">
				<div class="scroll-auto">
					<table class="table table-actions">
						<colgroup>
							<col style="width: 30px;">
							<col style="width: 150px;">
							<col style="width: 130px;">
							<col style="width: 130px;">
							<col style="width: 100px;">
							<col style="width: 50px;">
						</colgroup>
						<thead>
							<tr class="th-bg">
								<th scope="col">번호</th>
								<th scope="col">코드그룹ID</th>
								<th scope="col">코드그룹명</th>
								<th scope="col">설명</th>
								<th scope="col">생성일시</th>
								<th scope="col">사용여부</th>
							</tr>
						</thead>
						<tbody>
							<tr class="tb-list">
								<td>1</td>
								<td class="text-point">DATE_LIMIT_YN</td>
								<td>기간 시용 적용 여부</td>
								<td>기간 시용 적용 여부</td>
								<td>2020-04-09</td>
								<td>
									 <button type="button" class="btn-yes">Yes</button>
								</td>
							</tr>
							<tr class="tb-list">
								<td>2</td>
								<td class="text-point">FILE</td>
								<td>대용량 파일 설정</td>
								<td>배치에서 사용</td>
								<td>2020-04-09</td>
								<td>
									 <button type="button" class="btn-yes">Yes</button>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="btn-group pt15 tr">
				<button type="button" class="button btn-success" data-toggle="modal"><a href="#register" data-toggle="modal">등록</a></button>
			</div>
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
		 </div>
		</div>
	</div>
	<!-- E_right-area -->
</div>


<!-- 레이어 팝업 - 등록  -->
<div id="register" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width:600px">
		<div class="modal-header">
		<h4 class="modal-title">등록</h4>
			<button type="button" class="close" data-dismiss="modal"><img src="../images/icon_close.png"></button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-100">
					<div class="form-group">
						<label class="col-25 form-label">코드그룹 ID<em>*</em></label>
						<div class="col-75">
							<div class="search-box">
								<input type="text" class="text-input">
								<span class="search-box-append">
									<button type="button" class="btn-search"><a href="#overlap" role="button" data-toggle="modal">중복확인</a></button>
								</span>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">코드그룹명<em>*</em></label>
						<div class="col-75">
							<div class="form-input">
								<input type="text" class="text-input">
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label-textarea">코드그룹비고</label>
						<div class="col-75">
							<div class="form-input">
								<textarea class="textarea"></textarea>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">코드그룹사용여부</label>
						<div class="col-75">
							<select class="select-box">
								<option value="1" selected>Yes</option>
								<option value="2">No</option>
							</select>
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

$('.paging_cont').bootpag({        // 페이징을 표시할 div의 클래스
	total: totalPageCnt,  // 페이징모델의 전체페이지수
    page: pageCnt,        // 페이징모델의 현재페이지번호
    maxVisible: pageSizeCnt,  // 보여질 최대 페이지수
    firstLastUse: true,             // first와 last사용유무
    wrapClass: 'paging',              // 페이징을 감싼 클래스명
    activeClass: 'on',              // 현재페이지의 클래스명
    disabledClass: 'disabled',      // 각 항목별 클래스 지정
    nextClass: 'next',
    prevClass: 'prev',
    lastClass: 'last',
    firstClass: 'first',
	next: ' ',
	prev: ' ',
	first: '<span aria-hidden="true"></span>',
	last: '<span aria-hidden="true"></span>'
}).on("paging_cont", function(event, num){
    $("#page").val(num);
    $("#holiBdForm").submit();
});
</script>