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
	<div class="row mt10">
		<div class="img-box">
			<h4 class="line-br">
				<em>서울우유800ml</em>
			</h4>
			<div class="img-view">
				<img src=../images/pro_img04.jpeg>
			</div>
			<div class="img-cont ellipsis">
				<ul>
					<li class="text-bold">ㆍ제품명 : <span>서울우유800ml</span></li>
					<li class="text-bold">ㆍ포장유형 : <span>유리병</span></li>
					<li class="text-bold">ㆍ재활용등급 : <span class="fontColorBlue">정상</span></li>
					<li class="text-bold">ㆍ진행상태 : <span class="fontColorBlue">완료</span></li>
				</ul>
			</div>
			<div class="img-bottom tc">
				<button type="button" class="button btn-success"
					data-dismiss="modal">상세</button>
			</div>
		</div>

		<div class="img-box">
			<h4 class="line-br">
				<em>아이스브레이스</em>
			</h4>
			<div class="img-view">
				<img src=../images/pro_img01.jpeg>
			</div>
			<div class="img-cont ellipsis">
				<ul>
					<li class="text-bold">ㆍ제품명 : <span>아이스브레이스</span></li>
					<li class="text-bold">ㆍ포장유형 : <span>종이</span></li>
					<li class="text-bold">ㆍ재활용등급 : <span class="colorRed">나쁨</span></li>
					<li class="text-bold">ㆍ진행상태 : <span>진행중</span></li>
				</ul>
			</div>
			<div class="img-bottom tc">
				<button type="button" class="button btn-success"
					data-dismiss="modal">상세</button>
			</div>
		</div>
		<div class="img-box">
			<h4 class="line-br">
				<em>서울우유800ml</em>
			</h4>
			<div class="img-view">
				<img src=../images/pro_img02.jpeg>
			</div>
			<div class="img-cont ellipsis">
				<ul>
					<li class="text-bold">ㆍ제품명 : <span>서울우유800ml</span></li>
					<li class="text-bold">ㆍ포장유형 : <span>유리병</span></li>
					<li class="text-bold">ㆍ재활용등급 : <span>정상</span></li>
					<li class="text-bold">ㆍ진행상태 : <span>완료</span></li>
				</ul>
			</div>
			<div class="img-bottom tc">
				<button type="button" class="button btn-success"
					data-dismiss="modal">상세</button>
			</div>
		</div>
		<div class="img-box">
			<h4 class="line-br">
				<em>서울우유800ml</em>
			</h4>
			<div class="img-view">
				<img src=../images/pro_img03.jpeg>
			</div>
			<div class="img-cont ellipsis">
				<ul>
					<li class="text-bold">ㆍ제품명 : <span>서울우유800ml</span></li>
					<li class="text-bold">ㆍ포장유형 : <span>유리병</span></li>
					<li class="text-bold">ㆍ재활용등급 : <span>정상</span></li>
					<li class="text-bold">ㆍ진행상태 : <span>완료</span></li>
				</ul>
			</div>
			<div class="img-bottom tc">
				<button type="button" class="button btn-success"
					data-dismiss="modal">상세</button>
			</div>
		</div>
		<div class="img-box">
			<h4 class="line-br">
				<em>서울우유800ml</em>
			</h4>
			<div class="img-view">
				<img src=../images/pro_img04.jpeg>
			</div>
			<div class="img-cont ellipsis">
				<ul>
					<li class="text-bold">ㆍ제품명 : <span>서울우유800ml</span></li>
					<li class="text-bold">ㆍ포장유형 : <span>유리병</span></li>
					<li class="text-bold">ㆍ재활용등급 : <span>정상</span></li>
					<li class="text-bold">ㆍ진행상태 : <span>완료</span></li>
				</ul>
			</div>
			<div class="img-bottom tc">
				<button type="button" class="button btn-success"
					data-dismiss="modal">상세</button>
			</div>
		</div>
		<div class="img-box">
			<h4 class="line-br">
				<em>서울우유800ml</em>
			</h4>
			<div class="img-view">
				<img src=../images/pro_img05.jpeg>
			</div>
			<div class="img-cont ellipsis">
				<ul>
					<li class="text-bold">ㆍ제품명 : <span>서울우유800ml</span></li>
					<li class="text-bold">ㆍ포장유형 : <span>유리병</span></li>
					<li class="text-bold">ㆍ재활용등급 : <span>정상</span></li>
					<li class="text-bold">ㆍ진행상태 : <span>완료</span></li>
				</ul>
			</div>
			<div class="img-bottom tc">
				<button type="button" class="button btn-success"
					data-dismiss="modal">상세</button>
			</div>
		</div>
		<div class="img-box">
			<h4 class="line-br">
				<em>서울우유800ml</em>
			</h4>
			<div class="img-view">
				<img src=../images/pro_img06.jpeg>
			</div>
			<div class="img-cont ellipsis">
				<ul>
					<li class="text-bold">ㆍ제품명 : <span>서울우유800ml</span></li>
					<li class="text-bold">ㆍ포장유형 : <span>유리병</span></li>
					<li class="text-bold">ㆍ재활용등급 : <span>정상</span></li>
					<li class="text-bold">ㆍ진행상태 : <span>완료</span></li>
				</ul>
			</div>
			<div class="img-bottom tc">
				<button type="button" class="button btn-success"
					data-dismiss="modal">상세</button>
			</div>
		</div>
	</div>
