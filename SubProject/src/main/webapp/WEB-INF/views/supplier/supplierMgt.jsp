<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="content">
	<!-- S_검색-->
	<form>
		<div class="justify-content-between">
			<div class="form-group">
				<div class="form-inline">
					<select class="select-box w150">
						<option value="">전체</option>
						<option value="0">공급업체</option>
						<option value="1">사업자번호</option>
						<option value="2">공급유형</option>
						<option value="3">담당자</option>
					</select>
				</div>
				<div class="form-inline">
					<div class="search-box w250">
						<input type="text" class="text-input"> <span
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
					<col style="width: 100px;">
					<col style="width: 180px;">
					<col style="width: 100px;">
					<col style="width: 80px;">
					<col style="width: 90px;">
					<col style="width: 100px;">
					<col style="width: 90px;">
				</colgroup>
				<thead>
					<tr class="th-bg">
						<th><input type="checkbox" name="all" id="checkAll"></th>
						<th scope="col">공급업체ID</th>
						<th scope="col">공급업체명</th>
						<th scope="col">사업자번호</th>
						<th scope="col">대표자</th>
						<th scope="col">공급유형</th>
						<th scope="col">담당자</th>
						<th scope="col">관리</th>
					</tr>
				</thead>

				<tbody>
					<tr>
						<th><input type="checkbox" name="chk"></th>
						<td>SUP_001</td>
						<td class="text-point">희성산업</td>
						<td>02-000-000</td>
						<td>홍길동</td>
						<td class="ellipsis">원자재</td>
						<td><a href="#charge" role="button" data-toggle="modal"
							class="btn-icon"><img src="/images/icon_user2.png">홍나리</a></td>
						<td>
							<div class="btn-group">
								<a href="#detail" role="button" data-toggle="modal"
									class="btn-icon"><img src="/images/icon_detail.png"
									alt="상세보기" class="btn-Ticon"></a> <a href="#edit"
									role="button" data-toggle="modal" class="btn-icon"><img
									src="/images/icon_edit.png" alt="수정하기" class="btn-Ticon02"></a>
								<a href="#delete" role="button" data-toggle="modal"
									class="btn-icon"><img src="/images/icon_delete2.png"
									alt="삭제하기" class="btn-Ticon02"></a>
							</div>
						</td>
					</tr>
					<tr>
						<th><input type="checkbox" name="chk"></th>
						<td>SUP_002</td>
						<td class="text-point">포장</td>
						<td>02-000-000</td>
						<td>강감찬</td>
						<td class="ellipsis">포장</td>
						<td><a href="#charge" role="button" data-toggle="modal"
							class="btn-icon"><img src="/images/icon_user2.png">홍나리</a></td>
						<td>
							<div class="btn-group">
								<a href="#detail" role="button" data-toggle="modal"
									class="btn-icon"><img src="/images/icon_detail.png"
									alt="상세보기" class="btn-Ticon"></a> <a href="#edit"
									role="button" data-toggle="modal" class="btn-icon"><img
									src="/images/icon_edit.png" alt="수정하기" class="btn-Ticon02"></a>
								<a href="#delete" role="button" data-toggle="modal"
									class="btn-icon"><img src="/images/icon_delete2.png"
									alt="삭제하기" class="btn-Ticon02"></a>
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
			<a href="#register" data-toggle="modal">공급업체등록</a>
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
	<div class="modal-content" style="width: 900px">
		<div class="modal-header">
			<h4 class="modal-title">공급업체등록</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="tab">
				<ul class="tabnav">
					<li><a href="#tab01">기업정보</a></li>
					<li><a href="#tab02">담당자</a></li>
				</ul>
				<div class="tabcontent">
					<div id="tab01">
						<div class="row">
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">업체명</label>
									<div class="col-75">
										<input type="text" class="text-input">
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">대표자명</label>
									<div class="col-75">
										<input type="text" class="text-input">
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">사업자번호</label>
									<div class="col-75">
										<input type="text" class="text-input">
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">공급기업Type</label>
									<div class="col-75">
										<select class="select-box">
											<option value="1">원자재/포전재</option>
											<option value="2">원자재/포전재</option>
										</select>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-100">
								<div class="form-group">
									<label class="col-25 form-label">주소</label>
									<div class="col-75">
										<input type="text" class="text-input">
									</div>
								</div>
								<div class="form-group">
									<label class="col-25 form-label">웹사이트</label>
									<div class="col-75">
										<input type="text" class="text-input">
									</div>
								</div>
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
					<div id="tab02">
						<table class="table">
							<colgroup>
								<col style="width: 100px;">
								<col style="width: 100px;">
								<col style="width: 90px;">
							</colgroup>
							<thead>
								<tr class="th-bg">
									<th scope="col">성명</th>
									<th scope="col">직위</th>
									<th scope="col">관리</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="text-point">홍길동</td>
									<td>과장</td>
									<td>
										<div class="btn-group">
											<a href="#edit02" role="button" data-toggle="modal"
												class="btn-icon"><img src="/images/icon_edit.png"
												alt="수정하기" class="btn-Ticon02"></a> <a href="#delete"
												role="button" data-toggle="modal" class="btn-icon"><img
												src="/images/icon_delete2.png" alt="삭제하기" class="btn-Ticon02"></a>
										</div>
									</td>
								</tr>
								<tr>
									<td class="text-point">고길동</td>
									<td>차장</td>
									<td>
										<div class="btn-group">
											<a href="#edit02" role="button" data-toggle="modal"
												class="btn-icon"><img src="/images/icon_edit.png"
												alt="수정하기" class="btn-Ticon02"></a> <a href="#delete"
												role="button" data-toggle="modal" class="btn-icon"><img
												src="/images/icon_delete2.png" alt="삭제하기" class="btn-Ticon02"></a>
										</div>
									</td>
								</tr>
							</tbody>
						</table>

						<div class="row pt30">
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">성명</label>
									<div class="col-75">
										<input type="text" class="text-input">
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">휴대폰번호</label>
									<div class="col-75">
										<input type="text" class="text-input">
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">부서</label>
									<div class="col-75">
										<input type="text" class="text-input">
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">직위</label>
									<div class="col-75">
										<input type="text" class="text-input">
									</div>
								</div>
							</div>
							<div class="col-100">
								<div class="form-group">
									<label class="col-25 form-label">이메일</label>
									<div class="col-75">
										<input type="text" class="text-input">
									</div>
								</div>
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
	<div class="modal-content" style="width: 900px">
		<div class="modal-header">
			<h4 class="modal-title">공급업체상세</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<h4 class="tl mb10">
				<span class="title-point">[기업정보]</span>
			</h4>
			<div class="row">
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">등록날짜</label>
						<div class="col-75">
							<input type="text" class="text-input" value="2001-12-30" disabled>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">공급업체 ID</label>
						<div class="col-75">
							<input type="text" class="text-input" value="SUP_001" disabled>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">업체명</label>
						<div class="col-75">
							<input type="text" class="text-input" value="희성산업" disabled>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">대표자명</label>
						<div class="col-75">
							<input type="text" class="text-input">
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">사업자번호</label>
						<div class="col-75">
							<input type="text" class="text-input">
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">공급기업Type</label>
						<div class="col-75">
							<select class="select-box">
								<option value="1">원자재/포전재</option>
								<option value="2">원자재/포전재</option>
							</select>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-100">
					<div class="form-group">
						<label class="col-25 form-label">주소</label>
						<div class="col-75">
							<input type="text" class="text-input">
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">웹사이트</label>
						<div class="col-75">
							<input type="text" class="text-input">
						</div>
					</div>
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

			<h4 class="tl mb10 pt15">
				<span class="title-point">[담당자]</span>
			</h4>
			<div class="row">
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">성명</label>
						<div class="col-75">
							<input type="text" class="text-input">
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">휴대폰번호</label>
						<div class="col-75">
							<input type="text" class="text-input">
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">부서</label>
						<div class="col-75">
							<input type="text" class="text-input">
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">직위</label>
						<div class="col-75">
							<input type="text" class="text-input">
						</div>
					</div>
				</div>
				<div class="col-100">
					<div class="form-group">
						<label class="col-25 form-label">이메일</label>
						<div class="col-75">
							<input type="text" class="text-input">
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
	<div class="modal-content" style="width: 900px">
		<div class="modal-header">
			<h4 class="modal-title">공급업체수정</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<h4 class="tl mb10">
				<span class="title-point">[기업정보]</span>
			</h4>
			<div class="row">
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">업체명</label>
						<div class="col-75">
							<input type="text" class="text-input">
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">대표자명</label>
						<div class="col-75">
							<input type="text" class="text-input">
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">사업자번호</label>
						<div class="col-75">
							<input type="text" class="text-input">
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">공급기업Type</label>
						<div class="col-75">
							<select class="select-box">
								<option value="1">원자재/포전재</option>
								<option value="2">원자재/포전재</option>
							</select>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-100">
					<div class="form-group">
						<label class="col-25 form-label">주소</label>
						<div class="col-75">
							<input type="text" class="text-input">
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label">웹사이트</label>
						<div class="col-75">
							<input type="text" class="text-input">
						</div>
					</div>
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

			<h4 class="tl mb10 pt15">
				<span class="title-point">[담당자]</span>
			</h4>
			<div class="row">
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">성명</label>
						<div class="col-75">
							<input type="text" class="text-input">
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">휴대폰번호</label>
						<div class="col-75">
							<input type="text" class="text-input">
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">부서</label>
						<div class="col-75">
							<input type="text" class="text-input">
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">직위</label>
						<div class="col-75">
							<input type="text" class="text-input">
						</div>
					</div>
				</div>
				<div class="col-100">
					<div class="form-group">
						<label class="col-25 form-label">이메일</label>
						<div class="col-75">
							<input type="text" class="text-input">
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
<div id="edit02" class="modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width: 900px">
		<div class="modal-header">
			<h4 class="modal-title">담당자수정</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">성명</label>
						<div class="col-75">
							<input type="text" class="text-input">
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">휴대폰번호</label>
						<div class="col-75">
							<input type="text" class="text-input">
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">부서</label>
						<div class="col-75">
							<input type="text" class="text-input">
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">직위</label>
						<div class="col-75">
							<input type="text" class="text-input">
						</div>
					</div>
				</div>
				<div class="col-100">
					<div class="form-group">
						<label class="col-25 form-label">이메일</label>
						<div class="col-75">
							<input type="text" class="text-input">
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
							(<em class="text-bold">2021-10-18</em>)삭제합니다.
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
		<div class="modal-footer btn-Tgroup">
			<button type="button" class="button btn-warning" data-dismiss="modal">삭제</button>
			<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>

