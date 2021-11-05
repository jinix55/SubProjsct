<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="content">
						<!-- S_검색-->
            <form>
							<div class="justify-content-between">
								<div class="form-group">
									<div class="form-inline">
											<select class="select-box w150">
												<option value="0">게시판명</option>
												<option value="1">등록자</option>
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
										<col style="width: 180px;">
										<col style="width: 90px;">
										<col style="width: 195px;">
										<col style="width: 85px;">
										<col style="width: 60px;">
										<col style="width: 90px;">
									</colgroup>
									<thead>
											<tr class="th-bg">
												<th><input type="checkbox" name="all" id="checkAll"></th>
												<th scope="col">번호</th>
												<th scope="col">게시판명</th>
												<th scope="col">작성자</th>
												<th scope="col">옵션</th>
												<th scope="col">등록일</th>
												<th scope="col">사용여부</th>
												<th scope="col">관리</th>
										</tr>
									</thead>

									<tbody>
										<tr>
											<th><input type="checkbox" name="chk"></th>
											<td>1</td>
											<td class="tl text-point">Q&A</td>
											<td>웹마스터</td>
											<td>쓰기/읽기 권한</td>
											<td>2020-05-13</td>
											<td class="form-checkbox">
												<input type="checkbox" id="checkbox" checked>
												<label for="checkbox"><span></span></label>
											</td>
											<td>
												<div class="btn-group">
                          <a href="#detail" role="button" data-toggle="modal" class="btn-tbl_icon"><img src="/images/icon_detail.png" alt="상세보기" class="tbl-icon"></a>
													<a href="#edit" role="button" data-toggle="modal" class="btn-tbl_icon"><img src="/images/icon_edit.png" alt="수정하기" class="tbl-icon2"></a>
						              <a href="#delete" role="button" data-toggle="modal" class="btn-tbl_icon"><img src="/images/icon_delete2.png" alt="삭제하기" class="tbl-icon2"></a>
					              </div>
											</td>
										</tr>
										<tr>
											<th><input type="checkbox" name="chk"></th>
											<td>2</td>
											<td class="tl text-point">FAQ</td>
											<td>웹마스터</td>
											<td>댓글 쓰시/읽기 권한</td>
											<td>2020-05-13</td>
											<td class="form-checkbox">
												<div style="padding:10px 0;">
													<input type="checkbox" id="checkbox02">
													<label for="checkbox02"><span></span></label>
												</div>
											</td>
											<td>
												<div class="btn-group">
                          <a href="#detail" role="button" data-toggle="modal" class="btn-tbl_icon"><img src="/images/icon_detail.png" alt="상세보기" class="tbl-icon"></a>
													<a href="#edit" role="button" data-toggle="modal" class="btn-tbl_icon"><img src="/images/icon_edit.png" alt="수정하기" class="tbl-icon2"></a>
						              <a href="#delete" role="button" data-toggle="modal" class="btn-tbl_icon"><img src="/images/icon_delete2.png" alt="삭제하기" class="tbl-icon2"></a>
					              </div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<!-- E_그리드-->
						<div class="btn-group pt15 tr">
							<button type="button" class="button btn-success" data-toggle="modal"><a href="#register" data-toggle="modal">등록</a></button>
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
		<div id="register" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-content" style="width:800px">
		    <div class="modal-header">
	      <h4 class="modal-title">등록</h4>
					<button type="button" class="close" data-dismiss="modal"><img src="/images/icon_close.png"></button>
	      </div>
				<div class="modal-body">
					<div class="row">
						<div class="col-50">
							<div class="form-group">
								<label class="col-25 form-label">게시판 명</label>
								<div class="col-75">
									<div class="search-box">
										<input type="text" class="text-input">
										<span class="search-box-append">
											<button type="button" class="btn-search"><a href="#overlap" role="button" data-toggle="modal">중복확인</a></button>
										</span>
									</div>
								</div>
							</div>
						</div>
						<div class="col-50">
							<div class="form-group">
								<label class="col-25 form-label">게시판 유형</label>
								<div class="col-75">
										<select class="select-box">
											<option value="010">통합게시판</option>
											<option value="011">방명록</option>
										</select>
								</div>
							</div>
						</div>
						<div class="col-50">
							<div class="form-group">
								<label class="col-25 form-label">답장 가능여부</label>
								<div class="col-75">
										<select class="select-box">
											<option value="010">예</option>
											<option value="011">아니요</option>
										</select>
								</div>
							</div>
						</div>
						<div class="col-50">
							<div class="form-group">
								<label class="col-25 form-label">첨부파일여부</label>
								<div class="col-75">
									<div class="file-select">
											<select class="select-box">
												<option value="010">예</option>
												<option value="011">아니요</option>
											</select>
									</div>
									<div class="file-select">
											<select class="select-box">
												<option value="010">1</option>
												<option value="011">2</option>
												<option value="011">3</option>
											</select>
									</div>
								</div>
							</div>
						</div>
						<div class="col-50">
							<div class="form-group">
								<label class="col-25 form-label">추가선택사항</label>
								<div class="col-75">
									<select class="select-box">
										<option value="010">미선택</option>
										<option value="011">댓글</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-50">
							<div class="form-group">
								<label class="col-25 form-label">사용여부</label>
								<div class="col-75">
									<select class="select-box">
										<option value="010">미선택</option>
										<option value="011">댓글</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-100">
							<div class="form-group">
								<label class="col-25 form-label">옵션</label>
								<div class="col-75">
									<select class="select-box">
										<option value="">읽기/쓰기/보기/수정</option>
										<option value="">읽기/쓰기</option>
										<option value="">쓰기/보기/수정</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-100">
							<div class="form-group">
								<label class="col-25 form-label-textarea">게시판 설명</label>
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
		<!-- 레이어 팝업 아이디 중복 확인 -->
		<div id="overlap" class="modal" data-backdrop-limit="1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-modal-parent="#myModal">
			<div class="modal-content" style="width:400px">
		    <div class="modal-header">
		      <h4 class="modal-title">중복확인</h4>
						<button type="button" class="close" data-dismiss="modal"><img src="/images/icon_close.png"></button>
		    </div>
				<div class="modal-body">
					<div class="row">
	          <div class="col-100">
							<div class="form-group">
								<label class="col-25 form-label">사용자 ID<em>*</em></label>
								<div class="col-75">
									<div class="search-box">
										<input type="text" class="text-input">
										<span class="search-box-append">
											<button type="button" class="btn-search" onclick=;><img src="/images/icon_search.png" title="검색"></button>
										</span>
									</div>
								</div>
							</div>
							<div class="form-notice">* [ww]는 사용가능합니다</div>
						</div>
					</div>
				</div>
				<!-- 버튼 -->
			 	<div class="modal-footer btn-group">
					<button type="button" class="button btn-success" data-dismiss="modal">확인</button>
					<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
				</div>
		  </div>
		</div>
		<!-- 레이어 팝업 - 상세 -->
		<div id="detail" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-content" style="width:800px">
				<div class="modal-header">
					<h4 class="modal-title">상세</h4>
					<button type="button" class="close" data-dismiss="modal"><img src="/images/icon_close.png"></button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-50">
							<div class="form-group">
								<label class="col-25 form-label">등록일자</label>
								<div class="col-75">
									<div class="form-input">
										<input type="text" class="text-input" value="2010-10-23" disabled>
									</div>
								</div>
							</div>
						</div>
						<div class="col-50">
							<div class="form-group">
								<label class="col-25 form-label">등록자</label>
								<div class="col-75">
									<div class="form-input">
										<input type="text" class="text-input" value="관리자" disabled>
									</div>
								</div>
							</div>
						</div>
						<div class="col-50">
							<div class="form-group">
								<label class="col-25 form-label">게시판 명</label>
								<div class="col-75">
									<div class="form-input">
										<input type="text" class="text-input" value="Q&A" disabled>
									</div>
								</div>
							</div>
						</div>
						<div class="col-50">
							<div class="form-group">
								<label class="col-25 form-label">게시판 유형</label>
								<div class="col-75">
									<div class="form-input">
										<input type="text" class="text-input" value="Q&A통합게시판" disabled>
									</div>
								</div>
							</div>
						</div>
						<div class="col-50">
							<div class="form-group">
								<label class="col-25 form-label">답장 가능여부</label>
								<div class="col-75">
									<div class="form-input">
										<input type="text" class="text-input" value="예" disabled>
									</div>
								</div>
							</div>
						</div>
						<div class="col-50">
							<div class="form-group">
								<label class="col-25 form-label">첨부파일여부</label>
								<div class="col-75">
									<div class="form-input">
										<input type="text" class="text-input" value="예" disabled>
									</div>
								</div>
							</div>
						</div>
						<div class="col-50">
							<div class="form-group">
								<label class="col-25 form-label">추가선택사항</label>
								<div class="col-75">
									<div class="form-input">
										<input type="text" class="text-input" value="댓글" disabled>
									</div>
								</div>
							</div>
						</div>
						<div class="col-50">
							<div class="form-group">
								<label class="col-25 form-label">사용여부</label>
								<div class="col-75">
									<div class="form-input">
										<input type="text" class="text-input" value="예" disabled>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-100">
							<div class="form-group">
								<label class="col-25 form-label">옵션</label>
								<div class="col-75">
									<div class="form-input">
										<input type="text" class="text-input" value="쓰기/읽기" disabled>
									</div>
								</div>
							</div>
						</div>
						<div class="col-100">
							<div class="form-group">
								<label class="col-25 form-label-textarea">게시판 설명</label>
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
		<div id="edit" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-content" style="width:800px">
					<div class="modal-header">
						<h4 class="modal-title">수정</h4>
						<button type="button" class="close" data-dismiss="modal"><img src="/images/icon_close.png"></button>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">게시판 명</label>
									<div class="col-75">
										<div class="form-input">
											<input type="text" class="text-input" value="Q&A">
										</div>
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">게시판 유형</label>
									<div class="col-75">
											<select class="select-box">
												<option value="010">통합게시판</option>
												<option value="011">방명록</option>
											</select>
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">답장 가능여부</label>
									<div class="col-75">
											<select class="select-box">
												<option value="010">예</option>
												<option value="011">아니요</option>
											</select>
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">첨부파일여부</label>
									<div class="col-75">
										<div class="file-select">
												<select class="select-box">
													<option value="010">예</option>
													<option value="011">아니요</option>
												</select>
										</div>
										<div class="file-select">
												<select class="select-box">
													<option value="010">1</option>
													<option value="011">2</option>
													<option value="011">3</option>
												</select>
										</div>
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">추가선택사항</label>
									<div class="col-75">
										<select class="select-box">
											<option value="010">미선택</option>
											<option value="011">댓글</option>
										</select>
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">사용여부</label>
									<div class="col-75">
										<select class="select-box">
											<option value="010">미선택</option>
											<option value="011">댓글</option>
										</select>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-100">
								<div class="form-group">
									<label class="col-25 form-label">옵션</label>
									<div class="col-75">
										<select class="select-box">
											<option value="">읽기/쓰기/보기/수정</option>
											<option value="">읽기/쓰기</option>
											<option value="">쓰기/보기/수정</option>
										</select>
									</div>
								</div>
							</div>
							<div class="col-100">
								<div class="form-group">
									<label class="col-25 form-label-textarea">게시판 설명</label>
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
		<div id="delete" class="modal" data-backdrop-limit="1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-modal-parent="#myModal">
			<!-- Modal content-->
			<div class="modal-content" style="width:400px">
				<div class="modal-header">
					<h4 class="modal-title">삭제</h4>
						<button type="button" class="close" data-dismiss="modal"><img src="/images/icon_close.png"></button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-100">
							<div class="form-group">
								<div class="tc">(<em class="text-bold">Q&A</em>)삭제합니다.</div>
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
		<div id="Alldelete" class="modal" data-backdrop-limit="1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-modal-parent="#myModal">
			<!-- Modal content-->
			<div class="modal-content" style="width:400px">
				<div class="modal-header">
					<h4 class="modal-title">전체삭제</h4>
						<button type="button" class="close" data-dismiss="modal"><img src="/images/icon_close.png"></button>
				</div>
				<div class="modal-body">
					<div class="row">
	          <div class="col-100">
							<div class="form-group">
								<div class="tc"><em class="text-bold">14 items selected</em><br />삭제하시겠습니까?</div>
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

