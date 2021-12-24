<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="content">
	<!-- S_검색-->
	<form id="searchFrm" action="/system/role" method="POST">
		<input type="hidden" id="page" name="page" value="${pages.page}">
		<div class="justify-content-between">
			<div class="form-group">
				<div class="form-inline">
					<select class="select-box w150" id="searchKey" name ="searchKey">
						<option value="groupId">그룹 ID</option>
						<option value="groupNm">그룹명</option>
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
					<col style="width: 30px;">
					<col style="width: 40px;">
					<col style="width: 100px;">
					<col style="width: 100px;">
					<col style="width: 100px;">
					<col style="width: 225px;">
					<col style="width: 85px;">
					<col style="width: 90px;">
				</colgroup>
				<thead>
					<tr class="th-bg">
						<th>
<!-- 							<input type="checkbox" name="all" id="checkAll"> -->
						</th>
						<th scope="col">번호</th>
						<th scope="col">그룹 ID</th>
						<th scope="col">그룹 명</th>
						<th scope="col">그룹 분류</th>
						<th scope="col">설명</th>
						<th scope="col">등록일</th>
						<th scope="col">관리</th>
					</tr>
				</thead>

				<tbody>
					<c:forEach var="role" items="${roles}" varStatus="status">
						<tr>
							<th><input type="checkbox" name="chk"></th>
							<td>${pages.totalCount - (status.index + (pages.page -1) * pages.pageSize)}</td>
							<td class="text-point">${role.authId}</td>
							<td>${role.authNm}</td>
							<td>
								<c:choose>
									<c:when test="${role.authCl eq 'A'}">
										시스템 관리자
									</c:when>
									<c:when test="${role.authCl eq 'P'}">
										관리자
									</c:when>
									<c:otherwise>
										참여자
									</c:otherwise>
								</c:choose>
							</td>
							<td>${role.authDsc}</td>
							<td>
								<spring:eval expression="role.rgstDt.toString().substring(0,10)" />
							</td>
							<td>
								<div class="btn-group">
									<a href="#detail" role="button" data-toggle="modal" class="btn-icon"><img src="/images/icon_detail.png" alt="상세보기" class="tbl-icon"></a>
									<a href="#edit" role="button" data-toggle="modal" class="btn-icon"><img src="/images/icon_edit.png" alt="수정하기" class="btn-Ticon02"></a>
									<a href="#delete" role="button" data-toggle="modal" class="btn-icon"><img src="/images/icon_delete2.png" alt="삭제하기" class="btn-Ticon02"></a>
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
		<button type="button" class="button btn-success" data-toggle="modal">
			<a href="#register" data-toggle="modal">등록</a>
		</button>
	</div>
	<!-- S_페이징-->
	<div class="board-paging">
	</div>
	<!-- E_페이징-->
</div>

<!-- 레이어 팝업 - 수정 -->
<div id="register" class="modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width: 800px">
		<div class="modal-header">
			<h4 class="modal-title">수정</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">등록일</label>
						<div class="col-75">
							<div class="form-input">
								<input type="text" class="text-input" value="2010-10-01"
									disabled>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">수정일</label>
						<div class="col-75">
							<div class="form-input">
								<input type="text" class="text-input" value="2010-10-21"
									disabled>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">그룹 ID</label>
						<div class="col-75">
							<div class="form-input">
								<input type="text" class="text-input" value="GROUP_01" disabled>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">회사명</label>
						<div class="col-75">
							<select class="select-box">
								<option value="1">CN_RTDATA</option>
								<option value="2">CN_PPLUSEcho</option>
							</select>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">그룹분류</label>
						<div class="col-75">
							<select class="select-box">
								<option value="1" selected>담당자</option>
								<option value="2">참여자</option>
							</select>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">그룹명</label>
						<div class="col-75">
							<div class="form-input">
								<input type="text" class="text-input" value="알티데이타랩">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-100">
					<div class="form-group">
						<label class="col-25 form-label-textarea">그룹 설명</label>
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
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-100">
					<div class="form-group">
						<div class="tc">
							(<em class="text-bold">GROUP_01</em>)삭제합니다.
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
				<img src="/images/icon_close.png">
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
	
</script>