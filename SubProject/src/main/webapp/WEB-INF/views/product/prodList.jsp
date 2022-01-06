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
						<option value="">제품명</option>
						<option value="">포장유형</option>
						<option value="">재활용등급</option>
						<option value="">상태</option>
					</select>
				</div>
				<div class="form-inline">
					<div class="search-box w250">
						<input type="text" class="text-input"> <span
							class="search-box-append">
							<button type="button" class="button-search">
								<img src="../images/icon_search.png" title="검색">
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
		<div class="scroll-auto">
			<table class="table table-actions">
				<colgroup>
					<col style="width: 40px;">
					<col style="width: 90px;">
					<col style="width: 100px;">
					<col style="width: 90px;">
					<col style="width: 90px;">
					<col style="width: 80px;">
					<col style="width: 80px;">
					<col style="width: 50px;">
					<col style="width: 60px;">
					<col style="width: 90px;">
				</colgroup>
				<thead>
					<tr class="th-bg">
						<th scope="col">번호</th>
						<th scope="col">제품코드</th>
						<th scope="col">사진</th>
						<th scope="col">제품명</th>
						<th scope="col">포장유형</th>
						<th scope="col">재활용등급</th>
						<th scope="col">첨부문서</th>
						<th scope="col">진행상태</th>
						<th scope="col">체크</th>
						<th scope="col">관리</th>
				</thead>
				<tbody>
					<tr>
						<td>1</td>
						<td>HSI000000</td>
						<td><img src="../images/pro_img04.jpeg" width="70"
							height="auto"></td>
						<td>서울유유 800g</td>
						<td>철캔</td>
						<td class="fontColorBlue"><img
							src="../images/free-icon-emoji-3456813.png" width="26px">우수</td>
						<td><img src="../images/icon_file.png">(o)</td>
						<td>진행중</td>
						<td>신청대상</td>
						<td>
							<div class="btn-group">
								<a href="#detail" role="button" data-toggle="modal"
									class="btn-icon"><img src="../images/icon_detail.png"
									alt="상세보기" class="btn-Ticon"></a> <a href="#edit"
									role="button" data-toggle="modal" class="btn-icon"><img
									src="../images/icon_edit.png" alt="수정하기" class="btn-Ticon02"></a>
								<a href="#delete" role="button" data-toggle="modal"
									class="btn-icon"><img src="../images/icon_delete2.png"
									alt="삭제하기" class="btn-Ticon02"></a>
							</div>
						</td>
					</tr>
					<tr>
						<td>2</td>
						<td>HSI000000</td>
						<td><img src="../images/pro_img01.jpeg" width="70"
							height="auto"></td>
						<td>서울유유 800g</td>
						<td>종이팩</td>
						<td class="colorRed"><img
							src="../images/free-icon-angry-1747839.png" width="26px">나쁨</td>
						<td class="op"><img src="../images/icon_file.png">(x)</td>
						<td class="fontColorBlue">완료</td>
						<td class="fontColorBlue">정상</td>
						<td>
							<div class="btn-group">
								<a href="#detail" role="button" data-toggle="modal"
									class="btn-icon"><img src="../images/icon_detail.png"
									alt="상세보기" class="btn-Ticon"></a> <a href="#edit"
									role="button" data-toggle="modal" class="btn-icon"><img
									src="../images/icon_edit.png" alt="수정하기" class="btn-Ticon02"></a>
								<a href="#delete" role="button" data-toggle="modal"
									class="btn-icon"><img src="../images/icon_delete2.png"
									alt="삭제하기" class="btn-Ticon02"></a>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- E_그리드-->
		<div class="btn-group pt15 tr">
			<button type="button" class="button btn-success" data-toggle="modal">
				<a href="#register" data-toggle="modal">제품등록</a>
			</button>
		</div>
		<!-- S_페이징-->
		<div class="board-paging"></div>
		<!-- E_페이징-->
	</div>
</div>


