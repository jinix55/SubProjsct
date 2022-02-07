<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<form id="frm">
		<div class="content">
			<!-- S_검색-->
			<form >
				<div class="justify-content-between">
					<div class="form-group">
						<div class="form-inline">
							<select class="select-box w150">
								<option value="">전체</option>
								<option value="">상품명</option>
								<option value="">포장유형</option>
								<option value="">재활용등급</option>
								<option value="">상태</option>
							</select>
						</div>
						<div class="form-inline">
							<div class="search-box w250">
								<input type="text" class="text-input">
								<span class="search-box-append">
									<button type="button" class="button-search"><img src="../images/icon_search.png" title="검색"></button>
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
					<table class="table">
						<colgroup>
							<col style="width: 40px;">
							<col style="width: 80px;">
							<col style="width: 80px;">
							<col style="width: 80px;">
							<col style="width: 120px;">
							<col style="width: 70px;">
							<col style="width: 50px;">
							<col style="width: 50px;">
							<col style="width: 70px;">
							<col style="width: 60px;">
							<col style="width: 60px;">
						</colgroup>
						<thead>
							<tr class="th-bg">
							<th scope="col">번호</th>
							<th scope="col">상품코드</th>
							<th scope="col">사진</th>
							<th scope="col">상품명</th>
							<th scope="col">포장유형</th>
							<th scope="col">재활용등급</th>
							<th scope="col">진행상태</th>
							<th scope="col">체크</th>
							<th scope="col">포장정보</th>
							<th scope="col">재활용<br>분담금결과</th>
							<th scope="col">관리</th>
						</thead>
						<tbody>

							<c:choose>
								<c:when test="${not empty productList }">
									<c:forEach items="${productList }" var="list" varStatus="status">


							<tr>
								<td>1</td>
								<td><input type="text" style="border:none" id="productCode_${list.rownum}" value="${list.productCode}" readonly="true"  ></td>
								<td><img src="../images/pro_img04.jpeg" width="70" height="auto"></td>
								<td>${list.productNm} </td>
								<td>철캔</td>
								<td class="fontColorBlue"><img src="../images/free-icon-emoji-3456813.png" width="26px">우수</td>
								<td>진행중</td>
								<td>신청대상</td>
								<td><a href="#detail" role="button" data-toggle="modal" class="button-Csmall">포장정보등록</a></td>
								<td><a href="#envi_result" role="button" data-toggle="modal" class="button-Csmall">결과확인</a></td>
								<td>
									<div class="btn-group">
										<a href="#edit" role="button" data-toggle="modal" class="btn-icon">
											<img src="../images/icon_edit.png" alt="수정하기" class="btn-Ticon02" id="editBtn_${list.rownum}" >
										</a>
										  
										<a href="#delete"  onclick="deleteProductItemSet('${list.productCode}');" role="button" data-toggle="modal" class="btn-icon">
											<img src="../images/icon_delete2.png" alt="삭제하기" class="btn-Ticon02" >
										</a>
									</div>
								</td>
							</tr>


						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="4">
								재질을 선택하지 않았거나 등록되 데이터가 없습니다.
							</td>
						</tr>
					</c:otherwise>
				</c:choose>




						</tbody>
					</table>
				</div>
				<!-- E_그리드-->
				<div class="btn-group pt15 tr">
					<button type="button" class="button btn-success" data-toggle="modal"><a href="#register" data-toggle="modal">상품등록</a></button>
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
		</div>
</form>

<form id="frmInsert">
<!-- 레이어 팝업 - 등록  -->
<div id="register" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width:1000px">
		<div class="modal-header">
			<h4 class="modal-title">상품기본정보등록</h4>
			<button type="button" class="close" data-dismiss="modal"><img src="../images/icon_close.png"></button>
		</div>
		<div class="modal-body">
		 <div class="row">
			<div class="col-50">
				<div class="form-group">
					<label class="col-25 form-label">상품코드</label>
					<div class="col-75">
						<input type="text" class="text-input"  placeholder="상품코드를 입력하세요">
					</div>
				</div>
			</div>
			<div class="col-50">
				<div class="form-group">
					<label class="col-25 form-label">상품분류</label>
					<div class="col-75">
						<select class="select-box">
							<option value="선택없음" selected="">선택없음</option>

							<c:choose>
								<c:when test="${not empty productTypeList }">
									<c:forEach items="${productTypeList}" var="list" varStatus="status">
										<option value="${list}">${list}</option>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="4">
								재질을 선택하지 않았거나 등록되 데이터가 없습니다.
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
						</select>
					</div>
				</div>
			</div>
			<div class="col-100">
				<div class="form-group">
					<label class="col-25 form-label">상품명</label>
					<div class="col-75">
						<input type="text" class="text-input" placeholder="예시)건강참기름 가정용">
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
					<label class="col-25 form-label">상품제조사</label>
					<div class="col-75">
						<input type="text" class="text-input" placeholder="예시)아산 제1공장">
					</div>
				</div>
			</div>
			<div class="col-50">
				<div class="form-group">
					<label class="col-25 form-label">재활용분담금</label>
					<div class="col-75">
						<input type="text" class="text-input" placeholder="누적판매량 등록시 자동계산">
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
						 <input name="files[]" type="file" multiple="multiple" id="our-file01" class="with-preview afile-img">
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
</div>
</form>

