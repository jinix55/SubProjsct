<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="content">
	<!-- S_검색-->
	<form id="searchFrm">
		<div class="justify-content-between">
			<div class="form-group">
				<div class="form-inline">
					<select id="searchKey" name="searchKey" class="select-box w150">
						<option value="ALL">전체</option>
						<option value="supplierNm">공급업체명</option>
						<option value="supplierCode">공급업체코드</option>
					</select>
				</div>
				<div class="form-inline">
					<div class="search-box">
						<input id="searchVlaue" name="searchValue" type="text" class="text-input"> <span
							class="search-box-append">
							<button type="button" class="btn-search">
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
		<div class="scroll-auto">
			<table class="table table-actions">
				<colgroup>
					<col style="width: 30px;">
					<col style="width: 100px;">
					<col style="width: 180px;">
					<col style="width: 100px;">
					<col style="width: 80px;">
					<col style="width: 100px;">
					<col style="width: 90px;">
				</colgroup>
				<thead>
					<tr class="th-bg">
						<th></th>
						<th scope="col">공급업체 코드</th>
						<th scope="col">공급업체 명</th>
						<th scope="col">사업자번호</th>
						<th scope="col">대표자</th>
						<th scope="col">담당자 관리</th>
						<th scope="col">관리</th>
					</tr>
				</thead>

				<tbody>
					<c:choose>
						<c:when test="${not empty suppliers }">
							<c:forEach items="${suppliers }" var="list" varStatus="status">
								<tr>
									<th>${pages.totalCount - (status.index + (pages.page -1) * pages.pageSize)}</th>
									<td>${list.supplierCode}</td>
									<td>${list.supplierNm}</td>
									<td>${list.supplierNo}</td>
									<td>${list.representativeNm}</td>
									<td>
										<a href="javascript:void(0);" role="button" onclick="detailView('${list.supplierCode}', 'tabnav02');" data-toggle="modal" class="btn-icon text-point">
											<img src="/images/icon_user2.png">
										</a>
									</td>
									<td>
										<div class="btn-group">
											<a href="javascript:void(0);" role="button" data-toggle="modal"
												onclick="detailView('${list.supplierCode}', 'tabnav01');">
												<img src="/images/icon_edit.png" alt="상세보기" class="btn-table-icon">
											</a> <a href="#delete" role="button" data-toggle="modal"
												onclick="deleteSupSet('${list.supplierNm}','${list.supplierId}');"
												class="btn-icon"> <img src="/images/icon_delete2.png"
												alt="삭제하기" class="btn-table-icon02">
											</a>
										</div>
									</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="7">
									등록된 업체가 없습니다.
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>
	<!-- E_그리드-->
	<div class="btn-group pt15 tr">
		<button type="button" class="button btn-success" href="#register" data-toggle="modal">
			공급업체등록
			<!-- 			<a href="#register" data-toggle="modal">공급업체등록</a> -->
		</button>
	</div>
	<!-- S_페이징-->
	<div class="board-paging"></div>
	<!-- E_페이징-->
</div>

<!-- 레이어 팝업 - 등록 -->
<form id="frmRegister">
<div id="register" class="modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width: 910px">
		<div class="modal-header">
			<h4 class="modal-title">공급업체 등록</h4>
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
						<label class="col-25 form-label">업체 코드<em>*</em></label>
						<div class="col-75">
							<input id="supplierCode" name="supplierCode" type="text" placeholder="원하시는 업체코드를 입력해 주세요" class="text-input">
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">업체명<em>*</em></label>
						<div class="col-75">
							<input id="supplierNm" name="supplierNm" type="text" placeholder="업체명을 입력해 주세요" class="text-input">
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">대표자명<em>*</em></label>
						<div class="col-75">
							<input id="representativeNm" name="representativeNm" placeholder="업체 대표자 명을 입력해 주세요" type="text" class="text-input">
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">사업자번호</label>
						<div class="col-75">
							<div class="phone-number">
								<div class="pr16"><input id="supplierNo1" name="supplierNo1" type="text" class="text-input" placeholder="3자리" maxlength="3" onkeyup="this.value = setNumber(this.value)"></div>
							</div>
							<div class="phone-number">
								<div class="pr16"><input id="supplierNo2" name="supplierNo2" type="text" class="text-input" placeholder="2자리" maxlength="2" onkeyup="this.value = setNumber(this.value)"></div>
							</div>
							<div class="phone-number end">
								<div><input id="supplierNo3" name="supplierNo3" type="text" class="text-input" placeholder="5자리" maxlength="5" onkeyup="this.value = setNumber(this.value)"></div>
							</div>
							<input type="hidden" id="supplierNo" name="supplierNo" />
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">연락처</label>
						<div class="col-75">
							<div class="phone-number">
								<div class="pr16"><input id="telephoneNo1" name="telephoneNo1" type="text" class="text-input" placeholder="지역번호" maxlength="3" onkeyup="this.value = setNumber(this.value)"></div>
							</div>
							<div class="phone-number">
								<div class="pr16"><input id="telephoneNo2" name="telephoneNo2" type="text" class="text-input" placeholder="3~4자리" maxlength="4" onkeyup="this.value = setNumber(this.value)"></div>
							</div>
							<div class="phone-number end">
								<div><input id="telephoneNo3" name="telephoneNo3" type="text" class="text-input" placeholder="4자리" maxlength="4" onkeyup="this.value = setNumber(this.value)"></div>
							</div>
							<input type="hidden" id="telephoneNo" name="telephoneNo" />
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">사용여부</label>
						<div class="col-75">
							<select id="useYn" name="useYn" class="select-box">
								<option value="Y">YES</option>
								<option value="N">NO</option>
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
							<input id="address" name="address" type="text" placeholder="주소를 입력해 주세요" class="text-input">
						</div>
					</div>
					<div class="form-group">
						<label class="col-25 form-label-textarea">설명</label>
						<div class="col-75">
							<div class="form-input">
								<textarea id="supplierDsc" name="supplierDsc" class="textarea"></textarea>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">담당자 아이디</label>
						<div class="col-75">
							<div class="search-box">
								<input id="managementId" name="managementId" type="hidden" >
								<input id="managementIdDisplay" name="managementIdDisplay" type="text" class="text-input w-auto" placeholder="담당자 정보 검색해 주세요" disabled>
								<span class="">
									<button type="button" class="btn-search" id="userSearch" href="#overlap" data-toggle="modal">찾기
