<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
  $(document).ready(function () {
    $(".dropdown-notification").on("click", function () {
      $('.dropdown-no-content').toggle();
    });
    $(function () {
      var group = $("#Accordion_wrap");
      group.each(function () {
        var _group = new GroupBox(this);
      });
      // 사용자 정의 생성자 함수 정의
      function GroupBox(groupElement) {
        var box = $(groupElement).find(".Accordion-box");
        var title = $(groupElement).find(".Accordion-box .que span");
        box.each(function (idx) {
          var newBox = new RootBox(this);
          if (idx > 0) {
            newBox.siblingsClose();
          }
        });
      }
      // 사용자 정의 생성자 함수 정의
      function RootBox(boxElement) {
        var _this = this;
        var boxEl = $(boxElement);
        var target = $(boxEl).find(".que span");
        var cont = $(boxEl).find(".anw");
        // _groupParent = $(boxEl).parent();
        target.on("click", anchorClickEvent);

        function anchorClickEvent() {
          if (cont.is(':hidden')) {
            _this.open();
          } else {
            _this.close();
          }
        }
        _this.siblingsClose = function () {
          cont.css('display', 'none');
        };
        _this.open = function () {
          cont.slideDown();
        };
        _this.close = function () {
          cont.slideUp();
        }
      }
    });
  });
</script>
		<div class="content">
          <!-- S_검색-->
          <form  id="searchFrm" action="/product/prodList" method="POST">
            <input type="hidden" id="page" name="page" value="${pages.page}">
			<div class="justify-content-between">
              <div class="form-group">
                <div class="form-inline">
                  <select id="searchKey" name="searchKey" class="select-box w150">
                    <option value="ALL">전체</option>
					<option value="productNm">상품명</option>
					<option value="matTypeNm">포장유형</option>
					<option value="selfEvlGradNm">재활용등급</option>
					<option value="masterApplyNm">상태</option>
                  </select>
                </div>
                <div class="form-inline">
                  <div class="search-box w250">
                    <input id="searchValue" name="searchValue" value="${pages.searchValue}" type="text" class="text-input">
                    <span class="search-box-append">
                      <button type="button" class="btn-search">
						<img class="searchBtn" src="/images/icon_search.png" title="검색">
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
              <table class="table">
                <colgroup>
                  <col style="width: 40px;">
                  <col style="width: 80px;">
                  <col style="width: 80px;">
                  <col style="width: 100px;">
                  <col style="width: 100px;">
                  <col style="width: 50px;">
                  <col style="width: 50px;">
                  <col style="width: 50px;">
                  <col style="width: 60px;">
                  <col style="width: 60px;">
                  <!-- <col style="width: 40px;"> -->
                  <col style="width: 40px;">
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
                    <th scope="col">포장정보</th>
                    <th scope="col">자가진단</th>
                    <th scope="col">재활용<br>분담금결과</th>
                    <!-- <th scope="col">육안판정</th> -->
                    <th scope="col">관리</th>
                </thead>
                <tbody>
                  <c:choose>
				    <c:when test="${products.size() > 0 }">
						<c:forEach items="${products}" var="product" varStatus="status">
							<tr>
								<td>${pages.totalCount - (status.index + (pages.page -1) * pages.pageSize)}</td>
								<td><input type="text" style="border:none" id="productCode_${product.rownum}" value="${product.productCode}" readonly="readonly"  ></td>
								<td>
									<c:if test="${product.photoGfileId ne ''}">
										<img src="/file/view/${product.photoGfileId}"  width="70" height="auto">
									</c:if>	
								</td>
								<td>${product.productNm} </td>
								<td>${product.matTypeNm}</td>
								<td class="fontColorBlue">
									<c:choose>
										<c:when test="${product.selfEvlGradNm eq '최우수'}">
											<img src="/images/free-icon-in-love-356695.png" width="26px">
										</c:when>
										<c:when test="${product.selfEvlGradNm eq '우수'}">
											<img src="/images/free-icon-emoji-3456813.png" width="26px">
										</c:when>
										<c:when test="${product.selfEvlGradNm eq '보통'}">
											<img src="/images/free-icon-smile-356662.png" width="26px">
										</c:when>
										<c:when test="${product.selfEvlGradNm eq '어려움'}">
											<img src="/images/free-icon-angry-1747839.png" width="26px">
										</c:when>
										<c:otherwise>
											<img src="/images/free-icon-smile-356662.png" width="26px">
										</c:otherwise>
									</c:choose>
									${product.selfEvlGradNm}
								</td>
								<td>${product.masterApplyNm}</td>
								<td>
									<a href="javascript:void(0);" onclick="openProductPackagingLayer('${product.productCode}', '${product.productNm}');" role="button" data-toggle="modal" class="btn-small02">포장정보등록</a>
								</td>
								<td>
									<a href="javascript:void(0);" onclick="openProductPackagingSelfLayer('${product.productCode}', '${product.productNm}');" role="button" data-toggle="modal" class="btn-small02">자가진단</a>
								</td>
								<td><a href="javascript:void(0);#envi_result" role="button" data-toggle="modal" class="btn-small02">결과확인</a></td>
								<td>
									<div class="btn-group">
										<a href="javascript:void(0);"   onclick="javascript:productDetail('${product.productCode}');layerPopup(edit);"  role="button" data-toggle="modal" class="btn-icon">
											<img src="/images/icon_edit.png" alt="수정하기" class="btn-table-icon02" id="editBtn_${product.rownum}" >
										</a>
										  
										<a href="javascript:void(0);"  onclick="javascript:openProductDeleteLayer('${product.productCode}');layerPopup(delete);" role="button" data-toggle="modal" class="btn-icon">
											<img src="/images/icon_delete2.png" alt="삭제하기" class="btn-table-icon02" >
										</a>
									</div>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
					    <tr>
							<td colspan="11">
								등록된 상품정보가 없습니다.
							</td>
						</tr>
					</c:otherwise>
				  </c:choose>
                </tbody>
              </table>
            </div>
            <!-- E_그리드-->
            <div class="btn-group pt15 tr">
              <button id="registView" type="button" class="button btn-success" data-toggle="modal">
              	<a href="javascript:openProductLayer('registProduct');" onclick="javascript:layerPopup(register);" data-toggle="modal">상품등록</a></button>
            </div>
            <!-- S_페이징-->
            <div class="board-paging"></div>
            <!-- E_페이징-->
          </div>
        </div>
      </section>
      <!-- E_본문-->
    </div>
  </div>
  
  <!-- 레이어 팝업 - 상품등록  -->
  <form id="frmInsert"  enctype="multipart/form-data">
	  <div id="register" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-content" style="width:1000px">
		  <div class="modal-header">
			<h4 class="modal-title">상품등록</h4>
			<button type="button" class="close" data-dismiss="modal" onclick="javascript:layerPopupClose(register);"><img src="/images/icon_close.png"></button>
		  </div>
		  <div class="modal-body">
			<input name="masterApply" type="hidden" value="UNPROCEED" class="text-input" >
			<input name="masterMapping" type="hidden" value="UNMAPPING" class="text-input" >
			<div class="row">
			  <div class="col-50">
				<div class="form-group">
				  <label class="col-25 form-label">상품코드</label>
				  <div class="col-75">
					<input name="productCode" type="text" class="text-input" value="" autocomplete="off"  maxlength="100">
				  </div>
				</div>
			  </div>
			  <div class="col-50">
			  </div>
			  <div class="col-50">
				<div class="form-group">
				  <label class="col-25 form-label">상품명</label>
				  <div class="col-75">
					<input name="productNm" type="text" class="text-input" placeholder="예시)건강참기름 가정용" autocomplete="off">
				  </div>
				</div>
			  </div>
			  <div class="col-50">
				<div class="form-group">
				  <label class="col-25 form-label">납품기업</label>
				  <div class="col-75">
					<input name="supplierInfo" type="text" class="text-input" autocomplete="off">
				  </div>
				</div>
			  </div>
			  <div class="col-100">
				<div class="form-group">
				  <label class="col-25 form-label-textarea">설명</label>
				  <div class="col-75">
					<div class="form-input">
					  <textarea name="summary" class="textarea"></textarea>
					</div>
				  </div>
				</div>
				<div class="form-group">
				  <label class="col-25 form-label-img">사진</label>
				  <div class="col-75">
					<div class="form-input-img">
					  <input name="photos" type="file" multiple="multiple" id="our-file01" class="with-preview afile-img">
					</div>
				  </div>
				</div>
				<div class="form-group">
				  <label class="col-25 form-label-txt">도면 및 SPEC</label>
				  <div class="col-75">
					<div class="form-input-txt">
					  <input name="specs" type="file" multiple="multiple"  class="afile-txt" />
					</div>
				  </div>
				</div>
			  </div>

			</div>
			<!-- 버튼 -->
			<div class="modal-footer btn-group">
			  <button id="regBtn" type="button" class="button btn-success">저장</button>
			  <button type="button" class="button btn-cancel" data-dismiss="modal" onclick="javascript:layerPopupClose(register);">취소</button>
			</div>
		  </div>
		</div>
	  </div>
  </form>
  
  <!-- 레이어 팝업 - 상품수정  -->
  <form id="frmUpdate"  enctype="multipart/form-data">
	  <!-- 레이어 팝업 - 수정  -->
	  <div id="edit" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-content" style="width:1100px">
		  <div class="modal-header">
			<h4 class="modal-title">상품수정</h4>
			<button type="button" class="close" data-dismiss="modal" onclick="javascript:layerPopupClose(edit);"><img src="/images/icon_close.png"></button>
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
						  <input name="productCode" type="hidden" class="text-input">
						  <input name="photoGfileId" type="hidden" class="text-input">
						  <input name="specGfileId" type="hidden" class="text-input">
						  <input name="productCodeView" type="text" class="text-input" value="" disabled>
						</div>
					  </div>
					</div>
					<div class="col-50">
					</div>
					<div class="col-50">
					  <div class="form-group">
						<label class="col-25 form-label">상품명</label>
						<div class="col-75">
						  <input name="productNm" type="text" class="text-input" placeholder="예시)건강참기름 가정용" autocomplete="off">
						</div>
					  </div>
					</div>
					<div class="col-50">
					  <div class="form-group">
						<label class="col-25 form-label">납품기업</label>
						<div class="col-75">
						  <input name="supplierInfo" type="text" class="text-input" autocomplete="off">
						</div>
					  </div>
					</div>
					<div class="col-35">
					  <div class="form-group">
						<label class="col-40 form-label"  id="edit_baseYear">누적판매량(기준 년)</label>
						<input name="baseYear" type="hidden">
						<input name="baseYear_1" type="hidden">
						<input name="baseYear_2" type="hidden">
						<div class="col-60">
						  <input name="accumulateSaleQty" type="text" class="text-input" placeholder="누적판매량(년)"  autocomplete="off">
						</div>
					  </div>
					</div>
					<div class="col-25">
					  <div class="form-group">
						<label class="col-40 form-label">포장재총중량</label>
						<div class="col-60">
						  <input name="packingTotalWeight" type="text" class="text-input" placeholder="포장재총중량"  autocomplete="off">
						</div>
					  </div>
					</div>
					<div class="col-40">
					  <div class="form-group">
						<label class="col-40 form-label">재활용분담금</label>
						<div class="col-60 d-flex">
						  <input name="recyleContributions" type="text" class="text-input" placeholder="누적판매량 등록시 자동계산" readonly  autocomplete="off">
						   <button onclick="calculateRecyleContributions('recyleContributions');" type="button" class="button btn-success" style="width:70px;padding: 0px;">계산</button>
						</div>
					  </div>
					</div>