<!-- 레이어 팝업 - 등록  -->
<div id="register" class="modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width: 1000px">
		<div class="modal-header">
			<h4 class="modal-title">제품등록</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="../images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="tab">
				<ul class="tabnav">
					<li><a href="#tab01">제품기본정보</a></li>
					<li><a href="#tab02">재활용분담금</a></li>
				</ul>
				<div class="tabcontent">
					<div id="tab01">
						<div class="row">
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">제품코드</label>
									<div class="col-75">
										<input type="text" class="text-input" value="HSL2100000001"
											disabled>
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">제품분류</label>
									<div class="col-75">
										<select class="select-box">
											<option value="선택없음" selected="">선택없음</option>
											<option value="제품분류선택">제품분류선택</option>
											<option value="제품분류선택">제품분류선택</option>
											<option value="제품분류선택">제품분류선택</option>
											<option value="제품분류선택">제품분류선택</option>
										</select>
									</div>
								</div>
							</div>
							<div class="col-100">
								<div class="form-group">
									<label class="col-25 form-label">제품명</label>
									<div class="col-75">
										<input type="text" class="text-input"
											placeholder="예시)건강참기름 가정용">
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">누적판매량(년)</label>
									<div class="col-75">
										<input type="text" class="text-input" placeholder="누적판매량(년)">
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">포장재총중량</label>
									<div class="col-75">
										<input type="text" class="text-input" placeholder="포장재총중량">
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">제품제조사</label>
									<div class="col-75">
										<input type="text" class="text-input" placeholder="예시)아산 제1공장">
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">재활용분담금</label>
									<div class="col-75">
										<input type="text" class="text-input"
											placeholder="누적판매량 등록시 자동계산">
									</div>
								</div>
							</div>
							<div class="col-100">
								<div class="form-group">
									<label class="col-25 form-label-textarea">설명</label>
									<div class="col-75">
										<div class="form-input">
											<textarea class="textarea"></textarea>
										</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-25 form-label-img">사진</label>
									<div class="col-75">
										<div class="form-input-img">
											<input name="files[]" type="file" multiple="multiple"
												id="our-file01" class="multi with-preview">
										</div>
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">포장차수</label>
									<div class="col-75 text-input d-flex">
										<div id='result' class="w40">0</div>
										<input type='button' onclick='count("plus")' value='+'
											/ class="w30 mr05"> <input type='button'
											onclick='count("minus")' value='-' / class="w30">
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">별도포장</label>
									<div class="col-75">
										<input type="number" class="text-input" placeholder="1"
											min="0" max="5">
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="tab02">
						<span class="mt10 pb04">√ 라디오버튼 선택시 제품기본정보의 누적판매량이 표시됩니다.</span>

						<h4 class="tl pt15">
							<span class="title-point">[포장기준]</span>
						</h4>
						<div class="row">
							<div class="col-20">
								<div class="form-group">
									<label class="col-60 form-label">1차포장기준수량</label>
									<div class="col-40">
										<input type="text" class="text-input" placeholder="1">
									</div>
								</div>
							</div>
							<div class="col-35">
								<div class="form-group">
									<label class="col-50 form-label"><input type="radio"
										id="radio" name="radio" checked
										style="width: 14px; height: 12px;">1차 누적판매량/수량</label>
									<div class="col-50">
										<input type="text" class="text-input" placeholder="고객시스템값">
									</div>
								</div>
							</div>
							<div class="col-20">
								<div class="form-group">
									<label class="col-35 form-label">기준중량</label>
									<div class="col-75">
										<input type="text" class="text-input" placeholder="1차포장 (입력x)">
									</div>
								</div>
							</div>
							<div class="col-25">
								<div class="form-group">
									<label class="col-40 form-label">재활용분담금 </label>
									<div class="col-60">
										<input type="text" class="text-input" placeholder="자동계산">
									</div>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-20">
								<div class="form-group">
									<label class="col-60 form-label">2차포장기준수량</label>
									<div class="col-40">
										<input type="text" class="text-input" placeholder="2">
									</div>
								</div>
							</div>
							<div class="col-35">
								<div class="form-group">
									<label class="col-50 form-label"><input type="radio"
										id="radio" name="radio" style="width: 14px; height: 12px;">2차
										누적판매량/수량</label>
									<div class="col-50">
										<input type="text" class="text-input" placeholder="고객시스템값">
									</div>
								</div>
							</div>
							<div class="col-20">
								<div class="form-group">
									<label class="col-35 form-label">기준중량</label>
									<div class="col-75">
										<input type="text" class="text-input" placeholder="2차포장 (입력x)">
									</div>
								</div>
							</div>
							<div class="col-25">
								<div class="form-group">
									<label class="col-40 form-label">재활용분담금 </label>
									<div class="col-60">
										<input type="text" class="text-input" placeholder="자동계산">
									</div>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-20">
								<div class="form-group">
									<label class="col-60 form-label">3차포장기준수량</label>
									<div class="col-40">
										<input type="text" class="text-input" placeholder="3">
									</div>
								</div>
							</div>
							<div class="col-35">
								<div class="form-group">
									<label class="col-50 form-label"><input type="radio"
										id="radio" name="radio" style="width: 14px; height: 12px;">3차
										누적판매량/수량</label>
									<div class="col-50">
										<input type="text" class="text-input" placeholder="고객시스템값">
									</div>
								</div>
							</div>
							<div class="col-20">
								<div class="form-group">
									<label class="col-35 form-label">기준중량</label>
									<div class="col-75">
										<input type="text" class="text-input" placeholder="3차포장 (입력x)">
									</div>
								</div>
							</div>
							<div class="col-25">
								<div class="form-group">
									<label class="col-40 form-label">재활용분담금 </label>
									<div class="col-60">
										<input type="text" class="text-input" placeholder="자동계산">
									</div>
								</div>
							</div>
						</div>

						<h4 class="tl pt15">
							<span class="title-point">[별도포장]</span>
						</h4>
						<div class="row">
							<div class="col-20">
								<div class="form-group">
									<label class="col-60 form-label">1차별도포장</label>
									<div class="col-40">
										<input type="text" class="text-input" placeholder="4">
									</div>
								</div>
							</div>
							<div class="col-35">
								<div class="form-group">
									<label class="col-50 form-label"><input type="radio"
										id="radio" name="radio" style="width: 14px; height: 12px;">4차
										누적판매량/수량</label>
									<div class="col-50">
										<input type="text" class="text-input" placeholder="고객시스템값">
									</div>
								</div>
							</div>
							<div class="col-20">
								<div class="form-group">
									<label class="col-35 form-label">기준중량</label>
									<div class="col-75">
										<input type="text" class="text-input" placeholder="4차포장 (입력x)">
									</div>
								</div>
							</div>
							<div class="col-25">
								<div class="form-group">
									<label class="col-40 form-label">재활용분담금 </label>
									<div class="col-60">
										<input type="text" class="text-input" placeholder="자동계산">
									</div>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-20">
								<div class="form-group">
									<label class="col-60 form-label">2차별도포장</label>
									<div class="col-40">
										<input type="text" class="text-input" placeholder="5">
									</div>
								</div>
							</div>
							<div class="col-35">
								<div class="form-group">
									<label class="col-50 form-label"><input type="radio"
										id="radio" name="radio" style="width: 14px; height: 12px;">5차
										누적판매량/수량</label>
									<div class="col-50">
										<input type="text" class="text-input" placeholder="고객시스템값">
									</div>
								</div>
							</div>
							<div class="col-20">
								<div class="form-group">
									<label class="col-35 form-label">기준중량</label>
									<div class="col-75">
										<input type="text" class="text-input" placeholder="5차포장 (입력x)">
									</div>
								</div>
							</div>
							<div class="col-25">
								<div class="form-group">
									<label class="col-40 form-label">재활용분담금 </label>
									<div class="col-60">
										<input type="text" class="text-input" placeholder="자동계산">
									</div>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-50">
								<div class="form-group">
									<label class="col-30 form-label">누적판매량/수량합계</label>
									<div class="col-70">
										<input type="text" class="text-input"
											placeholder="재활용분담금 합한 금액">
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-30 form-label">재활용분담금</label>
									<div class="col-70">
										<input type="text" class="text-input"
											placeholder="재활용분담금 합한 금액">
									</div>
								</div>
							</div>
						</div>
						<span class="fr pt10 text-point">※재활용분담금 : 누적판매수량/년 x 중량/원
							x 단가</span>
					</div>
				</div>
			</div>
			<!-- 버튼 -->
			<div class="modal-footer btn-group">
				<button type="button" class="button btn-success"
					data-dismiss="modal">저장</button>
				<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<!-- 레이어 팝업 - 수정  -->