<!-- 										<a id="userSearchCheck" href="#overlap" role="button" data-toggle="modal">찾기</a> -->
									</button>
								</span>
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">담당자 성명</label>
						<div class="col-75">
							<div class="search-box">
								<input id="managementNm" name="managementNm" type="text" class="text-input w-auto" disabled>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 버튼 -->
		<div class="modal-footer btn-group">
			<button type="button" class="button btn-success" onclick="insertSupplier();" >저장</button>
		</div>
	</div>
</div>
</form>

<!-- 레이어 팝업 - 등록  -->
<form id="frmEdit">
	<div id="edit" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<input id="supplierId" name="supplierId" type="hidden" class="text-input">
		<div class="modal-content" style="width: 900px;">
			<div class="modal-header">
				<h4 class="modal-title">공급업체 상세</h4>
				<button type="button" class="close" data-dismiss="modal" onclick="javascript:layerPopupClose(edit);">
					<img src="/images/icon_close.png">
				</button>
			</div>
			<div class="modal-body">
				<div class="tab">
					<ul class="tabnav" style="display:none;">
						<li><a id="tabnav01" href="#tab01">기업정보</a></li>
						<li><a id="tabnav02" href="#tab02">담당자</a></li>
					</ul>
					<div class="tabcontent">
						<div id="tab01">
							<div class="row">
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label">등록일자</label>
										<div class="col-75">
											<input id="rgstDt" name="rgstDt" type="text"
												class="text-input">
										</div>
									</div>
								</div>
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label">수정일자</label>
										<div class="col-75">
											<input id="modiDt" name="modiDt" type="text"
												class="text-input">
										</div>
									</div>
								</div>
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label">업체코드</label>
										<div class="col-75">
											<input id="supplierCode" name="supplierCode" type="text"
												class="text-input">
										</div>
									</div>
								</div>
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label">사용여부</label>
										<div class="col-75">
											<select id="useYn" name="useYn" class="select-box">
												<option value="Y">YES</option>
												<option value="N">NO</option>
											</select>
										</div>
									</div>
								</div>
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label">공급업체</label>
										<div class="col-75">
											<input id="supplierNm" name="supplierNm" type="text"
												class="text-input">
										</div>
									</div>
								</div>
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label">대표자명</label>
										<div class="col-75">
											<input id="representativeNm" name="representativeNm"
												type="text" class="text-input">
										</div>
									</div>
								</div>
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label">사업자번호</label>
										<div class="col-75">
											<div class="phone-number">
												<div class="pr16"><input id="supplierNo1" name="supplierNo1" type="text" class="text-input" maxlength="3" onkeyup="this.value = setNumber(this.value)"></div>
											</div>
											<div class="phone-number">
												<div class="pr16"><input id="supplierNo2" name="supplierNo2" type="text" class="text-input" maxlength="2" onkeyup="this.value = setNumber(this.value)"></div>
											</div>
											<div class="phone-number end">
												<div><input id="supplierNo3" name="supplierNo3" type="text" class="text-input" maxlength="5" onkeyup="this.value = setNumber(this.value)"></div>
											</div>
											<input type="hidden" id="supplierNo" name="supplierNo" />
										</div>
									</div>
								</div>
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label">연락처</label>
										<div class="col-75">
											<div class="phone-number">
												<div class="pr16"><input id="telephoneNo1" name="telephoneNo1" type="text" class="text-input" maxlength="3" onkeyup="this.value = setNumber(this.value)"></div>
											</div>
											<div class="phone-number">
												<div class="pr16"><input id="telephoneNo2" name="telephoneNo2" type="text" class="text-input" maxlength="4" onkeyup="this.value = setNumber(this.value)"></div>
											</div>
											<div class="phone-number end">
												<div><input id="telephoneNo3" name="telephoneNo3" type="text" class="text-input" maxlength="4" onkeyup="this.value = setNumber(this.value)"></div>
											</div>
											<input type="hidden" id="telephoneNo" name="telephoneNo" />
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-100">
									<div class="form-group">
										<label class="col-25 form-label">주소</label>
										<div class="col-75">
											<input id="address" name="address" type="text"
												class="text-input">
										</div>
									</div>
									<div class="form-group">
										<label class="col-25 form-label-textarea">설명</label>
										<div class="col-75">
											<div class="form-input">
												<textarea id="supplierDsc" name="supplierDsc" class="textarea"></textarea>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label">담당자 아이디</label>
										<div class="col-75">
											<div class="search-box">
												<input id="managementId" name="managementId" type="hidden" >
												<input id="managementIdDisplay" name="managementIdDisplay" type="text" class="text-input w-auto" placeholder="담당자 정보 검색해 주세요" disabled>
												<span class="">
													<button type="button" class="btn-search" id="userSearch" href="#overlapMngmt" data-toggle="modal">찾기
				<!-- 										<a id="userSearchCheck" href="#overlap" role="button" data-toggle="modal">찾기</a> -->
													</button>
												</span>
											</div>
										</div>
									</div>
								</div>
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label">담당자 성명</label>
										<div class="col-75">
											<div class="search-box">
												<input id="managementNm" name="managementNm" type="text" class="text-input w-auto" disabled>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div id="tab02">
							<table class="table">
								<colgroup>
									<col style="width: 15%;">
<%-- 									<col style="width: 10%;"> --%>
<%-- 									<col style="width: 10%;"> --%>
									<col style="width: 20%;">
									<col style="width: 20%;">
									<col style="width: 5%;">
								</colgroup>
								<thead>
									<tr class="th-bg">
										<th scope="col">성명</th>
<!-- 										<th scope="col">부서</th> -->
<!-- 										<th scope="col">직위</th> -->
										<th scope="col">연락처</th>
										<th scope="col">메일</th>
										<th scope="col">관리</th>
									</tr>
								</thead>
								<tbody id="managerTable">
									<tr>
										<td colspan="4">등록된 담당자가 없습니다.</td>
									</tr>
								</tbody>
							</table>
							<div id="managerInfo" class="row pt30">
								<input id="managerId" name="managerId" type="hidden" class="text-input">
								<input id="maSupplierCode" name="maSupplierCode" type="hidden" class="text-input">
