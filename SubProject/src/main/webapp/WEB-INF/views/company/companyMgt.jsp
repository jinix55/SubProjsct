<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="content">
	<!-- S_검색-->
	<form id="companySearch" action="/system/company" method="POST">
		<input type="hidden" id="page" name="page" value="${pages.page}">
		<div class="justify-content-between">
			<div class="form-group">
				<div class="form-inline">
					<select id="searchKey" name="searchKey" class="select-box w150">
						<option value="ALL">전체</option>
						<option value="companyCode">회사 코드</option>
						<option value="companyNm">회사 명</option>
					</select>
				</div>
				<div class="form-inline">
					<div class="search-box">
						<input id="searchValue" name="searchValue" value="${pages.searchValue }" type="text" class="text-input">
						 <span class="search-box-append">
							<button type="submit" class="btn-search">
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
<!-- 		<div class="buttons-action" style="display: none"> -->
<!-- 			<div> -->
<!-- 				<a href="#Alldelete" role="button" data-toggle="modal"> -->
<!-- 					<button type="button" class="btn-alldelete"> -->
<!-- 						전체삭제<img src="/images/icon_delete.png" title="삭제"> -->
<!-- 					</button> -->
<!-- 				</a> -->
<!-- 				<button type="button" class="btn-allcancel"> -->
<!-- 					삭제취소<img src="/images/icon_cancel.png" title="취소"> -->
<!-- 				</button> -->
<!-- 			</div> -->
<!-- 			<div> -->
<!-- 				<span class="text-action">14 items selected</span> -->
<!-- 			</div> -->
<!-- 		</div> -->
		<div class="scroll-auto">
			<table class="table table-actions">
				<colgroup>
<%-- 					<col style="width: 30px;"> --%>
					<col style="width: 6%;">
					<col style="width: 15%;">
					<col style="width: *;">
					<col style="width: 15%;">
					<col style="width: 14%;">
					<col style="width: 8%;">
					<col style="width: 8%;">
					<col style="width: 8%;">
				</colgroup>
				<thead>
					<tr class="th-bg">
<!-- 						<th><input type="checkbox" name="all" id="checkAll"></th> -->
						<th scope="col">번호</th>
						<th scope="col">회사 코드</th>
						<th scope="col">회사명</th>
						<th scope="col">사업자번호</th>
						<th scope="col">등록일</th>
						<th scope="col">사용여부</th>
						<th scope="col">계정관리</th>
						<th scope="col">관리</th>
					</tr>
				</thead>
				<tbody>
				<c:choose>
					<c:when test="${companys.size() > 0}" >
						<c:forEach items="${companys }" var="company" varStatus="status">
						<tr id="tr_${company.companyId}" >
<!-- 							<th><input type="checkbox" name="chk"></th> -->
							<td>${pages.totalCount - (status.index + (pages.page -1) * pages.pageSize)}</td>
							<td class="text-point <c:if test="${company.useYn eq 'N'}">colorGray</c:if>">${company.companyCode }</td>
							<td>${company.companyNm }</td>
							<td>${company.companyNo }</td>
							<td><spring:eval expression="company.rgstDt" /></td>
							<td>
								<button type="button" class="btn-<c:choose><c:when test="${company.useYn eq 'Y'}">yes</c:when><c:otherwise>no</c:otherwise></c:choose>"><c:choose><c:when test="${company.useYn eq 'Y'}">YES</c:when><c:otherwise>NO</c:otherwise></c:choose></button>
							</td>
							<td>
								<a href="javascript:void(0);" onclick="openMemberLayer('${company.companyCode}', '${company.companyNm}', true);" role="button" data-toggle="modal" class="btn-small02">계정관리</a>
<%-- 								<a href="/member/member?companyCode=${company.companyCode}" class="btn-small02">계정관리</a> --%>
							</td>
							<td>
								<div class="btn-group">
									<a href="#edit" onclick="detailView('${company.companyId}');" role="button" data-toggle="modal">
										<img src="/images/icon_edit.png" alt="수정하기" class="btn-table-icon02">
									</a>
									<c:if test="${company.useYn eq 'Y' and pages.authId eq 'au2000001'}">
										<a href="#delete" data-nm="${company.companyNm }" data-id="${company.companyId }" data-code="${company.companyCode }" data-no="${company.companyNo }" role="button" data-toggle="modal"
											class="btn-table-icon02 deleteBtnAction"><img src="/images/icon_delete2.png"
											alt="삭제하기" class="btn-table-icon02">
										</a>
									</c:if>
								</div>
							</td>
						</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="9">데이터가 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>
		</div>
	</div>
	<!-- E_그리드-->
	<c:if test="${pages.authId eq 'au2000001' }">
		<div class="btn-group pt15 tr">
			<button type="button" class="button btn-success" data-toggle="modal">
				<a href="#register" data-toggle="modal">등록</a>
			</button>
		</div>
	</c:if>
	<!-- S_페이징-->
	<div class="board-paging">
	</div>
	<!-- E_페이징-->
