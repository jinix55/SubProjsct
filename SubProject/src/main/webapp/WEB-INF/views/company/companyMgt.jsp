<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div id="contents">
		<div class="content">
			<div id="sub">
			 <p>PPLUS Echo</p>/<a href="">시스템관리</a>
			</div>
			<div class="stn_top">
				<form action="">
					<div class="cont">
					<h2 class="sta"><!--시스템관리--><span>그룹관리</span></h2>
					<!-- 검색_S-->
						<div class="search_wrap">
							<div class="select_box">
								<div class="custom_select">
									<select name="">
										<option value="0">분류</option>
										<option value="1">그룹ID</option>
										<option value="2">그룹명</option>
										<option value="3">사업자번호</option>
									</select>
								</div>
							</div>
							<div class="search_box">
								<input type="text" name="" value="" placeholder="">
								<button type="button" name="button"><img src="../../images/icon-search.png"></button>
							</div>
						</div>
						<div class="top_calendar">
							<label for="delivery_period" class="delivery_period">기간별조회</label>
							<div class="input_calendar">
								<input type="text" name="" value="" class="datapicker" id="datepicker">
							</div>
						</div>
					<!-- 검색_E-->
					</div>
				</form>
			</div>

			<div class="stn_cont">
				<table>
				<caption>그룹테이블</caption>
				<colgroup>
					<col width="4%">
					<col width="5%">
					<col width="10%">
					<col width="15%">
					<col width="auto">
					<col width="15%">
					<col width="10%">
					<col width="15%">
				</colgroup>
				<thead>
					<tr>
						<th>
							<input type="checkbox" name="dummy" id="cbAll">
							<label for="cbAll"></label>
						</th>
						<th>
						 <div><span>NO</span><img src="../../images/icon-sort.png" alt="정렬화살" class="sort"></div>
						</th>
						<th>그룹ID</th>
						<th>그룹명</th>
						<th>그룹설명</th>
						<th>
							<div>
								<span>사업자번호</span>
								<img src="../../images/icon-sort.png" alt="" class="sort">
							</div>
						</th>
						<th>등록일</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="checkbox" name="cb" id="cb1"><label for="cb1"></label></td>
						<td>1</td>
						<td><a href="#detail" role="button" data-toggle="modal" class="btn_detailPage">GROUP_RTDATE</a></td>
						<td>슈퍼관리자</td>
						<td>모든 관한을 관리하는 관리자(추가/수정/삭제)</td>
						<td>123-45-67890</td>
						<td>2021-10-05</td>
						<td>
							<a href="#edit" role="button" data-toggle="modal" class="btn_edit"><span>수정</span><img src="../../images/icon-modify2.png" alt="수정하기"></a>
							<a href="#delete" role="button" data-toggle="modal" class="btn_delete2"><span>삭제</span><img src="../../images/icon-delete2.png" alt="삭제하기"></a>
						</td>
					</tr>
					<tr>
						<td><input type="checkbox" name="cb" id="cb2"><label for="cb2"></label></td>
						<td>2</td>
						<td><a href="javascript:void(0)" class="btn_detailPage">그룹ID그룹ID그룹ID</a></td>
						<td>그룹명그룹명그룹명그룹명그룹명</td>
						<td>그룹설명그룹설명그룹설명그룹설명그룹설명그룹설명그룹설명</td>
						<td>123-4567-8910</td>
						<td>2021-10-05</td>
						<td>
							<a href="" class="btn_edit"><span>수정</span><img src="../../images/icon-modify2.png" alt="수정하기"></a>
							<a href="" class="btn_delete2"><span>삭제</span><img src="../../images/icon-delete2.png" alt="삭제하기"></a>
						</td>
					</tr>
				</tbody>
				</table>
			</div>

			<div class="stn_btm">
				<div class="btn_cont">
					<button type="button" name="button" class="btn_delete" disabled>삭제</button>
					<button type="button" class="btn_register"><a href="#register" data-toggle="modal">등록</a></button>
				</div>
				<div class="paging_cont">
					<div class="paging">
						<a href="#" class="btn_paging first"><span class="blind">처믕ㅁ</span></a>
						<a href="#" class="btn_paging prev disabled"><span class="blind">이전</span></a>
						<a href="#" class="on">1</a>
						<a href="#"><span>2</span></a>
						<a href="#"><span>3</span></a>
						<a href="#" class="btn_paging next"><span class="blind">다음</span></a>
						<a href="#" class="btn_paging prev last"><span class="blind">끝</span></a>
					</div>
				</div>
			</div>
		</div>
	</div>
