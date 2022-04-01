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
					<option value="packingType">포장유형</option>
					<option value="recycleGrade">재활용등급</option>
					<option value="masterApplyNm">상태</option>
                  </select>
                </div>
                <div class="form-inline">
                  <div class="search-box w250">
                    <input id="searchValue" name="searchValue" value="${pages.searchValue}" type="text" class="text-input">
                    <span class="search-box-append">
                      <button type="submit" class="button-search"><img src="/images/icon_search.png"
                          title="검색"></button>
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
                  <col style="width: 70px;">
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
                    <th scope="col">체크</th>
                    <th scope="col">포장정보</th>
                    <th scope="col">재활용<br>분담금결과</th>
                    <!-- <th scope="col">육안판정</th> -->
                    <th scope="col">관리</th>
                </thead>
                <tbody>
                  <c:choose>
				    <c:when test="${products.size() > 0 }">
						<c:forEach items="${products }" var="product" varStatus="status">
							<tr>
								<td>${pages.totalCount - (status.index + (pages.page -1) * pages.pageSize)}</td>
								<td><input type="text" style="border:none" id="productCode_${product.rownum}" value="${product.productCode}" readonly="readonly"  ></td>
								<td><img src="/file/view/${product.photo}"  width="70" height="auto"></td>
								<td>${product.productNm} </td>
								<td>${product.packingType}</td>
								<td class="fontColorBlue">
									<c:choose>
										<c:when test="${product.recycleGrade eq '최우수'}">
											<img src="/images/free-icon-in-love-356695.png" width="26px">
										</c:when>
										<c:when test="${product.recycleGrade eq '우수'}">
											<img src="/images/free-icon-emoji-3456813.png" width="26px">
										</c:when>
										<c:when test="${product.recycleGrade eq '적합'}">
											<img src="/images/free-icon-smile-356662.png" width="26px">
										</c:when>
										<c:when test="${product.recycleGrade eq '나쁨'}">
											<img src="/images/free-icon-angry-1747839.png" width="26px">
										</c:when>
										<c:when test="${product.recycleGrade eq '부적합'}">
											<img src="/images/free-icon-angry-1747839.png" width="26px">
										</c:when>
										<c:otherwise>
											<img src="/images/free-icon-smile-356662.png" width="26px">
										</c:otherwise>
									</c:choose>
									${product.recycleGrade}
								</td>
								<td>${product.masterApplyNm}</td>
								<td>${product.check1}</td>
								<td><a href="#" onclick="productPackagingOrder('${product.productId}');" role="button" data-toggle="modal" class="button-Csmall">포장정보등록</a></td>
								<td><a href="#envi_result" role="button" data-toggle="modal" class="button-Csmall">결과확인</a></td>
								<td>
									<div class="btn-group">
										<a href="#edit" onclick="detailView('${product.productId}');" role="button" data-toggle="modal" class="btn-icon">
											<img src="/images/icon_edit.png" alt="수정하기" class="btn-Ticon02" id="editBtn_${product.rownum}" >
										</a>
										  
										<a href="#delete"  onclick="deleteProductItemSet('${product.productId}', '${product.productCode}');" role="button" data-toggle="modal" class="btn-icon">
											<img src="/images/icon_delete2.png" alt="삭제하기" class="btn-Ticon02" >
										</a>
									</div>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
					    <tr>
							<td colspan="11">
								재질을 선택하지 않았거나 등록된 데이터가 없습니다.
							</td>
						</tr>
					</c:otherwise>
				  </c:choose>
                </tbody>
              </table>
            </div>
            <!-- E_그리드-->
            <div class="btn-group pt15 tr">
              <button id="registView" type="button" class="button btn-success" data-toggle="modal"><a href="#register"
                  data-toggle="modal">상품관리</a></button>
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

  <!-- 레이어 팝업 - 등록  -->
  <form id="frmInsert"  enctype="multipart/form-data">
	  <div id="register" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-content" style="width:1000px">
		  <div class="modal-header">
			<h4 class="modal-title">상품기본정보등록</h4>
			<button type="button" class="close" data-dismiss="modal"><img src="/images/icon_close.png"></button>
		  </div>
		  <div class="modal-body">
			<input id="masterApplyNm" name="masterApplyNm" type="hidden" value="진행중" class="text-input" >
			<div class="row">
			  <div class="col-50">
				<div class="form-group">
				  <label class="col-25 form-label">상품코드</label>
				  <div class="col-75">
					<input id="productCode" name="productCode" type="text" class="text-input" value="" autocomplete="off">
				  </div>
				</div>
			  </div>
			  <div class="col-50">
<!-- 				<div class="form-group"> -->
<!-- 				  <label class="col-25 form-label">상품분류</label> -->
<!-- 				  <div class="col-75"> -->
<!-- 					<select id="productClass" name="productClass" class="select-box"> -->
<!-- 					    <option value="none">선택없음</option> -->
<%-- 						<c:forEach items="${productTypeList}" var="list" varStatus="status"> --%>
<%-- 							<option value="${list}">${list}</option> --%>
<%-- 						</c:forEach> --%>
<!-- 					</select> -->
<!-- 				  </div> -->
<!-- 				</div> -->
			  </div>
			  <div class="col-50">
				<div class="form-group">
				  <label class="col-25 form-label">상품명</label>
				  <div class="col-75">
					<input id="productNm" name="productNm" type="text" class="text-input" placeholder="예시)건강참기름 가정용" autocomplete="off">
				  </div>
				</div>
			  </div>
			  <div class="col-50">
				<div class="form-group">
				  <label class="col-25 form-label">납품기업</label>
				  <div class="col-75">
					<input id="supplierInfo" name="supplierInfo" type="text" class="text-input" autocomplete="off">
				  </div>
				</div>
			  </div>
			  <!-- <div class="col-50">
				<div class="form-group">
				  <label class="col-25 form-label">누적판매량(년)</label>
				  <div class="col-75">
					<input id="accumulateSaleQty" name="accumulateSaleQty" type="text" class="text-input" placeholder="누적판매량(년)">
				  </div>
				</div>
			  </div>
			  <div class="col-50">
				<div class="form-group">
				  <label class="col-25 form-label">포장재총중량</label>
				  <div class="col-75">
					<input id="packingTotalWeight" name="packingTotalWeight" type="text" class="text-input" placeholder="포장재총중량">
				  </div>
				</div>
			  </div>
			  <div class="col-50">
				<div class="form-group">
				  <label class="col-25 form-label">상품제조사</label>
				  <div class="col-75">
					<input id="productMaker" name="productMaker" type="text" class="text-input" placeholder="예시)아산 제1공장">
				  </div>
				</div>
			  </div>
			  <div class="col-50">
				<div class="form-group">
				  <label class="col-25 form-label">재활용분담금</label>
				  <div class="col-75">
					<input id="recyleContributions" name="recyleContributions" type="text" class="text-input" placeholder="누적판매량 등록시 자동계산">
				  </div>
				</div>
			  </div> -->
			  <div class="col-100">
				<div class="form-group">
				  <label class="col-25 form-label-textarea">설명</label>
				  <div class="col-75">
					<div class="form-input">
					  <textarea id="summary" name="summary" class="textarea"></textarea>
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
			  <button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
			</div>
		  </div>
		</div>
	  </div>
  </form>

  <form id="frmResult">
	  <!-- 레이어 팝업 - 결과  -->
	  <div id="envi_result" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-content" style="width:1200px">
		  <div class="modal-header">
			<h4 class="modal-title">재활용분담금결과등록</h4>
			<button type="button" class="close" data-dismiss="modal"><img src="/images/icon_close.png"></button>
		  </div>
		  <div class="modal-body">
			<!--<span class="mt10 pb04">√ 라디오버튼 선택시 상품기본정보의 누적판매량이 표시됩니다.</span>
				<div class="title-model-s">
					<h4 class="d-inblock pt10"><span class="title-point">[포장기준]</span></h4>
				</div> -->
		  <div>
			<div class="col-35">
			  <div class="form-group">
				<label class="col-45 form-label"><input type="radio" id="radio" name="radio" checked="checked">1차포장</label>
				<div class="col-55">
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
			<div class="row">
			  <div class="col-16">
				<div class="form-group">
				  <label class="col-40 form-label">출고량</label>
				  <div class="col-60">
					<input type="text" class="text-input" placeholder="1차포장 (입력x)">
				  </div>
				</div>
			  </div>
			  <div class="col-16">
				<div class="form-group">
				  <label class="col-40 form-label">기준중량</label>
				  <div class="col-60">
					<input type="text" class="text-input" placeholder="1차포장 (입력x)">
				  </div>
				</div>
			  </div>
			  <div class="col-16">
				<div class="form-group">
				  <label class="col-60 form-label">재활용의무율</label>
				  <div class="col-40">
					<input type="number" class="text-input" placeholder="1" min="0" max="5">
				  </div>
				</div>
			  </div>
			  <div class="col-16">
				<div class="form-group">
				  <label class="col-40 form-label">단가</label>
				  <div class="col-60">
					<input type="text" class="text-input" placeholder="1차포장 (입력x)">
				  </div>
				</div>
			  </div>
			  <div class="col-16">
				<div class="form-group">
				  <label class="col-40 form-label">활증</label>
				  <div class="col-60">
					<input type="text" class="text-input" placeholder="1차포장 (입력x)">
				  </div>
				</div>
			  </div>
			  <div class="col-20">
				<div class="form-group">
				  <label class="col-45 form-label">재활용분담금</label>
				  <div class="col-55">
					<input type="text" class="text-input" placeholder="자동계산">
				  </div>
				</div>
			  </div>
			</div>
		  </div>
			
		  <div>
			<div class="col-35">
			  <div class="form-group">
				<label class="col-45 form-label"><input type="radio" id="radio" name="radio" checked="checked">2차포장</label>
				<div class="col-55">
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
			<div class="row">
			  <div class="col-16">
				<div class="form-group">
				  <label class="col-40 form-label">출고량</label>
				  <div class="col-60">
					<input type="text" class="text-input" placeholder="1차포장 (입력x)">
				  </div>
				</div>
			  </div>
			  <div class="col-16">
				<div class="form-group">
				  <label class="col-40 form-label">기준중량</label>
				  <div class="col-60">
					<input type="text" class="text-input" placeholder="1차포장 (입력x)">
				  </div>
				</div>
			  </div>
			  <div class="col-16">
				<div class="form-group">
				  <label class="col-60 form-label">재활용의무율</label>
				  <div class="col-40">
					<input type="number" class="text-input" placeholder="1" min="0" max="5">
				  </div>
				</div>
			  </div>
			  <div class="col-16">
				<div class="form-group">
				  <label class="col-40 form-label">단가</label>
				  <div class="col-60">
					<input type="text" class="text-input" placeholder="1차포장 (입력x)">
				  </div>
				</div>
			  </div>
			  <div class="col-16">
				<div class="form-group">
				  <label class="col-40 form-label">활증</label>
				  <div class="col-60">
					<input type="text" class="text-input" placeholder="1차포장 (입력x)">
				  </div>
				</div>
			  </div>
			  <div class="col-20">
				<div class="form-group">
				  <label class="col-45 form-label">재활용분담금</label>
				  <div class="col-55">
					<input type="text" class="text-input" placeholder="자동계산">
				  </div>
				</div>
			  </div>
			</div>
		  </div>
		  <div>
			<div class="col-35">
			  <div class="form-group">
				<label class="col-45 form-label"><input type="radio" id="radio" name="radio" checked="checked">3차포장</label>
				<div class="col-55">
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
			<div class="row">
			  <div class="col-16">
				<div class="form-group">
				  <label class="col-40 form-label">출고량</label>
				  <div class="col-60">
					<input type="text" class="text-input" placeholder="1차포장 (입력x)">
				  </div>
				</div>
			  </div>
			  <div class="col-16">
				<div class="form-group">
				  <label class="col-40 form-label">기준중량</label>
				  <div class="col-60">
					<input type="text" class="text-input" placeholder="1차포장 (입력x)">
				  </div>
				</div>
			  </div>
			  <div class="col-16">
				<div class="form-group">
				  <label class="col-60 form-label">재활용의무율</label>
				  <div class="col-40">
					<input type="number" class="text-input" placeholder="1" min="0" max="5">
				  </div>
				</div>
			  </div>
			  <div class="col-16">
				<div class="form-group">
				  <label class="col-40 form-label">단가</label>
				  <div class="col-60">
					<input type="text" class="text-input" placeholder="1차포장 (입력x)">
				  </div>
				</div>
			  </div>
			  <div class="col-16">
				<div class="form-group">
				  <label class="col-40 form-label">활증</label>
				  <div class="col-60">
					<input type="text" class="text-input" placeholder="1차포장 (입력x)">
				  </div>
				</div>
			  </div>
			  <div class="col-20">
				<div class="form-group">
				  <label class="col-45 form-label">재활용분담금</label>
				  <div class="col-55">
					<input type="text" class="text-input" placeholder="자동계산">
				  </div>
				</div>
			  </div>
			</div>
		  </div>

		  <div class="row pt30">
			<div class="col-25">
			  <div class="form-group">
				<label class="col-60 form-label">누적판매량/수량합계</label>
				<div class="col-40">
				  <input type="number" class="text-input" placeholder="1" min="0" max="5">
				</div>
			  </div>
			</div>
			<div class="col-25">
			  <div class="form-group">
				<label class="col-60 form-label">할증</label>
				<div class="col-40">
				  <input type="number" class="text-input" placeholder="1" min="0" max="5">
				</div>
			  </div>
			</div>
			<div class="col-25">
			  <div class="form-group">
				<label class="col-35 form-label">할인</label>
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
		  <span class="fr pt10 text-point">
			※ 재활용분담금 : 누적판매수량/년 x 중량/원 x 재활용의무율 x 단가
			<ul class="desc02 mt10">할증
			  <li>1. 복합재질 및 필름시티 10%</li>
			  <li>2. 발포합성수지 PSP</li>
			</ul>
		  </span>
		  <!-- 버튼 -->
		  <div class="modal-footer btn-group">
			<button type="button" class="button btn-success" data-dismiss="modal">저장</button>
			<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
		  </div>
		</div>
	  </div>
	</div>
  </form>

  <form id="frmUpdate"  enctype="multipart/form-data">
	  <!-- 레이어 팝업 - 수정  -->
	  <div id="edit" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-content" style="width:1000px">
		  <div class="modal-header">
			<h4 class="modal-title">상품수정</h4>
			<button type="button" class="close" data-dismiss="modal"><img src="/images/icon_close.png"></button>
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
						  <input id="edit_productCode" type="text" class="text-input" disabled>
						  <input id="edit_productIdSave" name="productId" type="hidden" class="text-input">
						  <input id="edit_productCodeSave" name="productCode" type="hidden" class="text-input">
						  <input id="edit_photo" name="photo" type="hidden" class="text-input">
						  <input id="edit_spec" name="spec" type="hidden" class="text-input">
						</div>
					  </div>
					</div>
					<div class="col-50">