<!-- 								<div class="col-100 mb10"> -->
<!-- 									<input id="managerRepresent" name="managerRepresent" type="checkbox" style="margin: 0;"> -->
<!-- 									<label for="managerRepresent">대표 적용</label> -->
<!-- 								</div> -->
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label"><em>*</em>성명</label>
										<div class="col-75">
											<input id="managerNm" name="managerNm" type="text" class="text-input">
										</div>
									</div>
								</div>
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label"><em>*</em>휴대폰번호</label>
										<div class="col-75">
											<div class="phone-number">
												<div class="pr16"><input id="managerPhone1" name="managerPhone1" type="text" class="text-input" maxlength="3" onkeyup="this.value = setNumber(this.value)"></div>
											</div>
											<div class="phone-number">
												<div class="pr16"><input id="managerPhone2" name="managerPhone2" type="text" class="text-input" maxlength="4" onkeyup="this.value = setNumber(this.value)"></div>
											</div>
											<div class="phone-number end">
												<div><input id="managerPhone3" name="managerPhone3" type="text" class="text-input" maxlength="4" onkeyup="this.value = setNumber(this.value)"></div>
											</div>
											<input type="hidden" id="managerPhone" name="managerPhone" />
										</div>
									</div>
								</div>
<!-- 								<div class="col-50"> -->
<!-- 									<div class="form-group"> -->
<!-- 										<label class="col-25 form-label">부서</label> -->
<!-- 										<div class="col-75"> -->
<!-- 											<input id="managerDept" name="managerDept" type="text" -->
<!-- 												class="text-input"> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 								<div class="col-50"> -->
<!-- 									<div class="form-group"> -->
<!-- 										<label class="col-25 form-label">직위</label> -->
<!-- 										<div class="col-75"> -->
<!-- 											<input id="managerPstn" name="managerPstn" type="text" -->
<!-- 												class="text-input"> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 								</div> -->
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label"><em>*</em>이메일</label>
										<div class="col-75">
											<div class="form-input">
												<div class="email-add">
													<div class="pr28"><input id="managerMail1" name="managerMail1" type="text" class="text-input email"></div>
												</div>
												<div class="email-add">
													<div><input id="managerMail2" name="managerMail2" type="text" class="text-input email"></div>
												</div>
												<input type="hidden" id="managerMail" name="managerMail" />
											</div>
										</div>	
									</div>
								</div>
								<div class="col-50">
									<div class="form-group">
										<label class="col-25 form-label">사용여부</label>
										<div class="col-75">
											<select id="maUseYn" name="maUseYn" class="select-box">
												<option value="Y">YES</option>
												<option value="N">NO</option>
											</select>
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
				<button type="button" class="button btn-success edit" id="suppDetailBtn" >수정</button>
				<button type="button" class="button btn-cancel cancel" data-dismiss="modal" onclick="javascript:layerPopupClose(edit);">취소</button>
			</div>
		</div>
	</div>
</form>

<!-- 레이어 팝업 - delete -->
<form id="frmManager">
	<div id="delete" class="modal" data-backdrop-limit="1" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
		data-modal-parent="#myModal">
		<input type="hidden" name="delManagerId" id="delManagerId" /> <input
			type="hidden" name="delSupplierCode" id="delSupplierCode" /> <input
			type="hidden" name="delSupplierId" id="delSupplierId" />
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
								<em class="font-bold delName"></em> 삭제합니다.
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer btn-group">
				<button type="button" class="button btn-warning"
					onclick="deleteManager();" data-dismiss="modal">삭제</button>
				<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</form>

<!-- 레이어 팝업 - 담당자  -->
<div id="charge" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width: 720px">
		<div class="modal-header">
			<h4 class="modal-title">담당자 정보</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		
		<div class="modal-body">
			<div class="row">
			 <input id="pop_managerId" name="pop_managerId" type="hidden" class="text-input" disabled>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">성명</label>
						<div class="col-75">
							<div class="search-box">
								<input id="pop_managerNm" name="pop_managerNm" type="text" class="text-input w-auto" value="" disabled>
								<span class="overlapMngmt" style="display:none;">
									<button type="button" class="btn-search" id="userSearch" href="#overlapMngmt" data-toggle="modal">찾기</button>
								</span>
							</div>
						</div>
					</div>
				</div>
				
				<div class="col-50">
					<div class="form-group">
					<label class="col-25 form-label">휴대폰번호</label>
						<div class="col-75">
							<div class="phone-number">
								<div class="pr16"><input id="pop_managerPhone1" name="pop_managerPhone1" type="text" class="text-input" maxlength="3" onkeyup="this.value = setNumber(this.value)" disabled></div>
							</div>
							<div class="phone-number">
								<div class="pr16"><input id="pop_managerPhone2" name="pop_managerPhone2" type="text" class="text-input" maxlength="4" onkeyup="this.value = setNumber(this.value)" disabled></div>
							</div>
							<div class="phone-number end">
								<div><input id="pop_managerPhone3" name="pop_managerPhone3" type="text" class="text-input" maxlength="4" onkeyup="this.value = setNumber(this.value)" disabled></div>
							</div>
							<input id="pop_managerPhone" name="pop_managerPhone" type="hidden" class="text-input" value="010-123-4567">
						</div>
					</div>
				</div>
			
				<div class="col-100">
					<div class="form-group">
					<label class="col-25 form-label">이메일</label>				
						<div class="col-75">
							<div class="form-input">
								<div class="email-add">
									<div class="pr28"><input id="pop_managerMail1" name="pop_managerMail1" type="text" class="text-input email" disabled></div>
								</div>
								<div class="email-add">
									<div><input id="pop_managerMail2" name="pop_managerMail2" type="text" class="text-input email" disabled></div>
								</div>
								<input id="pop_managerMail" name="pop_managerMail" type="hidden" class="text-input" value="PPlueEc o@PlueEc.co.kr">
							</div>
						</div>		
					</div>
				</div>
				
				
			</div>
		</div>
	<!-- 버튼 -->
		<div class="modal-footer btn-group">
			<button type="button" class="button btn-success pop_btn pop_edit" >수정</button>
			<button type="button" class="button btn-success pop_cancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>