<script>
	$(function() {
		// 002. 팝업 초점 이동 추가
		$('.faq_dt button').on('click', function() {
			$(this).parent().toggleClass('on').parent().children('.faq_dd').slideToggle(300);
		});
		
		$('#search').click(function() {
			$('#page').val(1);
			$('#searchForm').submit();
		});
		
		$('#pageSize').change(function(){
			$("#page").val("1");
			$('#searchForm').submit();
		});		 

		$('.modifyInfo').click(function(e) {
			e.stopPropagation();
			const faqId = $(this).attr('value');
			$(location).attr('href', '/board/faq/modify/' + faqId);
		});

		//첨부파일 다운로드
		$(".attach_list a").on("click", function(){
			var frmFile = $("#frmFile");
			frmFile.attr("action", $(this).attr("url"));
			frmFile.submit();
		});		
	});

	$(document).ready(function() {
		$('#pageSize').val('${pages.pageSize}');
		$('#searchUseYn').val('${pages.searchUseYn}');
		$('#searchKey').val('${pages.searchKey}');
		$('#searchValue').val('${pages.searchValue}');
	});

	/**
	 * 페이징 처리 공통 함수
	 */
	$('.page').bootpag({		// 페이징을 표시할 div의 클래스
		total: ${pages.totalPage},  // 페이징모델의 전체페이지수
		page: ${pages.page},		// 페이징모델의 현재페이지번호
		maxVisible: 10,  // 보여질 최대 페이지수
		firstLastUse: true,			 // first와 last사용유무
		wrapClass: 'page',			  // 페이징을 감싼 클래스명
		activeClass: 'on',			  // 현재페이지의 클래스명
		disabledClass: 'disabled',	  // 각 항목별 클래스 지정
		nextClass: 'next',
		prevClass: 'prev',
		lastClass: 'last',
		firstClass: 'first'
	}).on("page", function(event, num){
		$("#page").val(num);
		$("#searchForm").submit();
	});	
</script>