<div id="edit" class="modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width: 1000px">
		<div class="modal-header">
			<h4 class="modal-title">제품수정</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="../images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="tab02">
				<ul class="tabnav02">
					<li><a href="#tab03">제품기본정보</a></li>
					<li><a href="#tab04">문서정보</a></li>
				</ul>
				<div class="tabcontent02">
					<div id="tab03">
						<div class="row">
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">제품코드</label>
									<div class="col-75">
										<input type="text" class="text-input" value="HSL2100000001"
											disabled>
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">제품분류</label>
									<div class="col-75">
										<select class="select-box">
											<option value="선택없음" selected="">선택없음</option>
											<option value="제품분류선택">제품분류선택</option>
											<option value="제품분류선택">제품분류선택</option>
											<option value="제품분류선택">제품분류선택</option>
											<option value="제품분류선택">제품분류선택</option>
										</select>
									</div>
								</div>
							</div>
							<div class="col-100">
								<div class="form-group">
									<label class="col-25 form-label">제품명</label>
									<div class="col-75">
										<input type="text" class="text-input"
											placeholder="예시)건강참기름 가정용">
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">누적판매량(년)</label>
									<div class="col-75">
										<input type="text" class="text-input" placeholder="누적판매량(년)">
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">포장재총중량</label>
									<div class="col-75">
										<input type="text" class="text-input" placeholder="포장재총중량">
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">제품제조사</label>
									<div class="col-75">
										<input type="text" class="text-input" placeholder="예시)아산 제1공장">
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">재활용분담금</label>
									<div class="col-75">
										<input type="text" class="text-input"
											placeholder="누적판매량 등록시 자동계산">
									</div>
								</div>
							</div>
							<div class="col-100">
								<div class="form-group">
									<label class="col-25 form-label-textarea">설명</label>
									<div class="col-75">
										<div class="form-input">
											<textarea class="textarea"></textarea>
										</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-25 form-label-img">사진</label>
									<div class="col-75">
										<div class="form-input-img">
											<input name="files[]" type="file" multiple="multiple"
												id="our-file02" class="multi with-preview">
										</div>
									</div>
								</div>

								<h4 class="tl pt15">
									<span class="title-point">[환경부 진행상황]</span>
								</h4>
								<div class="col-100">
									<div class="form-group">
										<label class="col-25 form-label">진행상태</label>
										<div class="col-75">
											<div class="form-input-box">
												<div class="button-Rsmall d-inblock">
													<input type="radio" id="radio1" name="radio"
														checked="checked"> <label for="radio1"
														class="mr05">진행중</label>
												</div>
												<div class="button-Rsmall d-inblock">
													<input type="radio" id="radio2" name="radio"> <label
														for="radio2" class="mr05">보완</label>
												</div>
												<div class="button-Rsmall d-inblock">
													<input type="radio" id="radio2" name="radio"> <label
														for="radio2" class="mr05">반려</label>
												</div>
												<div class="button-Rsmall d-inblock">
													<input type="radio" id="radio2" name="radio"> <label
														for="radio2" class="mr05">완료</label>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">접수번호</label>
									<div class="col-75">
										<input type="text" class="text-input">
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">승인번호</label>
									<div class="col-75">
										<input type="text" class="text-input">
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="tab04">
						<div class="row">
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">최초 생성일</label>
									<div class="col-75">
										<input type="text" class="text-input" value="2022-01-01"
											disabled>
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">최종 변경일</label>
									<div class="col-75">
										<input type="text" class="text-input" value="2022-01-04"
											disabled>
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">생성자</label>
									<div class="col-75">
										<input type="text" class="text-input" value="김희영" disabled>
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">최종변경자</label>
									<div class="col-75">
										<input type="text" class="text-input" value="김희영" disabled>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 버튼 -->
			<div class="modal-footer btn-group">
				<button type="button" class="button btn-success"
					data-dismiss="modal">저장</button>
				<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<!-- 레이어 팝업 - 상세  -->
