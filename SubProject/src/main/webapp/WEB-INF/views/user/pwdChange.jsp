<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="content tc">
						<!-- S_content-->
						<div class="login-tltle">비밀번호 변경</div>
							<div class="login-content" style="background: none;border: 0px;">
								<div class="login-form">
									<form>
										<div class="login-id h45">
											 <input type="text" class="text-input pl35" placeholder="아이디을 입력하세요.">
										</div>
										<div class="login-pw h45">
											 <input type="password" class="text-input pl35" placeholder="비밀번호 입력하세요.">
										</div>
										<div class="login-pw h45">
											 <input type="password" class="text-input pl35" placeholder="새 비밀번호 입력하세요.">
										</div>
										<div class="login-pw h45">
											 <input type="password" class="text-input pl35" placeholder="새 비밀번호 확인.">
										</div>
										<div class="btn-group">
											<button type="button" class="button btn-success w100"><a href="../login/Login.html">비밀번호 변경</a></button>
										</div>
									</form>
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