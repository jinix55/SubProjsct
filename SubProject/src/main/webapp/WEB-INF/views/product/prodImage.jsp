<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>



 


	<!-- S_본문-->
		<div class="content">
			<!--<ul class="page-nav">
				<li class="item-nav"><a href="Prod.html" class="link-nav">
	        제품 목록보기</a></li>
				<li class="item-nav"><a href="ProdImg.html" class="link-nav active">
	        이미지 목록보기</a></li>
			</ul>-->
			<!-- S_검색-->
			<form  id="searchFrm" action="/product/prodImage" method="POST">
            	<input type="hidden" id="page" name="page" value="${pages.page}">
				<div class="justify-content-between">
					<div class="form-group">
						<div class="form-inline">
							<select id="searchKey" name="searchKey" class="select-box w150">
			                    <option value="ALL">전체</option>
								<option value="productNm">상품명</option>
								<option value="packingType">포장유형</option>
								<option value="recycleGrade">재활용등급</option>
								<option value="completeStatus">상태</option>
			                 </select>
						</div>
						<div class="form-inline">
							<div class="search-box w250">
								<input id="searchValue" name="searchValue" value="${pages.searchValue}" type="text" class="text-input">
								<span class="search-box-append">
									<button type="button" class="button-search"><img src="/images/icon_search.png" title="검색"></button>
								</span>
							</div>
						</div>
					</div>
				</div>
			</form>
			<!-- E_검색-->

		<!-- S_그리드-->
		<div class="row mt10">
			<c:choose>
			    <c:when test="${products.size() > 0 }">
					<c:forEach items="${products }" var="product" varStatus="status">
						<div class="img-box">
							<div class="img-view">
								<img src="/file/view/${product.photo}">
							</div>
							<div class="img-cont ellipsis">
								<ul>
									<li class="text-bold" style="text-overflow: ellipsis;overflow: hidden;white-space: nowrap;">ㆍ제품명 : <span>${product.productNm}</span></li>
									<li class="text-bold">ㆍ포장유형 : <span>${product.packingType}</span></li>
									<li class="text-bold">ㆍ재활용등급 : <span class="fontColorBlue">${product.recycleGrade}</span></li>
									<li class="text-bold">ㆍ진행상태 : <span class="fontColorBlue">${product.completeStatus}</span></li>
								</ul>
							</div>
							<div class="img-bottom tc">
									<button type="button" onclick="goToProductPage('${product.rownum}');" class="btn-none" data-dismiss="modal">상세보기</button>
							 </div>
					 	</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div class="img-box">
						재질을 선택하지 않았거나 등록된 데이터가 없습니다.
					</div>
				</c:otherwise>
			</c:choose>
		</div>
		 <!-- S_페이징-->
            <div class="board-paging"></div>
            <!-- E_페이징-->
		</div>
	<!-- E_본문-->