<div id="detail" class="modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width: 1000px">
		<div class="modal-header">
			<h4 class="modal-title">제 vta상세</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="../images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="tab-content-box">
					<p>
						<button id="btn-add-tab" type="button" class="button-Rsmall fr">Add
							Tab</button>
					</p>
					<!-- Nav tabs -->
					<ul id="tab-list" class="nav tab-nav" role="tablist">
						<li class="active"><a href="#tab1" role="tab"
							data-toggle="tab"><span>1차 포장 </span></a></li>
					</ul>
					<!-- Tab panes -->
					<div style="clear: both;">
						<div id="tab-content" class="tab-content">

							<div class="tab-in-nav d-flex">
								<span class="pt10 pr10">ㆍ재질유형</span> <select
									class="select-box w200">
									<option value="0">종이팩</option>
									<option value="1">플라스틱</option>
								</select>
								<button type="button" class="button btn-radius mr10 ml10">
									<a href="#tab01">몸체</a>
								</button>
								<button type="button" class="button btn-radius mr10">
									<a href="#tab02">라벨</a>
								</button>
								<button type="button" class="button btn-radius mr10">
									<a href="#tab03">마개및잡자재</a>
								</button>
								<button type="button" class="button btn-radius mr10">
									<a href="#tab04">라벨 마개 및 잡자재</a>
								</button>
							</div>
							<div class="tab-pane active" id="tab1">
								<div class="tab-in-content">
									<!-- 몸체 상세-->
									<div id="tab01">
										<h4 class="tl pt15">
											<span class="title-point">[몸체 상세]</span>
										</h4>
										<div class="row">
											<div class="col-50">
												<div class="form-group">
													<label class="col-25 form-label">재질정보</label>
													<div class="col-75">
														<div class="form-input">
															<input type="text" class="text-input" value="">
														</div>
													</div>
												</div>
											</div>
											<div class="col-50">
												<div class="form-group">
													<label class="col-25 form-label">무게</label>
													<div class="col-75">
														<div class="form-input">
															<input type="text" class="text-input">
														</div>
													</div>
												</div>
											</div>
											<div class="col-50">
												<div class="form-group">
													<label class="col-25 form-label">규격</label>
													<div class="col-75">
														<div class="form-input">
															<input type="text" class="text-input">
														</div>
													</div>
												</div>
											</div>
											<div class="col-50">
												<div class="form-group">
													<label class="col-25 form-label">색상</label>
													<div class="col-75">
														<div class="form-input">
															<input type="text" class="text-input">
														</div>
													</div>
												</div>
											</div>
											<div class="col-50">
												<div class="form-group">
													<label class="col-25 form-label">기준수량</label>
													<div class="col-75">
														<div class="form-input">
															<input type="text" class="text-input">
														</div>
													</div>
												</div>
											</div>
											<div class="col-100">
												<div class="form-group">
													<label class="col-25 form-label-textarea">비고</label>
													<div class="col-75">
														<div class="form-input">
															<textarea class="textarea"></textarea>
														</div>
													</div>
												</div>
												<div class="form-group">
													<label class="col-25 form-label-img">사진등록</label>
													<div class="col-75">
														<div class="form-input-img">
															<input name="files[]" type="file" multiple="multiple"
																id="our-file03" class="multi with-preview">
														</div>
													</div>
												</div>
												<div class="form-group">
													<label class="col-25 form-label">참고도면 및 문서</label>
													<div class="col-75">
														<input type="file" multiple="multiple" class="text-input">
													</div>
												</div>
												<div class="form-group">
													<label class="col-25 form-label">보고서 생성</label>
													<div class="col-75 tl">
														<div class="text-input">
															<button type="button" class="button-Rsmall mr05">포장재질구조증명</button>
															<button type="button" class="button-Rsmall">육안판정서</button>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>

								</div>
							</div>

							<h4 class="tl pt15">
								<span class="title-point">[업체정보]</span>
							</h4>
							<div class="row">
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label">공급업체</label>
										<div class="col-75">
											<div class="form-input">
												<input type="text" class="text-input" value="">
											</div>
										</div>
									</div>
								</div>
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label">담당자</label>
										<div class="col-75">
											<div class="form-input">
												<input type="text" class="text-input">
											</div>
										</div>
									</div>
								</div>

								<div class="col-100">
									<div class="form-group">
										<label class="col-25 form-label">이메일</label>
										<div class="col-75">
											<div class="search-box">
												<input type="text" class="text-input"> <span
													class="search-box-append">
													<button type="button" class="button-search">
														<a href="#overlap" role="button" data-toggle="modal">중복확인</a>
													</button>
												</span>
											</div>
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
				<button type="button" class="button btn-success"
					data-dismiss="modal">저장</button>
				<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<!-- 레이어 팝업 - delete -->