<!-- 					  <div class="form-group"> -->
<!-- 						<label class="col-25 form-label">상품분류</label> -->
<!-- 						<div class="col-75"> -->
<!-- 						  <select id="edit_productClass" name="productClass" class="select-box"> -->
<!-- 							<option value="선택없음" selected="">선택없음</option> -->
<%-- 							<c:forEach items="${productTypeList}" var="list" varStatus="status"> --%>
<%-- 								<option value="${list}">${list}</option> --%>
<%-- 							</c:forEach> --%>
<!-- 						  </select> -->
<!-- 						</div> -->
<!-- 					  </div> -->
					</div>
					<div class="col-50">
					  <div class="form-group">
						<label class="col-25 form-label">상품명</label>
						<div class="col-75">
						  <input id="edit_productNm" name="productNm" type="text" class="text-input" placeholder="예시)건강참기름 가정용" autocomplete="off">
						</div>
					  </div>
					</div>
					<div class="col-50">
					  <div class="form-group">
						<label class="col-25 form-label">납품기업</label>
						<div class="col-75">
						  <input id="edit_supplierInfo" name="supplierInfo" type="text" class="text-input" autocomplete="off">
						</div>
					  </div>
					</div>
					<div class="col-33">
					  <div class="form-group">
						<label class="col-40 form-label"  id="edit_baseYear">누적판매량(기준 년)</label>
						<input id="edit_baseYear_hidden" name="baseYear" type="hidden">
						<input id="edit_baseYear_1_hidden" name="baseYear_1" type="hidden">
						<input id="edit_baseYear_2_hidden" name="baseYear_2" type="hidden">
						<div class="col-60">
						  <input id="edit_accumulateSaleQty" name="accumulateSaleQty" type="text" class="text-input" placeholder="누적판매량(년)"  autocomplete="off">
						</div>
					  </div>
					</div>
					<div class="col-33">
					  <div class="form-group">
						<label class="col-40 form-label">포장재총중량</label>
						<div class="col-60">
						  <input id="edit_packingTotalWeight" name="packingTotalWeight" type="text" class="text-input" placeholder="포장재총중량"  autocomplete="off">
						</div>
					  </div>
					</div>
					<div class="col-33">
					  <div class="form-group">
						<label class="col-40 form-label">재활용분담금</label>
						<div class="col-60">
						  <input id="edit_recyleContributions" name="recyleContributions" type="text" class="text-input" placeholder="누적판매량 등록시 자동계산" readonly  autocomplete="off">
						   <button id="edit_calculateRecyleContributions" onclick="calculateRecyleContributions('recyleContributions');" type="button" class="button btn-success">계산</button>
						</div>
					  </div>
					</div>
					<div class="col-33">
					  <div class="form-group">
						<label class="col-40 form-label"  id="edit_baseYear_1">누적판매량(1년전)</label>
						<div class="col-60">
						  <input id="edit_accumulateSaleQty_1" name="accumulateSaleQty_1" type="text" class="text-input" placeholder="누적판매량(년)"  autocomplete="off">
						</div>
					  </div>
					</div>
					<div class="col-33">
					  <div class="form-group">
						<label class="col-40 form-label">포장재총중량</label>
						<div class="col-60">
						  <input id="edit_packingTotalWeight_1" name="packingTotalWeight_1" type="text" class="text-input" placeholder="포장재총중량"  autocomplete="off">
						</div>
					  </div>
					</div>
					<div class="col-33">
					  <div class="form-group">
						<label class="col-40 form-label">재활용분담금</label>
						<div class="col-60">
						  <input id="edit_recyleContributions_1" name="recyleContributions_1" type="text" class="text-input" placeholder="누적판매량 등록시 자동계산" readonly  autocomplete="off">
						  <button id="edit_calculateRecyleContributions" onclick="calculateRecyleContributions('recyleContributions_1');" type="button" class="button btn-success">계산</button>
						</div>
					  </div>
					</div>
					<div class="col-33">
					  <div class="form-group">
						<label class="col-40 form-label"  id="edit_baseYear_2">누적판매량(2년전)</label>
						<div class="col-60">
						  <input id="edit_accumulateSaleQty_2" name="accumulateSaleQty_2" type="text" class="text-input" placeholder="누적판매량(년)"  autocomplete="off">
						</div>
					  </div>
					</div>
					<div class="col-33">
					  <div class="form-group">
						<label class="col-40 form-label">포장재총중량</label>
						<div class="col-60">
						  <input id="edit_packingTotalWeight_2" name="packingTotalWeight_2" type="text" class="text-input" placeholder="포장재총중량"  autocomplete="off">
						</div>
					  </div>
					</div>
					<div class="col-33">
					  <div class="form-group">
						<label class="col-40 form-label">재활용분담금</label>
						<div class="col-60">
						  <input id="edit_recyleContributions_2" name="recyleContributions_2" type="text" class="text-input" placeholder="누적판매량 등록시 자동계산" readonly  autocomplete="off">
						  <button id="edit_calculateRecyleContributions" onclick="calculateRecyleContributions('recyleContributions_2');" type="button" class="button btn-success">계산</button>
						</div>
					  </div>
					</div>
					<div class="col-100">
					  <div class="form-group">
						<label class="col-25 form-label">상품제조사</label>
						<div class="col-75">
						  <div class="form-input-box" id="edit_productMaker">