</div>


<!-- 레이어 팝업 - 등록  -->
<form>
<div id="register" class="modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width: 800px">
		<div class="modal-header">
			<h4 class="modal-title">등록</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">회사 Code<em>*</em></label>
						<div class="col-75">
							<div class="search-box">
									<input id="reg_companyCode" name="reg_companyCode" type="text"
										class="text-input eInput w-auto">
									<span class="search-box-append">
									<button id="codeSearch" name="codeSearch" type="button" class="btn-search codeSearch">
										<a href="#overlap" class="codeSearchBtn" role="button" data-toggle="modal">중복확인</a>
									</button>
								</span>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">회사명<em>*</em></label>
						<div class="col-75">
							<div class="form-input">
								<input id="reg_companyNm" name="reg_companyNm" type="text" class="text-input">
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">대표자명<em>*</em></label>
						<div class="col-75">
							<div class="form-input">
								<input id="reg_representativeNm" name="reg_representativeNm" type="text" class="text-input">
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">주소<em>*</em></label>
						<div class="col-75">
							<div class="form-input">
								<input id="reg_address" name="reg_address" type="text" class="text-input">
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">사업자번호<em>*</em></label>
						<div class="col-75">
							<div class="form-input">
								<div class="phone-number">
									<div class="pr16"><input id="reg_companyNo1" name="reg_companyNo1" type="text" class="text-input" maxlength="3" onkeypress='return checkNumber(event)'></div>
								</div>
								<div class="phone-number">
									<div class="pr16"><input id="reg_companyNo2" name="reg_companyNo2" type="text" class="text-input" maxlength="2" onkeypress='return checkNumber(event)'></div>
								</div>
								<div class="phone-number">
									<div><input id="reg_companyNo3" name="reg_companyNo3" type="text" class="text-input" maxlength="5" onkeypress='return checkNumber(event)'></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">전화번호<em>*</em></label>
						<div class="col-75">
							<div class="form-input">
								<div class="phone-number">
									<div class="pr16"><input id="reg_telephoneNo1" name="reg_telephoneNo1" type="text" class="text-input" maxlength="3" onkeypress='return checkNumber(event)'></div>
								</div>
								<div class="phone-number">
									<div class="pr16"><input id="reg_telephoneNo2" name="reg_telephoneNo2" type="text" class="text-input" maxlength="4" onkeypress='return checkNumber(event)'></div>
								</div>
								<div class="phone-number">
									<div><input id="reg_telephoneNo3" name="reg_telephoneNo3" type="text" class="text-input" maxlength="4" onkeypress='return checkNumber(event)'></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-100">
					<div class="form-group">
						<label class="col-25 form-label">사용여부</label>
						<div class="col-75">
							<div class="form-input-box">
								<div class="btn-form-small">
									<input id="useY" name="useYn" type="radio" value="Y" checked="checked">
									<label for="useY" class="mr05">YES</label>
								</div>
								<div class="btn-form-small">
									<input id="useN" name="useYn" type="radio" value="N">
									<label for="useN" class="mr05">NO</label>
								</div>
							</div>
							<!--  <select id="reg_useYn" name="reg_useYn" class="select-box">
								<option value="Y">예</option>
								<option value="N">아니요</option>
							</select> -->
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label-textarea">회사설명</label>
						<div class="col-75">
							<div class="form-input">
								<textarea id="reg_companyDsc" name="reg_companyDsc" class="textarea"></textarea>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label-textarea">비고</label>
						<div class="col-75">
							<div class="form-input">
								<textarea id="reg_note" name="reg_note" class="textarea"></textarea>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 버튼 -->
		<div class="modal-footer btn-group">
			<button type="button" class="button btn-success companyInsert">저장</button>
			<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>
</form>
<!-- 레이어 팝업 아이디 중복 확인 -->
<div id="overlap" class="modal" data-backdrop-limit="1" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
	data-modal-parent="#myModal">
	<div class="modal-content" style="width: 450px">
		<div class="modal-header">
			<h4 class="modal-title">중복확인</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-100">
					<div class="form-group">
						<label class="col-25 form-label">회사 Code<em>*</em></label>
						<div class="col-75">
							<div class="search-box">
								<input type="text" class="text-input w-auto" id="re_reg_companyCode" name="re_reg_companyCode">
								<span class="search-box-append">
									<button id="re_codeSearch" name="re_codeSearch" type="button" class="btn-search">
										<img src="/images/icon_search.png" title="검색">
									</button>
								</span>
							</div>
						</div>
					</div>
					<div class="form-notice" style="display:none">* [ww]는 사용가능한 ID입니다</div>
				</div>
			</div>
		</div>
		<!-- 버튼 -->
		<div class="modal-footer btn-group">
			<button type="button" class="button btn-success codeCheck" data-dismiss="modal">확인</button>
			<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>