<form id="frmResult">

<!-- 레이어 팝업 - 결과  -->
<div id="envi_result" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width:1000px">
		<div class="modal-header">
			<h4 class="modal-title">재활용분담금결과등록</h4>
			<button type="button" class="close" data-dismiss="modal"><img src="../images/icon_close.png"></button>
		</div>
		<div class="modal-body">
			<span class="mt10 pb04">√ 라디오버튼 선택시 상품기본정보의 누적판매량이 표시됩니다.</span>
			<div class="title-model-s">
				<h4 class="d-inblock pt10"><span class="title-point">[포장기준]</span></h4>
				<div class="d-inblock fr">
					<button id='btn-add-row' class="button-Rsmall">(+)추가하기</button>
					<button id='btn-delete-row' class="button-Rsmall">(-)삭제하기</button>
				</div>
			</div>
			<!-- S_추가삭제적용1-->
			<div id="mytable">
				<div class="row">
					<div class="col-20">
						<div class="form-group">
							<label class="col-60 form-label">1차포장기준수량</label>
							<div class="col-40">
								<input type="number" class="text-input" placeholder="1" min="0" max="5" >
							</div>
						</div>
					</div>
				<div class="col-35">
						<div class="form-group">
							<label class="col-50 form-label"><input type="radio" id="radio" name="radio" checked="checked">1차 누적판매량/수량</label>
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
								<input type="number" class="text-input" placeholder="1" min="0" max="5" >
							</div>
						</div>
					</div>
					<div class="col-35">
						<div class="form-group">
							<label class="col-50 form-label"><input type="radio" id="radio" name="radio">2차 누적판매량/수량</label>
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
								<input type="number" class="text-input" placeholder="1" min="0" max="5" >
							</div>
						</div>
					</div>
				<div class="col-35">
						<div class="form-group">
							<label class="col-50 form-label"><input type="radio" id="radio" name="radio">3차 누적판매량/수량</label>
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
		</div>
		<!-- E_추가삭제적용1-->
		<div class="title-model-s">
			<h4 class="d-inblock pt10"><span class="title-point">[별도포장]</span></h4>
			<div class="d-inblock fr">
				<button id='btn-add-row2' class="button-Rsmall">(+)추가하기</button>
				<button id='btn-delete-row2' class="button-Rsmall">(-)삭제하기</button>
			</div>
		</div>
		<div id="mytable2">
			<div class="row">
				<div class="col-20">
					<div class="form-group">
						<label class="col-60 form-label">1차별도포장</label>
						<div class="col-40">
							<input type="number" class="text-input" placeholder="1" min="0" max="5" >
						</div>
					</div>
				</div>
				<div class="col-35">
					<div class="form-group">
						<label class="col-50 form-label"><input type="radio" id="radio" name="radio">1차 누적판매량/수량</label>
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
							<input type="number" class="text-input" placeholder="1" min="0" max="5" >
						</div>
					</div>
				</div>
				<div class="col-35">
					<div class="form-group">
						<label class="col-50 form-label"><input type="radio" id="radio" name="radio">2차 누적판매량/수량</label>
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
		</div>
   	<span class="fr pt10 text-point">※재활용분담금 : 누적판매수량/년 x 중량/원 x 단가</span>
		<!-- 버튼 -->
		<div class="modal-footer btn-group">
			<button type="button" class="button btn-success" data-dismiss="modal">저장</button>
			<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>
</div>

</form>