<!--내용_E-->
<!-- 등록 Modal -->
<div id="register" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<!-- Modal content-->
	<div class="modal_content" style="width:600px">
		<div class="modal_header">
			<h4 class="modal_title">그룹등록</h4>
			<button type="button" class="close" data-dismiss="modal">
			<a href="javascript:layerPopupClose(layerDeletePopup);"><img src="../../images/icon-close.png"></a></button>
		</div>
		<div class="modal_body">
			<div class="row h_45px">
				<label class="type_flex align_items-center">
				<p class="w_100px">그룹명<em>*</em></p>
				<div class="flex_item row input_group input_btn">
				<span class="form_control-validation">
				<input type="text" placeholder="예시 : 슈퍼관리자" class="form_control"></span>
				<button type="button" class="btn_default"><a href="#overlap" role="button" data-toggle="modal">중복체크</a>
				</div>
				</label>
			</div>
			<div class="row h_45px">
				<label class="type_flex align_items-center">
				<p class="w_100px">그룹설명</p>
				<div class="flex_item">
				<span>
				<input type="text" value="" autofocus="autofocus" class="form_control"></span>
				</div>
				</label>
			</div>
			<div class="row h_45px">
				<label class="type_flex align_items-center">
				<p class="w_100px">대표자명</p>
				<div class="flex_item">
				<span><input type="text" value="" autofocus="autofocus" class="form_control"></span>
				</div>
				</label>
			</div>
			<div class="row h_45px">
				<label class="type_flex align_items-center">
				<p class="w_100px">사업자번호</p>
				<div class="flex_item">
				<span><input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  maxlength='3' autofocus="autofocus" class="form_control"></span>
				</div>
				<div class="flex_item ml_6px">
				<span><input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  maxlength='2' autofocus="autofocus" class="form_control"></span>
				</div>
				<div class="flex_item ml_6px">
				<span><input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  maxlength='5' autofocus="autofocus" class="form_control"></span>
				</div>
				</label>
			</div>
			<div class="row h_45px">
				<label class="type_flex align_items-center">
				<p class="w_100px">연락처</p>
				<div class="flex_item">
				<span><input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  maxlength='3' autofocus="autofocus" class="form_control"></span>
				</div>
				<div class="flex_item ml_6px">
				<span><input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  maxlength='4' autofocus="autofocus" class="form_control"></span>
				</div>
				<div class="flex_item ml_6px">
				<span><input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  maxlength='4' autofocus="autofocus" class="form_control"></span>
				</div>
				</label>
			</div>
			<div class="stn_btm">
				<div class="btn_cont center">
					<button type="button" class="btn_register"><a href="#register" data-toggle="modal">등록</a></button>
				</div>
			</div>
		</div>
	</div>
</div>

<!--중복체크 Modal-->
<div id="overlap" class="modal" data-backdrop-limit="1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-modal-parent="#myModal">
<!-- Modal content-->
	<div class="modal_content" style="width:400px">
		<div class="modal_header">
			<h4 class="modal_title">중복체크</h4>
			<button type="button" class="close" data-dismiss="modal">
			<a href="javascript:layerPopupClose(layerDeletePopup);"><img src="../../images/icon-close.png"></a></button>
		</div>
		<div class="modal_body">
		 <span class="point">슈퍼관리자</span>는 사용 가능한 그룹입니다.
		</div>
		<div class="modal_footer stn_btm">
			<div class="btn_cont center">
			 <button type="button" class="btn_register"><a href="#overlap" data-toggle="modal" role="button" data-toggle="modal">확인</a></button>
			</div>
		</div>
	</div>
</div>