<!-- 레이어 팝업 - 수정 -->
<div id="edit" class="modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width: 800px">
		<div class="modal-header">
			<h4 class="modal-title">상세</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<form id="companyInst">
		<div class="modal-body">
			<div class="row">
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">회사ID</label>
						<div class="col-75">
							<div class="form-input">
								<input id="companyId" name="companyId" type="text" class="text-input" readonly>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">회사코드</label>
						<div class="col-75">
							<div class="form-input">
<!-- 								<input id="companyCode" name="companyCode" type="text" class="text-input" onkeypress='return checkEnglish(event)' disabled> -->
									<input id="companyCode" name="companyCode" type="text" class="text-input" readonly>
							</div>
						</div>
					</div>
				</div>

				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">회사명</label>
						<div class="col-75">
							<div class="form-input">
								<input id="companyNm" name="companyNm" type="text" class="text-input" disabled>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">대표자명</label>
						<div class="col-75">
							<div class="form-input">
								<input id="representativeNm" name="representativeNm" type="text" class="text-input" disabled>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">주소</label>
						<div class="col-75">
							<div class="form-input">
								<input id="address" name="address" type="text" class="text-input" disabled>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">사용여부</label>
						<div class="col-75">
							<div class="form-input-box">
								<div class="btn-form-small">
									<input id="useY" name="useYn" type="radio" value="Y">
									<label for="useY" class="mr05">YES</label>
								</div>
								<div class="btn-form-small">
									<input id="useN" name="useYn" type="radio" value="N">
									<label for="useN" class="mr05">NO</label>
								</div>
							</div>
							<!-- <select id="useYn" name="useYn" class="select-box" disabled>
								   <option value="Y">예</option>
								   <option value="N">아니요</option>
							//</select> -->
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">사업자번호</label>
						<div class="col-75">
							<div class="form-input">
								<input type="hidden" id="companyNo" name="companyNo" />
								<div class="phone-number">
									<div class="pr16"><input id="companyNo1" name="companyNo1" type="text" class="text-input" maxlength="3" disabled  onkeypress='return checkNumber(event)'></div>
								</div>
								<div class="phone-number">
									<div class="pr16"><input id="companyNo2" name="companyNo2" type="text" class="text-input" maxlength="2" disabled  onkeypress='return checkNumber(event)'></div>
								</div>
								<div class="phone-number">
									<div><input id="companyNo3" name="companyNo3" type="text" class="text-input" maxlength="5" disabled  onkeypress='return checkNumber(event)'></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">전화번호</label>
						<div class="col-75">
							<div class="form-input">
								<input type="hidden" id="telephoneNo" name="telephoneNo" />
								<div class="phone-number">
									<div class="pr16"><input id="telephoneNo1" name="telephoneNo1" type="text" class="text-input" maxlength="3" onkeypress='return checkNumber(event)' disabled></div>
								</div>
								<div class="phone-number">
									<div class="pr16"><input id="telephoneNo2" name="telephoneNo2" type="text" class="text-input" maxlength="4"  onkeypress='return checkNumber(event)' disabled></div>
								</div>
								<div class="phone-number">
									<div><input id="telephoneNo3" name="telephoneNo3" type="text" class="text-input" maxlength="4"  onkeypress='return checkNumber(event)' disabled></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-100">
					<div class="form-group">
						<label class="col-25 form-label-textarea">회사설명</label>
						<div class="col-75">
							<div class="form-input">
								<textarea id="companyDsc" name="companyDsc" class="textarea" disabled></textarea>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label-textarea">비고</label>
						<div class="col-75">
							<div class="form-input">
								<textarea id="note" name="note" class="textarea" disabled></textarea>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</form>
		<!-- 버튼 -->
		<div class="modal-footer btn-group">
			<button type="button" class="button btnEdit">수정</button>
			<button type="button" class="button btnCheck btn-cancel" data-dismiss="modal">확인</button>
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
							<em class="font-bold delCompanyText">Company_ID01</em> 삭제합니다.
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="modal-footer btn-group">
			<button type="button" class="button btn-warning delCompanyAction" onclick="deleteCompanyAction();" value="" data-dismiss="modal">삭제</button>
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
							<em class="font-bold">14 items selected</em><br />삭제하시겠습니까?
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