<!-- 레이어 팝업 - 담당자  -->
<div id="charge" class="modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width: 700px">
		<div class="modal-header">
			<h4 class="modal-title">담당자 정보</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">성명</label>
						<div class="col-75">
							<input type="text" class="text-input" value="홍나리" disabled>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">휴대폰번호</label>
						<div class="col-75">
							<input type="text" class="text-input" value="010-123-4567">
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">부서</label>
						<div class="col-75">
							<input type="text" class="text-input" value="홍보">
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">직위</label>
						<div class="col-75">
							<input type="text" class="text-input" value="과장">
						</div>
					</div>
				</div>
				<div class="col-100">
					<div class="form-group">
						<label class="col-25 form-label">이메일</label>
						<div class="col-75">
							<input type="text" class="text-input"
								value="PPlueEco@PlueEc.co.kr">
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 버튼 -->
		<div class="modal-footer btn-group">
			<button type="button" class="button btn-success" data-dismiss="modal">수정</button>
			<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>



<script type="text/javascript">
	/**
	 * 페이징 처리 공통 함수
	 */
	var totalPage = $
	{
		pages.totalPage
	};
	var page = $
	{
		pages.page
	};
	var pageSize = $
	{
		pages.pageSize
	};

	// var totalPage = 10;
	// var page = 2; 
	// var pageSize = 10; 

	$('.board-paging').bootpag({ // 페이징을 표시할 div의 클래스
		total : totalPage, // 페이징모델의 전체페이지수
		page : page, // 페이징모델의 현재페이지번호
		maxVisible : pageSize, // 보여질 최대 페이지수
		firstLastUse : true, // first와 last사용유무
		wrapClass : 'paging', // 페이징을 감싼 클래스명
		activeClass : 'on', // 현재페이지의 클래스명
		disabledClass : 'disabled', // 각 항목별 클래스 지정
		nextClass : 'next',
		prevClass : 'prev',
		lastClass : 'last',
		firstClass : 'first',
	}).on("page", function(event, num) {
		$("#page").val(num);
		$("#holiBdForm").submit();
	});

	function detailView(id) {
		$.ajax({
			url : '/system/company/detail/' + id,
			dataType : 'json',
			type : "POST",
			error : function(xhr, status, error) {
				console.log(error);
			},
			success : function(data) {
				setView(data);
			}
		});
	}

	function setView(data) {

		$('#edit .modal-title').text('상세');
		$('#edit input').attr('disabled', true);
		$('#edit textarea').attr('disabled', true);
		$('#edit select').attr('disabled', true);

		var companyNo1;
		var companyNo2;
		var companyNo3;
		var telephoneNo1;
		var telephoneNo2;
		var telephoneNo3;

		if (data.companyNo) {
			companyNo1 = data.companyNo.split("-")[0];
			companyNo2 = data.companyNo.split("-")[1];
			companyNo3 = data.companyNo.split("-")[2];
		}
		if (data.telephoneNo) {
			telephoneNo1 = data.telephoneNo.split("-")[0];
			telephoneNo2 = data.telephoneNo.split("-")[1];
			telephoneNo3 = data.telephoneNo.split("-")[2];
		}

		$('#companyCode').val(data.companyCode);
		$('#companyId').val(data.companyId);
		$('#companyNo').val(data.companyNo);
		$('#companyNo1').val(companyNo1);
		$('#companyNo2').val(companyNo2);
		$('#companyNo3').val(companyNo3);
		$('#companyNm').val(data.companyNm);
		$('#companyDsc').val(data.companyDsc);
		$('#address').val(data.address);
		$('#telephoneNo').val(data.telephoneNo);
		$('#telephoneNo1').val(telephoneNo1);
		$('#telephoneNo2').val(telephoneNo2);
		$('#telephoneNo3').val(telephoneNo3);
		$('#representativeNm').val(data.representativeNm);
		$('#note').val(data.note);
		$('#useYn').val(data.useYn);

	}

	function setEdit() {
		$('#edit .modal-title').text('수정');
		$('#edit input').attr('disabled', false);
		$('#edit textarea').attr('disabled', false);
		$('#edit select').attr('disabled', false);
		$('#companyId').attr('disabled', true);
		$('.btnCheck').text('취소');
		$('.btnEdit').text('저장');
		$('.btnEdit').addClass('btnSave');
	}

	function resetView() {
		$('#edit .modal-title').text('상세');
		$('#edit input').attr('disabled', true);
		$('#edit textarea').attr('disabled', true);
		$('#edit select').attr('disabled', true);
		$('.btnCheck').text('확인');
		$('.btnEdit').text('수정');
		$('.btnEdit').removeClass('btnSave');
	}

	function regResetView() {
		$('#register input').val('');
		$('#register .codeSearch').removeClass('search-Success');
	}

	function deleteCompanyAction() {
		$('#tr_' + $('.delCompanyAction').val()).remove();
		param = {
			companyId : $('.delCompanyAction').val()
		}
		if (validation()) {
			if (isDisabled) {
				return false;
			} else {
				isDisabled = true;
				$.ajax({
					url : '/system/company/delete',
					dataType : 'text',
					type : "POST",
					data : param,
					error : function(xhr, status, error) {
						console.log(error);
					},
					success : function(result) {
						if (result == 'Delete') {
							location.href = '/system/company';
						}
					}
				});
			}
		}
	}

	function companySave() {
		$('#companyId').attr('disabled', false);
		var param = $("#companyInst").serialize();
		callInsertAjax(param)
	}

	function companyInsert() {
		var has = $('#codeSearch').hasClass('search-Success');
		if (!has) {
			alert('회사 코드 중복 학인이 필요합니다.');
			return false;
		}

		var companyNo = $('#reg_companyNo1').val() + "-"
				+ $('#reg_companyNo2').val() + "-" + $('#reg_companyNo3').val();
		var telephoneNo = $('#reg_telephoneNo1').val() + "-"
				+ $('#reg_telephoneNo2').val() + "-"
				+ $('#reg_telephoneNo3').val();
		var param = {
			companyCode : $('#reg_companyCode').val(),
			companyId : $('#reg_companyId').val(),
			companyNo : companyNo,
			companyNm : $('#reg_companyNm').val(),
			companyDsc : $('#reg_companyDsc').val(),
			address : $('#reg_address').val(),
			telephoneNo : telephoneNo,
			representativeNm : $('#reg_representativeNm').val(),
			note : $('#reg_note').val(),
			useYn : $('#reg_useYn').val()
		};
		callInsertAjax(param);
	}

	function callInsertAjax(param) {
		if (validation()) {
			if (isDisabled) {
				return false;
			} else {
				isDisabled = true;
				$.ajax({
					type : 'post',
					url : '/system/company/insert',
					data : param,
					dataType : 'text',
					error : function(xhr, status, error) {
						console.log(error);
					},
					success : function(result) {
						if (result == 'Update' || result == 'Insert') {
							location.href = '/system/company';
						}
					}
				});
			}
		}
	}

	function codeSearch() {
		var codeSearch = $('#reg_companyCode').val();
		if (codeSearch) {
			$('#re_reg_companyCode').val(codeSearch);
			if (isDisabled) {
				return false;
			} else {
				searchCodeAction(codeSearch);
			}
		} else {
			$('#re_reg_companyCode').val('');
			$('.form-notice').text("확인이 필요합니다.");
			$('.form-notice').hide();
		}
	}

	function re_codeSearch() {
		var re_codeSearch = $('#re_reg_companyCode').val();
		if (re_codeSearch) {
			if (isDisabled) {
				return false;
			} else {
				searchCodeAction(re_codeSearch);
			}
		}
	}

	function codeCheckReset() {
		$('.form-notice').text("확인이 필요합니다.");
		$('.form-notice').hide();
		$('#re_reg_companyCode').val("");
	}

	function searchCodeAction(searchCode) {
		isDisabled = true;
		$.ajax({
			type : 'post',
			url : '/system/company/popup',
			data : {
				search : searchCode
			},
			dataType : 'text',
			error : function(xhr, status, error) {
				console.log(error);
			},
			success : function(result) {
				if (result == 'none') {
					$('.form-notice').text("이미 사용중인 코드 입니다.");
					$('.form-notice').addClass("colorRed");
					$('#codeSearch').removeClass('search-Success');
				} else {
					$('.form-notice').text("사용 가능한 코드 입니다.");
					$('.form-notice').addClass("fontColorBlue");
					$('#reg_companyCode').val(result);
					$('#re_reg_companyCode').val(result);
					$('#codeSearch').addClass('search-Success');
				}
				$('.form-notice').show();
			}
		});
	}

	function checkNumber(event) {
		if (event.key >= 0 && event.key <= 9) {
			return true;
		}
		return false;
	}

	function checkEnglish(event) {
		alert(event.key == /[^a-zA-Z0-9]/gi);
		// 	if(event.key >= 0 && event.key <= 9) {
		// 		return true;
		// 	}
		// 	return false;
	}

	$(document).ready(function() {
		var searchKey = '${pages.searchKey}';
		if (searchKey) {
			$('#searchKey').val('${pages.searchKey}');
		}

		$('.deleteBtnAction').click(function() {
			var code = this.dataset.code;
			var id = this.dataset.id;
			var no = this.dataset.no;
			var nm = this.dataset.nm;
			console.log(code);
			console.log(id);
			console.log(no);
			console.log(nm);
			$('.delCompanyAction').val(id)
			$('.delCompanyText').text(nm);
		});

		$('.btnEdit').click(function() {
			if ($(this).hasClass('btnSave')) {
				companySave();
			} else {
				setEdit();
			}
		});

		$('#reg_companyCode').keyup(function() {
			var str = $('#reg_companyCode').val();
			str = str.replace(/[^a-zA-Z0-9]/gi, "").toUpperCase();
			$('#reg_companyCode').val(str);
		});

		$('#re_reg_companyCode').keyup(function() {
			var str = $('#re_reg_companyCode').val();
			str = str.replace(/[^a-zA-Z0-9]/gi, "").toUpperCase();
			$('#re_reg_companyCode').val(str);
		});

		$('.close').click(function() {
			resetView();
			regResetView();
		});

		$('.btn-cancel').click(function() {
			resetView();
			regResetView();
		});

		$('.btnCheck').click(function() {
			resetView();
		});

		$("#codeSearch").keyup(function(e) {
			if (e.keyCode == '13') {
				$(".codeSearchBtn").click();
				codeSearch();
			}
		});

		$("#codeSearch").mouseup(function(e) {
			codeSearch();
		});

		$(".codeSearchBtn").mouseup(function(e) {
			codeSearch();
		});

		$('#re_codeSearch').click(function() {
			re_codeSearch();
		});

		$('.companyInsert').click(function() {
			if (validation()) {
				companyInsert();
			}
		});

		$('.codeCheck').click(function() {
			codeCheckReset();
		});
	});

	function validation() {
		if ($('#reg_companyId').val() == '') {
			alert('회사 코드를 입력해 주세요..');
			return false;
		}
		if ($('#reg_companyNm').val() == '') {
			alert('회사 이름을 입력해 주세요..');
			return false;
		}
		if ($('#reg_representativeNm').val() == '') {
			alert('대표자을 입력해 주세요..');
			return false;
		}
		if ($('#reg_address').val() == '') {
			alert('회사 주소를 입력해 주세요..');
			return false;
		}
		if ($('#reg_companyNo1').val() == '') {
			alert('회사 사업자번호을 입력해 주세요..');
			return false;
		}
		if ($('#reg_companyNo2').val() == '') {
			alert('회사 사업자번호을 입력해 주세요..');
			return false;
		}
		if ($('#reg_companyNo3').val() == '') {
			alert('회사 사업자번호을 입력해 주세요..');
			return false;
		}
		if ($('#reg_telephoneNo1').val() == '') {
			alert('회사 연락처를 입력해 주세요..');
			return false;
		}
		if ($('#reg_telephoneNo2').val() == '') {
			alert('회사 연락처를 입력해 주세요..');
			return false;
		}
		if ($('#reg_telephoneNo3').val() == '') {
			alert('회사 연락처를 입력해 주세요..');
			return false;
		}
		return true;
	}
</script>