<!-- 					<div class="col-35"> -->
<!-- 					  <div class="form-group"> -->
<!-- 						<label class="col-40 form-label"  id="edit_baseYear_1">누적판매량(1년전)</label> -->
<!-- 						<div class="col-60"> -->
<!-- 						  <input name="accumulateSaleQty_1" type="text" class="text-input" placeholder="누적판매량(년)"  autocomplete="off"> -->
<!-- 						</div> -->
<!-- 					  </div> -->
<!-- 					</div> -->
<!-- 					<div class="col-25"> -->
<!-- 					  <div class="form-group"> -->
<!-- 						<label class="col-40 form-label">포장재총중량</label> -->
<!-- 						<div class="col-60"> -->
<!-- 						  <input name="packingTotalWeight_1" type="text" class="text-input" placeholder="포장재총중량"  autocomplete="off"> -->
<!-- 						</div> -->
<!-- 					  </div> -->
<!-- 					</div> -->
<!-- 					<div class="col-40"> -->
<!-- 					  <div class="form-group"> -->
<!-- 						<label class="col-40 form-label">재활용분담금</label> -->
<!-- 						<div class="col-60 d-flex"> -->
<!-- 						  <input name="recyleContributions_1" type="text" class="text-input" placeholder="누적판매량 등록시 자동계산" readonly  autocomplete="off"> -->
<!-- 						  <button onclick="calculateRecyleContributions('recyleContributions_1');" type="button" class="button btn-success"  style="width:70px;padding: 0px;">계산</button> -->
<!-- 						</div> -->
<!-- 					  </div> -->
<!-- 					</div> -->
<!-- 					<div class="col-35"> -->
<!-- 					  <div class="form-group"> -->
<!-- 						<label class="col-40 form-label"  id="edit_baseYear_2">누적판매량(2년전)</label> -->
<!-- 						<div class="col-60"> -->
<!-- 						  <input name="accumulateSaleQty_2" type="text" class="text-input" placeholder="누적판매량(년)"  autocomplete="off"> -->
<!-- 						</div> -->
<!-- 					  </div> -->
<!-- 					</div> -->
<!-- 					<div class="col-25"> -->
<!-- 					  <div class="form-group"> -->
<!-- 						<label class="col-40 form-label">포장재총중량</label> -->
<!-- 						<div class="col-60"> -->
<!-- 						  <input name="packingTotalWeight_2" type="text" class="text-input" placeholder="포장재총중량"  autocomplete="off"> -->
<!-- 						</div> -->
<!-- 					  </div> -->
<!-- 					</div> -->
<!-- 					<div class="col-40"> -->
<!-- 					  <div class="form-group"> -->
<!-- 						<label class="col-40 form-label">재활용분담금</label> -->
<!-- 						<div class="col-60 d-flex"> -->
<!-- 						  <input name="recyleContributions_2" type="text" class="text-input" placeholder="누적판매량 등록시 자동계산" readonly  autocomplete="off"> -->
<!-- 						  <button onclick="calculateRecyleContributions('recyleContributions_2');" type="button" class="button btn-success"  style="width:70px;padding: 0px;">계산</button> -->
<!-- 						</div> -->
<!-- 					  </div> -->
<!-- 					</div> -->
					<div class="col-100">
					  <div class="form-group">
						<label class="col-25 form-label">상품제조사</label>
						<div class="col-75">
						  <div class="form-input-box" id="edit_productMaker">
						  </div>
						</div>
					  </div>
					</div>

					<div class="col-100">
					  <div class="form-group">
						<label class="col-25 form-label-textarea">설명</label>
						<div class="col-75">
						  <div class="form-input">
							<textarea name="summary" class="textarea"></textarea>
						  </div>
						</div>
					  </div>
					  <div class="form-group">
						<label class="col-25 form-label-img">사진</label>
						<div class="col-75">
						  <div class="form-input-img">
							<input id="edit_photos" name="photos" type="file" multiple="multiple" id="our-file02"
							  class="multi with-preview">
						  </div>
						</div>
					  </div>
					  <div class="form-group">
						<label class="col-25 form-label-txt">도면 및 SPEC</label>
						<div class="col-75">
						  <div class="form-input-txt">
							<input id="edit_specs" name="specs" type="file" multiple="multiple"  class="afile-txt" />
						  </div>
						</div>
					  </div>
					</div>
				  </div>
				  <h4 class="tl pt15"><span class="title-point">[환경부 진행상황]</span></h4>
				  <div class="row">
					<div class="col-50">
					  <div class="form-group">
						<label class="col-20 form-label">진행상태</label>
						<div class="col-80">
						  <div class="form-input-box" id="edit_masterApplyNm">
						  </div>
						</div>
					  </div>
					</div>
					<div class="col-50">
					  <div class="form-group">
						<label class="col-20 form-label">매핑상태</label>
						<div class="col-80">
						  <div class="form-input-box" id="edit_masterMapping">
						  </div>
						</div>
					  </div>
					</div>
					<div class="col-50">
					  <div class="form-group">
						<label class="col-20 form-label">접수번호</label>
						<div class="col-30">
						  <input name="receiptNo" type="text" class="text-input"  autocomplete="off">
						</div>
						<label class="col-20 form-label">승인번호</label>
						<div class="col-30">
						  <input name="approvalNo" type="text" class="text-input"  autocomplete="off">
						</div>
					  </div>
					</div>
					<div class="col-50">
					  <div class="form-group">
						<label class="col-20 form-label">매핑상품코드</label>
						<div class="col-30">
						  <input name="mappingProductCode" type="text" class="text-input"  autocomplete="off">
						</div>
						<label class="col-20 form-label">매핑상품명</label>
						<div class="col-30">
						  <input name="mappingProductNm" type="text" class="text-input"  autocomplete="off">
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
						  <input name="rgstDt" type="text" class="text-input" value="" disabled>
						</div>
					  </div>
					</div>
					<div class="col-50">
					  <div class="form-group">
						<label class="col-25 form-label">최종 변경일</label>
						<div class="col-75">
						  <input name="modiDt" type="text" class="text-input" value="" disabled>
						</div>
					  </div>
					</div>
					<div class="col-50">
					  <div class="form-group">
						<label class="col-25 form-label">생성자</label>
						<div class="col-75">
						  <input name="rgstId" type="text" class="text-input" value="" disabled>
						</div>
					  </div>
					</div>
					<div class="col-50">
					  <div class="form-group">
						<label class="col-25 form-label">최종변경자</label>
						<div class="col-75">
						  <input name="modiId" type="text" class="text-input" value="" disabled>
						</div>
					  </div>
					</div>
				  </div>
				</div>
			  </div>
			</div>
			<!-- 버튼 -->
			<div class="modal-footer btn-group">
			  <button id="editBtn" type="button" class="button btn-success">저장</button>
			  <button type="button" class="button btn-cancel" data-dismiss="modal" onclick="javascript:layerPopupClose(edit);">취소</button>
			</div>
		  </div>
		</div>
	  </div>
  </form>
  
  <!-- 레이어 팝업 - 상품삭제  -->
  <form id="frmDelete">
	  <!-- 레이어 팝업 - delete -->
	  <div id="delete" class="modal" data-backdrop-limit="1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true" data-modal-parent="#myModal">
		<input type="hidden" name="productCode" >
		<div class="modal-content" style="width:400px">
		  <div class="modal-header">
			<h4 class="modal-title">삭제</h4>
			<button type="button" class="close" data-dismiss="modal" onclick="javascript:layerPopupClose(delete);"><img src="/images/icon_close.png"></button>
		  </div>
		  <div class="modal-body">
			<div class="row">
			  <div class="col-100">
				<div class="form-group">
				  <div class="tc">(<em class="text-bold delName"></em>)삭제합니다.</div>
				</div>
			  </div>
			</div>
		  </div>
		  <div class="modal-footer btn-group">
			<button id="delBtn" type="button" class="button btn-warning" data-dismiss="modal">삭제</button>
			<button type="button" class="button btn-cancel" data-dismiss="modal" onclick="javascript:layerPopupClose(delete);">취소</button>
		  </div>
		</div>
	  </div>
  </form>
  
  <!-- 레이어 팝업 - 포장정보등록 및 상세  -->
  <form id="frmDetail">
	  <div id="packagingDetail" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-content" style="width:auto;max-width:1100px">
		  <div class="modal-header">
			<h4 class="modal-title" id="detailTitle"></h4>
			<button type="button" class="close" data-dismiss="modal" onclick="javascript:layerPopupClose(packagingDetail);"><img src="/images/icon_close.png"></button>
		  </div>
		  <div class="modal-body">
			<div class="row">
			  <div class="tab-content-box">
				<p>
				  <button id="btn-add-tab" type="button" class="btn-form-small fr">탭 추가</button>
				</p>
				<!-- Nav tabs -->
				<ul id="tab-list" class="nav tab-nav" role="tablist"></ul>
				<!-- Tab panes -->
				<div id="tab-content" class="tab-content">
				  <div class="tab-pane active" id="tab1">
					<!--S_탭 tab03_1-->
					<div id="tab03_1">
					  <div class="row">
						<!--S_탭 tab04-->
						
						<div class="tab04">
						  <!--S_탭 tabcontent04-->
						  <div class="tabcontent04">
							
								<div id="tab04_1">
								  <div class="tab-in-nav d-flex">
								  		<input id="frmDetail_productCode" type="hidden" class="text-input">
								  		<input type="hidden" name="groupId">
									<ul class="tabnav04-in d-flex pt05" id="selfpartCode1"></ul>
									<div class="add-row">
									  <button id='btn-add-row' class="btn-form-small">(+)추가하기</button>
									</div>
								  </div>
								  <!--S_몸체 -->
								  <div class="tabcontent04-in">
									<ul class="tabnav04-in d-flex pt05" id="partCodeDetail" style="display:none;"></ul>
									<div class="mytable_1_in" id="tab04_1_in1">
									  <div id="mytable_1_in1">
									  </div>
									</div>
									<!-- 버튼 -->
								  </div>
								  <div class="modal-footer btn-group">
									<button  id="savePackagingBtn" type="button" class="button btn-success">저장</button>
									<button type="button" class="button btn-cancel" data-dismiss="modal" onclick="javascript:layerPopupClose(packagingDetail);">취소</button>
								  </div>
								  <!--E_몸체 -->
								</div>
							
							<!--E_탭 tab04_2 -->
						  </div>
						  <!--E_탭 tabcontent04-->
						</div>
						<!--E_탭 tab04-->
					  </div>
					  <!--E_탭 tab03_1-->
					</div>
				  </div>
				</div>
			  </div>
			</div>
		  </div>
		</div>
	  </div>
  </form>
  
  <!-- 레이어 팝업 - 재질유형 정보 조회 -->
  <form id="frmPackagingOrder">
	  <div id="insertPackagingOrder" class="modal" data-backdrop-limit="1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-content" style="width:400px">
	      <div class="modal-header">
	        <h4 class="modal-title">포장정보</h4>
	        <button type="button"  onclick="showTab();" class="close" data-dismiss="modal"><img src="/images/icon_close.png"></button>
	      </div>
	      <div class="modal-body">
	        <div class="row">
	          <div class="col-100">
	            <div class="form-group"  id="matTypeSelectpackagingOrderNm">
	              <label class="col-25 form-label">포장차수</label>
	              <div class="col-75">
	                <input type="hidden" name="productCode">
	                <select class="select-box" id="packagingOrderNmApply" name="packagingOrder"></select>
	              </div>
	            </div>
	            <div class="form-notice" id="showMappedProductCode" style="display:none;"><input type="checkbox" id="mappedProductCode" name="mappedProductCode" value="Y"><label for="mappedProductCode"> * 동록된 상품코드가 있습니다.</label></div>
	<!--             <div class="form-notice">* [1차포장]은 등록되어있습니다.</div> -->
	            <div class="form-group" id="matTypeSelectProductMatType" style="display:none;">
	              <label class="col-25 form-label">재질유형</label>
	              <div class="col-75">
	                <input type="hidden" name="codeId">
	                <input type="hidden" name="groupId">
	                <select id="matTypeSelectBox" name="groupIdList" class="select-box"></select>
	              </div>
	            </div>
	            <div class="form-group" id="matTypeSelectProductCode" style="display:none;">
	              <label class="col-25 form-label">상품코드</label>
	              <div class="form-input">
	                <input type="hidden" id="matTypeSelectProductMatTypeMapped" name="mappedGroupId">
	                <input type="text" id="matTypeSelectProductCodeVal" class="text-input" name="subProductCode">
	              </div>
	            </div>
	          </div>
	        </div>
	      </div>
	      <!-- 버튼 -->
	      <div class="modal-footer btn-group">
	        <button type="button" class="button btn-success" onclick="addPackagingTab();">적용</button>
	        <button type="button" class="button btn-cancel" onclick="showTab();" data-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
  </form>
  
  <!-- 레이어 팝업 - 자가진단 상세  -->
  <form id="frmSelfDiagnose"  enctype="multipart/form-data">
	  <div id="selfDetail" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-content" style="width:auto;max-width:1100px">
		  <div class="modal-header">
			<h4 class="modal-title" id="selfDetailTitle"></h4>
			<button type="button" class="close" data-dismiss="modal" onclick="javascript:layerPopupClose(selfDetail);"><img src="/images/icon_close.png"></button>
		  </div>
		  <div class="modal-body">
			<div class="row">
			  <div class="tab-content-box">
				<!-- Nav tabs -->
				<ul id="self-tab-list" class="nav tab-nav" role="tablist"></ul>
				<!-- Tab panes -->
				<div id="tab-content" class="tab-content">
				  <div class="tab-pane active" id="self-tab1">
					<!--S_탭 tab03_1-->
					<div id="self-tab03_1">
					  <div class="row">
						<!--S_탭 tab04-->
						
						<div class="tab04">
						  <!--S_탭 tabcontent04-->
						  <div class="tabcontent04">
							<!--S_탭 tab04_2 -->
							
								<div id="self-tab04_2">
								<input type="hidden" name="packagingOrder">
								<input type="hidden" name="packagingId">
								<input type="hidden" name="productCode">
								<input type="hidden" name="recycleGrade">
								  <div id="Accordion_wrap" class="row100 pt10">
									<div class="Accordion-box">
									</div>
								  </div>
								  <!-- 버튼 -->
								  <div class="modal-footer btn-group" id="selfPackagingInfo">
									<button type="button" class="button btn-success" onclick="insertProdPackagingSelfAjax();">결과저장</button>
									<button type="button" class="button btn-cancel" data-dismiss="modal" onclick="javascript:layerPopupClose(selfDetail);">취소</button>
								  </div>
								</div>
							
							<!--E_탭 tab04_2 -->
						  </div>
						  <!--E_탭 tabcontent04-->
						</div>
						<!--E_탭 tab04-->
					  </div>
					  <!--E_탭 tab03_1-->
					</div>
				  </div>
				</div>
			  </div>
			</div>
		  </div>
		</div>
	  </div>
  </form>
  