<!-- 							<a href="#" role="button" data-toggle="modal" class="button-Csmall d-inblock" style="padding: 0 10px;">상품제조사명1</a> -->
<!-- 							<a href="#" role="button" data-toggle="modal" class="button-Csmall d-inblock" style="padding: 0 10px;">상품제조사명2</a> -->
						  </div>
						</div>
					  </div>
					</div>

					<div class="col-100">
					  <div class="form-group">
						<label class="col-25 form-label-textarea">설명</label>
						<div class="col-75">
						  <div class="form-input">
							<textarea id="edit_summary" name="summary" class="textarea"></textarea>
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
							<div class="button-Rsmall d-inblock">
							  <input type="radio"  name="masterApplyNm" value="미진행">
							  <label for="masterApplyNm" class="mr05">미진행</label></div>
							<div class="button-Rsmall d-inblock">
							  <input type="radio"  name="masterApplyNm" value="진행중">
							  <label for="masterApplyNm" class="mr05">진행중</label></div>
							<div class="button-Rsmall d-inblock">
							  <input type="radio"  name="masterApplyNm" value="완료">
							  <label for="masterApplyNm" class="mr05">완료</label></div>
							<div class="button-Rsmall d-inblock">
							  <input type="radio"  name="masterApplyNm" value="환경부 제외 상품">
							  <label for="masterApplyNm" class="mr05">환경부 제외 상품</label></div>
						  </div>
						</div>
					  </div>
					</div>
					<div class="col-50">
					  <div class="form-group">
						<label class="col-20 form-label">매핑상태</label>
						<div class="col-80">
						  <div class="form-input-box" id="edit_masterApply">
							<div class="button-Rsmall d-inblock">
							  <input type="radio"  name="masterApply" value="미매핑">
							  <label for="masterApply" class="mr05">미매핑</label></div>
							<div class="button-Rsmall d-inblock">  
							  <input type="radio" name="masterApply" value="매핑있음">
							  <label for="masterApply" class="mr05">매핑있음</label></div>
							<div class="button-Rsmall d-inblock">
							  <input type="radio" name="masterApply" value="매핑없음">
							  <label for="masterApply" class="mr05">매핑없음</label></div>
							 <div class="button-Rsmall d-inblock"  onclick="mapProductCode('edit_productCodeSave');">
							  <label class="mr05">매핑실행</label></div>
						  </div>
						</div>
					  </div>
					</div>
					<div class="col-50">
					  <div class="form-group">
						<label class="col-20 form-label">접수번호</label>
						<div class="col-30">
						  <input id="edit_receiptNumber" name="receiptNumber" type="text" class="text-input"  autocomplete="off">
						</div>
						<label class="col-20 form-label">승인번호</label>
						<div class="col-30">
						  <input id="edit_approvalNumber" name="approvalNumber" type="text" class="text-input"  autocomplete="off">
						</div>
					  </div>
					</div>
					<div class="col-50">
					  <div class="form-group">
						<label class="col-20 form-label">매핑상품번호</label>
						<div class="col-30">
						  <input id="edit_mappingProductId" name="mappingProductId" type="text" class="text-input"  autocomplete="off">
						</div>
						<label class="col-20 form-label">매핑상품명</label>
						<div class="col-30">
						  <input id="edit_mappingProductNm" name="mappingProductNm" type="text" class="text-input"  autocomplete="off">
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
						  <input id="edit_rgstDt" name="rgstDt" type="text" class="text-input" value="2022-01-01" disabled>
						</div>
					  </div>
					</div>
					<div class="col-50">
					  <div class="form-group">
						<label class="col-25 form-label">최종 변경일</label>
						<div class="col-75">
						  <input id="edit_modiDt" name="modiDt" type="text" class="text-input" value="2022-01-04" disabled>
						</div>
					  </div>
					</div>
					<div class="col-50">
					  <div class="form-group">
						<label class="col-25 form-label">생성자</label>
						<div class="col-75">
						  <input id="edit_rgstId" name="rgstId" type="text" class="text-input" value="김희영" disabled>
						</div>
					  </div>
					</div>
					<div class="col-50">
					  <div class="form-group">
						<label class="col-25 form-label">최종변경자</label>
						<div class="col-75">
						  <input id="edit_modiId" name="modiId" type="text" class="text-input" value="김희영" disabled>
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
			  <button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
			</div>
		  </div>
		</div>
	  </div>
  </form>
  
  <form id="frmDelete">
	  <!-- 레이어 팝업 - delete -->
	  <div id="delete" class="modal" data-backdrop-limit="1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true" data-modal-parent="#myModal">
		<input type="hidden" id="del_productCode" name="productId" >
		<div class="modal-content" style="width:400px">
		  <div class="modal-header">
			<h4 class="modal-title">삭제</h4>
			<button type="button" class="close" data-dismiss="modal"><img src="/images/icon_close.png"></button>
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
			<button type="button" class="button btn-warning" data-dismiss="modal"  onclick="deleteProductItem();">삭제</button>
			<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
		  </div>
		</div>
	  </div>
  </form>
  
  <form id="frmDetail">
	  <!-- 레이어 팝업 - 상세  -->
	  <div id="detail" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-content" style="width:auto;max-width:1100px">
		  <div class="modal-header">
			<h4 class="modal-title">상품포장정보</h4>
			<button type="button" class="close" data-dismiss="modal"><img src="/images/icon_close.png"></button>
		  </div>
		  <div class="modal-body">
			<div class="row">
			  <div class="tab-content-box">
				<p>
				  <button id="btn-add-tab" type="button" class="button-Rsmall fr">탭 추가</button>
				</p>
				<!-- Nav tabs -->
				<ul id="tab-list" class="nav tab-nav" role="tablist">
<!-- 				  <li class="active"><a href="#tab1" role="tab" data-toggle="tab"><span>1차 포장</span></a></li> -->
				</ul>
				<!-- Tab panes -->
				<div id="tab-content" class="tab-content">
				  <div class="tab-pane active" id="tab1">
					<!--S_탭 tab03_1-->
					<div id="tab03_1">
					  <div class="row">
						<!--S_탭 tab04-->
						<div class="tab04">
						  <ul class="tabnav04 tc mb10">
							<li><a href="#" onclick="javascript:showMatTypeSelf('tab04_1', this);">재질정보</a></li>
							<li><a href="#" onclick="javascript:showMatTypeSelf('tab04_2', this);">자가진단</a></li>
						  </ul>
						  <!--S_탭 tabcontent04-->
						  <div class="tabcontent04">
							<div id="tab04_1">
							  <div class="tab-in-nav d-flex">
							  		<input type="hidden" name="matType" id="matType">
<!-- 								<div class="tab-in-nav d-flex"> -->
<!-- 								  <span class="pt10 pr10">ㆍ재질유형</span> -->
<!-- 								  <select id="matType" name="matType" class="select-box w200 mr10"> -->
<!-- 									<option value="">선택</option> -->
<%-- 									<c:forEach items="${productMatTypeList}" var="productMatType" varStatus="status"> --%>
<%-- 										<option value="${productMatType.codeId}">${productMatType.codeNm}</option> --%>
<%-- 									</c:forEach> --%>
<!-- 								  </select> -->
<!-- 								</div> -->
								<ul class="tabnav04-in d-flex pt05" id="selfPartType1">
<!-- 								  <li><a href="#" onclick="javascript:showMatType('tab04_1_in1');">몸체</a></li> -->
<!-- 								  <li><a href="#" onclick="javascript:showMatType('tab04_1_in2');">라벨</a></li> -->
<!-- 								  <li><a href="#" onclick="javascript:showMatType('tab04_1_in3');">마개</a></li> -->
<!-- 								  <li><a href="#" onclick="javascript:showMatType('tab04_1_in4');">잡자재</a></li> -->
<!-- 								  <li><a href="#" onclick="javascript:showMatType('tab04_1_in5');">별도포장</a></li> -->
								</ul>
								<div class="add-row">
								  <button id='btn-add-row' class="button-Rsmall">(+)추가하기</button>
<!-- 								  <button id='btn-delete-row' class="button-Rsmall">(-)삭제하기</button> -->
								</div>
							  </div>
							  <!--S_몸체 -->
							  <div class="tabcontent04-in">
								<ul class="tabnav04-in d-flex pt05" id="partTypeDetail" style="display:none;">
								</ul>
								<div class="mytable_1_in" id="tab04_1_in1">
								  <div id="mytable_1_in1">
								  </div>
								</div>
<!-- 								<div class="mytable_1_in" id="tab04_1_in2"> -->
<!-- 								  <div id="mytable_1_in2"> -->
<!-- 								  </div> -->
<!-- 								</div> -->
<!-- 								<div class="mytable_1_in" id="tab04_1_in3"> -->
<!-- 								  <div id="mytable_1_in3"> -->
<!-- 								  </div> -->
<!-- 								</div> -->
<!-- 								<div class="mytable_1_in" id="tab04_1_in4"> -->
<!-- 									<div id="mytable_1_in4"> -->
<!-- 								  	</div> -->
<!-- 								</div> -->
<!-- 								<div class="mytable_1_in" id="tab04_1_in5"> -->
<!-- 									<div id="mytable_1_in5"> -->
<!-- 								  	</div> -->
<!-- 								</div> -->
								<!-- 버튼 -->
							  </div>
							  <div class="modal-footer btn-group">
								<button  id="savePackagingBtn" type="button" class="button btn-success">저장</button>
								<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
							  </div>
							  <!--E_몸체 -->

							</div>
							<!--S_탭 tab04_2 -->
							<div id="tab04_2" style="display:none;">
<!-- 							  <div class="row"> -->
<!-- 								<span class="pt10 pr10">ㆍ코드변경시점</span> -->
<!-- 								<select name="revision" class="select-box w150 mr10" id="codeDayList"> -->
<!--  								  <option value="0">2021년7월</option> --> 
<!-- 								  <option value="1">2021년1월</option> --> 
<!-- 								</select> -->
<!-- 								<div class="tab-in-nav d-flex"> -->
<!-- 								  <span class="pt10 pr10">ㆍ재질유형</span> -->
<!-- 								  <select id="selfMatType" class="select-box w150 mr10"> -->
<!-- 									<option value="0">종이팩</option> --> 
<!--  									<option value="1">플라스틱</option> --> 
<!-- 								  </select> -->
<!-- 								  <ul class="d-flex pt05" id="selfPartType"> -->
<!-- 									<li class="button btn-radius on">몸체</li> --> 
<!--  									<li class="button btn-radius">라벨</li> --> 
<!--  									<li class="button btn-radius on">마개및잡자재</li> --> 
<!-- 									<li class="button btn-radius">라벨 마개 및 잡자재</li> --> 
<!-- 								  </ul> -->
<!-- 								</div> -->
<!-- 							  </div> -->
							  <!--<div class="cb">체크 </div>-->
							  <div id="Accordion_wrap" class="row100 pt10" style="display:none;">
								<div class="Accordion-box">
								  <h4 class="que pt15"><span class="title-point" id="selfValidationLabel">[몸체]</span></h4>
								  <div class="anw">
									<ul class="choice-wrapper" id="selfValidation"></ul>
									<div class="row" >
									  <div class="col-50">
										<div class="form-group pb0">
										  <label class="col-25 form-label">증빙서류</label>
										  <div class="col-75">
											<div class="form-input">
											  <input type="text" class="text-input"
												placeholder="기기분석,육안판정,공인시험성적서,신고허가서류,기타">
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
											<label class="col-25 form-label">몸체평가결과
											</label>
											<div class="col-75">
											  <div class="form-input">
												<input type="text" class="text-input" placeholder="우수">
											  </div>
											</div>
										  </div>
										</div>
										<div class="col-50">
										  <div class="form-group pb0">
											<label class="col-25 form-label">필요서류
											  목록</label>
											<div class="col-75">
											  <div class="form-input">
												<input type="text" class="text-input"
												  placeholder="기기분석,육안판정,공인시험성적서,신고허가서류,기타">
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
							  <div class="modal-footer btn-group" id="packagingInfo">
								<button type="button" class="button btn-success" data-dismiss="modal">결과확인</button>
								<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
							  </div>
							  <!--S_최종결과 -->
							  <div class="row100 pt10">
								<div class="result-box">
								  <div class="row">
									<div class="col-50">
									  <div class="form-group pb0">
										<label class="col-25 form-label result-text">최종 결과
										</label>
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
  <div id="matTypeSelect" class="modal" data-backdrop-limit="1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
    aria-hidden="true" data-modal-parent="#myModal">
    <div class="modal-content" style="width:400px">
      <div class="modal-header">
        <h4 class="modal-title">포장정보</h4>
        <button type="button"  onclick="showTab();" class="close" data-dismiss="modal"><img src="/images/icon_close.png"></button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-100">
            <div class="form-group" id="matTypeSelectpackagingOrderNm">
              <label class="col-25 form-label">포장차수</label>
              <div class="col-75">
                <select class="select-box" id="packagingOrderNmApply" name="packagingOrderNmApply">
                </select>
              </div>
            </div>
            <div class="form-notice" id="showMappedProductCode" style="display:none;"><input type="checkbox" id="mappedProductCode" name="mappedProductCode" value="Y"><label for="mappedProductCode"> * 동록된 상품코드가 있습니다.</label></div>
