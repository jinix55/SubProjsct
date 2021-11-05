<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="content">
						<!-- S_검색-->
            <form>
							<div class="justify-content-between">
								<div class="form-group">
									<div class="form-inline">
											<select class="select-box w150">
												<option value="0">그룹 ID</option>
												<option value="1">그룹명</option>
											</select>
									</div>
									<div class="form-inline">
										<div class="search-box w250">
											<input type="text" class="text-input">
											<span class="search-box-append">
												<button type="button" class="btn-search"><img src="/images/icon_search.png" title="검색"></button>
											</span>
										</div>
									</div>
								</div>
							</div>
						</form>
						<!-- E_검색-->
						<!-- S_그리드-->
						<div class="content-table">
							<div class="buttons-action" style="display:none">
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
										<col style="width: 30px;">
										<col style="width: 40px;">
										<col style="width: 160px">
										<col style="width: 150px">
										<col style="width: 240px">
										<col style="width: 60px;">
										<col style="width: 90px;">
									</colgroup>
									<thead>
										<tr class="th-bg">
											<th><input type="checkbox" name="all" id="checkAll"></th>
											<th scope="col">번호</th>
											<th scope="col">권한 ID</th>
											<th scope="col">권한 명</th>
											<th scope="col">권한 설명</th>
											<th scope="col">메뉴생성여부</th>
											<th scope="col">메뉴생성</th>
										</tr>
									</thead>

									<tbody>
										<tr>
											<th><input type="checkbox" name="chk"></th>
											<td scope="row">1</td>
											<td class="tl text-point">ROLE_SITE_ADMIN</td>
											<td>SITE별 관리자</td>
											<td>SITE별 관리자</td>
											<td>
												<button type="button" class="btn-yes">YES</button>
											</td>
											<td>
												<div class="btn-group">
	                       <a href="" onclick="sidebar_open()" role="button" data-toggle="modal" class="btn-tbl_icon"><img src="/images/icon_genemenu.png" title="메뉴생성" class="tbl-icon"></a>
												</div>
											</td>
										</tr>

										<tr>
											<th><input type="checkbox" name="chk"></th>
											<td scope="row">2</td>
											<td class="tl text-point">ROLE_SYSOP</td>
											<td>보조 관리자</td>
											<td>보조 관리자</td>
											<td>
												<button type="button" class="btn-yes">YES</button>
											</td>
											<td>
												<div class="btn-group">
													<div class="btn-group">
		                       <a href="" onclick="sidebar_open()" role="button" data-toggle="modal" class="btn-tbl_icon"><img src="/images/icon_genemenu.png" title="메뉴생성" class="tbl-icon"></a>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<th><input type="checkbox" name="chk"></th>
											<td scope="row">3</td>
											<td class="tl text-point">ROLE_TEST</td>
											<td>ROLE_TEST</td>
											<td>테스트 권한</td>
											<td>
												<button type="button" class="btn-yes">YES</button>
											</td>
											<td>
												<div class="btn-group">
													<div class="btn-group">
		                       <a href="" onclick="sidebar_open()" role="button" data-toggle="modal" class="btn-tbl_icon"><img src="/images/icon_genemenu.png" title="메뉴생성" class="tbl-icon"></a>
													</div>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<!-- E_그리드-->
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

<!-- S_메뉴(오른쪽) -->
<!-- S_메뉴(오른쪽) -->
		<section class="menu-chat sidebar-animate" id="Sidebar">
			 <div class="modal-header">
			 <h4 class="modal-title">권한별 메뉴 변경</h4>
			 		<a href="javascript:layerPopupClose(sidebar_close);"><img src="/images/icon_close.png"></a>
			 </div>
				<div class="modal-body">
					<!-- 버튼 -->
          <div class="modal-title">ROLE_SITE_ADMIN</div>
					<div class="btn-group line-item">
						<button type="button" class="button-small btn-success">초기화</button>
						<button type="button" class="button-small btn-warning">적용</button>
						<button type="button" class="button-small btn-cancel" onclick="sidebar_close()">취소</button>
					</div>
					<form action="javascript:void(0)">
					<ul id="tree-checkmenu" class="checktree">
					 <li id="show-explorer">
						<input id="check-explorer" type="checkbox" />
						Administrator
						<span id="count-explorer" class="count"></span>
							<ul id="tree-explorer">
								<li id="show-iewin">
									<input id="check-iewin" type="checkbox" />프로젝트관리
									<span id="count-iewin" class="count"></span>
										<ul id="tree-iewin">
											<li><input type="checkbox" />프로젝트관리</li>
											<li><input type="checkbox" />그룹등록</li>
											<li><input type="checkbox" />사용자등록</li>
										</ul>
								 </li>
								 <li id="show-iemac">
									<input id="check-iemac" type="checkbox" />시스템관리
									<span id="count-iemac" class="count"></span>
										<ul id="tree-iemac">
											 <li><input type="checkbox" />권한목록등록</li>
											 <li><input type="checkbox" />계정권한부여</li>
											 <li class="last"><input type="checkbox" />권한별메뉴적용</li>
										</ul>
								 </li>
								 <li id="show-iemac2">
									<input id="check-iemac2" type="checkbox" />메뉴관리
									<span id="count-iemac2" class="count"></span>
										<ul id="tree-iemac2">
											<li><input type="checkbox" />관리자메뉴관리</li>
										</ul>
								 </li>
								 <li id="show-iemac3">
									<input id="check-iemac3" type="checkbox" />로그관리
									<span id="count-iemac3" class="count"></span>
									<ul id="tree-iemac3">
										<li><input type="checkbox" />계정권한정보</li>
									 <li><input type="checkbox" />레포트</li>
									</ul>
								 </li>
							</ul>
					 </li>
					 <li id="show-netscape">
						<input id="check-netscape" type="checkbox" />Data Visualization
						<span id="count-netscape" class="count"></span>
						<ul id="tree-netscape">
							<li id="show-iemac4">
							<input id="check-iemac4" type="checkbox" />데이터분석
							<span id="count-iemac4" class="count"></span>
							<ul id="tree-iemac4">
								<li><input type="checkbox" />대여소 현황</li>
								<li><input type="checkbox" />이용현황 분석</li>
								<li><input type="checkbox" />회원 분석</li>
								<li><input type="checkbox" />수요예측 모델 분석</li>
							</ul>
						 </li>
						</ul>
					 </li>
					 <li class="last"><input type="checkbox" />기타</li>
					</ul>
				</form>
				</div>
			</div>
		</section>

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

function sidebar_open() {
  document.getElementById("Sidebar").style.display = "block";
  document.getElementById("Backdrop").style.display = "block";
}

function sidebar_close() {
  document.getElementById("Sidebar").style.display = "none";
  document.getElementById("Backdrop").style.display = "none";
}
</script>