<!-- 레이어 팝업 - 메시지 관리  -->
 <form id="frmMembers">
  <div id="members" class="modal" data-backdrop-limit="1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
	aria-hidden="true" data-modal-parent="#myModal">
	<input type="hidden" name="interfaceId" >
	<div class="modal-content" style="width:1000px">
	  <div class="modal-header">
		<h4 class="modal-title" id="interfaceMessageTitle">계정관리</h4>
		<button type="button" class="close" data-dismiss="modal" onclick="javascript:layerPopupClose(members);"><img src="/images/icon_close.png"></button>
	  </div>
	  <div class="modal-body">
		<table class="table">
			<colgroup>
				<col style="width: 6%;">
				<col style="width: 12%;">
				<col style="width: 15%;">
				<col style="width: *%;">
				<col style="width: 14%;">
				<col style="width: 8%;">
				<col style="width: 8%;">
			</colgroup>
			<thead>
				<tr class="th-bg">
					<th scope="col">번호</th>
					<th scope="col">사용자 ID</th>
					<th scope="col">사용자 이름</th>
					<th scope="col">그룹 ID</th>
					<th scope="col">등록일</th>
					<th scope="col">사용여부</th>
					<th scope="col">관리</th>
				</tr>
			</thead>
			<tbody id="memberTable">
				<tr>
					<td colspan="7">등록된 정보가 없습니다.</td>
				</tr>
			</tbody>
		</table>
	  </div>
	  <div class="modal-footer btn-group">
		<button type="button" class="button btn-cancel" data-dismiss="modal" onclick="javascript:layerPopupClose(members);">취소</button>
		<c:set var="userType" value="사용자 관리"/>  
		<c:if test="${pages.authId eq 'au2000001' }">
			<c:set var="userType" value="관리자 관리"/>  
		</c:if>
		<button type="button" class="button btn-success"> <a href="javascript:void(0);" onclick="javascript:openMemberRegistLayer('registerMember');" data-dismiss="modal">${userType}</a></button>
	  </div>
	</div>
  </div>
 </form>

 <!-- 레이어 팝업 - 인터페이스 등록  -->
  <form id="frmInsert">
	  <div id="registerMember" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-content" style="width:1000px">
		  <div class="modal-header">
			<h4 class="modal-title">관리자 등록</h4>
			<button type="button" class="close" data-dismiss="modal" onclick="javascript:layerPopupClose(registerMember);"><img src="/images/icon_close.png"></button>
		  </div>
		  <div class="modal-body">
		  	<div class="row">
				<div class="col-50" id="memberRgstDt">
					<div class="form-group">
						<label class="col-25 form-label">등록일시</label>
						<div class="col-75">
							<div class="form-input">
								<input type="hidden" name="editModeYn" value="">
								<input name="rgstDt" type="text" class="text-input" disabled>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50" id="memberModiDt">
					<div class="form-group">
						<label class="col-25 form-label">수정일시</label>
						<div class="col-75">
							<div class="form-input">
								<input name="modiDt" type="text" class="text-input" disabled>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">사용자 ID<em>*</em></label>
						<div class="col-75">
							<div class="search-box">
								<input name="userId" type="text" class="text-input w-auto" placeholder="ID를 입력해 주세요"  disabled>
								<span class="search-box-append">
									<button type="button" class="btn-search" id="idSearch">
										<a id="idSearchCheck" href="#overlap" role="button" data-toggle="modal">중복확인</a>
									</button>
								</span>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">사용자 이름<em>*</em></label>
						<div class="col-75">
							<div class="form-input">
								<input name="userNm" type="text" class="text-input" placeholder="이름을 입력해 주세요">
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">회사명<em>*</em></label>
						<div class="col-75">
							<input name="companyCode" value="" type="hidden">
							<input name="companyNm" value="" type="text" class="text-input" disabled>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">그룹 ID<em>*</em></label>
						<div class="col-75">
							<c:set var="userAuth" value="au2000003"/>  
							<c:set var="userAuthNm" value="사이트 사용자"/>
							<c:if test="${pages.authId eq 'au2000001' }">
								<c:set var="userAuth" value="au2000002"/>  
								<c:set var="userAuthNm" value="사이트 관리자"/>
							</c:if>
							<input name="authId" value="${userAuth}" type="hidden">
							<input name="authNm" value="${userAuthNm}" type="text" class="text-input" disabled>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">이메일 주소<em>*</em></label>
						<div class="col-75">
							<div class="form-input">
								<div class="email-add">
									<div class="pr28"><input name="email1" type="text" class="text-input email"></div>
								</div>
								<div class="email-add">
									<div><input name="email2" type="text" class="text-input email"></div>
								</div>
								<input type="hidden" name="email" />
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<input type="hidden" id="phone" name="phone" /> <label
							class="col-25 form-label">연락처<em>*</em></label>
						<div class="col-75">
							<div class="form-input">
								<div class="phone-number">
									<div class="pr16"><input name="phone1" onkeyup="this.value = setNumber(this.value)" type="text" class="text-input phone" maxlength="3"></div>
								</div>
								<div class="phone-number">
									<div class="pr16"><input name="phone2" onkeyup="this.value = setNumber(this.value)" type="text" class="text-input phone" maxlength="4"></div>
								</div>
								<div class="phone-number">
									<div><input name="phone3" onkeyup="this.value = setNumber(this.value)" type="text" class="text-input phone" maxlength="4"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">잠금상태</label>
						<div class="col-75">
							<div class="form-input-box">