<form id="frmUpdate">
<!-- 레이어 팝업 - 수정  -->
<div id="edit" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width:1000px">
		<div class="modal-header">
			<h4 class="modal-title">상품수정</h4>
			<button type="button" class="close" data-dismiss="modal"><img src="../images/icon_close.png"></button>
		</div>
		<div class="modal-body">
			<div class="tab02">
				 <ul class="tabnav02">
					 <li><a href="#tab02_1">상품기본정보</a></li>
					 <li><a href="#tab02_2">문서정보</a></li>
				 </ul>
				 <div class="tabcontent02">
					 <div id="tab02_1">
						 <div class="row">
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">상품코드</label>
									<div class="col-75">
										<input type="text" class="text-input" value="HSL2100000001" disabled>
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">상품분류</label>
									<div class="col-75">
										<select class="select-box">
											<option value="선택없음" selected="">선택없음</option>
											<option value="상품분류선택">상품분류선택</option>
											<option value="상품분류선택">상품분류선택</option>
											<option value="상품분류선택">상품분류선택</option>
											<option value="상품분류선택">상품분류선택</option>
										</select>
									</div>
								</div>
							</div>
							<div class="col-100">
								<div class="form-group">
									<label class="col-25 form-label">상품명</label>
									<div class="col-75">
										<input type="text" class="text-input" placeholder="예시)건강참기름 가정용">
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
									<label class="col-25 form-label">상품제조사</label>
									<div class="col-75">
										<input type="text" class="text-input" placeholder="예시)아산 제1공장">
									</div>
								</div>
							</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">재활용분담금</label>
									<div class="col-75">
										<input type="text" class="text-input" placeholder="누적판매량 등록시 자동계산">
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
											<input name="files[]" type="file" multiple="multiple" id="our-file02" class="multi with-preview">
										</div>
									</div>
								</div>
	             </div>
							</div>
							<h4 class="tl pt15"><span class="title-point">[환경부 진행상황]</span></h4>
							<div class="row">
								<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">진행상태</label>
									<div class="col-75">
										<div class="form-input-box">
											<div class="button-Rsmall d-inblock">
												<input type="radio" id="radio1" name="radio" checked="checked">
												<label for="radio1" class="mr05">진행중</label></div>
											<!--<div class="button-Rsmall d-inblock">
												<input type="radio" id="radio2" name="radio">
												<label for="radio2" class="mr05">보완</label></div>
											<div class="button-Rsmall d-inblock">
												<input type="radio" id="radio3" name="radio">
												<label for="radio3" class="mr05">반려</label></div>-->
											<div class="button-Rsmall d-inblock">
												<input type="radio" id="radio4" name="radio">
												<label for="radio4" class="mr05">완료</label></div>
										</div>
									</div>
								</div>
								</div>
							<div class="col-50">
								<div class="form-group">
									<label class="col-25 form-label">마스터</label>
									<div class="col-75">
										<div class="form-input-box">
											<div class="button-Rsmall d-inblock">
												<input type="radio" id="radio1" name="radio" checked="checked">
												<label for="radio1" class="mr05">적용</label></div>
											<div class="button-Rsmall d-inblock">
												<input type="radio" id="radio4" name="radio">
												<label for="radio4" class="mr05">비적용</label></div>
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

					 <div id="tab02_2">
						 <div class="row">
						 <div class="col-50">
							 <div class="form-group">
								 <label class="col-25 form-label">최초 생성일</label>
								 <div class="col-75">
									 <input type="text" class="text-input" value="2022-01-01" disabled>
								 </div>
							 </div>
						 </div>
						 <div class="col-50">
							 <div class="form-group">
								 <label class="col-25 form-label">최종 변경일</label>
								 <div class="col-75">
									 <input type="text" class="text-input" value="2022-01-04" disabled>
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
				<button type="button" class="button btn-success" data-dismiss="modal">저장</button>
				<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

</form>

<form id="frmDelete">
<!-- 레이어 팝업 - delete -->
<div id="delete" class="modal" data-backdrop-limit="1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-modal-parent="#myModal">
	
	<input type="hidden" id="productCode" name="productCode" >

	<div class="modal-content" style="width:400px">
		<div class="modal-header">
			<h4 class="modal-title">삭제</h4>
			<button type="button" class="close" data-dismiss="modal"><img src="../images/icon_close.png"></button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-100">
					<div class="form-group">
						<div class="tc">
						<em class="text-bold delName"></em>코드를 삭제하시겠습니까?</div>
						<!--(<em class="text-bold">PEuser01</em>)삭제합니다.</div> -->
					</div>
				</div>
			</div>
		</div>
		<div class="modal-footer btn-group">
			<button type="button" class="button btn-warning" onclick="deleteProductItem();" data-dismiss="modal">삭제</button>
			<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>
</form>