<!-- 레이어 팝업 담당 관리자 검색 -->
<div id="overlap" class="modal" data-backdrop-limit="1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-modal-parent="#myModal">
	<div class="modal-content" style="width: 600px">
		<div class="modal-header">
			<h4 class="modal-title">담당 관리자 조회</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-100">
					<div class="form-group">
						<label class="col-25 form-label">담당 관리자 명<em>*</em></label>
						<div class="col-75">
							<div class="search-box">
								<input id="chUserNm" name="chUserNm" type="text" class="text-input" placeholder="찾으실 이름을 입력해 주세요.">
								<span>
									<button id="reUserSearch1" name="reUserSearch1" type="button" class="btn-search">
										<img src="/images/icon_search.png" title="검색">
									</button>
								</span>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="scroll-auto h300auto">
				<table class="table">
					<colgroup>
						<col style="width: 20%;">
						<col style="width: 30%;">
						<col style="width: 30%;">
						<col style="width: 20%;">
					</colgroup>
					<thead>
						<tr class="th-bg">
							<th scope="col">성명</th>
							<th scope="col">연락처</th>
							<th scope="col">메일</th>
							<th scope="col">선택</th>
						</tr>
					</thead>
					<tbody id="managementTable1">
						<tr>
							<td colspan="4">검색된 담당자가 없습니다.</td>
						</tr>
					</tbody>
				</table>
			</div>
			
		</div>
		<!-- 버튼 -->
		<div class="modal-footer btn-group">
			<button type="button" class="button btn-success userCheck1" data-dismiss="modal">확인</button>
			<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>


<!-- 레이어 팝업 담당 관리자 검색 -->
<div id="overlapMngmt" class="modal" data-backdrop-limit="1" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
	data-modal-parent="#myModal">
	<div class="modal-content" style="width: 600px">
		<div class="modal-header">
			<h4 class="modal-title">담당 관리자 조회</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-100">
					<div class="form-group">
						<label class="col-25 form-label">사용자 명<em>*</em></label>
						<div class="col-75">
							<div class="search-box">
								<input id="reChUserNm" name="reChUserNm" type="text" class="text-input" placeholder="찾으실 담당자를 입력해 주세요.">
								<span>
									<button id="reUserSearch2" name="reUserSearch2" type="button" class="btn-search">
										<img src="/images/icon_search.png" title="검색">
									</button>
								</span>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="scroll-auto h300auto">
				<table class="table">
					<colgroup>
						<col style="width: 20%;">
						<col style="width: 30%;">
						<col style="width: 30%;">
						<col style="width: 20%;">
					</colgroup>
					<thead>
						<tr class="th-bg">
							<th scope="col">성명</th>
							<th scope="col">연락처</th>
							<th scope="col">메일</th>
							<th scope="col">선택</th>
						</tr>
					</thead>
					<tbody id="managementTable2">
						<tr>
							<td colspan="4">검색된 담당자가 없습니다.</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<!-- 버튼 -->
		<div class="modal-footer btn-group">
			<button type="button" class="button btn-success userCheck2" data-dismiss="modal">확인</button>
			<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>