<!--             <div class="form-notice">* [1차포장]은 등록되어있습니다.</div> -->
            <div class="form-group" id="matTypeSelectProductMatType"  style="display:none;">
              <label class="col-25 form-label">재질유형</label>
              <div class="col-75">
                <select id="matTypeSelectBox" name="matTypeSelectBox" class="select-box">
                </select>
              </div>
            </div>
            <div class="form-group" id="matTypeSelectProductCode" style="display:none;">
              <label class="col-25 form-label">상품코드</label>
              <div class="form-input">
                <input type="hidden" id="matTypeSelectProductMatTypeMapped" name="matTypeSelectProductMatTypeMapped">
                <input type="text" class="text-input" id="matTypeSelectProductCodeVal" name="matTypeSelectProductCodeVal">
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
  
<script src='/js/plugins/jquery.MultiFile.min.js' type="text/javascript" language="javascript"></script>
<script>
  var selectedPartType ="";
  var selectedPartTypeNm ="";

  var button = '<button class="tab-close" type="button" title="Remove this page">×</button>';
  var tabID = 0;
  var selectedProdId = "";
  if('${param.productId}') {
	  $('#editBtn_${param.productId}').click();
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

  function getProductSelfPackaging(){
		 var param = {};
		 param.revisionYear="2022";
		 param.revisionMonth="03";
		 param.groupId = "PA";//$("#matType").val();//재질유형
		 
		 $.ajax({
			type : 'post',
			url : '/product/detail/selfPackaging/',
			data : param,
			dataType : 'json',
			error: function(request, status, error){
				console.log(request.responseText);
			},
			success : function(result) {
				var selfPackInfo = "";
				$("#Accordion_wrap").empty();
				result.middleModels.forEach(function(item, index) {
					selfPackInfo += '<div class="Accordion-box">';
					selfPackInfo += '<h4 class="que pt15"><span class="title-point">['+item.codeNm+']</span></h4>';
					selfPackInfo += '	<div class="anw">';
					selfPackInfo += '	            <ul class="choice-wrapper">';

					result.smallModels.forEach(function(sItem, index) {
						if(sItem.groupId === item.codeId){
							selfPackInfo += '	              <li class="choice-box">';
							selfPackInfo += '	                <h4 class="line-br">재활용-'+sItem.codeNm+'</h4>';
							selfPackInfo += '	                <div class="choice-cont">';
							selfPackInfo += '	                  <ul>';
	
							result.lastModels.forEach(function(lItem, index) {
								if(lItem.groupId === sItem.codeId){
									selfPackInfo += '	                    <li><input type="checkbox"><label for="">'+lItem.codeNm+'</label></li>';
								}
							});
	
							selfPackInfo += '	                  </ul>';
							selfPackInfo += '	                </div>';
							selfPackInfo += '	              </li>';
						}
					});

					selfPackInfo += '            </ul>';
					selfPackInfo += '             <div class="row">';
					selfPackInfo += '               <div class="col-50">';
					selfPackInfo += '                 <div class="form-group pb0">';
					selfPackInfo += '                   <label class="col-25 form-label">증빙서류</label>';
					selfPackInfo += '                   <div class="col-75">';
					selfPackInfo += '                     <div class="form-input">';
					selfPackInfo += '                       <input type="text" class="text-input" placeholder="기기분석,육안판정,공인시험성적서,신고허가서류,기타">';
					selfPackInfo += '                     </div>';
					selfPackInfo += '                   </div>';
					selfPackInfo += '                 </div>';
					selfPackInfo += '               </div>';
					selfPackInfo += '               <div class="col-50">';
					selfPackInfo += '                 <div class="form-group pb0">';
					selfPackInfo += '                   <label class="col-25 form-label">첨부파일</label>';
					selfPackInfo += '                   <div class="col-75">';
					selfPackInfo += '                     <input type="file" multiple="multiple" class="text-input">';
					selfPackInfo += '                   </div>';
					selfPackInfo += '                 </div>';
					selfPackInfo += '               </div>';
					selfPackInfo += '             </div>';
                    //            <!-- S_결과확인-->
                    selfPackInfo += '             <div class="result-box">';
                    selfPackInfo += '               <div class="row">';
                    selfPackInfo += '                 <div class="col-50">';
                    selfPackInfo += '                   <div class="form-group pb0">';
                    selfPackInfo += '                     <label class="col-25 form-label">몸체평가결과';
                    selfPackInfo += '                     </label>';
                    selfPackInfo += '                     <div class="col-75">';
                    selfPackInfo += '                       <div class="form-input">';
                    selfPackInfo += '                         <input type="text" class="text-input" placeholder="우수">';
                    selfPackInfo += '                       </div>';
                    selfPackInfo += '                     </div>';
                    selfPackInfo += '                   </div>';
                    selfPackInfo += '                 </div>';
                    selfPackInfo += '                 <div class="col-50">';
                    selfPackInfo += '                   <div class="form-group pb0">';
                    selfPackInfo += '                     <label class="col-25 form-label">필요서류목록</label>';
                    selfPackInfo += '                     <div class="col-75">';
                    selfPackInfo += '                       <div class="form-input">';
                    selfPackInfo += '                         <input type="text" class="text-input" placeholder="기기분석,육안판정,공인시험성적서,신고허가서류,기타">';
                    selfPackInfo += '                       </div>';
                    selfPackInfo += '                     </div>';
                    selfPackInfo += '                   </div>';
                    selfPackInfo += '                 </div>';
                    selfPackInfo += '               </div>';
                    selfPackInfo += '             </div>';
//                                 <!-- E_결과확인-->
                    selfPackInfo += '           </div>';
                    selfPackInfo += '</div>';
				});
				$("#Accordion_wrap").append(selfPackInfo);
				$("#Accordion_wrap").show();
			}
		});
}
  
  function getPackagingOrderByNew(id){
		console.log('getPackagingOrderByNew');
		 $.ajax({
			type : 'post',
			url : '/product/detail/'+id+'/getPackagingOrderByNew/',
			dataType : 'json',
			error: function(request, status, error){
				console.log(request.responseText);
			},
			success : function(result) {
				$("#packagingOrderNmApply").empty();
				$("#packagingOrderNmApply").append('<option value="">선택</option>');
				if (result.length > 0) {
					result.forEach(function(item, index) {
						// loop
						$('#packagingOrderNmApply').append('<option value="'+item.packagingOrder+'">'+item.packagingNm+'</option>');
// 						$('#matTypeSelectTab').empty();
						if(result.length == 1) {
							$('#packagingOrderNmApply option[value="'+item.packagingOrder+'"]').attr("selected", "selected");
							if(item.packagingOrder > 8){
								$('#matTypeSelectProductCode').show();
								$('#showMappedProductCode').show();
								$('#matTypeSelectProductMatType').hide();
// 								$('#matTypeSelectTab').text(item.packagingNm+' 정보를 매핑하세요.');
							}else {
								$('#matTypeSelectProductMatType').show();
								$('#matTypeSelectProductCode').hide();
								$('#showMappedProductCode').hide();
// 								$('#matTypeSelectTab').text(item.packagingNm+' 재잴 유형을 선택 하세요');
							}
						}else {
// 							$('#matTypeSelectTab').text('포장 차수 및 재질 정보를 선택하세요.');
						}
					});
					$("#matTypeSelect").modal('show');
				}
			}
		});
  }
  
  function mapProductCodeApply(id, packagingOrderNmApplyVal, selectedPackagingOrderNmText){
	 var productCode = $('#'+id).val();
	 if(productCode && productCode != '' && productCode != null) {
		 $.ajax({
				type : 'post',
				url : '/product/detail/'+productCode+'/apply/',
				dataType : 'json',
				error: function(request, status, error){
					console.log(request.responseText);
					alert(request.responseText);
				},
				success : function(result) {
					if (result.length > 0) {
						result.forEach(function(item, index) {
							// loop
							if(index === 0) {
								$('#matType').val(item.matType); 
								tabID = packagingOrderNmApplyVal;
								var selectedText = item.matTypeNm;
								$('#tab-list li.active').removeClass('active');
								$('#tab-list').append($('<li class="active"><a href="#tab' + packagingOrderNmApplyVal + '" onclick=\'productMatInfoView("'+selectedProdId+'", "'+packagingOrderNmApplyVal+'", this);\' role="tab" data-toggle="tab"><span>' +
										selectedPackagingOrderNmText +
							     ' ('+selectedText+')</span><button class="tab-close" type="button" onclick=\'deleteProductPackagingInfo("'+ selectedProdId + '", "'+ packagingOrderNmApplyVal + '", this);\' title="Remove this page">×</button></a></li>'
							    ));
						        
								var tabFirst = $('#tab-list a:first');
						        tabFirst.click();
								$("#tab" + packagingOrderNmApplyVal).modal("show");
			// 					getSelfCodeList(result.packingType.slice(0, result.packingType.indexOf('_')), 'tab-list', 'selfPartType1');
								$("#matTypeSelect").modal('hide');
							}
						});
					}
				}
			});
	 }
  }
  
  function mapProductCode(id){
	 var productCode = $('#'+id).val();
	 if(productCode && productCode != '' && productCode != null) {
		 $.ajax({
				type : 'post',
				url : '/product/detail/'+productCode+'/mapping/',
				dataType : 'json',
				error: function(request, status, error){
					console.log(request.responseText);
					alert(request.responseText);
				},
				success : function(result) {
					if(id === 'matTypeSelectProductCodeVal'){
						if(result.masterMapping !== 'MAPPING') {
							$('#matTypeSelectProductMatType').show();
						}else {
							$('#matTypeSelectProductMatTypeMapped').val('MAPPING');
							$('#matTypeSelectProductMatType').hide();
						}
					}else {
						$("#frmUpdate input[name=masterApplyNm]").val([result.masterApply]);
						$("#frmUpdate input[name=masterApply]").val([result.masterMapping]);
						$('#edit_receiptNumber').val(result.receiptNumber);
						$('#edit_approvalNumber').val(result.approvalNumber);
						$('#edit_mappingProductId').val(result.mappingProductId);
						$('#edit_mappingProductNm').val(result.mappingProductNm);
					}
				}
			});
	 }
  }
  
  function calculateRecyleContributions(year) {
	  var check = valyCheck(year);
	  if(check) {
		  var param = {};
		  if(year == 'recyleContributions') {
			  param.baseYear= $("#frmUpdate input[name=baseYear]").val();
			  param.accumulateSaleQty= $("#frmUpdate input[name=accumulateSaleQty]").val();
			  param.packingTotalWeight= $("#frmUpdate input[name=packingTotalWeight]").val();
		  }else if(year == 'recyleContributions_1') {
			  param.baseYear_1= $("#frmUpdate input[name=baseYear_1]").val();
			  param.accumulateSaleQty_1= $("#frmUpdate input[name=accumulateSaleQty_1]").val();
			  param.packingTotalWeight_1= $("#frmUpdate input[name=packingTotalWeight_1]").val();
		  }else if(year == 'recyleContributions_2') {
			  param.baseYear_2= $("#frmUpdate input[name=baseYear_2]").val();
			  param.accumulateSaleQty_2= $("#frmUpdate input[name=accumulateSaleQty_2]").val();
			  param.packingTotalWeight_2= $("#frmUpdate input[name=packingTotalWeight_2]").val();
		  }else {
			  return;
		  }
		  var productId = $("#frmUpdate input[name=productId]").val();
		  calculateRecyleContributionsAjax(productId, param, year);
	  }
  }
  
  function calculateRecyleContributionsAjax(productId, param, year){
// 	  var param = $('#frmUpdate').serialize();
	  $.ajax({
			type : 'post',
			url : 'detail/'+productId+'/recyle_contributions/',
			data : param,
			dataType : 'text',
			error: function(request, status, error){
				console.log(request.responseText);
				alert(request.responseText);
			},
			success : function(result) {
				$("#frmUpdate input[name="+year+"]").val(result);
			}
		});
  }
  
  function valyCheck(type) {
		if(type == 'registProduct'){
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
		}else if(type == 'editProduct'){
			var productNm = $("#frmUpdate input[name=productNm]").val();
			if (productNm == '') {
				alert('삼품명을 입력해 주세요.');
				$("#frmUpdate input[name=productNm]").focus();
				return false;
			}
		}else if(type == 'savePackaging'){
			var supplierCode = $("#frmDetail select[name=supplierCode]").val();
			if (supplierCode == '') {
				alert('공급업체를 선택해 주세요.');
				$("#frmDetail select[name=supplierCode]").focus();
				return false;
			}
			var managerId = $("#frmDetail select[name=managerId]").val();
			if (managerId == '') {
				alert('담당자를 선택해 주세요.');
				$("#frmDetail select[name=managerId]").focus();
				return false;
			}
		}else if(type == 'recyleContributions'){
			var accumulateSaleQty = $("#frmUpdate input[name=edit_accumulateSaleQty]").val();
			if (accumulateSaleQty == '') {
				alert('누적판패량을 입력해 주세요.');
				$("#frmUpdate input[name=edit_accumulateSaleQty]").focus();
				return false;
			}
			var packingTotalWeight = $("#frmUpdate input[name=packingTotalWeight]").val();
			if (packingTotalWeight == '') {
				alert('포장재총중량을 입력해 주세요.');
				$("#frmUpdate input[name=packingTotalWeight]").focus();
				return false;
			}
		}else if(type == 'recyleContributions_1'){
			var accumulateSaleQty = $("#frmUpdate input[name=edit_accumulateSaleQty_1]").val();
			if (accumulateSaleQty == '') {
				alert('누적판패량을 입력해 주세요.');
				$("#frmUpdate input[name=edit_accumulateSaleQty_1]").focus();
				return false;
			}
			var packingTotalWeight = $("#frmUpdate input[name=packingTotalWeight_1]").val();
			if (packingTotalWeight == '') {
				alert('포장재총중량을 입력해 주세요.');
				$("#frmUpdate input[name=packingTotalWeight_1]").focus();
				return false;
			}
		}else if(type == 'recyleContributions_2'){
			var accumulateSaleQty = $("#frmUpdate input[name=edit_accumulateSaleQty_2]").val();
			if (accumulateSaleQty == '') {
				alert('누적판패량을 입력해 주세요.');
				$("#frmUpdate input[name=edit_accumulateSaleQty_2]").focus();
				return false;
			}
			var packingTotalWeight = $("#frmUpdate input[name=packingTotalWeight_2]").val();
			if (packingTotalWeight == '') {
				alert('포장재총중량을 입력해 주세요.');
				$("#frmUpdate input[name=packingTotalWeight_2]").focus();
				return false;
			}
		}
		return true;
	}
  
  function detailView(id){
	$.ajax({
		url : '/product/detail/'+id,
		dataType : 'json',
		type : "POST",
		async: false,
		success : function(data) {
			var result = data;
			console.log(result);
			setView(data);
		}
	});
  }

  function getFileList(refId, placeId, savedId){
	  $.ajax({
			url : '/file/list/'+refId,
			dataType : 'json',
			type : "GET",
			async: false,
			success : function(data) {
// 				var result = data;
				console.log("FILES>>>");
// 				console.log(data);
				$('#'+placeId+'  > .MultiFile-list').empty();
				if (data.length > 0) {
					data.forEach(function(item, index) {
						// loop
						//이미지일떄는 이미지 택을 <span class="MultiFile-title">'+item.fileNm+'</span> 다음에 추가한다
						//<img class="MultiFile-preview" style="max-height:100px; max-width:100px;" src="">
						if(refId.indexOf('photos_') > -1){
// 							$('#'+placeId+'  > .MultiFile-list').append('<div class="MultiFile-label" ondrop="drop(event)" ondragover="allowDrop(event)"><a class="MultiFile-remove" href="#" onclick=\'deleteFileAjax("'+item.fileId+'","'+savedId+'","'+refId+'", this);\'>x</a> <span><span class="MultiFile-label" title='+item.fileNm+' 을 선택했습니다."><span class="MultiFile-title">'+item.fileNm+'</span><img id="'+item.fileId+'" class="MultiFile-preview" style="max-height:100px; max-width:100px;" src="/file/view/'+item.fileId+'" draggable="true" ondragstart="drag(event)"></span></span></div>');
							$('#'+placeId+'  > .MultiFile-list').append('<div class="MultiFile-label" ><a class="MultiFile-remove" href="#" onclick=\'deleteFileAjax("'+item.fileId+'","'+savedId+'","'+refId+'", this);\'>x</a> <span><span class="MultiFile-label" title='+item.fileNm+' 을 선택했습니다."><span class="MultiFile-title">'+item.fileNm+'</span><img id="'+item.fileId+'" class="MultiFile-preview" style="max-height:100px; max-width:100px;" src="/file/view/'+item.fileId+'"></span></span></div>');
						}else if(refId.indexOf('specs_') > -1){
							$('#'+placeId+'  > .MultiFile-list').append('<div class="MultiFile-label"><a class="MultiFile-remove" href="#" onclick=\'deleteFileAjax("'+item.fileId+'","'+savedId+'","'+refId+'", this);\'>x</a> <span><span class="MultiFile-label" title='+item.fileNm+' 을 선택했습니다." onclick=\'downloadFile("'+item.fileId+'");\'><span class="MultiFile-title">'+item.fileNm+'</span></span></span></div>');
						}
					});
				}else {
					if(refId.indexOf('photos_') > -1){
						$('#edit_photo').val('');
					}else if(refId.indexOf('specs_') > -1){
						$('#edit_spec').val('');
					}
				}
			}
		});
	  }
  
  // 상품 삭제시 사용(공통)
  function deleteFileAjax(fileId, savedId, refId, obj) {
  	$.ajax({
		type : 'post',
		url : '/file/delete/' + fileId,
		dataType : 'json',
		error: function(request, status, error){
			console.log(request.responseText);
			alert(request.responseText);
		},
		success : function(result) {
			console.log(result);
			$(obj).parent().remove();
			if(fileId == savedId) {
				if(refId.indexOf('photos_') > -1){
					$('#edit_photo').val('');
				}else if(refId.indexOf('specs_') > -1){
					$('#edit_spec').val('');
				}
			}
// 			if (result == action) {
// 				var param = $('#searchFrm').serialize();
// 				$('#searchFrm').attr('action','/product/prodList');
// 				$('#searchFrm').submit();
// 			}
		}
	});
  }
//   $("#matTypeSelect").modal('show');
//   function addPackagingTab(productId) {
  function addPackagingTab() {
	  var selectedVal = $("#matTypeSelectBox").val();
	  var packagingOrderNmApplyVal = $("#packagingOrderNmApply").val();
	  var selectedPackagingOrderNmText = $("#packagingOrderNmApply option:selected").text();
	  var matTypeSelectProductCodeVal = $("#matTypeSelectProductCode").val();
	  var matTypeSelectProductMatTypeMapped = $("#matTypeSelectProductMatTypeMapped").val();
	  var mappedProductCodeChecked = $('#mappedProductCode').is(':checked');
	  console.log(selectedVal);
	  console.log(packagingOrderNmApplyVal);
	  console.log(matTypeSelectProductCodeVal);
	  console.log(matTypeSelectProductMatTypeMapped);
	  console.log(selectedPackagingOrderNmText);
	  if(!packagingOrderNmApplyVal) {
		alert('포장차수를 선택해주세요.');
		return;
	  }
	  
	  if(packagingOrderNmApplyVal > 8 && mappedProductCodeChecked === true) {
			if($("#matTypeSelectProductCodeVal").val() !== '') {
		    	mapProductCodeApply('matTypeSelectProductCodeVal', packagingOrderNmApplyVal, selectedPackagingOrderNmText);
			}else {
				alert('등록된 부속상품코드를 입력해주세요.');
				return;
			}
	  }else {
		  if(selectedVal) {
			$('#matType').val(selectedVal); 
			var selectedText = $( "#matTypeSelectBox option:selected" ).text();
	// 		  productPackagingOrder();
// 			tabID++;
			tabID = packagingOrderNmApplyVal;
// 			$("#matTypeSelectTab").empty();		
// 			$("#matTypeSelectTab").text(tabID+'차 포장 재잴 유형을 선택 하세요');	
			$('#tab-list li.active').removeClass('active');
			$('#tab-list').append($('<li class="active"><a href="#tab' + packagingOrderNmApplyVal + '" role="tab" data-toggle="tab"><span>' +
					selectedPackagingOrderNmText +
		     ' ('+selectedText+')</span><button class="tab-close" type="button" title="Remove this page">×</button></a></li>'
		    ));
	        
			$("#tab" + packagingOrderNmApplyVal).modal("show");
	// 		$('#tab-list').append($('<li><a href="#tab1" role="tab" data-toggle="tab"><span>'+tabID+'차 포장 <br>'+selectedText+'</span></a></li>'));
			//기존 정보 초기화
			getSelfCodeList(selectedVal.slice(0, selectedVal.indexOf('_')), 'tab-list', 'selfPartType1');
			$("#matTypeSelect").modal('hide');
			
		  }else {
			 alert('재질유형을 선택해주세요');
	// 		 return false;
	// 		  $("#matTypeSelect").modal('show');
		  }
	  }
  }
  
  function setView(data){
  	$('#edit_productCode').val(data.productCode);
	$('#edit_productIdSave').val(data.productId);
	$('#edit_productCodeSave').val(data.productCode);
	
	$('#edit_productClass option[value="'+data.productClass+'"]').attr("selected", "selected");
// 		$('#edit_productClass').val(data.productClass);
	$('#edit_productNm').val(data.productNm);
	$('#edit_supplierInfo').val(data.supplierInfo);
	$('#edit_accumulateSaleQty').val(data.accumulateSaleQty);
	$('#edit_packingTotalWeight').val(data.packingTotalWeight);
	$('#edit_recyleContributions').val(data.recyleContributions);

	$('#edit_baseYear').text('누적판매량('+data.baseYear+'년)');
	$('#edit_baseYear_1').text('누적판매량('+data.baseYear_1+'년)');
	$('#edit_baseYear_2').text('누적판매량('+data.baseYear_2+'년)');
	$('#edit_baseYear_hidden').val(data.baseYear);
	$('#edit_baseYear_1_hidden').val(data.baseYear_1);
	$('#edit_baseYear_2_hidden').val(data.baseYear_2);
	
	$('#edit_accumulateSaleQty_1').val(data.accumulateSaleQty_1);
	$('#edit_packingTotalWeight_1').val(data.packingTotalWeight_1);
	$('#edit_recyleContributions_1').val(data.recyleContributions_1);

	$('#edit_accumulateSaleQty_2').val(data.accumulateSaleQty_2);
	$('#edit_packingTotalWeight_2').val(data.packingTotalWeight_2);
	$('#edit_recyleContributions_2').val(data.recyleContributions_2);
	
	$('#edit_productMaker').empty();
	console.log(data.prodPackagingList.length);
	//상품제조사정보
	if (data.prodPackagingList.length > 0) {
		data.prodPackagingList.forEach(function(item, index) {
			console.log(item);
			// loop으로 상품제조사 정보 출력
// 			productMatInfoViewDetail(id, packagingId, obj, partTypeId, partTypeNm)
			$('#edit_productMaker').append('<a href="#" onclick=\'productMatInfoViewDetail("'+data.productId+'", this);\' class="button-Csmall d-inblock" style="padding: 0 10px;">'+item.str+'</a>');
// 			$('#edit_productMaker').append(<a href="#" role="button" onclick=\'productMatInfoView("'+item.packagingOrder+'", this);\' data-toggle="modal" class="button-Csmall d-inblock" style="padding: 0 10px;">'+ item.str + '</a>');
		});
	}
	
	
	$('#edit_summary').val(data.summary);

	
	//photos and specs 정보 있으면 뿌려줌
	$('#edit_photo').val(data.photo);
	$('#edit_spec').val(data.spec);
	getFileList('photos_'+data.productId, "edit_photos", data.photo);
	getFileList('specs_'+data.productId, "edit_specs", data.spec);

	$('#edit_masterApplyNm').empty();
	console.log(data.environmentProceedStatCode.length);
	//진행상태
	if (data.environmentProceedStatCode.length > 0) {
		data.environmentProceedStatCode.forEach(function(item, index) {
			console.log(item);
			$('#edit_masterApplyNm').append('<div class="button-Rsmall d-inblock"><input type="radio"  name="masterApplyNm" value="'+item.codeId+'"><label for="masterApplyNm" class="mr05">'+item.codeNm+'</label></div>');
		});
	}

	$('#edit_masterApply').empty();
	console.log(data.mappingStatCode.length);
	//매핑정보
	if (data.mappingStatCode.length > 0) {
		data.mappingStatCode.forEach(function(item, index) {
			console.log(item);
			$('#edit_masterApply').append('<div class="button-Rsmall d-inblock"><input type="radio"  name="masterApply" value="'+item.codeId+'"><label for="masterApply" class="mr05">'+item.codeNm+'</label></div>');
		});
		$('#edit_masterApply').append('<div class="button-Rsmall d-inblock"  onclick="mapProductCode(\'edit_productCodeSave\');"><label class="mr05">매핑실행</label></div>');
	}
	
	$("#frmUpdate input[name=masterApplyNm]").val([data.masterApply]);
	$("#frmUpdate input[name=masterApply]").val([data.masterMapping]);
	$('#edit_receiptNumber').val(data.receiptNumber);
	$('#edit_approvalNumber').val(data.approvalNumber);
	
	$('#edit_rgstDt').val(data.rgstDt);
	$('#edit_rgstDt').attr('disabled',true);
	$('#edit_modiDt').val(data.modiDt);
	$('#edit_modiDt').attr('disabled',true);
	$('#edit_rgstId').val(data.rgstId);
	$('#edit_rgstId').attr('disabled',true);
	$('#edit_modiId').val(data.modiId);
	$('#edit_modiId').attr('disabled',true);
  }
  
  function productInsert(){
	var check = valyCheck("registProduct");
	if(check) {
		var param =  $('#frmInsert').serialize();
		insertAjax(param,'insert');
	}
  }
  
  function productUpdate(){
	  var check = valyCheck("editProduct");
	  if(check) {
		  var param =  $('#frmUpdate').serialize();
		  insertAjax(param,'update');
	  }
  }
  
  function insertAjax(param,action){
	  if(action == 'update') {
		  var form = $('#frmUpdate')[0];
	  }else {
		  var form = $('#frmInsert')[0];
	  }
	    var data = new FormData(form);
	    
	  	$.ajax({
		type : 'post',
		url : '/product/'+action,
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
		    if(result == 'Update' || result == 'Insert'){
		    	location.href = '/product/prodList';
		    }
		}
	});
  }
  
  function deleteProductItemSet(productId, productCode) {
  	$('.delName').text(productCode);		
	$('#del_productCode').val(productId);
	$('#delType').val('small');
	$('.tc div.fontColorRed').remove();
	$('.tc').append('<div class="pt05 fontColorRed">ㆍ삭제시 하위 코드 모두 삭제 됩니다.</div>');
  }
  
  function deleteProductItem(){
  	var action = 'delete';
	var	param = $('#frmDelete').serialize();
	 if(isDisabled){
		return false;
	 }else{
		isDisabled = true;
		deleteAjax(param, action);
	 }
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
			isDisabled = false;
// 			if (result == action) {
				var param = $('#searchFrm').serialize();
				$('#searchFrm').attr('action','/product/prodList');
				$('#searchFrm').submit();
// 			}
		}
	});
  }
  
  function productPackagingOrder(id){
	  selectedProdId = id;
// 	  tabID = 0;
	  $('#tab-list').empty();
	  $('#tab-list li.active').removeClass('active');
	  $('.tabnav04 a:first').addClass('active');
	  $.ajax({
			url : '/product/detail/packagingOrder',
			dataType : 'JSON',
			data : {'productId':id},
			type : "POST",
			async: false,
			error: function(request, status, error){
				console.log(request.responseText);
				alert(request.responseText);
			},
			success : function(data) {
				if (data.length > 0) {
					data.forEach(function(item, index) {
						// loop으로 포장 차 탭 출력
// 						tabID++;
						var packagingOrder = item.packagingOrder;
						if(item.packagingOrder > 8) {
							packagingOrder = '부속포장';
						}else {
							packagingOrder = item.packagingOrder +'차 포장';
						}
						$('#tab-list').append('<li class="active"><a href="#" onclick=\'productMatInfoView("'+item.productId+'", "'+item.packagingOrder+'", this);\' role="tab" data-toggle="tab"><span>' +
								packagingOrder +
						        ' ('+item.matTypeNm+')</span><button class="tab-close" type="button"  onclick=\'deleteProductPackagingInfo("'+ item.productId + '", "'+ item.packagingOrder + '", this);\' title="Remove this page">×</button></a></li>'
						     );
						
						// 텝 추가후 1차 포장정보 서버에서 조회 함
						if(index == 0) {
							getSelfCodeList(item.matType.slice(0, item.matType.indexOf('_')), 'tab-list', 'selfPartType1', item.matTypeNm, item);
							tabID = item.packagingOrder;
						}
					});
				}else {
					getPackagingOrderByNew(id);
					getMatTypeList();
// 					addPackagingTab(id);
				}
			}
		});
  }

  function deleteProductPackagingInfo(id, packagingOrder) {
// 	  alert("작업중입니다. 재품번호는: "+id+"이며 포장차수는 "+packagingOrder);
	  var result = confirm(packagingOrder+"차 포장정보를 삭제하시겠습니까?");
	  if(result)deletePackagingInfoAjax(id, packagingOrder, '');
  }
  
  function productMatInfoViewDetail(id, packagingId, obj, partTypeId, partTypeNm){
	    $('#mytable_1_in1').empty();
		if(id == '' || id == null || id == 'undefined') {
			$('#mytable_1_in1:last').append(getProductMatInfoHtml(partTypeId, partTypeNm));
			$('#partTypeDetail a').removeClass('on');
	        if(obj) {
	        	$(obj).parent().addClass('on');
		    }else {
		    	$('#partTypeDetail a:first').addClass('on');
			}
	        
			$('#tab04_1_in1').show();
			return true;
		}
		
		$.ajax({
			url : '/product/detail/'+id+'/packaging/'+packagingId,
			dataType : 'JSON',
// 			data : {'packagingId': packagingId, 'productId':id},
			type : "POST",
			async: false,
			error: function(request, status, error){
				console.log(request.responseText);
				alert(request.responseText);
			},
			success : function(data) {
				
// 				console.log(data);
				$('#matType').val(data.matType);
		        $('#mytable_1_in1:last').append(getProductMatInfoHtml(data.partType, data.partTypeNm,data));
		        $('.supplierCode option[value="'+data.supplierCode+'"]').attr("selected", "selected");
		        managersView(data.supplierCode, data.managerId);
		        
		        $('#partTypeDetail a').removeClass('on');
		        if(obj) {
		        	$(obj).parent().addClass('on');
			    }else {
			    	$('#partTypeDetail a:first').addClass('on');
				}
// 		        $('#packagingInfo').append('<button type="button" class="button btn-modify" onclick=\'deletePackagingId("'+data.packagingId+'", this);\'>삭제</button>');
				
				$('#tab04_1_in1').show();
			}
		});
	  }
  
  function productMatInfoView(id, packagingOrder, obj){
	  $('.tabnav04 a.active').removeClass('active');
	  $('.tabnav04 a:first').addClass('active');
	  $('#tab04_2').hide();
	  $('#tab04_1').show();
	  
	  $.ajax({
			url : '/product/detail/packaging',
			dataType : 'JSON',
			data : {'packagingOrder': packagingOrder, 'productId':id},
			type : "POST",
			async: false,
			error: function(request, status, error){
				console.log(request.responseText);
				alert(request.responseText);
			},
			success : function(data) {
				$('#tab04_1_in1').children().empty();
				$('#partTypeDetail').empty();
				if (data.length > 0) {
					data.forEach(function(item, index) {
// 						console.log(item);
						var innerHtml = "";
					   
					 // 텝 추가후 1차 포장정보 서버에서 조회 함
						if(index == 0) {
							innerHtml = '<li><a class="button btn-radius on" href="#"><span onclick=\'productMatInfoViewDetail("'+item.productId+'", "'+item.packagingId+'", this, "'+item.partType+'", "'+item.partTypeNm+'");\'>'+item.partTypeNm+'</span></span><button type="button"  onclick=\'deletePackagingId("'+item.packagingId+'", this);\' style="color:black;height:0px;line-height:10px;margin-left:1px;background:transparent;" title="Remove this page">×</button></li>';
							productMatInfoViewDetail(id, item.packagingId, null, item.partType, item.partTypeNm);
						}else {
							innerHtml = '<li><a class="button btn-radius" href="#"><span onclick=\'productMatInfoViewDetail("'+item.productId+'", "'+item.packagingId+'", this, "'+item.partType+'", "'+item.partTypeNm+'");\'>'+item.partTypeNm+'</span><button type="button"  onclick=\'deletePackagingId("'+item.packagingId+'", this);\' style="color:black;height:0px;line-height:10px;margin-left:1px;background:transparent;" title="Remove this page">×</button></li>';
						}
						$('#partTypeDetail:last').append(innerHtml);
						$('#partTypeDetail').show();
					});
				}else {
					var innerHtml = "";
				    innerHtml = '<li><a  class="button btn-radius on" href="#"><span onclick=\'productMatInfoViewDetail("", "", this, "'+selectedPartType+'", "'+selectedPartTypeNm+'");\'>'+selectedPartType+'</span><button type="button"  onclick=\'deletePackagingId("", this);\' style="color:black;height:0px;line-height:10px;margin-left:1px;background:transparent;" title="Remove this page">×</button></li>';
				    $('#partTypeDetail:last').append(innerHtml);
				    $('#partTypeDetail').show();
				    $('#mytable_1_in1').empty();
			        $('#mytable_1_in1:last').append(getProductMatInfoHtml(selectedPartType, selectedPartTypeNm));
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

  function deletePackagingId(packagingId, obj)	{
	  var result = confirm("삭제하시겠습니까?");
	  if(result) {
		$(obj).parent().parent().remove();
		if(packagingId == null || packagingId == '' || packagingId == 'undefined') {
			var lastPart = $('#partTypeDetail span:last');
			lastPart.click();
		}else {
			var productId = selectedProdId;
			deletePackagingInfoAjax(productId, '', packagingId);
		}
	  }
// 	console.log($(obj).parent().prev());
// 	$(obj).parent().parent().prev().click();
	
	//이전항목 선택해야 함
  }
  
  function saveProductPackaging() {
	var check = valyCheck("savePackaging");
	if(check){
		var param =  $('#frmDetail').serialize();
	  	var packagingId = $("#frmDetail input[name=packagingId]").val();
	  	console.log(packagingId);
	  	if(packagingId == '' || packagingId == null) {
	  		saveProductPackagingAjax(param,'insert');
	  	}else {
			saveProductPackagingAjax(param,'update');
	  	}
	}
  }

  function showTab() {
	  $('#btn-add-tab').show();
  }
  // 상품포장정보등록 수정
  function saveProductPackagingAjax(param, action, sendMail) {
    $.ajax({
		type : 'post',
		url : '/product/'+action+'/'+selectedProdId+'/packaging',
		data : param,
		dataType : 'text',
		error: function(request, status, error){
			console.log(request.responseText);
			alert(request.responseText);
		},
		success : function(result) {
			$('#btn-add-tab').show();
			var data = JSON.parse(result);
			console.log(data.packagingId);
			$("#frmDetail input[name=packagingId]").val(data.packagingId);
			if(sendMail) {
				sendEmail($('#frmDetail').serialize());
			}else {
// 				var param = $('#searchFrm').serialize(); 
// 				$('#searchFrm').attr('action','/product/prodList');
// 				$('#searchFrm').submit();
				alert("정상적으로 저장되었습니다.")
				productMatInfoView(data.productId, data.packagingOrder, "");
			}
// 			isDisabled = false;
// 			if (result == 'Delete') {
			
// 			}
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
				var param = $('#searchFrm').serialize(); 
				$('#searchFrm').attr('action','/product/prodList');
				$('#searchFrm').submit();
			}
		});
	  }

//포장 차수 삭제
  function deletePackagingInfoAjax(productId, packagingOrder, packagingId) {
	  	$.ajax({
		type : 'post',
		url : '/product/delete/'+productId+'/packaging/',
		data : {'packagingId': packagingId, 'packagingOrder': packagingOrder, 'productId':productId},
		dataType : 'text',
		error: function(request, status, error){
			console.log(request.responseText);
			alert(request.responseText);
		},
		success : function(result) {
			var lastPart = $('#partTypeDetail span:last');
			lastPart.click();
		}
	});
  }

  function showMatTypeSelf(id, obj) {
	    $('.tabnav04 a.active').removeClass('active');
		$(obj).addClass('active');
		if(id == 'tab04_1') {
			$('#tab04_2').hide();
			$('#Accordion_wrap').hide();
			$('#tab04_1').show();
		}else{
// 			getCodeDayList();
			getProductSelfPackaging();
			$('#tab04_1').hide();
			$('#tab04_2').show();
		}
  }

  
//재질유형 조회
  function getMatTypeList() {
    $.ajax({
		url : '/system/environmentCode/detail/getMatTypeList',
		dataType : 'JSON',
		type : "POST",
		error: function(request, status, error){
			console.log(request.responseText);
			alert(request.responseText);
		},
		success : function(data) {
			console.log(data);
			$('#matTypeSelectBox').empty();
			$('#matTypeSelectBox').append("<option value=''>선택</option>");
			if (data.length > 0) {
				data.forEach(function(item, index) {
					$('#matTypeSelectBox').append("<option value=" + item.codeId +">" + item.str + "</option>");
					if(data.length == 1)$('#matTypeSelectBox option[value="'+item.codeId+'"]').attr("selected", "selected");
				});
			}
		}
	});
  }
  
//자가진단 코드변경시점정보 ㅈ회
  function getCodeDayList() {
    $.ajax({
		url : '/product/detail/getCodeDayList',
		dataType : 'JSON',
		type : "POST",
		error: function(request, status, error){
			console.log(request.responseText);
			alert(request.responseText);
		},
		success : function(data) {
			console.log(data);
			$('#codeDayList').empty();
			$('#codeDayList').append("<option value=''>선택</option>");
			if (data.length > 0) {
				data.forEach(function(item, index) {
					$('#codeDayList').append("<option value=" + item.revisionYear +"-"+item.revisionMonth +">" + item.revisionYear +"년"+item.revisionMonth + "월</option>");
				});
			}
		}
	});
  }

//자가진단 코드정보조회
  function getSelfCodeList(codeId, id, nextId, codeNm, packageData) {
// 		if(nextId == 'selfPartType') {
// 			$('#selfPartType').empty();
// 		}
		var revision = $('#codeDayList').val();
		if(!revision) {
			revision = '2022-03';
		}
	    $.ajax({
		url : '/system/environmentCode/detail/'+codeId+'/getPartList/',
		dataType : 'JSON',
		type : "POST",
		data : {'smallCategory': codeId, 'revision': revision},
		error: function(request, status, error){
			console.log(request.responseText);
			alert(request.responseText);
		},
		success : function(data) {
			console.log(data);
			$('#'+nextId).empty();
			if(nextId == 'codeDayList' || nextId == 'selfMatType') {
				$('#'+nextId).append("<option value=''>선택</option>");
			}
			if (data.length > 0) {
				data.forEach(function(item, index) {
					if(nextId == 'codeDayList' || nextId == 'selfMatType') {
						$('#'+nextId).append("<option value=" + item.codeId +">" + item.codeNm + "</option>");
					}else if(nextId == 'selfPartType') {
						var innerHtml = "";
					    innerHtml = '<li class="button btn-radius on" onclick=\'getSelfCodeList("'+item.codeId+'", "selfPartType", "selfValidation", "'+item.codeNm+'");\'>'+item.codeNm+'</li>';
						$('#'+nextId+":last").append(innerHtml);
					}else if('selfPartType1') {
						var innerHtml = "";
// 						onclick="javascript:showMatType('tab04_1_in1');"
					    innerHtml = '<li class="button btn-radius" onclick=\'showMatType("'+item.codeId+'", "'+item.codeNm+'", this);\'>'+item.codeNm+'</li>';
						$('#'+nextId+":last").append(innerHtml);
						if(index == 0) {
							showMatType(item.codeId, item.codeNm);
							if(packageData) {
								productMatInfoView(packageData.productId, packageData.packagingOrder);
							}else {
								$('.mytable_1_in > div').empty();
							    $('.mytable_1_in').hide();
								var innerHtml = "";
							    innerHtml = '<li><a class="button btn-radius" href="#"><span onclick=\'productMatInfoViewDetail("", "", this, "'+item.codeId+'", "'+item.codeNm+'");\'>'+item.codeNm+'</span><button type="button"  onclick=\'deletePackagingId("", this);\' style="color:black;height:0px;line-height:10px;margin-left:1px;background:transparent;" title="Remove this page">×</button></li>';
							    $('#partTypeDetail').empty();
							    $('#partTypeDetail:last').append(innerHtml);
							    $('#partTypeDetail').show();
							    $('#mytable_1_in1').empty();
							    $('#mytable_1_in1:last').append(getProductMatInfoHtml(item.codeId, item.codeNm));
								$('#tab04_1_in1').show();
							}
							$("#detail").modal('show');
						}
					}else if(nextId == 'selfValidation') {
						$.ajax({
							url : '/system/environmentCode/detail/'+codeId,
							dataType : 'JSON',
							type : "POST",
							data : {'smallCategory': item.codeId, 'revision': revision},
							error: function(request, status, error){
								console.log(request.responseText);
								alert(request.responseText);
							},
							success : function(subData) {
								$('#Accordion_wrap').show();
								$('#selfValidationLabel').text(codeNm);
								var innerHtml = "";
								innerHtml = '<li class="choice-box">';
								innerHtml += '<h4 class="line-br">재활용-'+item.codeNm+'</h4>';
								innerHtml += '<div class="choice-cont">';
								innerHtml += '<ul>';
								if (subData.length > 0) {
									subData.forEach(function(subItem, index) {
										innerHtml += '<li><input type="checkbox"><label for="">'+subItem.codeNm+'</label></li>';
									});
								}
								innerHtml += '</ul>';
								innerHtml += '</div>';
								innerHtml += '</div>';
								$('#selfValidation').append(innerHtml);
								console.log('subData');
								console.log(subData);
							}
						});
					}
				});
			}
		}
	});
  }
  
  function resetTab() {
    var tabs = $("#tab-list li:not(:first)");
    var len = 1
    $(tabs).each(function (k, v) {
      len++;
      $(this).find('a').html(len + '차 포장' + button);
    })
    tabID--;
  }

  function getProductMatInfoHtml(partType, partTypeNm, data) {
	  var matInfo = "";
	  var weight = "";
	  var standard = "";
	  var color = "";
	  var addExplan = "";
	  var packagingId = "";
	  var packagingOrder = "";
	  var matFileNm ="";
	  var matFileId ="";
	  if(data) {
		  matInfo = data.matInfo; 
		  weight = data.weight; 
		  standard = data.standard; 
		  color = data.color; 
		  addExplan = data.addExplan; 
		  packagingId = data.packagingId;
		  packagingOrder = data.packagingOrder;
		  matFileNm = data.matFileNm;
		  matFileId = data.matFileId;
	  }else {
		  packagingOrder = tabID;
	  }
		var innerHtml = "";
		innerHtml += '<div class="addbox pt10">';
// 		innerHtml += '<button id=btn-delete-row2 class="button-Rsmall button-del fr">(-)삭제하기</button>';
		innerHtml += '<h4 class="tl pt15"><span class=title-point>['+partTypeNm+']</span></h4>';
		innerHtml += '<div class=row>';
		innerHtml += '<div class=col-50>';
		innerHtml += '<div class=form-group>';
		innerHtml += '<label class="col-25 form-label">재질정보</label>';
		innerHtml += '<div class=col-75>';
		innerHtml += '<div class=form-input>';
		innerHtml += '<input type=hidden name="productId" value="'+selectedProdId+'">';
		innerHtml += '<input type=hidden name="packagingId" value="'+packagingId+'">';
		innerHtml += '<input type=hidden name="packagingOrder" value="'+packagingOrder+'">';
		innerHtml += '<input type=hidden name="partType" value="'+partType+'">';
		innerHtml += '<input type=hidden name="partTypeNm" value="'+partTypeNm+'">';
		innerHtml += '<input type=text class=text-input name="matInfo" value="'+matInfo+'">';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '<div class=col-50>';
		innerHtml += '<div class=form-group>';
		innerHtml += '<label class="col-25 form-label">중량</label>';
		innerHtml += '<div class=col-75>';
		innerHtml += '<div class=form-input>';
		innerHtml += '<input type=text class=text-input name="weight" value="'+weight+'">';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '<div class=col-50>';
		innerHtml += '<div class=form-group>';
		innerHtml += '<label class="col-25 form-label">규격</label>';
		innerHtml += '<div class=col-75>';
		innerHtml += '<div class=form-input>';
		innerHtml += '<input type=text class=text-input name="standard" value="'+standard+'">';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '<div class=col-50>';
		innerHtml += '<div class=form-group>';
		innerHtml += '<label class="col-25 form-label">색상</label>';
		innerHtml += '<div class=col-75>';
		innerHtml += '<div class=form-input>';
		innerHtml += '<input type=text class=text-input name="color" value="'+color+'">';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '</div>';
		innerHtml += '<div class=col-100>';
		innerHtml += '<div class=form-group>';
		innerHtml += '<label class="col-25 form-label-textarea">추가설명</label>';
		innerHtml += '<div class=col-75>';
		innerHtml += '<div class=form-input>';
		innerHtml += '<textarea class=textarea name="addExplan">'+addExplan+'</textarea>';
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
		innerHtml += '<select name="managerId" class="select-box supplierManager">';
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
		innerHtml += '<input name="supplierNm" type=hidden class="text-input supplierNm">';
		innerHtml += '<input name="managerNm" type=hidden class="text-input managerNm">';
		innerHtml += '<input name="managerMail" type=text class="text-input supplierMail">';
		innerHtml += '<span class=search-box-append>';
		innerHtml += '<button type=button class="button-search sendEmail">이메일보내기</button>';
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
		innerHtml += '<button type=button class=button-search onclick=\'downloadFile("'+matFileId+'");\'>다운로드</button>';
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

  function downloadFile(id) {
	  if(id != '') {
	  		window.open('/file/detail/'+id, '_blank').focus();
		  }
  }
  
  function showMatType(codeId, codeNm, obj) {
	  selectedPartType=codeId;
	  selectedPartTypeNm=codeNm; 
	  
	  $('#selfPartType1 li.on').removeClass('on');
	  if(obj) {
	  	$(obj).addClass('on');
	  }else {
		  $('#selfPartType1 li:first').addClass('on');
	  }
  }
  
  function allowDrop(ev) {
	  ev.preventDefault();
	}

	function drag(ev) {
	  ev.dataTransfer.setData("text", ev.target.id);
	}

	function drop(ev) {
	  ev.preventDefault();
	  var data = ev.dataTransfer.getData("text");
	  ev.target.appendChild(document.getElementById(data));
	}
	
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
	$('#regBtn').click(function(){
		productInsert();
	});
	$('#editBtn').click(function(){
		productUpdate();
	});
	$('.delPopupCancel').click(function(){
		$('.fontColorRed').remove();
	});
	$('.delete').click(function(){
		if(isDisabled){
			return false;
		}else{
			deleteAjax();
		}
	});
	$('#savePackagingBtn').click(function(){
		saveProductPackaging();
	});
	$('.searchKeyword').click(function(){
		if(isDisabled){
			return false;
		}else{
			$('#searchFrm').submit();
		}
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
			$(this).parent().parent().parent().parent().next().find('.supplierMail').val(this.value.split("||")[1]);
		}else {
			$(this).parent().parent().parent().parent().next().find('.supplierMail').val('');
			$("#frmDetail input[name=managerNm]").val('');
		}
	});
	$(document).on('click', '.sendEmail', function () {
		var param =  $('#frmDetail').serialize();
		var packagingId = $("#frmDetail input[name=packagingId]").val();
	  	if(packagingId != '' && packagingId != null) {
	  		sendEmail(param);
	  	}else {
			saveProductPackagingAjax(param,'insert', true);
		}
		
	});
	
	$(document).on('change', '#codeDayList', function () {
		if(this.value){
			$('#revision').val(this.value);
			getSelfCodeList('GROUP_ID', 'codeDayList', 'selfMatType');
		}
	});

	$(document).on('change', '#selfMatType', function () {
		if(this.value){
			getSelfCodeList(this.value, 'selfMatType', 'selfPartType');
		}	
	});

	$('#mappedProductCode').change(function() {
        if(this.checked) {
        	$('#matTypeSelectProductCode').show();
        	$('#matTypeSelectProductMatType').hide();
        }else {
        	$('#matTypeSelectProductCode').hide();
        	$('#matTypeSelectProductMatType').show();
        }
    });
    
	$(document).on('change', '#packagingOrderNmApply', function () {
		if(this.value && this.value > 8){
			$('#matTypeSelectProductMatType').hide();
// 			$('#matTypeSelectProductCode').show();
			$('#showMappedProductCode').show();
			$('#matTypeSelectProductMatType').show();
// 			getSelfCodeList(this.value.slice(0, this.value.indexOf('_')), 'selfMatType', 'selfPartType');
		}else {
			$('#matTypeSelectProductCode').hide();
			$('#showMappedProductCode').hide();
			$('#matTypeSelectProductMatType').show();
		}
	});
	
	$('#btn-add-tab').click(function () {
		$('#btn-add-tab').hide();
		getPackagingOrderByNew(selectedProdId);
		getMatTypeList();
// 		$("#matTypeSelect").modal('show');
    });

    $('#tab-list').on('click', '.tab-close', function () {
      var tabID = $(this).parents('a').attr('href');
      $(this).parents('li').remove();
      $(tabID).remove();

      //display first tab
      var tabFirst = $('#tab-list a:first');
//       resetTab();
//       tabFirst.tab('show');
      tabFirst.click();
      $('#btn-add-tab').show();
    });

    var list = document.getElementById("tab-list");
	
    
	$('#btn-add-row').click(function () {
          var innerHtml = "";
	      innerHtml = '<li><a  class="button btn-radius on" href="#"><span onclick=\'productMatInfoViewDetail("", "", this, "'+selectedPartType+'", "'+selectedPartTypeNm+'");\'>'+selectedPartTypeNm+'</span><button type="button"  onclick=\'deletePackagingId("", this);\' style="color:black;height:0px;line-height:10px;margin-left:1px;background:transparent;" title="Remove this page">×</button></a></li>';
	      $('#partTypeDetail a').removeClass('on');
	      $('#partTypeDetail:last').append(innerHtml);
		  innerHtml = getProductMatInfoHtml(selectedPartType, selectedPartTypeNm);
          $('#mytable_1_in1').empty();
          $('#mytable_1_in1').append(innerHtml);
          return false;
      });
	
      
      $('#btn-delete-row').click(function () {
//         var trcut = $('#'+selectedPartType+ ' #mytable_1_in'+selectedPartType.slice(-1)+' > .addbox').length;
//         if (trcut > 0) {
//           $('#mytable_1_in'+selectedPartType.slice(-1)+' > .addbox:last').remove();
//           return false;
//         } else {
//           return false;
//         }
      });
  });

  var editHandler = function () {
    var t = $(this);
    t.css("visibility", "hidden");
    $(this).prev().attr("contenteditable", "true").focusout(function () {
      $(this).removeAttr("contenteditable").off("focusout");
      t.css("visibility", "visible");
    });
  };

//   $(".edit").click(editHandler);
</script>


