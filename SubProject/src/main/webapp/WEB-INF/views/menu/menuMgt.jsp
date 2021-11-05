<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="content">
	<div class="row">
		<!-- S_left-area -->
		<div class="col-35-area pr16-area">
			<div class="left-area">
				<h5>
					<div class="area-img form-inline">
						<img src="/images/icon-list.png">
					</div>
					메뉴목록
				</h5>
				<div class="menu-inner">
					<form action="javascript:void(0)">
						<ul id="tree-checkmenu" class="checktree">
							<li id="show-explorer"><input id="check-explorer"
								type="checkbox" />Administrator <span id="count-explorer"
								class="count"></span>
								<ul id="tree-explorer">
									<li id="show-iewin"><input id="check-iewin"
										type="checkbox" />프로젝트관리 <span id="count-iewin" class="count"></span>
										<ul id="tree-iewin">
											<li><input type="checkbox" />프로젝트관리</li>
											<li><input type="checkbox" />그룹등록</li>
											<li><input type="checkbox" />사용자등록</li>
										</ul></li>
									<li id="show-iemac"><input id="check-iemac"
										type="checkbox" />시스템관리 <span id="count-iemac" class="count"></span>
										<ul id="tree-iemac">
											<li><input type="checkbox" />권한목록등록</li>
											<li><input type="checkbox" />계정권한부여</li>
											<li class="last"><input type="checkbox" />권한별메뉴적용</li>
										</ul></li>
									<li id="show-iemac2"><input id="check-iemac2"
										type="checkbox" />메뉴관리 <span id="count-iemac2" class="count"></span>
										<ul id="tree-iemac2">
											<li><input type="checkbox" />관리자메뉴관리</li>
										</ul></li>
									<li id="show-iemac3"><input id="check-iemac3"
										type="checkbox" />로그관리 <span id="count-iemac3" class="count"></span>
										<ul id="tree-iemac3">
											<li><input type="checkbox" />계정권한정보</li>
											<li><input type="checkbox" />레포트</li>
										</ul></li>
								</ul></li>
							<li id="show-netscape"><input id="check-netscape"
								type="checkbox" />Data Visualization <span id="count-netscape"
								class="count"></span>
								<ul id="tree-netscape">
									<li id="show-iemac4"><input id="check-iemac4"
										type="checkbox" />데이터분석 <span id="count-iemac4" class="count"></span>
										<ul id="tree-iemac4">
											<li><input type="checkbox" />대여소 현황</li>
											<li><input type="checkbox" />이용현황 분석</li>
											<li><input type="checkbox" />회원 분석</li>
											<li><input type="checkbox" />수요예측 모델 분석</li>
										</ul></li>
								</ul></li>
							<li class="last"><input type="checkbox" />기타</li>
						</ul>
					</form>
				</div>
			</div>
		</div>
		<!-- E_left-area -->
		<!-- S_right-area -->
		<div class="col-65-area">
			<div class="right-area">
				<h5>
					<div class="area-img form-inline">
						<img src="/images/icon-list.png">
					</div>
					메뉴적용 현황
				</h5>
				<div class="row">
					<div class="col-100">
						<div class="form-group">
							<label class="col-25 form-label">상위 메뉴ID</label>
							<div class="col-75">
								<div class="form-input">
									<input type="text" class="text-input">
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label">메뉴ID</label>
							<div class="col-75">
								<div class="form-input">
									<input type="text" class="text-input">
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label">메뉴명</label>
							<div class="col-75">
								<div class="form-input">
									<input type="text" class="text-input">
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label">메뉴순서</label>
							<div class="col-75">
								<div class="form-input">
									<input type="text" class="text-input">
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label">메뉴URL</label>
							<div class="col-75">
								<div class="form-input">
									<input type="text" class="text-input">
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label">메뉴속성</label>
							<div class="col-75">
								<div class="form-input">
									<input type="text" class="text-input">
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label">메뉴구분</label>
							<div class="col-75">
								<div class="form-input-box">
									<div class="btn-sm di-inblock">
										<input type="radio" id="radio1" name="radio"> <label
											for="radio1" class="mr05">메뉴(M)
									</div>
									<div class="btn-sm di-inblock">
										<input type="radio" id="radio2" name="radio" checked="checked">
										<label for="radio2" class="mr05">기능(F)
									</div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label">메뉴사용여부</label>
							<div class="col-75">
								<div class="form-input-box">
									<div class="btn-sm di-inblock">
										<input type="radio" id="radio3" name="radio2"
											checked="checked"> <label for="radio3" class="mr05">사용(Y)
									</div>
									<div class="btn-sm di-inblock">
										<input type="radio" id="radio4" name="radio2"> <label
											for="radio4" class="mr05">미사용(N)
									</div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label-textarea">설명</label>
							<div class="col-75">
								<div class="form-input">
									<textarea class="textarea" placeholder="그룹 설명그룹 설명"></textarea>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="btn-group tr">
					<button type="button" class="button-small btn-success">저장</button>
					<button type="button" class="button-small btn-warning"
						onclick=javascript:layerPopup(layerDeletePopup);>삭제</button>
					<button type="button" class="button-small btn-cancel" onclick="">취소</button>
				</div>
			</div>
		</div>
	</div>
	<!-- E_right-area -->
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