<!-- 레이어 팝업 - 상세  -->
<div id="detail" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width:1200px">
		<div class="modal-header">
			<h4 class="modal-title">상세</h4>
			<button type="button" class="close" data-dismiss="modal"><img src="/images/icon_close.png"></button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="tab-content-box">
						<p>
								<button id="btn-add-tab" type="button" class="button-Rsmall fr">Add Tab</button>
						</p>
						<!-- Nav tabs -->
						<ul id="tab-list" class="nav tab-nav" role="tablist">
								<li class="active"><a href="#tab1" role="tab" data-toggle="tab"><span>1차 포장 </span></a></li>
						</ul>
						<!-- Tab panes -->
					 <div style="clear: both;">
						<div id="tab-content" class="tab-content" style="width:70%;display: inline-block;vertical-align: top;">
							<div class="tab-in-nav">
								<button type="button" class="button btn-radius"><a href="#tab01">몸체</a></button>
								<button type="button" class="button btn-radius"><a href="#tab02">라벨</a></button>
								<button type="button" class="button btn-radius"><a href="#tab03">마개및잡자재</a></button>
								<button type="button" class="button btn-radius"><a href="#tab04">라벨 마개 및 잡자재</a></button>
							</div>
							<div class="tab-pane active" id="tab1">
								<div class="tab-in-content">
									<!-- 몸체 상세-->
									<div id="tab01">
									<h4 class="tl pt15"><span class="title-point">[몸체 상세]</span></h4>
										<div class="row">
										 <div class="col-50">
											 <div class="form-group">
												 <label class="col-25 form-label">재질</label>
												 <div class="col-75">
													 <div class="form-input">
														 <input type="text" class="text-input" value="">
													 </div>
												 </div>
											 </div>
										 </div>
										 <div class="col-50">
											 <div class="form-group">
												 <label class="col-25 form-label">중량(g)</label>
												 <div class="col-75">
													 <div class="form-input">
														 <input type="text" class="text-input">
													 </div>
												 </div>
											 </div>
										 </div>
										 <div class="col-50">
											 <div class="form-group">
												 <label class="col-25 form-label">규격(장*폭*고)</label>
												 <div class="col-75">
													 <div class="form-input">
														 <input type="text" class="text-input">
													 </div>
												 </div>
											 </div>
										 </div>
										 <div class="col-50">
											 <div class="form-group">
												 <label class="col-25 form-label">두께(mm)</label>
												 <div class="col-75">
													 <div class="form-input">
														 <input type="text" class="text-input">
													 </div>
												 </div>
											 </div>
										 </div>
										 <div class="col-50">
											 <div class="form-group">
												 <label class="col-25 form-label">포장공장</label>
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
														 <input name="files[]" type="file" multiple="multiple" id="our-file03" class="multi with-preview">
													 </div>
												 </div>
											 </div>
											 <div class="form-group">
												 <label class="col-25 form-label">설계문서</label>
												 <div class="col-75">
														 <input type="file" class="text-input">
												 </div>
											 </div>
											 <div class="form-group">
												 <label class="col-25 form-label h70">증빙문서</label>
												 <div class="col-75 tl">
													 <div class="text-input h70">
														 <input type="radio" id="radio1" name="radio">
														 <label for="radio1" class="mr05">기기분석</label>
														 <input type="radio" id="radio1" name="radio">
														 <label for="radio1" class="mr05">육안판정</label>
														 <input type="radio" id="radio1" name="radio">
														 <label for="radio1" class="mr05">공인시험성적서</label>
														 <input type="radio" id="radio1" name="radio">
														 <label for="radio1" class="mr05">신고허가서류</label>
														 <input type="radio" id="radio1" name="radio">
														 <label for="radio1" class="mr05">기타</label>
														 <div><input type="file"></div>
													 </div>
												 </div>
											 </div>
											 <div class="form-group">
												 <label class="col-25 form-label">보고서 생성</label>
												 <div class="col-75 tl">
													 <div class="text-input"><button type="button" class="button-Rsmall">육안판정서</button></div>
												 </div>
											 </div>
											 <div class="form-group">
												 <label class="col-25 form-label">자가진단 등급</label>
												 <div class="col-75 tl">
													 <div class="text-input">우수</div>
												 </div>
											 </div>
										 </div>
										</div>
									</div>
									<!-- 라벨 상세-->
									<div id="tab02">
										<h4 class="tl pt15"><span class="title-point">[라벨 상세]</span></h4>
										<div class="row">
										 <div class="col-50">
											 <div class="form-group">
												 <label class="col-25 form-label">재질</label>
												 <div class="col-75">
													 <div class="form-input">
														 <input type="text" class="text-input" value="">
													 </div>
												 </div>
											 </div>
										 </div>
										 <div class="col-50">
											 <div class="form-group">
												 <label class="col-25 form-label">중량(g)</label>
												 <div class="col-75">
													 <div class="form-input">
														 <input type="text" class="text-input">
													 </div>
												 </div>
											 </div>
										 </div>
										 <div class="col-50">
											 <div class="form-group">
												 <label class="col-25 form-label">규격(장*폭*고)</label>
												 <div class="col-75">
													 <div class="form-input">
														 <input type="text" class="text-input">
													 </div>
												 </div>
											 </div>
										 </div>
										 <div class="col-50">
											 <div class="form-group">
												 <label class="col-25 form-label">두께(mm)</label>
												 <div class="col-75">
													 <div class="form-input">
														 <input type="text" class="text-input">
													 </div>
												 </div>
											 </div>
										 </div>
										 <div class="col-50">
											 <div class="form-group">
												 <label class="col-25 form-label">포장공장</label>
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
														 <input name="files[]" type="file" multiple="multiple" id="our-test" class="multi with-preview">
													 </div>
												 </div>
											 </div>
											 <div class="form-group">
												 <label class="col-25 form-label">설계문서</label>
												 <div class="col-75">
														 <input type="file" class="text-input">
												 </div>
											 </div>
											 <div class="form-group">
												 <label class="col-25 form-label h70">증빙문서</label>
												 <div class="col-75 tl">
													 <div class="text-input h70">
														 <input type="radio" id="radio1" name="radio">
														 <label for="radio1" class="mr05">기기분석</label>
														 <input type="radio" id="radio1" name="radio">
														 <label for="radio1" class="mr05">육안판정</label>
														 <input type="radio" id="radio1" name="radio">
														 <label for="radio1" class="mr05">공인시험성적서</label>
														 <input type="radio" id="radio1" name="radio">
														 <label for="radio1" class="mr05">신고허가서류</label>
														 <input type="radio" id="radio1" name="radio">
														 <label for="radio1" class="mr05">기타</label>
														 <div><input type="file"></div>
													 </div>
												 </div>
											 </div>
											 <div class="form-group">
												 <label class="col-25 form-label">보고서 생성</label>
												 <div class="col-75 tl">
													 <div class="text-input"><button type="button" class="button button-Rsmall">육안판정서</button></div>
												 </div>
											 </div>
											 <div class="form-group">
												 <label class="col-25 form-label">자가진단 등급</label>
												 <div class="col-75 tl">
													 <div class="text-input">우수</div>
												 </div>
											 </div>
										 </div>
										</div>
									</div>
								</div>
							</div>
						</div>
					<!--이미지 -->
					<div class="" style="width:30%;display: inline-block;margin-left:20px">
						<div class="tab-in-nav">
							<button type="button" class="button btn-radius"><a href="#tab01">이미지</a></button>
						</div>
						<ul>
							<li style="width:100%; height:150px;border: 1px solid #eee;border-radius: 4px;"><img src="/images/icon_edit.png" alt=""></li>
							<li style="width:100%; height:150px;border: 1px solid #eee;border-radius: 4px;"><img src="/images/icon_edit.png" alt=""></li>
							<li style="width:100%; height:150px;border: 1px solid #eee;border-radius: 4px;"><img src="/images/icon_edit.png" alt=""></li>
						</ul>
					</div>
					</div>
				</div>
			</div>

			<div>
				<button type="button" class="button btn-success">저장</button>
				<button type="button" class="button btn-cancel">취소</button>
			</div>
			<div class="tr pt40">
				<button type="button" class="button btn-success" onclick="location.href='../myself/MySelf.html';">포장재질구조평가</button>
				<button type="button" class="button btn-success">가이드보기</button>
			</div>
			<!-- 버튼 -->
			<div class="modal-footer btn-group">
				<button type="button" class="button btn-success" data-dismiss="modal">저장</button>
				<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<!-- 레이어 팝업 - delete -->
<div id="delete" class="modal" data-backdrop-limit="1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-modal-parent="#myModal">
	<div class="modal-content" style="width:400px">
		<div class="modal-header">
			<h4 class="modal-title">삭제</h4>
			<button type="button" class="close" data-dismiss="modal"><img src="/images/icon_close.png"></button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-100">
					<div class="form-group">
						<div class="tc">(<em class="text-bold">PEuser01</em>)삭제합니다.</div>
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
<script>
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
	
	function goToProductPage(id) {
		window.location.href = '/product/prodList?productId='+id;
	}
</script>