<!-- 수정 Modal-->
<div id="edit" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<!-- Modal content-->
	<div class="modal_content" style="width:600px">
		<div class="modal_header">
			<h4 class="modal_title">그룹수정</h4>
			<button type="button" class="close" data-dismiss="modal">
			<a href="javascript:layerPopupClose(layerDeletePopup);"><img src="../../images/icon-close.png"></a></button>
		</div>
		<div class="modal_body">
			<div class="row h_45px">
				<label class="type_flex align_items-center">
				<p class="w_100px">그룹명</p>
				<div class="flex_item">
				<span>
				<input type="text" value="슈퍼관리자" autofocus="autofocus" class="form_control" disabled></span>
				</div>
				</label>
			</div>
			<div class="row h_45px">
				<label class="type_flex align_items-center">
				<p class="w_100px">그룹설명</p>
				<div class="flex_item">
				<span>
				<input type="text" value="모든 관한을 관리하는 관리자(추가/수정/삭제)" autofocus="autofocus" class="form_control"></span>
				</div>
				</label>
			</div>
			<div class="row h_45px">
				<label class="type_flex align_items-center">
				<p class="w_100px">대표자명</p>
				<div class="flex_item">
				<span><input type="text" value="김아무개" autofocus="autofocus" class="form_control"></span>
				</div>
				</label>
			</div>
			<div class="row h_45px">
				<label class="type_flex align_items-center">
				<p class="w_100px">사업자번호</p>
				<div class="flex_item">
				<span><input type="text" value="123" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  maxlength='3' autofocus="autofocus" class="form_control"></span>
				</div>
				<div class="flex_item ml_6px">
				<span><input type="text" value="45" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  maxlength='2' autofocus="autofocus" class="form_control"></span>
				</div>
				<div class="flex_item ml_6px">
				<span><input type="text" value="67890" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  maxlength='5' autofocus="autofocus" class="form_control"></span>
				</div>
				</label>
			</div>
			<div class="row h_45px">
				<label class="type_flex align_items-center">
				<p class="w_100px">연락처</p>
				<div class="flex_item">
				<span><input type="text" value="123" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  maxlength='3' autofocus="autofocus" class="form_control"></span>
				</div>
				<div class="flex_item ml_6px">
				<span><input type="text" value="4567" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  maxlength='4' autofocus="autofocus" class="form_control"></span>
				</div>
				<div class="flex_item ml_6px">
				<span><input type="text" value="8901" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  maxlength='4' autofocus="autofocus" class="form_control"></span>
				</div>
				</label>
			</div>
			<div class="stn_btm">
				<div class="btn_cont center">
				 <button type="button" class="btn_register"><a href="#edit" data-toggle="modal">수정</a></button>
				</div>
			</div>
		</div>
	</div>
</div>

<!--삭제 Modal-->
<div id="delete" class="modal" data-backdrop-limit="1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-modal-parent="#myModal">
<!-- Modal content-->
	<div class="modal_content" style="width:400px">
		<div class="modal_header">
			<h4 class="modal_title">삭제</h4>
			<button type="button" class="close" data-dismiss="modal">
			<a href="javascript:layerPopupClose(layerDeletePopup);"><img src="../../images/icon-close.png"></a></button>
		</div>
		<div class="modal_body">
		 <span class="point">슈퍼관리자</span>을 삭제하시겠습니까?
		</div>
		<div class="modal_footer stn_btm">
			<div class="btn_cont center">
				<button type="button" class="btn_delete"><a href="#delete" data-toggle="modal">취소</a></button>
				<button type="button" class="btn_register ml_6px"><a href="#delete" data-toggle="modal">삭제하기</a></button>
			</div>
		</div>
	</div>
</div>