<!-- 								<button type="button" id="lockYn" name ="lockYn" class="btn-yes" style="height:26px;width:80px;line-height:26px;background:red;">Yes</button> -->
								<div class="btn-form-small">
									<input id="lockY" name="lockYn" type="radio" value="Y">
									<label for="lockY" class="mr05">활성화</label>
								</div>
								<div class="btn-form-small">
									<input id="lockY" name="lockYn" type="radio" value="N">
									<label for="lockN" class="mr05">비활성화</label>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">기한적용</label>
						<div class="col-75">
							<div class="form-input-box">
								<div class="btn-form-small">
									<input id="dtLimitY" name="dtLimitYn" type="radio" value="Y">
									<label for="dtLimitY" class="mr05">적용</label>
								</div>
								<div class="btn-form-small">
									<input id="dtLimitN" name="dtLimitYn" type="radio" value="N">
									<label for="dtLimitN" class="mr05">미적용</label>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">사용여부</label>
						<div class="col-75">
							<div class="form-input-box">
								<div class="btn-form-small">
									<input id="mUseY" name="useYn" type="radio" value="Y">
									<label for="mUseY" class="mr05">YES</label>
								</div>
								<div class="btn-form-small">
									<input id="mUseN" name="useYn" type="radio" value="N">
									<label for="mUseN" class="mr05">NO</label>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">기간설정</label>
						<div class="col-75">
							<div class="search-date">
								<input onkeyup="this.value = date_mask(this.value)" type="text"
									name="dateFrom" class="text-input">
							</div>
							<div class="search-date">
								<input onkeyup="this.value = date_mask(this.value)" type="text"
									name="dateTo" class="text-input">
							</div>
						</div>
					</div>
				</div>
			</div>
		  </div>
		  <!-- 버튼 -->
		<div class="modal-footer btn-group">
			<button id="saveMemberBtn" type="button" class="button btn-success insert" >저장</button>
			<button type="button" class="button btn-cancel cancel" data-dismiss="modal"  onclick="javascript:layerPopupClose(registerMember);">취소</button>
		</div>
		</div>
	  </div>
  </form>

<script type="text/javascript">
/**
 * 페이징 처리 공통 함수
 */
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
    $("#holiBdForm").submit();
});

function detailView(id){
	$.ajax({
		url : '/system/company/detail/'+id,
		dataType : 'json',
		type : "POST",
	    error: function(xhr, status, error){
	        console.log(error);
	    },
		success : function(data) {
			setView(data);
		}
	});
}

