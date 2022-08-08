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
<!-- 								<option value="recycleGrade">재활용등급</option> -->
<!-- 								<option value="completeStatus">상태</option> -->
			                 </select>
						</div>
						<div class="form-inline">
							<select id="matTypeList" name="matTypeList" class="select-box w150">
			                    <option value="ALL">전체</option>
			                    <c:forEach items="${matTypeList }" var="matType" varStatus="status">
									<option value="${matType.codeId}">${matType.codeNm}</option>
								</c:forEach>
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
								<c:if test="${product.photoRepFileId ne '' && not empty product.photoRepFileId}">
									<a href="javascript:getGroupImages('${product.productId}', '${product.photoGfileId}', '${product.photoRepFileId}');" ><img src="/file/view/${product.photoRepFileId}" width="70" height="auto"></a>
								</c:if>
							</div>
							<div class="img-cont ellipsis">
								<ul>
									<li class="text-bold" style="text-overflow: ellipsis;overflow: hidden;white-space: nowrap;">ㆍ제품명 : <span>${product.productNm}</span></li>
									<li class="text-bold">ㆍ포장유형 : <span>${product.matType}</span></li>
									<li class="text-bold">ㆍ재활용등급 : 
										<span class="fontColorBlue">
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
										</span>
									</li>
									<li class="text-bold">ㆍ진행상태 : <span class="fontColorBlue">${product.masterApplyNm}</span></li>
								</ul>
							</div>
							<div class="img-bottom tc">
									<button type="button" onclick="getGroupImages('${product.productId}', '${product.photoGfileId}', '${product.photoRepFileId}');"" class="btn-none" data-dismiss="modal">상세보기</button>
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

	<!-- 레이어 팝업 - 이메지 갤러리  -->
  <div id="deleteZoomLayer" class="modal" data-backdrop-limit="1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
	aria-hidden="true" data-modal-parent="#myModal">
	<input type="hidden" name="productId" >
	<div class="modal-content" style="width:400px">
	  <div class="modal-header">
		<h4 class="modal-title">상품 이미지</h4>
		<button type="button" class="close" data-dismiss="modal" onclick="javascript:layerPopupClose(deleteZoomLayer);"><img src="/images/icon_close.png"></button>
	  </div>
	  <div class="modal-body">
		<div class="row">
		  <!-- Primary carousel image -->
	     <div class="show">
	       <img src="/images/pro_img01.jpeg" id="show-img">
	     </div>
	
	     <!-- Secondary carousel image thumbnail gallery -->
	
	     <div class="small-img">
	      <img src="/images/next-icon.png" class="icon-left" alt="" id="prev-img">
	       <div class="small-container">
	        <div id="small-img-roll">
	        </div>
	       </div>
	      <img src="/images/next-icon.png" class="icon-right" alt="" id="next-img">
	     </div>
		</div>
	  </div>
	  <div class="modal-footer btn-group">
		<button type="button" class="button btn-cancel" data-dismiss="modal" onclick="javascript:layerPopupClose(deleteZoomLayer);">취소</button>
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

	function cssGroupImage() {
		$('.show-small-img:first-of-type').css({'border': 'solid 1px #951b25', 'padding': '2px'})
		$('.show-small-img:first-of-type').attr('alt', 'now').siblings().removeAttr('alt')
		$(document).on('click', '.show-small-img', function () {
		  $('#show-img').attr('src', $(this).attr('src'))
		  $('#big-img').attr('src', $(this).attr('src'))
		  $(this).attr('alt', 'now').siblings().removeAttr('alt')
		  $(this).css({'border': 'solid 1px #951b25', 'padding': '2px'}).siblings().css({'border': 'none', 'padding': '0'})
		  if ($('#small-img-roll').children().length > 4) {
		    if ($(this).index() >= 3 && $(this).index() < $('#small-img-roll').children().length - 1){
		      $('#small-img-roll').css('left', -($(this).index() - 2) * 76 + 'px')
		    } else if ($(this).index() == $('#small-img-roll').children().length - 1) {
		      $('#small-img-roll').css('left', -($('#small-img-roll').children().length - 4) * 76 + 'px')
		    } else {
		      $('#small-img-roll').css('left', '0')
		    }
		  }
		});

		//Enable the next button
		$(document).on('click', '#next-img', function (){
		  $('#show-img').attr('src', $(".show-small-img[alt='now']").next().attr('src'))
		  $('#big-img').attr('src', $(".show-small-img[alt='now']").next().attr('src'))
		  $(".show-small-img[alt='now']").next().css({'border': 'solid 1px #951b25', 'padding': '2px'}).siblings().css({'border': 'none', 'padding': '0'})
		  $(".show-small-img[alt='now']").next().attr('alt', 'now').siblings().removeAttr('alt')
		  if ($('#small-img-roll').children().length > 4) {
		    if ($(".show-small-img[alt='now']").index() >= 3 && $(".show-small-img[alt='now']").index() < $('#small-img-roll').children().length - 1){
		      $('#small-img-roll').css('left', -($(".show-small-img[alt='now']").index() - 2) * 76 + 'px')
		    } else if ($(".show-small-img[alt='now']").index() == $('#small-img-roll').children().length - 1) {
		      $('#small-img-roll').css('left', -($('#small-img-roll').children().length - 4) * 76 + 'px')
		    } else {
		      $('#small-img-roll').css('left', '0')
		    }
		  }
		});

		//Enable the previous button
		$(document).on('click', '#prev-img', function (){
		  $('#show-img').attr('src', $(".show-small-img[alt='now']").prev().attr('src'))
		  $('#big-img').attr('src', $(".show-small-img[alt='now']").prev().attr('src'))
		  $(".show-small-img[alt='now']").prev().css({'border': 'solid 1px #951b25', 'padding': '2px'}).siblings().css({'border': 'none', 'padding': '0'})
		  $(".show-small-img[alt='now']").prev().attr('alt', 'now').siblings().removeAttr('alt')
		  if ($('#small-img-roll').children().length > 4) {
		    if ($(".show-small-img[alt='now']").index() >= 3 && $(".show-small-img[alt='now']").index() < $('#small-img-roll').children().length - 1){
		      $('#small-img-roll').css('left', -($(".show-small-img[alt='now']").index() - 2) * 76 + 'px')
		    } else if ($(".show-small-img[alt='now']").index() == $('#small-img-roll').children().length - 1) {
		      $('#small-img-roll').css('left', -($('#small-img-roll').children().length - 4) * 76 + 'px')
		    } else {
		      $('#small-img-roll').css('left', '0')
		    }
		  }
		});
		layerPopup($('#deleteZoomLayer'));
	}
	// image group 조회
	function getGroupImages(productId, gfileId, photoRepFileId) {
		$('#small-img-roll').empty();
		var html ="";
		$('#show-img').attr("src","/file/view/"+photoRepFileId);
		html +='<img src="/file/view/'+photoRepFileId+'" class="show-small-img" alt="">';
		if(gfileId && gfileId !== null && gfileId !== '') {
			$.ajax({
				url : '/product/detail/'+productId+'/groupImages/'+gfileId,
				dataType : 'json',
				type : "GET",
				async : false,
				success : function(data) {
					data.forEach(function(item, index) {
	// 					console.log(item);
	// 					if(index === 0) {
	// 						$('#show-img').attr("src","/file/view/"+item.fileId);
	// 					}
						html +='<img src="/file/view/'+item.fileId+'" class="show-small-img" alt="">';
					});
					
					$('#small-img-roll').append(html);
					cssGroupImage();
				}
			});
		}else {
			$('#small-img-roll').append(html);
			cssGroupImage();
		}
	}
</script>