<!-- 상세 Modal-->
<div id="detail" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<!-- Modal content-->
	<div class="modal_content" style="width:600px">
		<div class="modal_header">
			<h4 class="modal_title">상세정보</h4>
			<button type="button" class="close" data-dismiss="modal">
			<a href="javascript:layerPopupClose(layerDeletePopup);"><img src="../../images/icon-close.png"></a></button>
		</div>
		<div class="modal_body">
			<div class="row h_45px">
				<label class="type_flex align_items-center">
				<p class="w_100px">등록일</p>
				<div class="flex_item">
				<span>
				<input type="text" value="2010-10-05" autofocus="autofocus" class="form_control" disabled></span>
				</div>
				</label>
			</div>
			<div class="row h_45px">
				<label class="type_flex align_items-center">
				<p class="w_100px">그룹ID</p>
				<div class="flex_item">
				<span>
				<input type="text" value="슈퍼관리자" autofocus="autofocus" class="form_control" disabled></span>
				</div>
				</label>
			</div>
			<div class="row h_45px">
				<label class="type_flex align_items-center">
				<p class="w_100px">그룹명</p>
				<div class="flex_item">
				<span>
				<input type="text" value="슈퍼관리자" autofocus="autofocus" class="form_control" disabled></span>
				</div>
				</label>
			</div>
			<div class="row h_45px">
				<label class="type_flex align_items-center">
				<p class="w_100px">그룹설명</p>
				<div class="flex_item">
				<span>
				<input type="text" value="모든 관한을 관리하는 관리자(추가/수정/삭제)" autofocus="autofocus" class="form_control" disabled></span>
				</div>
				</label>
			</div>
			<div class="row h_45px">
				<label class="type_flex align_items-center">
				<p class="w_100px">대표자명</p>
				<div class="flex_item">
				<span><input type="text" value="김아무개" autofocus="autofocus" class="form_control" disabled></span>
				</div>
				</label>
			</div>
			<div class="row h_45px">
				<label class="type_flex align_items-center">
				<p class="w_100px">사업자번호</p>
				<div class="flex_item">
				<span><input type="text" value="123" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  maxlength='3' autofocus="autofocus" class="form_control" disabled></span>
				</div>
				<div class="flex_item ml_6px">
				<span><input type="text" value="45" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  maxlength='2' autofocus="autofocus" class="form_control" disabled></span>
				</div>
				<div class="flex_item ml_6px">
				<span><input type="text" value="67890" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  maxlength='5' autofocus="autofocus" class="form_control" disabled></span>
				</div>
				</label>
			</div>
			<div class="row h_45px">
				<label class="type_flex align_items-center">
				<p class="w_100px">연락처</p>
				<div class="flex_item">
				<span><input type="text" value="123" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  maxlength='3' autofocus="autofocus" class="form_control" disabled></span>
				</div>
				<div class="flex_item ml_6px">
				<span><input type="text" value="4567" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  maxlength='4' autofocus="autofocus" class="form_control" disabled></span>
				</div>
				<div class="flex_item ml_6px">
				<span><input type="text" value="8901" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"  maxlength='4' autofocus="autofocus" class="form_control" disabled></span>
				</div>
				</label>
			</div>
			<div class="stn_btm">
				<div class="btn_cont center">
					<button type="button" class="btn_delete"><a href="#detail" data-toggle="modal">닫기</a></button>
					<button type="button" class="btn_register ml_6px"><a href="#detail" data-toggle="modal">수정</a></button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 개인정보수정 Modal -->
<div id="user-edit" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<!-- Modal content-->
	<div class="modal_content" style="width:600px">
		<div class="modal_header">
			<h4 class="modal_title">개인정보수정</h4>
			<button type="button" class="close" data-dismiss="modal">
			<a href="javascript:layerPopupClose(layerDeletePopup);"><img src="../../images/icon-close.png"></a></button>
		</div>
		<div class="modal_body">
			<div class="row h_45px">
				<label class="type_flex align_items-center">
				<p class="w_100px">ID</p>
				<div class="flex_item">
				<span>
				<input type="text" value="RTDATA" autofocus="autofocus" class="form_control"></span>
				</div>
				</label>
			</div>
			<div class="row h_45px">
				<label class="type_flex align_items-center">
				<p class="w_100px">비밀번호</p>
				<div class="flex_item">
				<span><input type="password" value="1234" autofocus="autofocus" class="form_control"></span>
				</div>
				</label>
			</div>
			<div class="row h_45px">
				<label class="type_flex align_items-center">
				<p class="w_100px">새 비밀번호</p>
				<div class="flex_item">
				<span><input type="password" value="" autofocus="autofocus" class="form_control"></span>
				</div>
				</label>
			</div>
			<div class="row h_45px">
				<label class="type_flex align_items-center">
				<p class="w_100px">새 비밀번호 확인</p>
				<div class="flex_item">
				<span><input type="password" value="" autofocus="autofocus" class="form_control"></span>
				</div>
				</label>
			</div>
			<div class="stn_btm">
				<div class="btn_cont center">
				 <button type="button" class="btn_register"><a href="#user-edit" data-toggle="modal">수정</a></button>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="/js/ui/global_script.js"></script>