function setView(data){
	
	$('#edit .modal-title').text('상세');
	$('#edit input').attr('disabled',true);
	$('#edit textarea').attr('disabled',true);
	$('#edit select').attr('disabled',true);
	
	var companyNo1;
	var companyNo2;
	var companyNo3;
	var telephoneNo1;
	var telephoneNo2;
	var telephoneNo3;
	
	if(data.companyNo){
		companyNo1 = data.companyNo.split("-")[0];
		companyNo2 = data.companyNo.split("-")[1];
		companyNo3 = data.companyNo.split("-")[2];
	}
	if(data.telephoneNo){
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

function setEdit(){
	$('#edit .modal-title').text('수정');
	$('#edit input').attr('disabled',false);
	$('#edit textarea').attr('disabled',false);
	$('#edit select').attr('disabled',false);
	$('#companyId').attr('disabled',true);
	$('#companyCode').attr('readonly',true);
	$('.btnCheck').text('취소');
	$('.btnEdit').text('저장');
	$('.btnEdit').addClass('btnSave');
}

function resetView(){
	$('#edit .modal-title').text('상세');
	$('#edit input').attr('disabled',true);
	$('#edit textarea').attr('disabled',true);
	$('#edit select').attr('disabled',true);
	$('.btnCheck').text('확인');
	$('.btnEdit').text('수정');
	$('.btnEdit').removeClass('btnSave');
}

function regResetView(){
	$('#register input').val('');
	$('#register .codeSearch').removeClass('search-Success');
}

function deleteCompanyAction(){
	$('#tr_'+$('.delCompanyAction').val()).remove();
	param = {
			companyId : $('.delCompanyAction').val()
	}
// 	if(validation()){
		if(isDisabled){
			return false;
		}else{
			isDisabled = true;
			$.ajax({
				url : '/system/company/delete',
				dataType : 'text',
				type : "POST",
				data : param,
			    error: function(xhr, status, error){
			        console.log(error);
			    },
				success : function(result) {
					if(result == 'Delete'){
						location.href = '/system/company';
					}
				}
			});
		}
// 	}
}

function companySave(){
	$('#companyId').attr('disabled',false);
	$('#companyCode').attr('disabled',false);
	var param = $("#companyInst").serialize();
	callInsertAjax(param)
}

function companyInsert(){
	var has = $('#codeSearch').hasClass('search-Success');
	if(!has){
		alert('회사 코드 중복 학인이 필요합니다.');
		return false;
	}
	
	var companyNo = $('#reg_companyNo1').val()+"-"+$('#reg_companyNo2').val()+"-"+$('#reg_companyNo3').val();
	var telephoneNo = $('#reg_telephoneNo1').val()+"-"+$('#reg_telephoneNo2').val()+"-"+$('#reg_telephoneNo3').val();
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
	isDisabled = false;
	callInsertAjax(param);
}

function callInsertAjax(param){
// 	if(validation()){
		if(isDisabled){
			return false;
		}else{
			isDisabled = true;
			$.ajax({
			    type : 'post',
			    url : '/system/company/insert',
			    data : param,
			    dataType : 'text',
			    error: function(xhr, status, error){
			        console.log(error);
			    },
			    success : function(result){
			    	if(result == 'Update' || result == 'Insert'){
			    		location.href = '/system/company';
			    	}
			    }
			});
		}
// 	}
}

function codeSearch(){
	var codeSearch = $('#reg_companyCode').val();
	if(codeSearch){
		$('#re_reg_companyCode').val(codeSearch);
		if(isDisabled){
			return false;
		}else{
			searchCodeAction(codeSearch);
		}
	}else{
		$('#re_reg_companyCode').val('');
		$('.form-notice').text("확인이 필요합니다.");
		$('.form-notice').hide();
	}
}

function re_codeSearch(){
	var re_codeSearch = $('#re_reg_companyCode').val();
	if(re_codeSearch){
		if(isDisabled){
			return false;
		}else{
			searchCodeAction(re_codeSearch);
		}
	}
}

function codeCheckReset(){
	$('.form-notice').text("확인이 필요합니다.");
	$('.form-notice').hide();
	$('#re_reg_companyCode').val("");
}

function searchCodeAction(searchCode){
	isDisabled = true;
	$.ajax({
	    type : 'post',
	    url : '/system/company/popup',
	    data : {search:searchCode},
	    dataType : 'text',
	    error: function(xhr, status, error){
	        console.log(error);
	    },
	    success : function(result){
	    	if(result == 'none'){
	    		$('.form-notice').text("이미 사용중인 코드 입니다.");
	    		$('.form-notice').addClass("colorRed");
	    		$('#codeSearch').removeClass('search-Success');
	    	}else{
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
	if(event.key >= 0 && event.key <= 9) {
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
	if(searchKey){
		$('#searchKey').val('${pages.searchKey}');
	}
	
	$('.deleteBtnAction').click(function(){
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
	
	$('.btnEdit').click(function(){
		if($(this).hasClass('btnSave')){
			companySave();			
		}else{
			setEdit();
		}
	});
	
	$('#reg_companyCode').keyup(function(){
		var str = $('#reg_companyCode').val();
		str = str.replace(/[^a-zA-Z0-9]/gi,"").toUpperCase();
		$('#reg_companyCode').val(str);
	});
	
	$('#re_reg_companyCode').keyup(function(){
		var str = $('#re_reg_companyCode').val();
		str = str.replace(/[^a-zA-Z0-9]/gi,"").toUpperCase();
		$('#re_reg_companyCode').val(str);
	});

	$('.close').click(function(){
		resetView();
		regResetView();
	});
	
	$('.btn-cancel').click(function(){
		resetView();
		regResetView();
	});
	
	$('.btnCheck').click(function(){
		resetView();
	});
	
	$("#codeSearch").keyup(function(e) {
        if(e.keyCode == '13'){
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

	$('#re_codeSearch').click(function(){
		re_codeSearch();
	});
	
	$('.companyInsert').click(function(){
		if(validation()){
			companyInsert();
		}
	});
	
	$('.codeCheck').click(function(){
		codeCheckReset();
	});
	
	$('#saveMemberBtn').click(function(){
		saveMember();
	});
	
	$('.email').keyup(function(){
		setEmail();
	});
	
	$('.phone').keyup(function(){
		setPhoneNo();
	});
	
});

function validation(){
	if($('#reg_companyId').val() == ''){
		alert('회사 코드를 입력해 주세요..');
		return false;
	}
	if($('#reg_companyNm').val() == ''){
		alert('회사 이름을 입력해 주세요..');
		return false;
	}
// 	if($('#reg_representativeNm').val() == ''){
// 		alert('대표자을 입력해 주세요..');
// 		return false;
// 	}
// 	if($('#reg_address').val() == ''){
// 		alert('회사 주소를 입력해 주세요..');
// 		return false;
// 	}
// 	if($('#reg_companyNo1').val() == ''){
// 		alert('회사 사업자번호을 입력해 주세요..');
// 		return false;
// 	}
// 	if($('#reg_companyNo2').val() == ''){
// 		alert('회사 사업자번호을 입력해 주세요..');
// 		return false;
// 	}
// 	if($('#reg_companyNo3').val() == ''){
// 		alert('회사 사업자번호을 입력해 주세요..');
// 		return false;
// 	}
// 	if($('#reg_telephoneNo1').val() == ''){
// 		alert('회사 연락처를 입력해 주세요..');
// 		return false;
// 	}
// 	if($('#reg_telephoneNo2').val() == ''){
// 		alert('회사 연락처를 입력해 주세요..');
// 		return false;
// 	}
// 	if($('#reg_telephoneNo3').val() == ''){
// 		alert('회사 연락처를 입력해 주세요..');
// 		return false;
// 	}
	return true;
}

//회사 소속 사용자 정보 조회
function openMemberLayer(companyCode, companyNm, openLayer) {
	$("#frmInsert input[name=companyCode]").val(companyCode);
	$("#frmInsert input[name=companyNm]").val(companyNm);
	$.ajax({
		url : '/system/company/detail/'+companyCode+'/members',
		dataType : 'JSON',
		type : "GET",
		async : false,
		error : function(request, status, error) {
			console.log(request.responseText);
			alert(request.responseText);
		},
		success : function(data) {
			memberViewMake(data, openLayer);
		}
	});
}

function memberViewMake(data, openLayer){
	$('#memberTable').empty();
	var html = '';
	if (data.length > 0) {
		data.forEach(function(item, index) {
			html += '<tr>';
			html += '	<td>' + (data.length-index) + '</td>';
			html += '	<td>'+item.userId.split("@")[0]+'</td>';
			html += '	<td>'+item.userNm+'</td>';
			html += '	<td>'+item.authNm+'</td>';
			html += '	<td>'+item.rgstDt+'</td>';
			if(item.useYn === 'Y') {
				html += '	<td><button type="button" class="btn-yes">YES</button></td>';
			}else {
				if(item.lockYn === 'Y') {
					html += '	<td><button type="button" class="btn-no backColorRed">Lock</button></td>';
				}else {
					html += '	<td><button type="button" class="btn-no">NO</button></td>';
				}
			}
			html += '	<td>';
			html += '		<div class="btn-group">';
			html += '			<a href="javascript:updateMember(\'' + item.companyCode + '\',\'' + item.userId.split("@")[0] + '\');" role="button" data-toggle="modal">';
			html += '				<img src="/images/icon_edit.png" alt="수정" class="btn-table-icon02">';
			html += '			</a>';
			html += '			<a href="javascript:deleteMember(\'' + item.companyCode + '\',\'' + item.userId.split("@")[0] + '\');" role="button" data-toggle="modal">';
			html += '				<img src="/images/icon_delete2.png" alt="삭제하기" class="btn-table-icon02">';
			html += '			</a>';
			html += '		</div>';
			html += '	</td>';
			html += '</tr>';
		});
	}else {
		html += '<tr>';
		html += '<td colspan="7">등록된 정보가 없습니다.</td>';
		html += '</tr>';
	}

	$('#memberTable').append(html);
	
	if(openLayer)layerPopup($('#members'));
}

function updateMember(companyCode, userId) {
	$.ajax({
		url : '/system/company/detail/'+companyCode+'/members/'+userId,
		dataType : 'JSON',
		type : "GET",
		async : false,
		error : function(request, status, error) {
			console.log(request.responseText);
			alert(request.responseText);
		},
		success : function(data) {
			memberEditMake(data);
		}
	});
}

function memberEditMake(data){
	var phone1 = '';
	var phone2 = '';
	var phone3 = '';
	var email1 = '';
	var email2 = '';
	var companyCd = 'none';
	var authId = 'none';
	var useYn = 'N';
	var lockYn = 'N';
	var dtLimitYn = 'N';
	
	if(data.phone){
		phone1 = data.phone.split("-")[0];
		phone2 = data.phone.split("-")[1];
		phone3 = data.phone.split("-")[2];
	}
	
	if(data.email){
		email1 = data.email.split("@")[0];
		email2 = data.email.split("@")[1];
	}
	
	if(data.useYn != ''){
		useYn = data.useYn;
	}
	
	if(data.lockYn != ''){
		lockYn = data.lockYn;
	}
	
	if(data.dtLimitYn != ''){
		dtLimitYn = data.dtLimitYn;
	}
	
	if(data.companyCode){
		companyCd = data.companyCode;
	}
	
	if(data.authId){
		authId = data.authId;
	}
	
	$("#memberRgstDt").show();
	$("#memberModiDt").show();
	$("#frmInsert input[name=editModeYn]").val('Y');
	
	$("#memberRgstDt").show();
	$("#memberModiDt").show();
	$("#frmInsert input[name=editModeYn]").val('Y');
	$("#frmInsert input[name=rgstDt]").val(data.rgstDt);
	$("#frmInsert input[name=modiDt]").val(data.modiDt);
	$("#frmInsert input[name=userId]").val(data.userId.split("@")[0]);
	$("#frmInsert input[name=userNm]").val(data.userNm);
	$("#frmInsert input[name=companyCode]").val(data.companyCode);
	$("#frmInsert input[name=companyNm]").val(data.companyNm);
	$("#frmInsert input[name=authId]").val(data.authId);
	$("#frmInsert input[name=authNm]").val(data.authNm);
	$("#frmInsert input[name=email]").val(data.email);
	$("#frmInsert input[name=email1]").val(email1);
	$("#frmInsert input[name=email2]").val(email2);
	$("#frmInsert input[name=phone]").val(data.phone);
	$("#frmInsert input[name=phone1]").val(phone1);
	$("#frmInsert input[name=phone2]").val(phone2);
	$("#frmInsert input[name=phone3]").val(phone3);
	$("#frmInsert input[name=startDt]").val(data.startDt);
	$("#frmInsert input[name=endDt]").val(data.endDt);
	
	$("#use"+useYn).prop('checked',true);
	$("#lock"+lockYn).prop('checked',true);
	$("#dtLimit"+dtLimitYn).prop('checked',true);
	
	layerPopup($('#registerMember'));
}

function deleteMember(companyCode, userId) {
// 	var param = $("#companyInst").serialize();
	$.ajax({
		url : '/system/company/delete/'+companyCode+'/members',
		dataType : 'text',
		type : "POST",
		data : {'companyCode': companyCode, 'userId': userId},
	    error: function(xhr, status, error){
	        console.log(error);
	    },
		success : function(result) {
			if(result == 'Delete'){
				openMemberLayer(companyCode, $("#frmInsert input[name=companyNm]").val());
			}
		}
	});
}

function openMemberRegistLayer(){
	$("#memberRgstDt").hide();
	$("#memberModiDt").hide();
	$("#frmInsert input[name=editModeYn]").val('N');
	$('#lockY').val('Y');
	$('#lockN').val('N');
	$('#dtLimitY').val('Y');
	$('#dtLimitN').val('N');
	$('#useY').val('Y');
	$('#useN').val('N');
	$('#lockN').prop('checked',true);
	$('#dtLimitY').prop('checked',true);
	$('#useY').prop('checked',true);
	
	$("#frmInsert input[name=rgstDt]").val("");
	$("#frmInsert input[name=modiDt]").val("");
	$("#frmInsert input[name=userId]").val("");
	$("#frmInsert input[name=userNm]").val("");
	$("#frmInsert input[name=authId]").val('${userAuth}');
	$("#frmInsert input[name=authNm]").val('${userAuthNm}');
	$("#frmInsert input[name=email]").val("");
	$("#frmInsert input[name=email1]").val("");
	$("#frmInsert input[name=email2]").val("");
	$("#frmInsert input[name=phone1]").val("");
	$("#frmInsert input[name=phone2]").val("");
	$("#frmInsert input[name=phone3]").val("");
	$("#frmInsert input[name=startDt]").val("");
	$("#frmInsert input[name=endDt]").val("");
	layerPopup($('#registerMember'));
}

function setPhoneNo(){
	var phone = $('#frmInsert input[name=phone1]').val()+'-'+$('#frmInsert input[name=phone2]').val()+'-'+$('#frmInsert input[name=phone3]').val(); 
	$('#frmInsert input[name=phone]').val(phone);
}

function setEmail(){
	var email = $('#frmInsert input[name=email1]').val()+'@'+$('#frmInsert input[name=email2]').val(); 
	$('#frmInsert input[name=email]').val(email);
}

function setNumber(objValue){
	str = objValue.replace(/[^0-9]/gi,"").toUpperCase();
    return str;
}

function date_mask(objValue) {
	var v = objValue.replace("--", "-");
    if (v.match(/^\d{4}$/) !== null) {
        v = v + '-';
    } else if (v.match(/^\d{4}\-\d{2}$/) !== null) {
        v = v + '-';
    }
    return v;
}

function validation(){
	if($('#frmInsert input[name=userId]').val() == ''){
		alert('아이디를 입력해 주세요..');
		return false;
	}
	if($('#frmInsert input[name=userNm]').val() == ''){
		alert('이름을 입력해 주세요..');
		return false;
	}
	if($('#frmInsert input[name=email1]').val() == ''){
		alert('메일을 입력해 주세요..');
		return false;
	}
	if($('#frmInsert input[name=email2]').val() == ''){
		alert('메일을 입력해 주세요..');
		return false;
	}
	return true;
}

function saveMember() {
	var action = "update";
	var companyCode = $("#frmInsert input[name=companyCode]").val();
	if($("#frmInsert input[name=editModeYn]").val() === 'N') {
		var has = $('#idSearch').hasClass('search-Success');
// 		if(!has){
// 			alert('아이디 중복 학인이 필요합니다.');
// 			return false;
// 		}
		action = "insert";
	}
	
	if(validation()){
		isDisabled = true;
		
		$('#frmInsert input[name=userId]').attr('disabled',false);
		var param =  $('#frmInsert').serialize();
		insertMemberAjax(companyCode, param,action);
	}
}

function insertMemberAjax(companyCode, param, action){
	isDisabled = true;
	$.ajax({
	    type : 'post',
	    url : '/system/company/'+action+'/'+companyCode+'/members/',
	    data : param,
	    dataType : 'text',
	    error: function(xhr, status, error){
	        console.log(error);
	    },
	    success : function(result){
	    	if(result == 'Update' || result == 'Insert'){
	    		layerPopupClose($('#registerMember'));
	    		openMemberLayer(companyCode, $("#frmInsert input[name=companyNm]").val());
// 	    		location.href = '/member/member';
	    	}
	    }
	});
}
</script>