</div>


<!-- 레이어 팝업 - 상세  -->
<div id="detail" class="modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width: 1200px">
		<div class="modal-header">
			<h4 class="modal-title">상세</h4>
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
						<div id="tab-content" class="tab-content"
							style="width: 70%; display: inline-block; vertical-align: top;">
							<div class="tab-in-nav">
								<button type="button" class="button btn-radius">
									<a href="#tab01">몸체</a>
								</button>
								<button type="button" class="button btn-radius">
									<a href="#tab02">라벨</a>
								</button>
								<button type="button" class="button btn-radius">
									<a href="#tab03">마개및잡자재</a>
								</button>
								<button type="button" class="button btn-radius">
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
															<input name="files[]" type="file" multiple="multiple"
																id="our-file03" class="multi with-preview">
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
															<input type="radio" id="radio1" name="radio"> <label
																for="radio1" class="mr05">기기분석</label> <input
																type="radio" id="radio1" name="radio"> <label
																for="radio1" class="mr05">육안판정</label> <input
																type="radio" id="radio1" name="radio"> <label
																for="radio1" class="mr05">공인시험성적서</label> <input
																type="radio" id="radio1" name="radio"> <label
																for="radio1" class="mr05">신고허가서류</label> <input
																type="radio" id="radio1" name="radio"> <label
																for="radio1" class="mr05">기타</label>
															<div>
																<input type="file">
															</div>
														</div>
													</div>
												</div>
												<div class="form-group">
													<label class="col-25 form-label">보고서 생성</label>
													<div class="col-75 tl">
														<div class="text-input">
															<button type="button" class="button-Rsmall">육안판정서</button>
														</div>
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
										<h4 class="tl pt15">
											<span class="title-point">[라벨 상세]</span>
										</h4>
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
															<input name="files[]" type="file" multiple="multiple"
																id="our-test" class="multi with-preview">
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
															<input type="radio" id="radio1" name="radio"> <label
																for="radio1" class="mr05">기기분석</label> <input
																type="radio" id="radio1" name="radio"> <label
																for="radio1" class="mr05">육안판정</label> <input
																type="radio" id="radio1" name="radio"> <label
																for="radio1" class="mr05">공인시험성적서</label> <input
																type="radio" id="radio1" name="radio"> <label
																for="radio1" class="mr05">신고허가서류</label> <input
																type="radio" id="radio1" name="radio"> <label
																for="radio1" class="mr05">기타</label>
															<div>
																<input type="file">
															</div>
														</div>
													</div>
												</div>
												<div class="form-group">
													<label class="col-25 form-label">보고서 생성</label>
													<div class="col-75 tl">
														<div class="text-input">
															<button type="button" class="button button-Rsmall">육안판정서</button>
														</div>
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
						<div class=""
							style="width: 30%; display: inline-block; margin-left: 20px">
							<div class="tab-in-nav">
								<button type="button" class="button btn-radius">
									<a href="#tab01">이미지</a>
								</button>
							</div>
							<ul>
								<li
									style="width: 100%; height: 150px; border: 1px solid #eee; border-radius: 4px;"><img
									src="../images/icon_edit.png" alt=""></li>
								<li
									style="width: 100%; height: 150px; border: 1px solid #eee; border-radius: 4px;"><img
									src="../images/icon_edit.png" alt=""></li>
								<li
									style="width: 100%; height: 150px; border: 1px solid #eee; border-radius: 4px;"><img
									src="../images/icon_edit.png" alt=""></li>
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
				<button type="button" class="button btn-success"
					onclick="location.href='../myself/MySelf.html';">포장재질구조평가</button>
				<button type="button" class="button btn-success">가이드보기</button>
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
	var button = '<button class="tab-close" type="button" title="Remove this page">×</button>';
	var tabID = 1;
	function resetTab() {
		var tabs = $("#tab-list li:not(:first)");
		var len = 1
		$(tabs).each(function(k, v) {
			len++;
			$(this).find('a').html(len + '차 포장' + button);
		})
		tabID--;
	}

	$(document).ready(function() {
		$('#btn-add-tab').click(function() {
			tabID++;
			$('#tab-list').append($('<li><a href="#tab' + tabID + '" role="tab" data-toggle="tab"><input type=text value=' + tabID + '차 포장><button class="tab-close" type="button" title="Remove this page">×</button></a></li>'));
			$('#tab-content').append($('<div class="tab-pane fade" id="tab' + tabID + '">Tab '+ tabID+ ' content</div>'));
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
// 	var totalPage = ${pages.totalPage};
// 	var page = ${pages.page};
// 	var pageSize = ${pages.pageSize};

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