<script type="text/javascript">
	/**
	 * 페이징 처리 공통 함수
	 */
	var totalPage = ${pages.totalPage};
	var page = ${pages.page};
	var pageSize = ${pages.pageSize};

	// 	var totalPage = 1;
	// 	var page = 2; 
	// 	var pageSize = 10;

	var setSupplierCode = '';
	var setManager = 'N';
	var setTab = 'S';
	var setManagerList;
	var managementData1;
	var managementData2;
	var setSelectManagerId;
	var setSelectSupplierCode;

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
	
	function userSearch(){
		var userSearch = $('#managementNm').val();
		if(userSearch){
			$('#chUserNm').val(userSearch);
			searchUserAction(userSearch);
		}else{
			$('#chUserNm').val('');
			$('.form-notice').text("찾으실 이름을 입력해 주세요.");
			$('.form-notice').hide();
		}
	}
	
	function reUserSearch(type){
		if(type == 1){
			var reUserSearch = $('#chUserNm').val();
		}else if(type == 2){
			var reUserSearch = $('#reChUserNm').val();
		}
		if(reUserSearch){
			searchUserAction(reUserSearch,type);
		}
	}
	
	function searchUserAction(nameSearch,type){
		$.ajax({
		    type : 'post',
		    url : '/supplier/supplier/detail/popup/'+nameSearch,
		    data : {memberId:nameSearch},
		    dataType : 'JSON',
		    error: function(xhr, status, error){
		        console.log(error);
		    },
		    success : function(result){
	    		managementTableMake(result,type);
		    }
		});
	}
	
	function managementTableMake(data,type){
		$('#managementTable'+type).empty();
		if(type == 1){
			managementData1 = data;	
		}else if(type == 2){
			managementData2 = data;
		}
		
		var html = '';
		if (data.length > 0) {
			data.forEach(function(item, index) {
				html += '<tr >';
				html += '	<td class="text-point">'+ item.userNm +'</td>';
				html += '	<td>' + item.phone + '</td>';
				html += '	<td>' + item.email + '</td>';
				html += '	<td>';
				html += '		<div class="btn-group">';
				html += '			<input type="radio" name="userCheck'+type+'" value="'+index+'">';
				html += '		</div>';
				html += '	</td>';
				html += '</tr>';
			});
		} else {
			html += '<tr>';
			html += '	<td colspan="4">검색된 담당 관리자가 없습니다.</td>';
			html += '</tr>';
		}
		$('#managementTable'+type).append(html);
	}

	function insertSupplier(){
		if(validation('register')){
			if (isDisabled) {
				return false;
			} else {
				isDisabled = true;
				
				var supplierNo = $('#register #supplierNo1').val()+'-'+$('#register #supplierNo2').val()+'-'+$('#register #supplierNo3').val();
				var telephoneNo = $('#register #telephoneNo1').val()+'-'+$('#register #telephoneNo2').val()+'-'+$('#register #telephoneNo3').val();
				$('#register #supplierNo').val(supplierNo);
				$('#register #telephoneNo').val(telephoneNo);
				
// 				var managementPhone = $('#register #managementPhone1').val()+'-'+$('#register #managementPhone2').val()+'-'+$('#register #managementPhone3').val();
// 				var managementMail = $('#register #managementMail1').val()+'@'+$('#register #managementMail2').val();
// 				$('#register #managementPhone').val(managementPhone);
// 				$('#register #managementMail').val(managementMail);
				
// 				var managerPhone = $('#register #managerPhone1').val()+'-'+$('#register #managerPhone2').val()+'-'+$('#register #managerPhone3').val();
// 				var managerMail = $('#register #managerMail1').val()+'@'+$('#register #managerMail2').val();
// 				$('#register #managerPhone').val(managerPhone);
// 				$('#register #managerMail').val(managerMail);
				
// 				if($('#register #managerRepresent').is(':checked')){
// 					$('#register #managerRepresent').val('Y');
// 				}else{
// 					$('#register #managerRepresent').val('');
// 				}
				var param = $('#frmRegister').serialize();
				insertSupplierAjax(param, 'insert');
			}
		}
	}
	
	function insertSupplierAjax(param, action) {
		$.ajax({
			url : '/supplier/supplier/' + action,
			dataType : 'TEXT',
			type : "POST",
			data : param,
			error : function(xhr, status, error) {
				console.log(error);
			},
			success : function(result) {
				isDisabled = false;
				if (result == 'Insert' || result == 'Update') {
					location.href = '/supplier/supplier';
				}
			}
		});
	}
	
	function setNumber(objValue){
		str = objValue.replace(/[^0-9]/gi,"").toUpperCase();
	    return str;
	}

	/*공급 업체 삭제를 눌렀을때*/
	function deleteSupSet(nm, Id) {
		$('.delName').text(nm);
		$('#delSupplierId').val(Id);
		$('#delManagerId').val('');
	}

	/*담당자 삭제를 눌렀을때*/
	function deleteSet(nm, Id) {
		$('.delName').text(nm);
		$('#delManagerId').val(Id);
		$('#delSupplierCode').val(setSupplierCode);
	}

	function deleteManager() {
		if ($('#delManagerId').val() == '') {
			if (isDisabled) {
				return false;
			} else {
				isDisabled = true;
				var param = $('#frmManager').serialize();
				deleteSupplierAjax(param, 'delete/supplier');
			}
		} else {
			if (isDisabled) {
				return false;
			} else {
				isDisabled = true;
				var param = $('#frmManager').serialize();
				deleteManagerAjax(param, 'delete/manager');
			}
		}
	}

	function deleteSupplierAjax(param, action) {
		$.ajax({
			url : '/supplier/supplier/' + action,
			dataType : 'TEXT',
			type : "POST",
			data : param,
			error : function(xhr, status, error) {
				console.log(error);
			},
			success : function(result) {
				isDisabled = false;
				if (result == 'Delete') {
					location.href = '/supplier/supplier';
				}
			}
		});
	}

	function deleteManagerAjax(param, action) {
		$.ajax({
			url : '/supplier/supplier/' + action,
			dataType : 'JSON',
			type : "POST",
			data : param,
			error : function(xhr, status, error) {
				console.log(error);
			},
			success : function(data) {
				isDisabled = false;
				managersViewMake(data);
			}
		});
	}

	// 대표매니저 검색
	function selectManager(id,code) {
		setSelectManagerId = id;
		setSelectSupplierCode = code;
		if (isDisabled) {
			return false;
		} else {
			isDisabled = true;
			$.ajax({
				url : '/supplier/supplier/detail/manager/' + id,
				dataType : 'JSON',
				type : "POST",
				error : function(xhr, status, error) {
					console.log(error);
				},
				success : function(data) {
					managerDetailView(data);
				}
			});
		}
	}

	function managerDetailView(data) {
		$('#pop_managerId').val(data.userId);
		$('#pop_managerNm').val(data.userNm);
		if(data.phone){
			$('#pop_managerPhone1').val(data.phone.split('-')[0]);
			$('#pop_managerPhone2').val(data.phone.split('-')[1]);
			$('#pop_managerPhone3').val(data.phone.split('-')[2]);
			$('#pop_managerPhone').val(data.phone);
		}
		if(data.email){
			$('#pop_managerMail1').val(data.email.split('@')[0]);
			$('#pop_managerMail2').val(data.email.split('@')[1]);
			$('#pop_managerMail').val(data.email);
		}
// 		$('#pop_managerDept').val(data.deptNm);
// 		$('#pop_managerPstn').val(data.pstnNm);
		isDisabled = false;
	}

	function detailView(id, tabId) {
		setSupplierCode = id;
		if(tabId === 'tabnav02'){
			managersView(id, tabId);
		}else {
			$.ajax({
				url : '/supplier/supplier/detail/' + id,
				dataType : 'JSON',
				type : "POST",
				error : function(xhr, status, error) {
					console.log(error);
				},
				success : function(data) {
					detailViewMake(data, tabId);
					isDisabled = false;
				}
			});
		}
	}

	function detailViewMake(data, tabId) {
		$('#edit input').attr('disabled', true);
		$('#edit select').attr('disabled', true);
		$('#edit textarea').attr('disabled', true);
		setSupplierCode = data.supplierCode;
		$('#edit #supplierId').val(data.supplierId);
		$('#edit #supplierCode').val(data.supplierCode);
		
		if(data.supplierNo) {
			var supplierNo = data.supplierNo.split('-');
			var supplierNo1 = supplierNo[0];
			var supplierNo2 = supplierNo[1];
			var supplierNo3 = supplierNo[2];
			$('#edit #supplierNo').val(data.supplierNo);
			$('#edit #supplierNo1').val(supplierNo1);
			$('#edit #supplierNo2').val(supplierNo2);
			$('#edit #supplierNo3').val(supplierNo3);
		}
		$('#edit #supplierNm').val(data.supplierNm);
		$('#edit #supplierDsc').val(data.supplierDsc);
		$('#edit #address').val(data.address);
		if(data.telephoneNo) {
			$('#edit #telephoneNo').val(data.telephoneNo);
			var telephoneNo = data.telephoneNo.split('-');
			var telephoneNo1 = telephoneNo[0];
			var telephoneNo2 = telephoneNo[1];
			var telephoneNo3 = telephoneNo[2];
			$('#edit #telephoneNo1').val(telephoneNo1);
			$('#edit #telephoneNo2').val(telephoneNo2);
			$('#edit #telephoneNo3').val(telephoneNo2);
		}
		if(data.representativeNm == 'Y'){
			$('#edit #managerRepresent').prop('checked',true);
		}else{
			$('#edit #managerRepresent').prop('checked',false);
		}
		$('#edit #representativeNm').val(data.representativeNm);
		$('#edit #managementId').val(data.managementId);
		$('#edit #managementIdDisplay').val(data.managementId.split("@")[0]);
		$('#edit #managementNm').val(data.managementNm);
		$('#edit #note').val(data.note);
		$('#edit #useYn').val(data.useYn);
		$('#edit #rgstDt').val(data.rgstDt);
		$('#edit #modiDt').val(data.modiDt);
		
		$('#'+tabId).click();
		$('#edit .modal-title').text('공급업체 상세');
		layerPopup($('#edit'));
	}

	// 담당자 검색
	function managersView(id, tabId) {
		setManager = 'Y';
		if (isDisabled) {
			return false;
		} else {
			isDisabled = true;
			$.ajax({
				url : '/supplier/supplier/detail/managers/' + id,
				dataType : 'JSON',
				type : "POST",
				error : function(xhr, status, error) {
					console.log(error);
				},
				success : function(data) {
					managersViewMake(data, tabId);
					isDisabled = false;
				}
			});
		}
	}
	
	function setManagerView(index){
		$('#edit input').attr('disabled', true);
		$('#edit select').attr('disabled', true);
		$('#edit textarea').attr('disabled', true);
		if(setManagerList[index].managerRepresent == 'Y'){
			$('#managerInfo #managerRepresent').prop('checked',true);
			$('#managerInfo #managerRepresent').val('Y');
		}else{
			$('#managerInfo #managerRepresent').prop('checked',false);
			$('#managerInfo #managerRepresent').val('N');
		}
		$('#managerInfo #maSupplierCode').val(setManagerList[index].supplierCode);
		$('#managerInfo #managerDept').val(setManagerList[index].managerDept);
		$('#managerInfo #managerDept').val(setManagerList[index].managerDept);
		$('#managerInfo #managerPstn').val(setManagerList[index].managerPstn);
		$('#managerInfo #managerPhone1').val(setManagerList[index].managerPhone.split('-')[0]);
		$('#managerInfo #managerPhone2').val(setManagerList[index].managerPhone.split('-')[1]);
		$('#managerInfo #managerPhone3').val(setManagerList[index].managerPhone.split('-')[2]);
		$('#managerInfo #managerPhone').val(setManagerList[index].managerPhone);
		$('#managerInfo #managerMail1').val(setManagerList[index].managerMail.split('@')[0]);
		$('#managerInfo #managerMail2').val(setManagerList[index].managerMail.split('@')[1]);
		$('#managerInfo #managerMail').val(setManagerList[index].managerMail);
		$('#managerInfo #managerNm').val(setManagerList[index].managerNm);
		$('#managerInfo #managerId').val(setManagerList[index].managerId);
		$('#managerInfo #maUseYn').val(setManagerList[index].useYn);
		
		$('#edit .btn-success').text('수정');
		$('#edit .btn-success').addClass('edit');
		$('#edit .btn-success').removeClass('save');
		
	}

	function managersViewMake(data, tabId) {
		setManagerList = data
		$('#managerTable').empty();
		var html = '';
		if (data.length > 0) {
			data.forEach(function(item, index) {
				html += '<tr >';
				html += '	<td class="text-point" thisData="'+item+'"  onclick="setManagerView(\''+index+'\');">' + item.managerNm + '</td>';
// 				html += '	<td>' + item.managerDept + '</td>';
// 				html += '	<td>' + item.managerPstn + '</td>';
				html += '	<td>' + item.managerPhone + '</td>';
				html += '	<td>' + item.managerMail + '</td>';
				html += '	<td>';
				html += '		<div class="btn-group">';
				html += '			<a href="#delete" role="button" data-toggle="modal">';
				html += '				<img src="/images/icon_delete2.png" onclick="deleteSet(\'' + item.managerNm + '\',\'' + item.managerId + '\');" alt="삭제하기" class="btn-table-icon02">';
				html += '			</a>';
				html += '		</div>';
				html += '	</td>';
				html += '</tr>';
			});
		} else {
			html += '<tr>';
			html += '	<td colspan="4">등록된 담당자가 없습니다.</td>';
			html += '</tr>';
		}
		$('#managerTable').append(html);
		$('#'+tabId).click();
		$('#edit .modal-title').text('공급업체 담당자');
		layerPopup($('#edit'));
	}
	
	function resetInput1(){
		$('#tab01 input').attr('disabled', false);
		$('#tab01 select').attr('disabled', false);
		$('#tab01 textarea').attr('disabled', false);
		$('#tab01 #rgstDt').attr('disabled', true);
		$('#tab01 #modiDt').attr('disabled', true);
		$('#tab01 #supplierCode').attr('disabled', true);
		$('#edit #managementIdDisplay').attr('disabled', true);
		$('#edit #managementNm').attr('disabled', true);
		$('#edit .btn-success').text('저장');
		$('#edit .btn-success').removeClass('edit');
		$('#edit .btn-success').addClass('save');
	}
	
	function resetInput2(){
		$('#tab02 input').attr('disabled', false);
		$('#tab02 select').attr('disabled', false);
		$('#tab02 textarea').attr('disabled', false);
		$('#tab02 input').val('');
		$('#tab02 #maUseYn').val('Y');
		$('#edit .btn-success').text('저장');
		$('#tab02 #managerRepresent').prop('checked',false);
		$('#edit .btn-success').removeClass('edit');
		$('#edit .btn-success').addClass('save');
	}
	
	function editInput(){
		$('#tab02 input').attr('disabled', false);
		$('#tab02 select').attr('disabled', false);
		$('#tab02 textarea').attr('disabled', false);
		$('#edit .btn-success').text('저장');
		$('#edit .btn-success').removeClass('edit');
		$('#edit .btn-success').addClass('save');
		
		$('#edit #managementIdDisplay').prop('disabled', true);
		$('#edit #managementNm').prop('disabled', true);
	}
	
	function saveSupplier(){
		if(validation('edit')){
			if (isDisabled) {
				return false;
			} else {
				isDisabled = true;
				var supplierNo = $('#edit #supplierNo1').val()+'-'+$('#edit #supplierNo2').val()+'-'+$('#edit #supplierNo3').val();
				var telephoneNo = $('#edit #telephoneNo1').val()+'-'+$('#edit #telephoneNo2').val()+'-'+$('#edit #telephoneNo3').val();
				$('#edit #supplierNo').val(supplierNo);
				$('#edit #telephoneNo').val(telephoneNo);
				$('#edit #supplierCode').prop('disabled',false);
				$('#edit #supplierId').prop('disabled',false);
				var param = $('#frmEdit').serialize();
				var dataType = 'TEXT'
				saveSupplierAjax(param, 'insert/supplier', dataType);
			}
		}
	}
	
	function saveManager(){
		if(validationManager('edit')){
			if (isDisabled) {
				return false;
			} else {
				isDisabled = true;
				var managerPhone = $('#edit #managerPhone1').val()+'-'+$('#edit #managerPhone2').val()+'-'+$('#edit #managerPhone3').val();
				var managerMail = $('#edit #managerMail1').val()+'@'+$('#edit #managerMail2').val();
				$('#edit #managerPhone').val(managerPhone);
				$('#edit #managerMail').val(managerMail);
				if($('#edit #managerRepresent').is(':checked')){
					$('#edit #managerRepresent').val('Y');
				}else{
					$('#edit #managerRepresent').val('');
				}
				$('#managerId').prop('disabled',false);
				$('#maSupplierCode').val(setSupplierCode);
				var param = $('#frmEdit').serialize();
				var dataType = 'JSON'; 
				var action = 'update/manager';
				if($('#managerInfo #managerId').val() == '' || $('#managerInfo #managerId').val() == undefined){
					action = 'insert/manager'
				}
				saveSupplierAjax(param, action, dataType);
			}
		}
	}
	
	function saveSupplierAjax(param, action, dataType) {
		$.ajax({
			url : '/supplier/supplier/' + action,
			dataType : dataType,
			type : "POST",
			data : param,
			error : function(xhr, status, error) {
				console.log(error);
			},
			success : function(result) {
				isDisabled = false;
				if(setTab == 'M'){
					managersViewMake(result);
					resetInput2();
				}else{
					if (result == 'Insert' || result == 'Update') {
						location.href = '/supplier/supplier';
					}
				}
			}
		});
	}

	$(document).ready(function() {
		var searchKey = '${pages.searchKey}';
		if (searchKey) {
			$('#searchKey').val('${pages.searchKey}');
		}

		$('#supplierCode').keyup(function() {
			var str = $('#supplierCode').val();
			str = str.replace(/[^a-zA-Z0-9]/gi, "").toUpperCase();
			$('#supplierCode').val(str);
		});

		$('#chUserNm').keyup(function(e) {
	        if(e.keyCode == '13'){
	        	reUserSearch(1);
	        }
		});
		
		
		$('#reChUserNm').keyup(function(e){
	        if(e.keyCode == '13'){
	        	reUserSearch(2);
	        }
		});

		$('#tabnav01').click(function() {
			setTab = 'S';
			$('#edit .btn-success.edit').text('수정');
		});

		$('#tabnav02').click(function() {
			setTab = 'M';
			if (setManager == 'N') {
				managersView(setSupplierCode);
			}
			resetInput2();
		});
		
		$('#suppDetailBtn').click(function() {
			if($('#suppDetailBtn').hasClass('edit')){
				if(setTab == 'S'){
					resetInput1();
				}else{
					editInput();
				}
			}else{
				if(setTab == 'S'){
					saveSupplier();
				}
				if(setTab == 'M'){
					saveManager();
				}
			}
			
		});

		$('#edit .close, #edit .btn-cancel').click(function() {
			setSupplierCode = '';
			setManager = 'N';
			setTab = 'S';
			$('.active').removeClass('active');
			$('#tab02').css('display', 'none');
			$('#tab01').css('display', 'block');
			$('#tabnav01').addClass('active');
			$('#edit #supplierId').val('');
			$('#edit #supplierCode').val('');
			$('#edit #supplierNo').val('');
			$('#edit #supplierNo1').val('');
			$('#edit #supplierNo2').val('');
			$('#edit #supplierNo3').val('');
			$('#edit #supplierNm').val('');
			$('#edit #note').val('');
			$('#edit #address').val('');
			$('#edit #telephoneNo').val('');
			$('#edit #telephoneNo1').val('');
			$('#edit #telephoneNo2').val('');
			$('#edit #telephoneNo3').val('');
			$('#edit #representativeNm').val('');
			$('#edit #note').val('');
			$('#edit #useYn').val('');
			$('#edit #rgstDt').val('');
			$('#edit #modiDt').val('');
			$('#edit .btn-success').text('수정');
			$('#edit .btn-success').removeClass('save');
			$('#edit .btn-success').addClass('edit');
			$('#managerInfo #managerId').val('');
		});
		
		$('.search-box-append').click(function(){
			if(isDisabled){
				return false;
			}else{
				isDisabled = true;
				$('#searchFrm').submit();
			}
		});
		
		$("#userSearch").click(function(e) {
        	userSearch();
	    });
		
		$('#reUserSearch1').click(function(){
			reUserSearch(1);
		});
		$('#reUserSearch2').click(function(){
			reUserSearch(2);
		});
		
		$('.userCheck1').click(function(){
			setManagerment(1);
		});
		
		$('.userCheck2').click(function(){
			setManagerment(2);
		});
		
		$('.pop_cancel').click(function(){
			popResetInput();
		});
		
		$('.pop_btn').click(function(){
			if($('.pop_btn').hasClass('pop_edit')){
				$('.pop_edit').text('저장');
				$('.pop_edit').addClass('pop_save');
				$('.pop_edit').removeClass('pop_edit');
				$('.overlapMngmt').show();
			}else if($('.pop_btn').hasClass('pop_save')){
				if(setSelectManagerId != $('#pop_managerId').val()){
					if(confirm('책임자를 변경하시겠습니까?')){
						$('.pop_save').text('수정');
						$('.pop_save').addClass('pop_edit');
						$('.pop_save').removeClass('pop_save');
						$('.overlapMngmt').hide();
						if(isDisabled){
							return false;
						}else{
							isDisabled = true;
							updateManager($('#pop_managerId').val());
						}
					}
				}else{
					$('.pop_save').text('수정');
					$('.pop_save').addClass('pop_edit');
					$('.pop_save').removeClass('pop_save');
					$('.overlapMngmt').hide();
				}
			}
		});
	});
	
	function updateManager(id){
		var param = {
				supplierCode : setSelectSupplierCode
		}
		$.ajax({
			url : '/supplier/supplier/update/manager/' + id,
			dataType : 'TEXT',
			type : "POST",
			data : param,
			error : function(xhr, status, error) {
				console.log(error);
			},
			success : function(result) {
				isDisabled = false;
				if(result == 'Update'){
					location.href = '/supplier/supplier';
				}
			}
		});
	}
	
	function popResetInput(){
		$('.overlapMngmt').hide();
		$('#charge input').val('');
		$('.pop_btn').addClass('pop_edit');
		$('.pop_btn').removeClass('pop_save');
		$('.pop_btn').text('수정');
	}

	function setManagerment(type){
		var data = "";
		if(type == 1){
			data = managementData1[$("input[name='userCheck"+type+"']:checked").val()];
			$('#managementId').val(data.userId);
			$('#managementIdDisplay').val(data.userId.split("@")[0]);
			$('#managementNm').val(data.userNm);
// 			$('#managementCompanyNm').val(data.companyNm);
// 			$('#managementPhone1').val(data.phone.split('-')[0]);
// 			$('#managementPhone2').val(data.phone.split('-')[1]);
// 			$('#managementPhone3').val(data.phone.split('-')[2]);
// 			$('#managementPhone').val(data.phone);
// 			$('#managementMail1').val(data.email.split('@')[0]);
// 			$('#managementMail2').val(data.email.split('@')[1]);
// 			$('#managementMail').val(data.email);
// 			$('#managementDept').val(data.deptNm);
// 			$('#managementPstn').val(data.pstn);
			isDisabled = false;
		}else if(type == 2){
			data = managementData2[$("input[name='userCheck"+type+"']:checked").val()];
			$('#edit #managementId').val(data.userId);
			$('#edit #managementIdDisplay').val(data.userId.split("@")[0]);
			$('#edit #managementNm').val(data.userNm);
// 			managerDetailView(data);
		}
	}
	
	function validation(type){
		if ($('#'+type+' #supplierCode').val() == '') {
			alert('공급업체 코드를 입력해 주세요.');
			return false;
		}
		if ($('#'+type+' #supplierNm').val() == '') {
			alert('공급업체 이름을 입력해 주세요.');
			return false;
		}
		if ($('#'+type+' #representativeNm').val() == '') {
			alert('대표자을 입력해 주세요.');
			return false;
		}
// 		if ($('#'+type+' #address').val() == '') {
// 			alert('회사 주소를 입력해 주세요.');
// 			return false;
// 		}
// 		if ($('#'+type+' #supplierNo1').val() == '') {
// 			alert('공급업체 사업자번호을 입력해 주세요.');
// 			return false;
// 		}
// 		if ($('#'+type+' #supplierNo2').val() == '') {
// 			alert('공급업체 사업자번호을 입력해 주세요.');
// 			return false;
// 		}
// 		if ($('#'+type+' #supplierNo3').val() == '') {
// 			alert('공급업체 사업자번호을 입력해 주세요.');
// 			return false;
// 		}
// 		if ($('#'+type+' #telephoneNo1').val() == '') {
// 			alert('공급업체 연락처를 입력해 주세요.');
// 			return false;
// 		}
// 		if ($('#'+type+' #telephoneNo2').val() == '') {
// 			alert('공급업체 연락처를 입력해 주세요.');
// 			return false;
// 		}
// 		if ($('#'+type+' #telephoneNo3').val() == '') {
// 			alert('공급업체 연락처를 입력해 주세요.');
// 			return false;
// 		}
		if(type == 'register'){
// 			if($('#managementNm').val() == ''){
// 				alert('담당 관리자를 선택해 주세요.');
// 				return false;
// 			}
// 			if ($('#'+type+' #managerNm').val() == '') {
// 				alert('담당자 이름를 입력해 주세요.');
// 				return false;
// 			}
// 			if ($('#'+type+' #managerPhone1').val() == '') {
// 				alert('담당자 연락처를 입력해 주세요.');
// 				return false;
// 			}
// 			if ($('#'+type+' #managerPhone2').val() == '') {
// 				alert('담당자 연락처를 입력해 주세요.');
// 				return false;
// 			}
// 			if ($('#'+type+' #managerPhone3').val() == '') {
// 				alert('담당자 연락처를 입력해 주세요.');
// 				return false;
// 			}
// 			if ($('#'+type+' #managerMail1').val() == '') {
// 				alert('담당자 메일을 입력해 주세요.');
// 				return false;
// 			}
// 			if ($('#'+type+' #managerMail2').val() == '') {
// 				alert('담당자 메일을 입력해 주세요.');
// 				return false;
// 			}
		}
		return true;
	}
	
	function validationManager(type){
		if ($('#'+type+' #managerNm').val() == '') {
			alert('담당자 이름를 입력해 주세요.');
			return false;
		}
		if ($('#'+type+' #managerPhone1').val() == '') {
			alert('담당자 연락처를 입력해 주세요.');
			return false;
		}
		if ($('#'+type+' #managerPhone2').val() == '') {
			alert('담당자 연락처를 입력해 주세요.');
			return false;
		}
		if ($('#'+type+' #managerPhone3').val() == '') {
			alert('담당자 연락처를 입력해 주세요.');
			return false;
		}
		if ($('#'+type+' #managerMail1').val() == '') {
			alert('담당자 메일을 입력해 주세요.');
			return false;
		}
		if ($('#'+type+' #managerMail2').val() == '') {
			alert('담당자 메일을 입력해 주세요.');
			return false;
		}
		
		var exp = '@'; 
		if($('#'+type+' #managerMail1').val().match(exp) != null){
			$('#'+type+' #managerMail1').val($('#'+type+' #managerMail1').val().replace('@',''));
        }
		if($('#'+type+' #managerMail2').val().match(exp) != null){
			$('#'+type+' #managerMail2').val($('#'+type+' #managerMail2').val().replace('@',''));
        }
		
		return true;
	}
</script>