<div id="delete" class="modal" data-backdrop-limit="1" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
	data-modal-parent="#myModal">
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
							(<em class="text-bold">PEuser01</em>)삭제합니다.
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


<script src='/js/plugins/jquery.form.js' type="text/javascript" language="javascript"></script>
<script src='/js/plugins/jquery.MetaData.js' type="text/javascript" language="javascript"></script>
<script src='/js/plugins/jquery.MultiFile.min.js' type="text/javascript" language="javascript"></script>
<script type="text/javascript">

	var button='<button class="tab-close" type="button" title="Remove this page">×</button>';
	var tabID = 1;
	function resetTab(){
	var tabs=$("#tab-list li:not(:first)");
	var len=1
	$(tabs).each(function(k,v){
		len++;
		$(this).find('a').html(len + '차 포장'+ button);
	})
	tabID--;
	}
	
	$(document).ready(function() {
	$('#btn-add-tab').click(function() {
	    tabID++;
	    $('#tab-list').append($('<li><a href="#tab' + tabID + '" role="tab" data-toggle="tab"><input type=text value=' + tabID + '차 포장><button class="tab-close" type="button" title="Remove this page">×</button></a></li>'));
	    $('#tab-content').append($('<div class="tab-pane fade" id="tab' + tabID + '">Tab ' + tabID + ' content</div>'));
	    $(".edit").click(editHandler);
	});
	
	$('#tab-list').on('click', '.tab-close', function() {
	    var tabID = $(this).parents('a').attr('href');
	    $(this).parents('li').remove();
	    $(tabID).remove();
	
	    //display first tab
	    var tabFirst = $('#tab-list a:first');
	    resetTab();
	    tabFirst.tab('show');
	});
	
	var list = document.getElementById("tab-list");
	});
	
	var editHandler = function() {
	var t = $(this);
	t.css("visibility", "hidden");
	$(this).prev().attr("contenteditable", "true").focusout(function() {
	$(this).removeAttr("contenteditable").off("focusout");
	t.css("visibility", "visible");
	});
	};
	
	$(".edit").click(editHandler);

	/**
	 * 페이징 처리 공통 함수
	 */
// 	 var totalPage = ${pages.totalPage};
// 	 var page = ${pages.page}; 
// 	 var pageSize = ${pages.pageSize}; 

	var totalPage = 10;
	var page = 2; 
	var pageSize = 10; 

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