<form id="frmDetail">
<!-- 레이어 팝업 - 상세  -->
<div id="detail" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width:auto;max-width:1200px">
		<div class="modal-header">
			<h4 class="modal-title">상품포장정보</h4>
			<button type="button" class="close" data-dismiss="modal"><img src="../images/icon_close.png"></button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="tab03">
					 <ul class="tabnav03">
						 <li><a href="#tab03_1">1차포장</a></li>
						 <li><a href="#tab03_2">2차포장</a></li>
					 </ul>
					 <div class="tabcontent03">
						 <!--S_탭 tab03_1-->
						 <div id="tab03_1">
							 <div class="row">
								 <!--S_탭 tab04-->
								 <div class="tab04">
										<ul class="tabnav04 tc">
											<li><a href="#tab04_1">재질정보</a></li>
											<li><a href="#tab04_2">자가진단</a></li>
										</ul>
										<!--S_탭 tabcontent04-->
										<div class="tabcontent04">
											<div id="tab04_1">
												<div class="tab-in-nav d-flex">
													 <span class="pt10 pr10">ㆍ재질유형</span>
													 <select class="select-box w200 mr10">
														 <option value="0">종이팩</option>
														 <option value="1">플라스틱</option>
													 </select>
													 <ul class="tabnav04-in d-flex pt05">
			 											<li><a href="#tab04_1_in1">몸체</a></li>
			 											<li><a href="#tab04_1_in2">라벨</a></li>
														<li><a href="#tab04_1_in3">마개및잡자재</a></li>
			 											<li><a href="#tab04_1_in4">라벨 마개 및 잡자재</a></li>
			 										</ul>
												 </div>
												 <!--S_몸체 -->
												 <div class="tabcontent04-in">
												 <div id="tab04_1_in1">
												 <h4 class="tl pt15"><span class="title-point">[몸체 상세]</span></h4>
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
										 							<input name="files[]" type="file" multiple="multiple" id="our-file03" class="with-preview afile-img">
										 						</div>
			 												 </div>
			 											 </div>
			 											 <div class="form-group">
			 												 <label class="col-25 form-label-txt">참고도면 및 문서</label>
			 												 <div class="col-75">
																 <div class="form-input-txt">
																	<input type="file" class="afile-txt" />
																</div>
			 												 </div>
			 											 </div>
			 											 <div class="form-group">
			 												 <label class="col-25 form-label">보고서 생성</label>
			 												 <div class="col-75 tl">
			 													 <div class="text-input"><button type="button" class="button-Rsmall mr05">포장재질구조증명</button><button type="button" class="button-Rsmall">육안판정서</button></div>
			 												 </div>
			 											 </div>
			 										 </div>
			 										</div>

													<h4 class="tl pt15"><span class="title-point">[업체담당자정보]</span></h4>
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
																	 <input type="text" class="text-input">
																	 <span class="search-box-append">
																		 <button type="button" class="button-search"><a href="../email.html" role="button" data-toggle="modal">이메일보내기</a></button>
																	 </span>
																 </div>
															 </div>
														 </div>
													 </div>
													</div>
													</div>
													<div id="tab04_1_in2">
														라벨
													</div>
													<div id="tab04_1_in3">
														마개및 잡자재
													</div>
													<div id="tab04_1_in4">
														라벨마개 및 잡자재
													</div>
													<!-- 버튼 -->
												</div>
												<div class="modal-footer btn-group">
													<button type="button" class="button btn-success" data-dismiss="modal">저장</button>
													<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
												</div>
												<!--E_몸체 -->

												</div>
												<!--S_탭 tab04_2 -->
												<div id="tab04_2">
													 <div class="row">
														 <span class="pt10 pr10">ㆍ코드변경시점</span>
															<select class="select-box w150 mr10">
																<option value="0">2021년7월</option>
																<option value="1">2021년1월</option>
															</select>
														 	<div class="tab-in-nav d-flex">
															 <span class="pt10 pr10">ㆍ재질유형</span>
		 													 <select class="select-box w150 mr10">
		 														 <option value="0">종이팩</option>
		 														 <option value="1">플라스틱</option>
		 													 </select>
															 <ul class="d-flex pt05">
					 											<li class="button btn-radius on">몸체</li>
					 											<li class="button btn-radius">라벨</li>
																<li class="button btn-radius on">마개및잡자재</li>
					 											<li class="button btn-radius">라벨 마개 및 잡자재</li>
					 											</ul>
		 												 	</div>
														 </div>
														 <!--<div class="cb">체크 </div>-->
														 <div id="Accordion_wrap"  class="row100 pt10">
															 <div class="Accordion-box">
																 <h4 class="que pt15"><span class="title-point">[몸체]</span></h4>
																 <div class="anw">
																	 <ul class="choice-wrapper">
																		 <li class="choice-box">
																			 <h4 class="line-br">재활용-최우수/우수</h4>
																			 <div class="choice-cont">
																				 <ul>
																					 <li><input type="checkbox"><label for="">무색</label></li>
																					 <li><input type="checkbox"><label for="">녹색 </label></li>
																					 <li><input type="checkbox"><label for="">갈색 </label></li>
																				 </ul>
																			 </div>
																		 </li>
																		 <li class="choice-box">
																			<h4 class="line-br">재활용-어려움</h4>
																			<div class="choice-cont">
																				<ul>
																					<li><input type="checkbox"><label for="">무색 </label></li>
																					<li><input type="checkbox"><label for="">녹색 </label></li>
																					<li><input type="checkbox"><label for="">갈색 </label></li>
																				 </ul>
																			</div>
																		 </li>
																		 <li class="choice-box">
																			 <h4 class="line-br">재활용-보통</h4>
																			 <div class="choice-cont">
																				 <ul>
																					 <li><input type="checkbox"><label for="">무색 </label></li>
																				 </ul>
																			 </div>
																		 </li>
																		 <li class="choice-box">
																			<h4 class="line-br">판정방법</h4>
																			<div class="choice-cont">
																				<ul>
																					<li><input type="checkbox"><label for="">기기분석</label></li>
																					<li><input type="checkbox"><label for="">육안판정</label></li>
																					<li><input type="checkbox"><label for="">공인시험성적서</label></li>
																					<li><input type="checkbox"><label for="">신고허가서류</label></li>
																					<li><input type="checkbox"><label for="">기타</label></li>
																				 </ul>
																			</div>
																		 </li>
																	 </ul>
																	 <div class="row">
																		<div class="col-50">
																			<div class="form-group pb0">
																				<label class="col-25 form-label">증빙서류</label>
																				<div class="col-75">
																					<div class="form-input">
																						<input type="text" class="text-input" placeholder="기기분석,육안판정,공인시험성적서,신고허가서류,기타">
																					</div>
																				</div>
																			</div>
																		</div>
																		<div class="col-50">
																			<div class="form-group pb0">
																			 <label class="col-25 form-label">첨부파일</label>
																			 <div class="col-75">
																					 <input type="file" multiple="multiple" class="text-input">
																			 </div>
																			 </div>
																		</div>
																	 </div>
																	 <!-- S_결과확인-->
																	 <div class="result-box">
																		 <div class="row">
																			<div class="col-50">
																				<div class="form-group pb0">
																					<label class="col-25 form-label">몸체평가결과 </label>
																					<div class="col-75">
																						<div class="form-input">
																							<input type="text" class="text-input" placeholder="우수">
																						</div>
																					</div>
																				</div>
																			</div>
																			<div class="col-50">
																				<div class="form-group pb0">
																					<label class="col-25 form-label">필요서류 목록</label>
																					<div class="col-75">
																						<div class="form-input">
																							<input type="text" class="text-input" placeholder="기기분석,육안판정,공인시험성적서,신고허가서류,기타">
																						</div>
																					</div>
																				</div>
																			</div>
																		 </div>
																	 </div>
																	 <!-- E_결과확인-->
																 </div>
															 </div>
															 <div class="Accordion-box">
																 <h4 class="que pt15"><span class="title-point">[라벨]</span></h4>
																 <div class="anw">
																	 <ul class="choice-wrapper">
																		 <li class="choice-box">
																			 <h4 class="line-br">재활용-최우수/우수</h4>
																			 <div class="choice-cont">
																				 <ul>
																					 <li><input type="checkbox"><label for="">미사용(유통기한 및 제조일자만 표시된 경우 포함)</label></li>
																					 <li><input type="checkbox"><label for="">종이재질</label></li>
																					 <li><input type="checkbox"><label for="">절취선을 포함한 비접(점)착식 합성수지 재질</label></li>
																				 </ul>
																			 </div>
																		 </li>
																		 <li class="choice-box">
																			<h4 class="line-br">재활용-어려움</h4>
																			<div class="choice-cont">
																				<ul>
																					<li><input type="checkbox"><label for="">미사용(유통기한 및 제조일자만 표시된 경우 포함)</label></li>
																					<li><input type="checkbox"><label for="">종이재질</label></li>
																					<li><input type="checkbox"><label for="">절취선을 포함한 비접(점)착식 합성수지 재질</label></li>
																				 </ul>
																			</div>
																		 </li>
																		 <li class="choice-box">
																			 <h4 class="line-br">재활용-보통</h4>
																			 <div class="choice-cont">
																				 <ul>
																					 <li><input type="checkbox"><label for="">절취선을 포함하지 않은 비접(점)착식 합성수지 재질</label></li>
																					 <li><input type="checkbox"><label for="">접(점)착제가 사용된 합성수지 재질로서 몸체와 분리가능한 경우</label></li>
																					 <li><input type="checkbox"><label for="">몸체에 직접 인쇄(유통기간 및 제조일자 표시 제외)</label></li>
																					 <li><input type="checkbox"><label for="">기타</label></li>
																				 </ul>
																			 </div>
																		 </li>
																		 <li class="choice-box">
																			<h4 class="line-br">판정방법</h4>
																			<div class="choice-cont">
																				<ul>
																					<li><input type="checkbox"><label for="">기기분석</label></li>
																					<li><input type="checkbox"><label for="">육안판정</label></li>
																					<li><input type="checkbox"><label for="">공인시험성적서</label></li>
																					<li><input type="checkbox"><label for="">신고허가서류</label></li>
																					<li><input type="checkbox"><label for="">기타</label></li>
																				 </ul>
																			</div>
																		 </li>
																	 </ul>
																	 <div class="row">
																		<div class="col-50">
																			<div class="form-group pb0">
																				<label class="col-25 form-label">증빙서류</label>
																				<div class="col-75">
																					<div class="form-input">
																						<input type="text" class="text-input" placeholder="기기분석,육안판정,공인시험성적서,신고허가서류,기타">
																					</div>
																				</div>
																			</div>
																		</div>
																		<div class="col-50">
																			<div class="form-group pb0">
																			 <label class="col-25 form-label">첨부파일</label>
																			 <div class="col-75">
																					 <input type="file" multiple="multiple" class="text-input">
																			 </div>
																			 </div>
																		</div>
																	 </div>
																	 <!-- S_결과확인-->
																	 <div class="result-box">
																		 <div class="row">
																			<div class="col-50">
																				<div class="form-group pb0">
																					<label class="col-25 form-label">몸체평가결과 </label>
																					<div class="col-75">
																						<div class="form-input">
																							<input type="text" class="text-input" placeholder="우수">
																						</div>
																					</div>
																				</div>
																			</div>
																			<div class="col-50">
																				<div class="form-group pb0">
																					<label class="col-25 form-label">필요서류 목록</label>
																					<div class="col-75">
																						<div class="form-input">
																							<input type="text" class="text-input" placeholder="기기분석,육안판정,공인시험성적서,신고허가서류,기타">
																						</div>
																					</div>
																				</div>
																			</div>
																		 </div>
																	 </div>
																	 <!-- E_결과확인-->
																 </div>
															 </div>
															 <div class="Accordion-box">
																 <h4 class="que pt15"><span class="title-point">[마개 및 잡자재]</span></h4>
																 <div class="anw">
																	 <ul class="choice-wrapper">
																		 <li class="choice-box">
																			 <h4 class="line-br">재활용-최우수/우수</h4>
																			 <div class="choice-cont">
																				 <ul>
																					 <li><input type="checkbox"><label for="">뚜껑·테 일체형 구조</label></li>
																					 <li><input type="checkbox"><label for="">몸체와 분리가능한 마개 및 잡자재</label></li>
																				 </ul>
																			 </div>
																		 </li>
																		 <li class="choice-box">
																			<h4 class="line-br">재활용-어려움</h4>
																			<div class="choice-cont">
																				<ul>
																					<li><input type="checkbox"><label for="">뚜껑·테 일체형 구조</label></li>
																					<li><input type="checkbox"><label for="">몸체와 분리가능한 마개 및 잡자재</label></li>
																				 </ul>
																			</div>
																		 </li>
																		 <li class="choice-box">
																			 <h4 class="line-br">재활용-보통</h4>
																			 <div class="choice-cont">
																				 <ul>
																					 <li>
																						 <input type="checkbox"><label for="">기타</label>
																						 <textarea class="textarea"></textarea>
																					 </li>
																				 </ul>
																			 </div>
																		 </li>
																		 <li class="choice-box">
																			<h4 class="line-br">판정방법</h4>
																			<div class="choice-cont">
																				<ul>
																					<li><input type="checkbox"><label for="">기기분석</label></li>
																					<li><input type="checkbox"><label for="">육안판정</label></li>
																					<li><input type="checkbox"><label for="">공인시험성적서</label></li>
																					<li><input type="checkbox"><label for="">신고허가서류</label></li>
																					<li><input type="checkbox"><label for="">기타</label></li>
																				 </ul>
																			</div>
																		 </li>
																	 </ul>
																	 <div class="row">
																		<div class="col-50">
																			<div class="form-group pb0">
																				<label class="col-25 form-label">증빙서류</label>
																				<div class="col-75">
																					<div class="form-input">
																						<input type="text" class="text-input" placeholder="기기분석,육안판정,공인시험성적서,신고허가서류,기타">
																					</div>
																				</div>
																			</div>
																		</div>
																		<div class="col-50">
																			<div class="form-group pb0">
																			 <label class="col-25 form-label">첨부파일</label>
																			 <div class="col-75">
																					 <input type="file" multiple="multiple" class="text-input">
																			 </div>
																			 </div>
																		</div>
																	 </div>
																	 <!-- S_결과확인-->
																	 <div class="result-box">
																		 <div class="row">
																			<div class="col-50">
																				<div class="form-group pb0">
																					<label class="col-25 form-label">몸체평가결과 </label>
																					<div class="col-75">
																						<div class="form-input">
																							<input type="text" class="text-input" placeholder="우수">
																						</div>
																					</div>
																				</div>
																			</div>
																			<div class="col-50">
																				<div class="form-group pb0">
																					<label class="col-25 form-label">필요서류 목록</label>
																					<div class="col-75">
																						<div class="form-input">
																							<input type="text" class="text-input" placeholder="기기분석,육안판정,공인시험성적서,신고허가서류,기타">
																						</div>
																					</div>
																				</div>
																			</div>
																		 </div>
																	 </div>
																	 <!-- E_결과확인-->
																 </div>
															 </div>
														 </div>
														<!-- 버튼 -->
														<div class="modal-footer btn-group">
															<button type="button" class="button btn-success" data-dismiss="modal">결과확인</button>
															<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
														</div>
														<!--S_최종결과 -->
														<div class="row100 pt10">
															<div class="result-box">
																<div class="row">
																 <div class="col-50">
																	 <div class="form-group pb0">
																		 <label class="col-25 form-label result-text">최종 결과 </label>
																		 <div class="col-75">
																			 <div class="form-input">
																				 <input type="text" class="text-input" placeholder="우수">
																			 </div>
																		 </div>
																	 </div>
																 </div>
																 <div class="col-50">
																	 <div class="form-group pb0">
																		 <label class="col-25 form-label result-text">매핑결과</label>
																		 <div class="col-75">
																			 <div class="form-input">
																				 <input type="text" class="text-input" placeholder="1안) – 3안) 중 결과 보여줌">
																			 </div>
																		 </div>
																	 </div>
																 </div>
																</div>
															</div>
														</div>
													 <!--E_최종결과 -->
													</div>
												  <!--E_탭 tab04_2 -->
												</div>
												<!--E_탭 tabcontent04-->
											</div>
											<!--E_탭 tab04-->
										</div>
							 		</div>
									<!--E_탭 tab03_1-->

									<div id="tab03_2">
		 						 		<div class="row">
											<div class="tab05">
			 									<ul class="tabnav05">
			 										<li><a href="#tab05_1">재질정보</a></li>
			 										<li><a href="#tab05_2">자가진단</a></li>
			 									</ul>
			 									<div class="tabcontent05">
			 										<div id="tab05_1">
			 											<div class="row">
			 												 2차포장재질정보
			 										 </div>
			 										</div>
			 										<div id="tab05_2">
			 											 <div class="row">
			 											2차포장자가진단
			 											 </div>
			 										</div>
			 									</div>
			 								</div>
								 		</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
    </div>