<script src='/js/plugins/jquery.MultiFile.min.js' type="text/javascript" language="javascript"></script>
<script>
	var selectedPartCode ="";
	var selectedPartNm ="";
	var grade = [];
	var button = '<button class="tab-close" type="button" title="Remove this page">×</button>';
	var tabID = 0;
	var selectedProductCode = "";
	var selectedProductNm = "";
	var selectedPackagingId = "";
	//다른페이지에서 특정 프로덕트코드 파라미터로 들어올때 해당 상품상세 정보 호출
	if('${param.productCode}') {
		  $('#editBtn_${param.productCode}').click();
	}
	var totalPage = ${pages.totalPage};
	var page = ${pages.page};
	var pageSize = ${pages.pageSize}; 
	
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
	
	$(document).ready(function () {
		//[2] 업로드할수있는 파일수 제한 및 확장자 필터
	      $('.afile-txt').MultiFile({
	        // 옵션 설정
	        max: 3, //업로할수있는 최대 파일 갯수
	        accept: 'txt|pptx|xlsx|pdf|hwp', //허용할수있는 파일 확장자
	        STRING: { //Multi-lingual support : 메시지 수정 가능
	          //remove : "제거", //추가한 파일 제거 문구, 이미태그를 사용하면 이미지사용가능
	          duplicate: "$file 은 이미 선택된 파일입니다.",
	          denied: "$ext 는(은) 업로드 할수 없는 파일확장자입니다.",
	          selected: '$file 을 선택했습니다.',
	          toomany: "업로드할 수 있는 최대 갯수는 $max개 입니다.",
	        }
	      });
	      $('.afile-img').MultiFile({
	        max: 3, //업로드 최대 파일 갯수 (지정하지 않으면 무한대)
	        accept: 'jpeg|jpg|png|gif', //허용할 확장자(지정하지 않으면 모든 확장자 허용)
	        STRING: { //Multi-lingual support : 메시지 수정 가능
	          //remove : "제거", //추가한 파일 제거 문구, 이미태그를 사용하면 이미지사용가능
	          duplicate: "$file 은 이미 선택된 파일입니다.",
	          denied: "$ext 는(은) 업로드 할수 없는 파일확장자입니다.",
	          selected: '$file 을 선택했습니다.',
	          toomany: "업로드할 수 있는 최대 갯수는 $max개 입니다.",
	        }
	      });

	  	var searchKey = '${pages.searchKey}';
		if(searchKey){
			$('#searchKey').val('${pages.searchKey}');
		}
		//상품등록 버튼 클릭시
		$('#regBtn').click(function(){
			productInsert();
		});
		
		//상품정보 수정 버튼 클릭시
		$('#editBtn').click(function(){
			productUpdate();
		});
		
		$('#delBtn').click(function(){
			productDelete();
		});

		$('#savePackagingBtn').click(function(){
			saveProdPackagingDetail();
		});

		$(document).on('change', '.supplierCode', function() {
			if(this.value){
				console.log($(this).find("option:selected").text());
				$("#frmDetail input[name=supplierNm]").val($(this).find("option:selected").text());
				managersView(this.value, '');
			}else {
				$("#frmDetail input[name=managerNm]").val('');
				$("#frmDetail input[name=supplierNm]").val('');
			}
		});
		$(document).on('change', '.supplierManager', function() {
			if(this.value){
				console.log($(this).find("option:selected").text());
				$("#frmDetail input[name=managerNm]").val($(this).find("option:selected").text());
				$("#frmDetail input[name=managerId]").val(this.value.split("||")[0]);
				$(this).parent().parent().parent().parent().next().find('.supplierMail').val(this.value.split("||")[1]);
			}else {
				$(this).parent().parent().parent().parent().next().find('.supplierMail').val('');
				$("#frmDetail input[name=managerNm]").val('');
				$("#frmDetail input[name=managerId]").val('');
			}
		});
		$(document).on('click', '.sendEmail', function () {
			var param =  $('#frmDetail').serialize();
			var packagingDetailId = $("#frmDetail input[name=packagingDetailId]").val();
		  	if(packagingDetailId != '' && packagingDetailId != null) {
		  		sendEmail(param);
		  	}else {
				saveProductPackagingDetailAjax(param,'insert', true);
			}
			
		});

		$("#mappedProductCode").change(function() {
			if(this.checked) {
	        	$('#matTypeSelectProductCode').show();
	        	$('#matTypeSelectProductMatType').hide();
	        }else {
	        	$('#matTypeSelectProductCode').hide();
	        	$('#matTypeSelectProductMatType').show();
	        }
	    });
	    
		$(document).on('change', '#packagingOrderNmApply', function () {
			if(this.value && this.value > 10){
				$('#matTypeSelectProductMatType').hide();
				$('#showMappedProductCode').show();
				$('#matTypeSelectProductMatType').show();
			}else {
				$('#matTypeSelectProductCode').hide();
				$('#showMappedProductCode').hide();
				$('#matTypeSelectProductMatType').show();
			}
		});

		$('#btn-add-tab').click(function () {
			$('#btn-add-tab').hide();
			getPodPackagingOrderNmList(selectedProductCode);
			getMatTypeList();
	    });

	    $('#tab-list').on('click', '.tab-close', function () {
	      var tabID = $(this).parents('a').attr('href');
	      $(this).parents('li').remove();
	      $(tabID).remove();

	      //display first tab
	      var tabFirst = $('#tab-list a:first');
//	       resetTab();
//	       tabFirst.tab('show');
	      tabFirst.click();
	      $('#btn-add-tab').show();
	    });

	    var list = document.getElementById("tab-list");
		
	    
		$('#btn-add-row').click(function () {
	          var innerHtml = "";
		      innerHtml = '<li><a  class="button btn-radius on" href="#"><span onclick=\'getProdPackagingDetail("'+selectedPackagingId+'", "", this, "'+selectedPartCode+'", "'+selectedPartNm+'");\'>'+selectedPartNm+'</span><button type="button"  onclick=\'deletePackagingId("", this);\' style="color:black;height:0px;line-height:10px;margin-left:1px;background:transparent;" title="Remove this page">×</button></a></li>';
		      $('#partCodeDetail a').removeClass('on');
		      $('#partCodeDetail:last').append(innerHtml);
			  innerHtml = getProductDetailInfoHtml(selectedPartCode, selectedPartNm, selectedPackagingId);
	          $('#mytable_1_in1').empty();
	          $('#mytable_1_in1').append(innerHtml);
	          return false;
	      });
		
	});
	
	//상품 등록 레이어 오픈시 기존 값 초기화
	function openProductLayer(type){
		if (type == 'registProduct') {
			$("#frmInsert input[name=productCode]").val('');
			$("#frmInsert input[name=productNm]").val('');
			$("#frmInsert input[name=supplierInfo]").val('');
			$("#frmInsert textarea[name=summary]").val('');
			$("#frmInsert input[name=photos]").val('');
			$("#frmInsert input[name=specs]").val('');
			$("#frmInsert .MultiFile-list").empty();
		} else if (type == 'editProduct') {
			$("#frmUpdate input[name=productCode]").val('');
			$("#frmUpdate input[name=productNm]").val('');
			$("#frmUpdate input[name=supplierInfo]").val('');
			$("#frmUpdate textarea[name=summary]").val('');
			$("#frmUpdate input[name=photos]").val('');
			$("#frmUpdate input[name=specs]").val('');
			$("#frmUpdate .MultiFile-list").empty();
		}
	}
	
	//상품저장 전 validation
	function productInsert() {
		var check = valyCheck("registProduct");
		if (check) {
			var param = $('#frmInsert').serialize();
			insertAjax(param, 'insert');
		}
	}

	// 데이터 validation 
	function valyCheck(type) {
		if (type == 'registProduct') {
			var productCode = $("#frmInsert input[name=productCode]").val();
			if (productCode == '') {
				alert('상품코드를 입력해 주세요.');
				// 				$("#frmInsert input[name=productCode]").focus();
				return false;
			}

			var productNm = $("#frmInsert input[name=productNm]").val();
			if (productNm == '') {
				alert('삼품명을 입력해 주세요.');
				$("#frmInsert input[name=productNm]").focus();
				return false;
			}
		} else if (type == 'editProduct') {
			var productNm = $("#frmUpdate input[name=productNm]").val();
			if (productNm == '') {
				alert('삼품명을 입력해 주세요.');
				$("#frmUpdate input[name=productNm]").focus();
				return false;
			}
		} else if (type == 'savePackaging') {
			var supplierCode = $("#frmDetail select[name=supplierCode]").val();
			if (supplierCode == '') {
				alert('공급업체를 선택해 주세요.');
				$("#frmDetail select[name=supplierCode]").focus();
				return false;
			}
			var managerId = $("#frmDetail select[name=managerIdList]").val();
			if (managerId == '') {
				alert('담당자를 선택해 주세요.');
				$("#frmDetail select[name=managerIdList]").focus();
				return false;
			}
		} else if (type == 'recyleContributions') {
			var accumulateSaleQty = $(
					"#frmUpdate input[name=edit_accumulateSaleQty]").val();
			if (accumulateSaleQty == '') {
				alert('누적판패량을 입력해 주세요.');
				$("#frmUpdate input[name=edit_accumulateSaleQty]").focus();
				return false;
			}
			var packingTotalWeight = $(
					"#frmUpdate input[name=packingTotalWeight]").val();
			if (packingTotalWeight == '') {
				alert('포장재총중량을 입력해 주세요.');
				$("#frmUpdate input[name=packingTotalWeight]").focus();
				return false;
			}
		} else if (type == 'recyleContributions_1') {
			var accumulateSaleQty = $(
					"#frmUpdate input[name=edit_accumulateSaleQty_1]").val();
			if (accumulateSaleQty == '') {
				alert('누적판패량을 입력해 주세요.');
				$("#frmUpdate input[name=edit_accumulateSaleQty_1]").focus();
				return false;
			}
			var packingTotalWeight = $(
					"#frmUpdate input[name=packingTotalWeight_1]").val();
			if (packingTotalWeight == '') {
				alert('포장재총중량을 입력해 주세요.');
				$("#frmUpdate input[name=packingTotalWeight_1]").focus();
				return false;
			}
		} else if (type == 'recyleContributions_2') {
			var accumulateSaleQty = $(
					"#frmUpdate input[name=edit_accumulateSaleQty_2]").val();
			if (accumulateSaleQty == '') {
				alert('누적판패량을 입력해 주세요.');
				$("#frmUpdate input[name=edit_accumulateSaleQty_2]").focus();
				return false;
			}
			var packingTotalWeight = $(
					"#frmUpdate input[name=packingTotalWeight_2]").val();
			if (packingTotalWeight == '') {
				alert('포장재총중량을 입력해 주세요.');
				$("#frmUpdate input[name=packingTotalWeight_2]").focus();
				return false;
			}
		}
		return true;
	}

	//상품 저장
	function insertAjax(param, action) {
		if (action == 'update') {
			var form = $('#frmUpdate')[0];
		} else {
			var form = $('#frmInsert')[0];
		}
		var data = new FormData(form);

		$.ajax({
			type : 'post',
			url : '/product/' + action,
			enctype : 'multipart/form-data',
			data : data,
			dataType : 'text',
			processData : false,
			contentType : false,
			cache : false,
			timeout : 600000,
			error : function(request, status, error) {
				console.log(request.responseText);
				alert(request.responseText);
			},
			success : function(result) {
				alert("정상적으로 상품 저장 되었습니다.")

				//목록조회 페이지 재로딩함
				if (result == 'Update' || result == 'Insert') {
					$("#page").val(page);
					$("#searchFrm").submit();
				}
			}
		});
	}
	
	// 상품수정 버튼 클릭시 정보 조회 후 레이어 표시
	function productDetail(productCode) {
		//기존정보 초기화
		openProductLayer('editProduct');
		
		$.ajax({
			url : '/product/detail/',
			dataType : 'json',
			data : {
				'productCode' : productCode
			},
			type : "POST",
			async : false,
			success : function(data) {
				var result = data;
				console.log(result);
				setProductDetailView(data);
			}
		});
	}
	
	// 조회된 상품상세정보 설정
	function setProductDetailView(data){
		//hidden 정보
		$("#frmUpdate input[name=productCode]").val(data.productCode);
		$("#frmUpdate input[name=photoGfileId]").val(data.photoGfileId);
		$("#frmUpdate input[name=specGfileId]").val(data.specGfileId);
		
		//기본정보
		$("#frmUpdate input[name=productCodeView]").val(data.productCode);
		$("#frmUpdate input[name=productNm]").val(data.productNm);
		$("#frmUpdate input[name=supplierInfo]").val(data.supplierInfo);
		$("#frmUpdate input[name=accumulateSaleQty]").val(data.accumulateSaleQty);
		$("#frmUpdate input[name=packingTotalWeight]").val(data.packingTotalWeight);
		$("#frmUpdate input[name=recyleContributions]").val(data.recyleContributions);
		
		//재활용분담금
		$('#edit_baseYear').text('누적판매량('+data.baseYear+'년)');
// 		$('#edit_baseYear_1').text('누적판매량('+data.baseYear_1+'년)');
// 		$('#edit_baseYear_2').text('누적판매량('+data.baseYear_2+'년)');
		$("#frmUpdate input[name=baseYear]").val(data.baseYear);
// 		$("#frmUpdate input[name=baseYear_1]").val(data.baseYear_1);
// 		$("#frmUpdate input[name=baseYear_2]").val(data.baseYear_2);
		
// 		$("#frmUpdate input[name=accumulateSaleQty_1]").val(data.accumulateSaleQty_1);
// 		$("#frmUpdate input[name=packingTotalWeight_1]").val(data.packingTotalWeight_1);
// 		$("#frmUpdate input[name=recyleContributions_1]").val(data.recyleContributions_1);
		
// 		$("#frmUpdate input[name=accumulateSaleQty_2]").val(data.accumulateSaleQty_2);
// 		$("#frmUpdate input[name=packingTotalWeight_2]").val(data.packingTotalWeight_2);
// 		$("#frmUpdate input[name=recyleContributions_2]").val(data.recyleContributions_2);
		
		//상품추가정보
// 		$("#frmUpdate textarea[name=productMaker]").val(data.productMaker);
		$("#frmUpdate textarea[name=summary]").val(data.summary);
		getFileList('photos_'+data.productCode, "edit_photos", data.photoGfileId);
		getFileList('specs_'+data.productCode, "edit_specs", data.specGfileId);
		
		$('#edit_masterApplyNm').empty();
		console.log(data.environmentProceedStatCode.length);
		//진행상태
		if (data.environmentProceedStatCode.length > 0) {
			data.environmentProceedStatCode.forEach(function(item, index) {
				console.log(item);
				$('#edit_masterApplyNm').append('<div class="button-Rsmall d-inblock"><input type="radio"  name="masterApplyCode" value="'+item.codeId+'"><label for="masterApply" class="mr05">'+item.codeNm+'</label></div>');
			});
		}
		
		//매핑정보
		$('#edit_masterMapping').empty();
		console.log(data.mappingStatCode.length);
		if (data.mappingStatCode.length > 0) {
			data.mappingStatCode.forEach(function(item, index) {
				console.log(item);
				$('#edit_masterMapping').append('<div class="button-Rsmall d-inblock"><input type="radio"  name="masterMappingCode" value="'+item.codeId+'"><label for="masterMapping" class="mr05">'+item.codeNm+'</label></div>');
			});
			$('#edit_masterMapping').append('<div class="button-Rsmall d-inblock"  onclick="mapProductCode(\'edit_productCodeSave\');"><label class="mr05">매핑실행</label></div>');
		}
		
		$("#frmUpdate input[name=masterApplyCode]").val([data.masterApplyCode]);
		$("#frmUpdate input[name=masterMappingCode]").val([data.masterMappingCode]);
		$("#frmUpdate input[name=receiptNo]").val(data.receiptNo);
		$("#frmUpdate input[name=approvalNo]").val(data.approvalNo);
		$("#frmUpdate input[name=mappingProductCode]").val(data.mappingProductCode);
		$("#frmUpdate input[name=mappingProductNm]").val(data.mappingProductNm);
		
		$("#frmUpdate input[name=rgstDt]").val(data.rgstDt);
		$("#frmUpdate input[name=rgstDt]").attr('disabled',true);
		$("#frmUpdate input[name=modiDt]").val(data.modiDt);
		$("#frmUpdate input[name=modiDt]").attr('disabled',true);
		$("#frmUpdate input[name=rgstId]").val(data.rgstId);
		$("#frmUpdate input[name=rgstId]").attr('disabled',true);
		$("#frmUpdate input[name=modiId]").val(data.modiId);
		$("#frmUpdate input[name=modiId]").attr('disabled',true);
	}
	
	//재활용분담금 정보 조회전 데이터 검증 및 설정
	function calculateRecyleContributions(year) {
		var check = valyCheck(year);
		if (check) {
			var param = {};
			if (year == 'recyleContributions') {
				param.baseYear = $("#frmUpdate input[name=baseYear]").val();
				param.accumulateSaleQty = $("#frmUpdate input[name=accumulateSaleQty]").val();
				param.packingTotalWeight = $("#frmUpdate input[name=packingTotalWeight]").val();
			} else if (year == 'recyleContributions_1') {
				param.baseYear_1 = $("#frmUpdate input[name=baseYear_1]").val();
				param.accumulateSaleQty_1 = $("#frmUpdate input[name=accumulateSaleQty_1]").val();
				param.packingTotalWeight_1 = $("#frmUpdate input[name=packingTotalWeight_1]").val();
			} else if (year == 'recyleContributions_2') {
				param.baseYear_2 = $("#frmUpdate input[name=baseYear_2]").val();
				param.accumulateSaleQty_2 = $("#frmUpdate input[name=accumulateSaleQty_2]").val();
				param.packingTotalWeight_2 = $("#frmUpdate input[name=packingTotalWeight_2]").val();
			} else {
				return;
			}
			var productCode = $("#frmUpdate input[name=productCode]").val();
			calculateRecyleContributionsAjax(productCode, param, year);
		}
	}

	//재활용분담금 정보 조회
	function calculateRecyleContributionsAjax(productCode, param, year) {
		//	 	  var param = $('#frmUpdate').serialize();
		$.ajax({
			type : 'post',
			url : 'detail/' + productCode + '/recyle_contributions/',
			data : param,
			dataType : 'text',
			error : function(request, status, error) {
				console.log(request.responseText);
				alert(request.responseText);
			},
			success : function(result) {
				$("#frmUpdate input[name=" + year + "]").val(result);
			}
		});
	}
	
	//첨부 파일 조회
	function getFileList(refId, placeId, savedId) {
		$.ajax({
			url : '/product/detail/file/list/'+savedId,
			dataType : 'json',
			type : "GET",
			async: false,
			success : function(data) {
				$('#'+placeId+'  > .MultiFile-list').empty();
				if (data.length > 0) {
					data.forEach(function(item, index) {
						if(refId.indexOf('photos_') > -1){
							$('#'+placeId+'  > .MultiFile-list').append('<div class="MultiFile-label" ><a class="MultiFile-remove" href="#" onclick=\'deleteFileAjax("'+item.fileId+'", this);\'>x</a> <span><span class="MultiFile-label" title='+item.fileNm+' 을 선택했습니다."><span class="MultiFile-title">'+item.fileNm+'</span><img id="'+item.fileId+'" class="MultiFile-preview" style="max-height:100px; max-width:100px;" src="/file/view/'+item.fileId+'"></span></span></div>');
						}else if(refId.indexOf('specs_') > -1){
							$('#'+placeId+'  > .MultiFile-list').append('<div class="MultiFile-label"><a class="MultiFile-remove" href="#" onclick=\'deleteFileAjax("'+item.fileId+'", this);\'>x</a> <span><span class="MultiFile-label" title='+item.fileNm+' 을 선택했습니다." onclick=\'downloadFile("'+item.fileId+'");\'><span class="MultiFile-title">'+item.fileNm+'</span></span></span></div>');
						}
					});
				}
			}
		});
	}

	// 상품 삭제시 사용(공통)  
	function deleteFileAjax(fileId, obj) {
		$.ajax({
			type : 'post',
			url : '/product/detail/file/delete/' + fileId,
			dataType : 'json',
			error : function(request, status, error) {
				console.log(request.responseText);
				alert(request.responseText);
			},
			success : function(result) {
				console.log(result);
				$(obj).parent().remove();
			}
		});
	}
	
	//상품수정 전 validation
	function productUpdate() {
		var check = valyCheck("editProduct");
		if (check) {
			var param = $('#frmUpdate').serialize();
			insertAjax(param, 'update');
		}
	}
	
	//상품 삭제 레이어 노출
	function openProductDeleteLayer(productCode) {
	  	$('.delName').text(productCode);
	  	$("#frmDelete input[name=productCode]").val(productCode);
		$('#delType').val('small');
		$('.tc div.fontColorRed').remove();
		$('.tc').append('<div class="pt05 fontColorRed">ㆍ삭제시 하위 코드 모두 삭제 됩니다.</div>');
	}
	
	//삭제전 데이터 준비
	function productDelete(){
	  	var action = 'delete';
		var	param = $('#frmDelete').serialize();
		deleteAjax(param, action);
	}
	
	// 상품 삭제시 사용(공통)
	function deleteAjax(param, action) {
	  	$.ajax({
			type : 'post',
			url : '/product/' + action,
			data : param,
			dataType : 'text',
			error: function(request, status, error){
				console.log(request.responseText);
				alert(request.responseText);
			},
			success : function(result) {
				alert('정상작으로 삭제 되었습니다.')
				$("#page").val(page);
				$("#searchFrm").submit();
			}
		});
	}
	
	/** 포장정보 조회 레이어 및 데이터 노출
	 1. 패캐징 탭 정보 조회
	 2. 패캐징 정보 있는 경우 탭 노출
	      - 첫번째 탭 기준으로 상품 부위 정보 조회
	      - 등록 포장정보 목록을 조회
	      - 목록중 첫번째 데이터 노출
	 3. 패캐징 정보 없는 경우 탭 및 재질 정보 조회 후 등록할수 있게 작업
	**/
	function openProductPackagingLayer(productCode, productNm, self){
		selectedProductCode = productCode;
		selectedProductNm = productNm;
		$('#detailTitle').text('상품포장정보('+productNm+')');
		$('#tab-list').empty();
		$('#tab-list li.active').removeClass('active');
		$('.tabnav04 a:first').addClass('active');
		$.ajax({
				url : '/product/detail/selectProductPackaging',
				dataType : 'JSON',
				data : {'productCode':productCode},
				type : "POST",
				async: false,
				error: function(request, status, error){
					console.log(request.responseText);
					alert(request.responseText);
				},
				success : function(data) {
					if (data.length > 0) {
						data.forEach(function(item, index) {
							var packagingOrder = item.packagingOrder;
							if(item.packagingOrder > 10) {
								packagingOrder = '부속포장';
							}else {
								packagingOrder = item.packagingOrder +'차 포장';
							}
							if(self){
								$('#self-tab-list').append('<li class="active"><a href="#" onclick=\'getProdPackagingSelfList("'+item.packagingId+'", this);\' role="tab" data-toggle="tab"><span>' +
										packagingOrder +
								        ' ('+item.groupNm+')</span><button class="tab-close" type="button"  onclick=\'deleteProductPackagingSelfTab("'+ item.packagingId + '", this);\' title="Remove this page">×</button></a></li>'
								     );
								layerPopup($('#selfDetail'));

								// 텝 추가후 1차 포장자가진단 정보 서버에서 조회 함
								if(index == 0) {
									getProdPackagingSelfList(item.packagingId);
								}
							}else {
								$('#tab-list').append('<li class="active"><a href="#" onclick=\'getProdPackagingDetailList("'+item.packagingId+'", this);\' role="tab" data-toggle="tab"><span>' +
										packagingOrder +
								        ' ('+item.groupNm+')</span><button class="tab-close" type="button"  onclick=\'deleteProductPackagingTab("'+ item.productCode + '", "'+ item.packagingId + '", "'+ item.packagingOrder + '", this);\' title="Remove this page">×</button></a></li>'
								     );
								
								// 텝 추가후 1차 포장정보 서버에서 조회 함
								if(index == 0) {
									//제품 부위 타입(몸채, 등등)
									getProductPartList(item.groupId, 'tab-list', 'selfpartCode1', item.groupNm, item);
									tabID = item.packagingOrder;
								}
								layerPopup($('#packagingDetail'));
							}
						});
					}else {
						if(!self){
							getPodPackagingOrderNmList(productCode);
							getMatTypeList();
						}

					}
				}
	    });
	}
	
	// 포장등록 안 되어 있으면 등록 레이어 노출
	function getPodPackagingOrderNmList(productCode){
		 $.ajax({
			type : 'post',
			url : '/product/detail/selectProdPackagingOrderNmList/',
			dataType : 'json',
			data : {'productCode':productCode},
			error: function(request, status, error){
				console.log(request.responseText);
			},
			success : function(result) {
				$("#frmPackagingOrder select[name=packagingOrder]").empty();
				$("#frmPackagingOrder select[name=packagingOrder]").append('<option value="">선택</option>');
				if (result.length > 0) {
					result.forEach(function(item, index) {
						$("#frmPackagingOrder select[name=packagingOrder]").append('<option value="'+item.packagingOrder+'">'+item.packagingOrderNm+'</option>');
						if(result.length == 1) {
							$('#packagingOrderNmApply option[value="'+item.packagingOrder+'"]').attr("selected", "selected");
							if(item.packagingOrder > 10){
								$('#matTypeSelectProductCode').show();
								$('#showMappedProductCode').show();
								$('#matTypeSelectProductMatType').hide();
							}else {
								$('#matTypeSelectProductMatType').show();
								$('#matTypeSelectProductCode').hide();
								$('#showMappedProductCode').hide();
							}
						}
					});
					$("#insertPackagingOrder").modal('show');
				}
			}
		});
    }

	//재질유형 조회
	function getMatTypeList() {
	    $.ajax({
			url : '/product/detail/selectProductMatTypeList',
			dataType : 'JSON',
			type : "POST",
			error: function(request, status, error){
				console.log(request.responseText);
				alert(request.responseText);
			},
			success : function(data) {
				console.log(data);
				$("#frmPackagingOrder select[name=groupIdList]").empty();
				$("#frmPackagingOrder select[name=groupIdList]").append('<option value="">선택</option>');
				if (data.length > 0) {
					data.forEach(function(item, index) {
						$("#frmPackagingOrder select[name=groupIdList]").append('<option value="'+item.codeId+'">'+item.groupCodeNm+'</option>');
// 						if(data.length == 1)$('#matTypeSelectBox option[value="'+item.codeId+'"]').attr("selected", "selected");
					});
				}
			}
		});
	}

	//패캐징 정보 처음 등록시 레이어 호출
	function addPackagingTab() {
		  var groupId = $("#frmPackagingOrder select[name=groupIdList]").val();
		  var packagingOrder = $("#frmPackagingOrder select[name=packagingOrder]").val();
		  var selectedPackagingOrderNmText = $("#frmPackagingOrder select[name=packagingOrderNm] option:selected").text();
		  var mappingProductCode = $("#frmPackagingOrder input[name=mappingProductCode]").val();
		  var mappedGroupId = $("#frmPackagingOrder input[name=mappedGroupId]").val();
		  var mappedProductCodeChecked = $("#mappedProductCode").is(':checked');
		  if(!packagingOrder) {
			alert('포장차수를 선택해주세요.');
			return;
		  }
		  
		  if(packagingOrder > 10 && mappedProductCodeChecked === true) {
				if($("#frmPackagingOrder input[name=subProductCode]").val() !== '') {
					if($("#frmPackagingOrder input[name=subProductCode]").val() === selectedProductCode){
						alert('동일한 상품을 부속포장으로 할수 없습니다.');
						return;
				    }else {
				    	$("#frmPackagingOrder input[name=subProductCode]").val(selectedProductCode);
						$("#frmPackagingOrder input[name=codeId]").val(groupId);
						$("#frmPackagingOrder input[name=groupId]").val(groupId.split("_")[0]);
						insertProductPackagingAjax();
					}
				}else {
					alert('등록된 부속상품코드를 입력해주세요.');
					return;
				}
		  }else {
			  if(groupId) {
				//포장 차수 및 재질유형을 선택했을 경우에 패캐징 정보 등록 해줌
				$("#frmPackagingOrder input[name=productCode]").val(selectedProductCode);
				$("#frmPackagingOrder input[name=codeId]").val(groupId);
				$("#frmPackagingOrder input[name=groupId]").val(groupId.split("_")[0]);
				insertProductPackagingAjax();
			  }else {
				 alert('재질유형을 선택해주세요');
			  }
		  }
	}
	
	//상품 패캐지 정보 등록
	function insertProductPackagingAjax() {
		var param = $('#frmPackagingOrder').serialize();

		$.ajax({
			type : 'post',
			url : '/product/insert/productPackaging/',
			dataType : 'text',
			data : param,
			error : function(request, status, error) {
				console.log(request.responseText);
				alert(request.responseText);
			},
			success : function(result) {
				//레이어창 취소
				$("#insertPackagingOrder").modal('hide');
				//포장정보 레이어 노출 시킴
				openProductPackagingLayer(selectedProductCode, selectedProductNm);
			}
		});
	}
	
	//상품 부위 정보 조회
	function getProductPartList(inGroupId, id, nextId, codeNm, packageData) {
		    $.ajax({
			url : '/product/detail/selectProductPartList',
			dataType : 'JSON',
			type : "POST",
			data : {'inGroupId': inGroupId},
			error: function(request, status, error){
				console.log(request.responseText);
				alert(request.responseText);
			},
			success : function(data) {
				console.log(data);
				$('#'+nextId).empty();
				if (data.length > 0) {
					data.forEach(function(item, index) {
							var innerHtml = "";
						    innerHtml = '<li class="button btn-radius" onclick=\'showMatType("'+item.codeId+'", "'+item.codeNm+'", this);\'>'+item.codeNm+'</li>';
							$('#'+nextId+":last").append(innerHtml);
							if(index == 0) {
								showMatType(item.codeId, item.codeNm);
								if(packageData) {
									getProdPackagingDetailList(packageData.packagingId);
								}else {
									$('.mytable_1_in > div').empty();
								    $('.mytable_1_in').hide();
									var innerHtml = "";
								    innerHtml = '<li><a class="button btn-radius" href="#"><span onclick=\'getProdPackagingDetail("", "", this, "'+item.codeId+'", "'+item.codeNm+'");\'>'+item.codeNm+'</span><button type="button"  onclick=\'deletePackagingId("", this);\' style="color:black;height:0px;line-height:10px;margin-left:1px;background:transparent;" title="Remove this page">×</button></li>';
								    $('#partCodeDetail').empty();
								    $('#partCodeDetail:last').append(innerHtml);
								    $('#partCodeDetail').show();
								    $('#mytable_1_in1').empty();
								    $('#mytable_1_in1:last').append(getProductDetailInfoHtml(item.codeId, item.codeNm));
									$('#tab04_1_in1').show();
								}
								$("#detail").modal('show');
							}
					});
				}
			}
		});
	}

	//상품 부위 정보 활성화
	function showMatType(codeId, codeNm, obj) {
		selectedPartCode=codeId;
		selectedPartNm=codeNm; 
		  
		$('#selfpartCode1 li.on').removeClass('on');
		if(obj) {
		 $(obj).addClass('on');
		}else {
			$('#selfpartCode1 li:first').addClass('on');
		}
	}
	
	//등록된 패캐지 부위목록 조회
	function getProdPackagingDetailList(packagingId, obj){
	  selectedPackagingId = packagingId;
	  $('.tabnav04 a.active').removeClass('active');
	  $('.tabnav04 a:first').addClass('active');
	  $('#tab04_2').hide();
	  $('#tab04_1').show();
	  $.ajax({
			url : '/product/detail/selectProdPackagingDetailList',
			dataType : 'JSON',
			data : {'packagingId': packagingId},
			type : "POST",
			async: false,
			error: function(request, status, error){
				console.log(request.responseText);
				alert(request.responseText);
			},
			success : function(data) {
				$('#tab04_1_in1').children().empty();
				$('#partCodeDetail').empty();
				if (data.length > 0) {
					data.forEach(function(item, index) {
// 						console.log(item);
						var innerHtml = "";
					   
					 // 텝 추가후 1차 포장정보 서버에서 조회 함
						if(index == 0) {
							innerHtml = '<li><a class="button btn-radius on" href="#"><span onclick=\'getProdPackagingDetail("'+item.packagingId+'", "'+item.packagingDetailId+'", this, "'+item.partCode+'", "'+item.partNm+'");\'>'+item.partNm+'</span></span><button type="button"  onclick=\'deletePackagingId("'+item.packagingDetailId+'", this);\' style="color:black;height:0px;line-height:10px;margin-left:1px;background:transparent;" title="Remove this page">×</button></li>';
							getProdPackagingDetail(item.packagingId, item.packagingDetailId, null, item.partCode, item.partNm);
						}else {
							innerHtml = '<li><a class="button btn-radius" href="#"><span onclick=\'getProdPackagingDetail("'+item.packagingId+'", "'+item.packagingDetailId+'", this, "'+item.partCode+'", "'+item.partNm+'");\'>'+item.partNm+'</span><button type="button"  onclick=\'deletePackagingId("'+item.packagingDetailId+'", this);\' style="color:black;height:0px;line-height:10px;margin-left:1px;background:transparent;" title="Remove this page">×</button></li>';
						}
						$('#partCodeDetail:last').append(innerHtml);
						$('#partCodeDetail').show();
					});
				}else {
					var innerHtml = "";
				    innerHtml = '<li><a  class="button btn-radius on" href="#"><span onclick=\'getProdPackagingDetail("", "", this, "'+selectedPartCode+'", "'+selectedPartNm+'");\'>'+selectedPartNm+'</span><button type="button"  onclick=\'deletePackagingId("", this);\' style="color:black;height:0px;line-height:10px;margin-left:1px;background:transparent;" title="Remove this page">×</button></li>';
				    $('#partCodeDetail:last').append(innerHtml);
				    $('#partCodeDetail').show();
				    $('#mytable_1_in1').empty();
			        $('#mytable_1_in1:last').append(getProductDetailInfoHtml(selectedPartCode, selectedPartNm, packagingId));
				}
		        
		        $('#tab-list li.active').removeClass('active');
		        if(obj) {
		        	$(obj).parent().addClass('active');
			    }else {
			    	$('#tab-list li:first').addClass('active');
				}
				$('#tab04_1_in1').show();
			}
		});
	  }

	//packaging 상세 정보 조회 및 등록 화면 구성
	function getProductDetailInfoHtml(partCode, partCodeNm, packagingId, data) {
	  var matInfo = "";
	  var weight = "";
	  var standard = "";
	  var color = "";
	  var summary = "";
	  var packagingDetailId = "";
	  var packagingOrder = "";
	  var matFileNm ="";
	  var matFileId ="";
	  var managerId ="";
	  if(data) {
		  matInfo = data.matInfo; 
		  weight = data.weight; 
		  standard = data.standard; 
		  color = data.color; 
		  summary = data.summary; 
		  packagingDetailId = data.packagingDetailId;
		  packagingOrder = data.packagingOrder;
		  matFileNm = data.matFileNm;
		  matFileId = data.matFileId;
		  matFileId = data.matFileId;
		  managerId = data.managerId;
	  }else {
		  packagingOrder = tabID;
	  }
		var innerHtml = "";
		innerHtml += '<div class="addbox pt10">';
		innerHtml += '<h4 class="tl pt15"><span class=title-point>['+partCodeNm+']</span></h4>';
		innerHtml += '<div class=row>';
		innerHtml += '<div class=col-50>';
		innerHtml += '<div class=form-group>';
		innerHtml += '<label class="col-25 form-label">재질정보</label>';
		innerHtml += '<div class=col-75>';
		innerHtml += '<div class=form-input>';
		innerHtml += '<input type=hidden name="packagingId" value="'+packagingId+'">';
		innerHtml += '<input type=hidden name="packagingDetailId" value="'+packagingDetailId+'">';
		innerHtml += '<input type=hidden name="partCode" value="'+partCode+'">';
		innerHtml += '<input type=hidden name="partCodeNm" value="'+partCodeNm+'">';
		innerHtml += '<input type=text class=text-input name="matInfo" value="'+matInfo+'">';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '<div class=col-50>';
		innerHtml += '<div class=form-group>';
		innerHtml += '<label class="col-25 form-label">포장재 중량(g)</label>';
		innerHtml += '<div class=col-75>';
		innerHtml += '<div class=form-input>';
		innerHtml += '<input type=number step=0.01 placeholder="내용물을 제외한 전체포장재만의 무게" class=text-input name="weight" value="'+weight+'">';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '<div class=col-50>';
		innerHtml += '<div class=form-group>';
		innerHtml += '<label class="col-25 form-label">규격(mm)</label>';
		innerHtml += '<div class=col-75>';
		innerHtml += '<div class=form-input>';
		innerHtml += '<input type=text class=text-input name="standard" placeholder="장*폭*고(원혈일 경우 지름*지름*고)" value="'+standard+'">';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '<div class=col-50>';
		innerHtml += '<div class=form-group>';
		innerHtml += '<label class="col-25 form-label">색상</label>';
		innerHtml += '<div class=col-75>';
		innerHtml += '<div class=form-input>';
		innerHtml += '<input type=text class=text-input name="color" placeholder="색상기입/해당없음" value="'+color+'">';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '<div class=col-100>';
		innerHtml += '<div class=form-group>';
		innerHtml += '<label class="col-25 form-label-textarea">추가설명</label>';
		innerHtml += '<div class=col-75>';
		innerHtml += '<div class=form-input>';
		innerHtml += '<textarea class=textarea name="summary">'+summary+'</textarea>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '<h4 class="tl pt15"><span class=title-point>[업체담당자정보]</span></h4>';
		innerHtml += '<div class=row>';
		innerHtml += '<div class=col-50>';
		innerHtml += '<div class=form-group>';
		innerHtml += '<label class="col-25 form-label">공급업체</label>';
		innerHtml += '<div class=col-75>';
		innerHtml += '<div class=form-input>';
		innerHtml += '<select name="supplierCode" class="select-box supplierCode">';
		innerHtml += '<option value="">선택</option>';
		<c:forEach items="${suppliers}" var="supplier" varStatus="status">
			innerHtml += '<option value="${supplier.supplierCode}">${supplier.supplierNm}</option>';
		</c:forEach>
		innerHtml += '</select>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '<div class=col-50>';
		innerHtml += '<div class=form-group>';
		innerHtml += '<label class="col-25 form-label">담당자</label>';
		innerHtml += '<div class=col-75>';
		innerHtml += '<div class=form-input>';
		innerHtml += '<select name="managerIdList" class="select-box supplierManager">';
		innerHtml += '</select>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '<div class=col-100>';
		innerHtml += '<div class=form-group>';
		innerHtml += '<label class="col-25 form-label">이메일</label>';
		innerHtml += '<div class=col-75>';
		innerHtml += '<div class=search-box>';
		innerHtml += '<input type=hidden name="managerId" value="'+managerId+'" class="text-input managerId">';
		innerHtml += '<input name="supplierNm" type=hidden class="text-input supplierNm">';
		innerHtml += '<input name="managerNm" type=hidden class="text-input managerNm">';
		innerHtml += '<input name="managerMail" type=text class="text-input supplierMail">';
		innerHtml += '<span class=search-box-append>';
		innerHtml += '<button type=button class="btn-search sendEmail">이메일보내기</button>';
		innerHtml += '</span>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '<h4 class="tl pt15"><span class=title-point>[첨부파일]</span></h4>';
		innerHtml += '<div class=row>';
		innerHtml += '<div class=col-100>';
		innerHtml += '<div class=form-group>';
		innerHtml += '<label class="col-25 form-label">포장재질증명서</label>';
		innerHtml += '<div class=col-75>';
		innerHtml += '<div class=search-box>';
		innerHtml += '<input type=text disabled class=text-input value='+matFileNm+'>';
		innerHtml += '<span class=search-box-append>';
		innerHtml += '<button type=button class=btn-search onclick=\'downloadFile("'+matFileId+'");\'>다운로드</button>';
		innerHtml += '</span>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		return innerHtml;
	}  

	//첨부파일 다운로드
	function downloadFile(id) {
		if(id != '') {
			window.open('/file/detail/'+id, '_blank').focus();
		}
	}

	//패캐징 상세정보 저장 전 검증
	function saveProdPackagingDetail() {
		var check = valyCheck("savePackaging");
		if(check){
			var param =  $('#frmDetail').serialize();
		  	var packagingDetailId = $("#frmDetail input[name=packagingDetailId]").val();
		  	console.log(packagingDetailId);
		  	if(packagingDetailId == '' || packagingDetailId == null) {
		  		saveProductPackagingDetailAjax(param,'insert');
		  	}else {
				saveProductPackagingDetailAjax(param,'update');
		  	}
		}
	}

	// 상품포장정보등록 수정
	  function saveProductPackagingDetailAjax(param, action, sendMail) {
		    $.ajax({
			type : 'post',
			url : '/product/'+action+'/prodPackagingDetail/',
			data : param,
			dataType : 'text',
			error: function(request, status, error){
				console.log(request.responseText);
				alert(request.responseText);
			},
			success : function(result) {
				$('#btn-add-tab').show();
				var data = JSON.parse(result);
				console.log(data.packagingDetailId);
				$("#frmDetail input[name=packagingDetailId]").val(data.packagingDetailId);
				if(sendMail) {
					sendEmail($('#frmDetail').serialize());
				}else {
					alert("정상적으로 저장되었습니다.")
				}
			}
		});
	  }

	// 담당자 검색
	  function managersView(id, managerId) {
	    $.ajax({
			url : '/supplier/supplier/detail/managers/' + id,
			dataType : 'JSON',
			type : "POST",
			error: function(request, status, error){
				console.log(request.responseText);
				alert(request.responseText);
			},
			success : function(data) {
				$('.supplierManager').empty();
				$('.supplierManager').append("<option value=''>선택</option>");
				if (data.length > 0) {
					data.forEach(function(item, index) {
						$('.supplierManager').append("<option value=" + item.managerId +"||"+item.managerMail +">" + item.managerNm + "</option>");
						console.log(managerId+">>>"+item.managerId);
						if(managerId == item.managerId) {
							$('.supplierManager option[value="'+item.managerId +"||"+item.managerMail+'"]').attr("selected", "selected");
							$('.supplierMail').val(item.managerMail);
						}
					});
				}
			}
		});
	  }

	  //이메일 전송 테스트
	  function sendEmail(param) {
	    $.ajax({
			url : '/api/v1/call/sendMail',
			dataType : 'text',
			data : param,
			type : "POST",
			error: function(request, status, error){
				console.log(request.responseText);
				alert(request.responseText);
			},
			success : function(data) {
				alert("정상적으로 이메일 전송이 되었습니다.");
			}
		});
	 }

	  //포장 상세정보
	 function getProdPackagingDetail(packagingId, packagingDetailId, obj, partCode, partNm){
		    $('#mytable_1_in1').empty();
			if(packagingDetailId == '' || packagingDetailId == null || packagingDetailId == 'undefined') {
				$('#mytable_1_in1:last').append(getProductDetailInfoHtml(partCode, partNm, packagingId));
				$('#partCodeDetail a').removeClass('on');
		        if(obj) {
		        	$(obj).parent().addClass('on');
			    }else {
			    	$('#partCodeDetail a:first').addClass('on');
				}
		        
				$('#tab04_1_in1').show();
				return true;
			}
			
			$.ajax({
				url : '/product/detail/selectProdPackagingDetail/',
				dataType : 'JSON',
				data : {'packagingDetailId': packagingDetailId},
				type : "POST",
				async: false,
				error: function(request, status, error){
					console.log(request.responseText);
					alert(request.responseText);
				},
				success : function(data) {
			        $('#mytable_1_in1:last').append(getProductDetailInfoHtml(data.partCode, data.partNm, packagingId, data));
			        $('.supplierCode option[value="'+data.supplierCode+'"]').attr("selected", "selected");
			        managersView(data.supplierCode, data.managerId);
			        
			        $('#partCodeDetail a').removeClass('on');
			        if(obj) {
			        	$(obj).parent().addClass('on');
				    }else {
				    	$('#partCodeDetail a:first').addClass('on');
					}
					
					$('#tab04_1_in1').show();
				}
			});
	  }

	  //포장상세정보 삭제전 검증
	 function deletePackagingId(packagingDetailId, obj)	{
		  var result = confirm("삭제하시겠습니까?");
		  if(result) {
			$(obj).parent().parent().remove();
			if(packagingDetailId == null || packagingDetailId == '' || packagingDetailId == 'undefined') {
				var lastPart = $('#partCodeDetail span:last');
				lastPart.click();
			}else {
				deletePackagingDetailAjax(packagingDetailId);
			}
		  }
	 }

	 function deletePackagingDetailAjax(packagingDetailId) {
		  	$.ajax({
			type : 'post',
			url : '/product/delete/prodPackagingDetail/',
			data : {'packagingDetailId': packagingDetailId},
			dataType : 'text',
			error: function(request, status, error){
				console.log(request.responseText);
				alert(request.responseText);
			},
			success : function(result) {
				var lastPart = $('#partCodeDetail span:last');
				lastPart.click();
			}
		});
	  }

	 // 포창 차수 삭제 버튼 클릭시
	 function deleteProductPackagingTab(productCode, packagingId, packagingOrder) {
		  var result = confirm(packagingOrder+"차 포장정보를 삭제하시겠습니까?");
		  if(result)deletePackagingInfoAjax(productCode, packagingId, packagingOrder);
	  }

	 //포창차수 삭제
	 function deletePackagingInfoAjax(productCode, packagingId, packagingOrder) {
		  	$.ajax({
			type : 'post',
			url : '/product/delete/productPackaging',
			data : {'packagingId': packagingId},
			dataType : 'text',
			error: function(request, status, error){
				console.log(request.responseText);
				alert(request.responseText);
			},
			success : function(result) {
				var lastPart = $('#tab-list span:last');
				lastPart.click();
			}
		});
	  }

	  //자가진단 설정하여 패캐징 정보 조회 후  레이어 호출
	  function openProductPackagingSelfLayer(productCode, productNm) {
		  openProductPackagingLayer(productCode, productNm, true);
	  }

	  //자가진단 목록 조회
	  function getProdPackagingSelfList(packagingId) {
		     selectedPackagingId = packagingId;
		     var param = {};
			 param.packagingId=packagingId;
			 
			 $.ajax({
				type : 'post',
				url : '/product/detail/selectProdPackagingSelfList/',
				data : param,
				dataType : 'json',
				error: function(request, status, error){
					console.log(request.responseText);
				},
				success : function(result) {
					var selfPackInfo = "";
					var orgResult = result;
					var partCode = "";
					var gradeCode = "";
					console.log(orgResult);
					$("#Accordion_wrap").empty();
					result.forEach(function(item, index) {
						if(partCode !== item.partCode){
							selfPackInfo += '<div class="Accordion-box">';
							selfPackInfo += '<h4 class="que pt15 choice-title" id="'+item.groupId.split('_')[0]+'_'+item.groupId.split('_')[1]+'"><span class="title-point">['+item.partNm+']</span></h4>';
							selfPackInfo += '	<div class="anw">';
							selfPackInfo += '	            <ul class="choice-wrapper">';
							orgResult.forEach(function(sItem, index) {
								if(gradeCode !== sItem.gradeCode && item.partCode == sItem.partCode){
									
									selfPackInfo += '	              <li class="choice-box">';
									selfPackInfo += '	                <h4 class="line-br">재활용-'+sItem.gradeNm+'</h4>';
									selfPackInfo += '	                <div class="choice-cont">';
									selfPackInfo += '	                  <ul>';
									orgResult.forEach(function(lItem, index) {
										if(lItem.gradeCode == sItem.gradeCode && lItem.partCode == sItem.partCode){
											selfPackInfo += '	                    <li><input type="checkbox" '+lItem.checked+' value="'+lItem.groupId+'||'+lItem.codeId+'" id="'+lItem.groupId.split('_')[0]+'_'+lItem.groupId.split('_')[1]+'-'+index+'" data-key="'+sItem.partCode+'" data-a="'+lItem.rptMatStruct+'" data-b="'+lItem.rptDevAnal+'" data-c="'+lItem.rptVisualJudg+'" data-d="'+lItem.rptTest+'" data-e="'+lItem.rptPermission+'" data-f="'+lItem.rptEtc+'" name="checkbox_self" class="checkbox_'+item.groupId.split('_')[0]+'_'+item.groupId.split('_')[1]+'" onclick=\'chkClick(this);\'><label for="">'+lItem.codeNm+'</label></li>';
										}
									});
									selfPackInfo += '	                  </ul>';
									selfPackInfo += '	                </div>';
									selfPackInfo += '	              </li>';

									gradeCode = sItem.gradeCode;
								}
							});
	
							var chk_rptMatStruct = "";
							var chk_rptDevAnal = "";
							var chk_rptVisualJudg = "";
							var chk_rptTest = "";
							var chk_rptPermission = "";
							var chk_rptEtc = "";
	// 						result.selfPackagingModels.forEach(function(selfItem, index) {
	// 							if(selfItem.file === 'rptMatStruct_'+item.codeId){
	// 								chk_rptMatStruct = "checked";
	// 							}
	// 							if(selfItem.file === 'rptDevAnal_'+item.codeId){
	// 								chk_rptDevAnal = "checked";
	// 							}
	// 							if(selfItem.file === 'rptVisualJudg_'+item.codeId){
	// 								chk_rptVisualJudg = "checked";
	// 							}
	// 							if(selfItem.file === 'rptTest_'+item.codeId){
	// 								chk_rptTest = "checked";
	// 							}
	// 							if(selfItem.file === 'rptPermission_'+item.codeId){
	// 								chk_rptPermission = "checked";
	// 							}
	// 							if(selfItem.file === 'rptEtc_'+item.codeId){
	// 								chk_rptEtc = "checked";
	// 							}
	// 						});
							
							selfPackInfo += '				  <li class="choice-box2">';
							selfPackInfo += '                    <h4 class="line-br">판정방법</h4>';
							selfPackInfo += '                    <div class="choice-cont2">';
							selfPackInfo += '                      <ul>';
							selfPackInfo += '                        <li><input type="checkbox" class="word_check-'+item.groupId.split('_')[0]+'_'+item.groupId.split('_')[1]+'" '+chk_rptMatStruct+' value="'+item.groupId+'||'+item.codeId+'" name="chk_rptMatStruct" id="chk_rptMatStruct-'+item.groupId.split('_')[0]+'_'+item.groupId.split('_')[1]+'"  onclick="return false;"><label for="chk_rptMatStruct-'+item.codeId+'" style="margin:0 4px">포장재질구조증명서</label><input type="file" name="RPT_MAT_STRUCT-'+item.partCode+'" multiple="multiple" class="afile-txt" id="file_rptMatStruct-'+item.codeId+'"></li>';
		  					selfPackInfo += '                        <li><input type="checkbox" class="word_check-'+item.groupId.split('_')[0]+'_'+item.groupId.split('_')[1]+'" '+chk_rptDevAnal+' value="'+item.groupId+'||'+item.codeId+'" name="chk_rptDevAnal" id="chk_rptDevAnal-'+item.groupId.split('_')[0]+'_'+item.groupId.split('_')[1]+'"  onclick="return false;"><label for="chk_rptDevAnal-'+item.codeId+'" style="margin:0 4px">기기분석</label><input type="file" name="RPT_DEV_ANAL-'+item.partCode+'" multiple="multiple" class="afile-txt" id="file_rptDevAnal-'+item.codeId+'"></li>';
		   					selfPackInfo += '                        <li><input type="checkbox" class="word_check-'+item.groupId.split('_')[0]+'_'+item.groupId.split('_')[1]+'" '+chk_rptVisualJudg+' value="'+item.groupId+'||'+item.codeId+'" name="chk_rptVisualJudg" id="chk_rptVisualJudg-'+item.groupId.split('_')[0]+'_'+item.groupId.split('_')[1]+'"  onclick="return false;"><label for="chk_rptVisualJudg-'+item.codeId+'" style="margin:0 4px">육안판정</label><input type="file" name="RPT_VISUAL_JUDGE-'+item.partCode+'" multiple="multiple" class="afile-txt" id="file_rptVisualJudg-'+item.codeId+'"></li>';
		   					selfPackInfo += '                        <li><input type="checkbox" class="word_check-'+item.groupId.split('_')[0]+'_'+item.groupId.split('_')[1]+'" '+chk_rptTest+' value="'+item.groupId+'||'+item.codeId+'" name="chk_rptTest" id="chk_rptTest-'+item.groupId.split('_')[0]+'_'+item.groupId.split('_')[1]+'"  onclick="return false;"><label for="chk_rptTest-'+item.codeId+'" style="margin:0 4px">공인시험성적서</label><input type="file" name="RPT_TEST-'+item.partCode+'" multiple="multiple" class="afile-txt" id="file_rptTest-'+item.codeId+'"></li>';
		   					selfPackInfo += '                        <li><input type="checkbox" class="word_check-'+item.groupId.split('_')[0]+'_'+item.groupId.split('_')[1]+'" '+chk_rptPermission+' value="'+item.groupId+'||'+item.codeId+'" name="chk_rptPermission" id="chk_rptPermission-'+item.groupId.split('_')[0]+'_'+item.groupId.split('_')[1]+'"  onclick="return false;"><label for="chk_rptPermission-'+item.codeId+'" style="margin:0 4px">신고허가서류</label><input type="file" name="RPT_PERMISSION-'+item.partCode+'" multiple="multiple" class="afile-txt" id="file_rptPermission-'+item.codeId+'"></li>';
		   					selfPackInfo += '                        <li><input type="checkbox" class="word_check-'+item.groupId.split('_')[0]+'_'+item.groupId.split('_')[1]+'" '+chk_rptEtc+' value="'+item.groupId+'||'+item.codeId+'" name="chk_rptEtc" id="chk_rptEtc-'+item.groupId.split('_')[0]+'_'+item.groupId.split('_')[1]+'"  onclick="return false;"><label for="chk_rptEtc-'+item.codeId+'" style="margin:0 4px">기타</label><input type="file" name="RPT_ETC-'+item.partCode+'" multiple="multiple" class="afile-txt" id="file_rptEtc-'+item.codeId+'"></li>';
							selfPackInfo += '                      </ul>';
							selfPackInfo += '    				 </div>';
							selfPackInfo += '                  </li>';
							selfPackInfo += '            </ul>';
	//	                                 <!-- E_결과확인-->
		                    selfPackInfo += '           </div>';
		                    selfPackInfo += '</div>';
		                    partCode = item.partCode;
						}
					});
					$("#Accordion_wrap").append(selfPackInfo);
					$('.afile-txt').MultiFile({
				        // 옵션 설정
				        max: 1, //업로할수있는 최대 파일 갯수
				        accept: 'txt|pptx|xlsx|pdf|hwp', //허용할수있는 파일 확장자
				        STRING: { //Multi-lingual support : 메시지 수정 가능
				          //remove : "제거", //추가한 파일 제거 문구, 이미태그를 사용하면 이미지사용가능
				          duplicate: "$file 은 이미 선택된 파일입니다.",
				          denied: "$ext 는(은) 업로드 할수 없는 파일확장자입니다.",
				          selected: '$file 을 선택했습니다.',
				          toomany: "업로드할 수 있는 최대 갯수는 $max개 입니다.",
				        }
				      });

					result.files.forEach(function(f, index) {
						result.middleModels.forEach(function(item, index) {
							console.log(f.refId.split('_pd')[0]);
							console.log(f.refId.split('-')[0]+'-'+item.codeId);
							console.log('#file_'+f.refId.split('_pd')[0]+'  > .MultiFile-list');
							if(f.refId.split('_pd')[0] === f.refId.split('-')[0]+'-'+item.codeId){
								$('#file_'+f.refId.split('_pd')[0]+'  > .MultiFile-list').append('<div class="MultiFile-label"><a class="MultiFile-remove" href="#" onclick=\'deleteFileAjax("'+f.fileId+'","","'+f.refId+'", this);\'>x</a> <span><span class="MultiFile-label" title='+f.fileNm+' 을 선택했습니다." onclick=\'downloadFile("'+f.fileId+'");\'><span class="MultiFile-title">'+f.fileNm+'</span></span></span></div>');
							}			
						});				
					});
				}
			});
	  }

	  //자가진단 항목 선택시
	  var aJsonArray = new Array();
	  function chkClick(that){
	 		var id = $(that).attr('id');
			if(id.split('-')[0].split('_')[1] == 'B'){
	 			if($('.checkbox_'+id.split('-')[0]).is(':checked')){
			   		$('.checkbox_'+id.split('-')[0]).prop('checked',false);
	 			}
	 			$('#'+id).prop('checked', true);
	 		}else{
	 			if(!$('.checkbox_'+id.split('-')[0]).is(':checked')){
	 				console.log('>> '+$(that).attr('data-Key'));
	 				if($(that).attr('data-Key') == 'D'){
	      			if(grade.indexOf(id.split('-')[0]) == -1){
	      				grade.push(id.split('-')[0]);
	      			}else{
	      				for (var i = 0; i < grade.length; i++) {
	              		    if (grade[i] === id.split('-')[0]) {
	              		    	grade.splice(i, 1);
	              		    }
	              		}
	      			}
	          	}
	 			}
	 		}
			
			var rptMatStruct = $(that).attr('data-a');
			var rptDevAnal = $(that).attr('data-b');
			var rptVisualJudg = $(that).attr('data-c');
			var rptTest = $(that).attr('data-d');
			var rptPermission = $(that).attr('data-e');
			var rptEtc = $(that).attr('data-f');
			$('.word_check-'+id.split('-')[0]).prop('checked',false);
			
			// 몸체는 단독체크, 그외 멀티체크 분리
			if(id.split('-')[0].split('_')[1] == 'B'){
				if(rptMatStruct == 'Y'){
					$('#chk_rptMatStruct-'+id.split('-')[0]).prop('checked',true);
				}
				if(rptDevAnal == 'Y'){
					$('#chk_rptDevAnal-'+id.split('-')[0]).prop('checked',true);
				}
				if(rptVisualJudg == 'Y'){
					$('#chk_rptVisualJudg-'+id.split('-')[0]).prop('checked',true);
				}
				if(rptTest == 'Y'){
					$('#chk_rptTest-'+id.split('-')[0]).prop('checked',true);
				}
				if(rptPermission == 'Y'){
					$('#chk_rptPermission-'+id.split('-')[0]).prop('checked',true);
				}
				if(rptEtc == 'Y'){
					$('#chk_rptEtc-'+id.split('-')[0]).prop('checked',true);
				}
			}else{
				var aJson = new Object();
				var bJson = new Object();
				bJson.rptMatStruct = rptMatStruct;
				bJson.rptDevAnal = rptDevAnal;
				bJson.rptVisualJudg = rptVisualJudg;
				bJson.rptTest = rptTest;
				bJson.rptPermission = rptPermission;
				bJson.rptEtc = rptEtc;
				aJson.codeId = id;
				
				var chk = false;
				console.log(aJsonArray.length);
				aJsonArray.forEach(function(item,index){
					console.log(index);
					if(item.codeId == id){
						console.log(item.codeId);
						console.log(id);
						chk = true;
						aJsonArray.splice(index, 1);
					}
				})
				if(aJsonArray.length == 0 && !chk){
					aJson.value = bJson;
					aJsonArray.push(aJson);
				}else{
					if(!chk){
						aJson.value = bJson;
						aJsonArray.push(aJson);
					}
				}
				
				aJsonArray.forEach(function(item){
					if(item.value.rptMatStruct == 'Y'){
						$('#chk_rptMatStruct-'+id.split('-')[0]).prop('checked',true);
					}
					if(item.value.rptDevAnal == 'Y'){
						$('#chk_rptDevAnal-'+id.split('-')[0]).prop('checked',true);
					}
					if(item.value.rptVisualJudg == 'Y'){
						$('#chk_rptVisualJudg-'+id.split('-')[0]).prop('checked',true);
					}
					if(item.value.rptTest == 'Y'){
						$('#chk_rptTest-'+id.split('-')[0]).prop('checked',true);
					}
					if(item.value.rptPermission == 'Y'){
						$('#chk_rptPermission-'+id.split('-')[0]).prop('checked',true);
					}
					if(item.value.rptEtc == 'Y'){
						$('#chk_rptEtc-'+id.split('-')[0]).prop('checked',true);
					}
				})
			}
			
			
		  var isSeasonChk = false;
	      var chk = $('.checkbox_'+id.split('-')[0]);
	      for(var i=0;i<chk.length;i++){
	          if(chk[i].checked == true) {
	          	if($(that).attr('data-Key') == 'D'){
	              	isSeasonChk = true;
	      			if(grade.indexOf(id.split('-')[0]) == -1){
	      				grade.push(id.split('-')[0]);
	      			}
	              	break;
	          	}else{
	          		if(grade.indexOf(id.split('-')[0]) > -1){
		            		for (var i = 0; i < grade.length; i++) {
		            		    if (grade[i] === id.split('-')[0]) {
		            		    	grade.splice(i, 1);
		            		    }
		            		}
	          		}
	          	}
	          }
	      }
	  }

	 //자가진단 등록
	 function insertProdPackagingSelfAjax(){
	    var res = prodPackagingSelfResult();
	    $("#frmSelfDiagnose input[name=recycleGrade]").val(res);
	    $("#frmSelfDiagnose input[name=productCode]").val(selectedProductCode);
	    $("#frmSelfDiagnose input[name=packagingId]").val(selectedPackagingId);
	    if(res){
		    	alert(res);
		}else {
			alert('결과확인이 어려웠습니다. 잘 선택이 되었는지 확인해주세요.');
			return;
		}
	    var param = [];
	    var sc = $('.choice-title').length;
	    for(var i = 0 ; i < sc ; i++){
	    	var id = $('.choice-title')[i].id;
	    	var chkList = $('.checkbox_'+id);
	    	for(var j=0;j<chkList.length;j++){
	    		if(chkList[j].checked == true) {
	    			param.push({
	    				packagingId: selectedPackagingId,
	    				groupId: (chkList[j].value).split('||')[0],
	    				codeId: chkList[j].value.split('||')[1]
		    			});
	    		}
	    	}
	    }
	    console.log('<>'+JSON.stringify(param));

	    var settings = {
   		  "url": "/product/insert/ProdPackagingSelf/",
   		  "method": "POST",
   		  "timeout": 0,
   		  "headers": {
   		    "Content-Type": "application/json"
   		  },
   		  "data": JSON.stringify(param),
   		};

   		$.ajax(settings).done(function (response) {
   		  	console.log(response);
   		 insertProdPackagingSelfFileAjax();
   		});
     }

	//자가진단 첨부파일 등록
	 function insertProdPackagingSelfFileAjax(){
		var form = $('#frmSelfDiagnose')[0];
	    var data = new FormData(form);
	  	$.ajax({
			type : 'post',
			url : '/product/insert/ProdPackagingSelfFile/',
			enctype: 'multipart/form-data',
			data : data,
			dataType : 'text',
			processData: false,
	        contentType: false,
	        cache: false,
	        timeout: 600000,
			error: function(request, status, error){
				console.log(request.responseText);
				alert(request.responseText);
			},
			success : function(result){
				alert('정상적으로 등록되었습니다.');
			    console.log(result);
			}
	   });
     }
     
     //자가진단 결과 검증
	 function prodPackagingSelfResult(){
		  var retResult = "";
		  var gradeResult = [];
	      var chkCnt = 0;
	      var sc = $('.choice-title').length;
	      var text = '';
	      var isAlert = true; 
	      for(var i = 0 ; i < sc ; i++){
	      	var id = $('.choice-title')[i].id;
	      	var chkList = $('.checkbox_'+id);
	      	console.log(id);
	      	for(var j=0;j<chkList.length;j++){
	      		if(chkList[j].checked == true) {
	      			gradeResult.push(chkList[j].dataset.key);
	      			chkCnt++;
	      			isAlert = false;
	      			if(id.split('_')[1] == 'B'){
		        			break;        				
	      			}
	      		}
	      	}
	      	text = $('.choice-title')[i].children[0].innerText;
	      	if(isAlert){
		        	alert(text+' 항목을 선택하지 않으셨습니다.');
		        	isAlert = false;
		        	break;
	      	}
	      	isAlert = true;
	      }
	      if(isAlert){
	      	var gradeNum = 0;
	      	gradeResult.forEach(function(item){
			        if(item == 'A'){
			        	if(gradeNum < 1){
//	 			        	$('.rating').text('최우수');
//	 			        	$('.rating').css('color','black');
				        	retResult = '최우수';
				        	gradeNum = 1;
			        	}
			        }else if(item == 'B'){
			        	if(gradeNum < 2){
//	 			        	$('.rating').text('우수');
//	 			        	$('.rating').css('color','black');
				        	retResult = '우수';
				        	gradeNum = 2;
			        	}
			        }else if(item == 'C'){
			        	if(gradeNum < 3){
//	 			        	$('.rating').text('보통');
//	 			        	$('.rating').css('color','black');
							retResult = '보통';
				        	gradeNum = 3;
			        	}
			        }else if(item == 'D'){
			        	if(gradeNum < 4){
//	 			        	$('.rating').text('어려움');
//	 			        	$('.rating').css('color','red');
				        	retResult = '어려움';
				        	gradeNum = 4;
			        	}
			        }
	      	})
	      	if($('.checkbox_PE_L')){
	      		var boxs = $('.checkbox_PE_L');
	      		for(var i = 0 ; i < boxs.length ; i++){
	      			if($('#'+boxs[i].id).prop('checked') && $('#'+boxs[i].id).attr('data-key') == 'A' && gradeNum != 4){
//	       				$('.rating').text('최우수');
//	       				$('.rating').css('color','black');
	      				retResult = '어려움';
	      			}
	      		}
	      	}
	      	return retResult;
//	 	        $('#score').show();
//	 	        $('.btn-success.isClose').focus();
	      }
	      return retResult;
	  }
	  
	 // 포장 자가진단 차수 삭제 버튼 클릭시
	 function deleteProductPackagingSelfTab(packagingId, packagingOrder) {
		  var result = confirm(packagingOrder+"차 자가진단 정보를 삭제하시겠습니까?");
		  if(result)deletePackagingSelfAjax(packagingId);
	 }
	  
	 //포장자가진단 삭제
	 function deletePackagingSelfAjax(packagingId) {
		  	$.ajax({
			type : 'post',
			url : '/product/delete/ProdPackagingSelf',
			data : {'packagingId': packagingId},
			dataType : 'text',
			error: function(request, status, error){
				console.log(request.responseText);
				alert(request.responseText);
			},
			success : function(result) {
				var lastPart = $('#slef-tab-list span:last');
				lastPart.click();
			}
		});
	  }
</script>