</form>


<script type="text/javascript">

	$(document).ready(function() {
		var day = '${environmentCodeModel.revisionYear}-${environmentCodeModel.revisionMonth}';
		$('#midRevision').val(day);
		$('#smlRevision').val(day);	
		$('#smlGroupId').val('${environmentCodeModel.groupId}');
		
		$('#largeCategory').change(function(){
			$('#middleCategory').val('');
			var param = $('#frm').serialize();
			$('#frm').attr('action','/system/environmentCode');
			$('#frm').submit();
		});
		
		$('#revision').change(function(){
			var param = $('#frm').serialize();
			$('#frm').attr('action','/system/environmentCode');
			$('#frm').submit();
		});
		
		$('.middleCodeCancel, .mid_close').click(function(){
			middleInputReset();
			$('.middleCodeInsert').addClass('new');
			$('.middleCodeInsert').text('신규');
			$('.middleCodeInsert').removeClass('save');
			$('.middleCodeInsert').removeClass('edit');
		});
		
		$('.smallCodeCancel, .sml_close').click(function(){
			smallInputReset();
			$('#smlGroupId').val('${environmentCodeModel.groupId}');
			$('.smallCodeInsert').addClass('new');
			$('.smallCodeInsert').text('신규');
			$('.smallCodeInsert').removeClass('save');
			$('.smallCodeInsert').removeClass('edit');
		});
		
		$('.detailCodeCancel, .de_close').click(function(){
			detailInputReset();
			$('.detailCodeInsert').addClass('new');
			$('.detailCodeInsert').text('신규');
			$('.detailCodeInsert').removeClass('save');
			$('.detailCodeInsert').removeClass('edit');
			$('.detailCodeDelete').hide();
		});
		
		$('.middleCodeInsert').click(function(){
			if($('.middleCodeInsert').hasClass('new')){
				$('.middleCodeInsert').text('저장');
				$('.middleCodeInsert').addClass('save');
				$('.middleCodeInsert').removeClass('new');
				$('#midGroupId').val($('#largeCategory').val());
				$('#midCodeId').attr('disabled',false);
				$('#midCodeKey').attr('disabled',false);
				$('#midCodeNm').attr('disabled',false);
				$('#midOrdSeq').attr('disabled',false);
				$('#midCodeDsc').attr('disabled',false);
			}else{
				if($('.middleCodeInsert').hasClass('save')){
					middleCodeSave();
				}
				if($('.middleCodeInsert').hasClass('edit')){
					middleCodeEdit();
				}
			}
		});
		
		$('.smallCodeInsert').click(function(){
			if($('.smallCodeInsert').hasClass('new')){
				$('.smallCodeInsert').text('저장');
				$('.smallCodeInsert').addClass('save');
				$('.smallCodeInsert').removeClass('new');
				$('#smlCodeId').attr('disabled',false);
				$('#smlCodeKey').attr('disabled',false);
				$('#smlCodeNm').attr('disabled',false);
				$('#smlOrdSeq').attr('disabled',false);
				$('#smlCodeDsc').attr('disabled',false);
			}else{
				if($('.smallCodeInsert').hasClass('save')){
					smallCodeSave();
				}
				if($('.smallCodeInsert').hasClass('edit')){
					smallCodeEdit();
				}
			}
		});
		
		$('.detailCodeInsert').click(function(){
			if($('.detailCodeInsert').hasClass('new')){
				$('.detailCodeInsert').text('저장');
				$('.detailCodeInsert').addClass('save');
				$('.detailCodeInsert').removeClass('new');
				$('#deCodeId').attr('disabled',false);
				$('#deCodeKey').attr('disabled',false);
				$('#deCodeNm').attr('disabled',false);
				$('#deOrdSeq').attr('disabled',false);
				$('#deCodeDsc').attr('disabled',false);
			}else{
				if($('.detailCodeInsert').hasClass('save')){
					detailCodeSave();
				}
				if($('.detailCodeInsert').hasClass('edit')){
					detailCodeEdit();
					$('.detailCodeDelete').hide();
				}
			}
		});
		
		$('.delPopupCancel').click(function(){
			$('.fontColorRed').remove();
		});
	
	});

	function deleteProductItemSet(productCode) {
	 	$('.delName').text(productCode);		
		$('#productCode').val(productCode);
		$('#delType').val('small');
		$('.tc').append('<div class="pt05 fontColorRed">ㆍ삭제시 하위 코드 모두 삭제 됩니다.</div>');
	}

	function deleteProductItem(){
		$('#productCode').val($('#productCode').val());		
		var action = 'delete';
		var	param = $('#frmDelete').serialize();
		 if(isDisabled){
		 	return false;
		 }else{
			isDisabled = true;
			deleteAjax(param, action);
		 }
	}
	
		
	// 코드 삭제시 사용(공통)
	function deleteAjax(param, action) {
		console.log('deleteAjax:', param);
		$.ajax({
			type : 'post',
			url : '/product/prodList/' + action,
			data : param,
			dataType : 'text',
			error : function(xhr, status, error) {
				console.log(error);
			},
			success : function(result) {
				isDisabled = false;
				if (result == 'Delete') {
					var param = $('#frm').serialize();
					$('#frm').attr('action','/product/prodList');
					$('#frm').submit();
				}
			}
		});
	}
	

</script>


