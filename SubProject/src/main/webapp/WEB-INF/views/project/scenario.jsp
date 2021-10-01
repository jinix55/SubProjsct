<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" href="/css/treetable/jquery.treetable.css" />
<link rel="stylesheet"href="/css/treetable/jquery.treetable.theme.default.css" />
<script src="/js/treetable/jquery.treetable.js"></script>
<section class="content">
	<div class="content_tit">
		<div><span class="content_h1">시나리오</span></div>
		<ul class="content_nav">
			<li>HOME</li>
			<li>프로젝트</li>
			<li>시나리오</li>
		</ul>
	</div>
	
	<div class="boxHeader">
		<form id="scenarioForm" action="/project/scenario" method="post">
			
			<div class="search_wrap">
				<div class="form-inline">
					<div class="search-box">
					    <input type="text"  class="mr10" id="domainId" name="domainId" value="${scenarioModel.domainId }" placeholder="도메인 번호">
					    <input type="text" class="mr10" id="cookieId" name="cookieId" value="${scenarioModel.cookieId }" placeholder="쿠키값을 입력해 주세요.">
						<input type="text" id="searchValue" name="searchValue" placeholder="검색어를 입력하세요." class="w30">
						<span class="search-box-append">
							<button type="button" class="btn small success" onclick="search();">적용</button>
						</span>
						<input type="button" value="업로드 펼치기" onclick="showUpload();" id="uploadShow" class="btn small blue ml10">
					</div>

				</div>
		    </div>
    	</form>
		<div class="fileBox showUpload" style="display:none">
			<form id="fileForm" name="fileForm" enctype="multipart/form-data" method="post">
				<div id="fileDrop" class="fileDrop drag_drop_bg mt20"></div>
				<div class="buttonBox">
					<button type="button" id="cancle" class="btn small clear">취소</button>
					<button type="button" id="save" class="btn small success ml10">저장</button>
                </div>
				<!-- <div class="buttonBox">
                    <button type="button" id="save">저장</button>
                </div> -->
			</form>
		</div>
	</div>
	
   <div class="box_wrap2"> 
		<div class="box_cont">
			<!-- <div class="tb01_line"></div> -->
			<table class="tb01 state_list" id="example-advanced">
				<caption class="hidden">사용자 목록</caption>
				<colgroup>
					<col width="25%">
					<col width="*">
					<col width="15%">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">
							<div class="checkbox"></div> <span>대화</span>
						</th>
						<th scope="col">대화목록 <em id="chatListCount">( 0 )</em></th>
						<th scope="col">링크</th>
					</tr>
				</thead>
				<tbody id="htmlView">
					<tr class="collapsed">
						<td colspan="3">검색된 내용이 없습니다.</td>
					</tr>
				</tbody>
			</table>
			<div class="page"></div>
		</div>
		<div class="box_cont">
			<div class="radio_select mb10">
<!-- 				 <label>
					<input type="radio" id="radioTypeNORMAL" name="radioType" value="NORMAL"  disabled="disabled">일반대화
				</label>
				<label> 
					<input type="radio" id="radioTypeTASK" name="radioType" value="TASK" disabled="disabled">TASK
				</label>           
				<div class="loginTxt2">
					<input type="text" id="selectId" class="selectId" disabled>
					<input type="text" id="selectName" class="selectName"  disabled>
					<div style="display: none;">
						<input type="checkbox" class="checkbox" value="" name="checkedid">
						<div class="checkbox"></div>
					</div>
				</div> -->
				  <input type="radio" id="radioTypeNORMAL" name="radioType" value="NORMAL" checked="checked">
	              <label for="radioTypeNORMAL">일반대화</label>
	              <input type="radio" id="radioTypeTASK" name="radioType" value="TASK">
	              <label for="radioTypeTASK">TASK</label>
			              
			</div>
			<div class="col-md-12 questionSearchList">
				<div class="table-result">
					<input type="hidden" id="questionErrorMsg" value="">
					<div class="data_table" id="questionArea">
						<div class="categy_title">
							<span>질문</span><span id="questionCount"><em>(0)</em></span>
							<img alt="펼치기"	src="/images/icon_arr_faq.png">
						</div>
						<div class="sub_data_table" style="display: none;">
<!-- 							<table id="" class="add_data"> -->
<%-- 								<caption class="clipped">data add</caption> --%>
<%-- 								<colgroup> --%>
<%-- 									<col width="12%"> --%>
<%-- 									<col width="*"> --%>
<%-- 									<col width="10%"> --%>
<%-- 								</colgroup> --%>
<!-- 								<tbody> -->
<!-- 									<tr> -->
<!-- 										<td><select id="questionType"> -->
<!-- 												<option>일반 질문</option> -->
<!-- 												<option>정규식 질문</option> -->
<!-- 												<option>인텐트</option> -->
<!-- 												<option>cic 이벤트</option> -->
<!-- 										</select></td> -->
<!-- 										<td><input type="hidden" class="hidden" id="questionId" -->
<!-- 											value=""> <input type="text" class="test" -->
<!-- 											id="questionText"></td> -->
<!-- 										<td> -->
<!-- 											<button class="scBtn" type="button" action-type="add" -->
<!-- 												id="questionService">추가</button> -->
<!-- 										</td> -->
<!-- 									</tr> -->
<!-- 								</tbody> -->
<!-- 							</table> -->
							<table class="data_table">
								<caption class="clipped">data table</caption>
								<colgroup>
									<col width="15%">
									<col width="*">
<%-- 									<col width="5%"> --%>
<%-- 									<col width="5%"> --%>
								</colgroup>
								<thead class="">
									<tr>
										<th>질문 유형</th>
										<th>질문 내용</th>
<!-- 										<th>편집</th> -->
<!-- 										<th>삭제</th> -->
									</tr>
								</thead>
								<tbody class="tbody_question">

								</tbody>
								<tbody>
									<tr class="result_none none">
										<td colspan="2">조회 결과 없음</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-12 inputContextSearchList">
				<div class="table-result">
					<input type="hidden" id="inputContextErrorMsg" value="">
					<div class="data_table" id="inputArea">
						<div class="categy_title">
							<span>Input 컨텍스트</span><span id="questionCount"><em>(0)</em></span>
							<img alt="펼치기" src="/images/icon_arr_faq.png">
						</div>
						<div class="sub_data_table" style="display: none">
<!-- 							<table id="" class="add_data"> -->
<%-- 								<caption class="clipped">data add</caption> --%>
<%-- 								<colgroup> --%>
<%-- 									<col width="*"> --%>
<%-- 									<col width="10%"> --%>
<%-- 								</colgroup> --%>
<!-- 								<tbody> -->
<!-- 									<tr> -->
<!-- 										<td><input type="text" class="" -->
<!-- 											id="createInputContextText"></td> -->
<!-- 										<td> -->
<!-- 											<button class="scBtn" type="button" action-type="add" -->
<!-- 												id="inputService">추가</button> -->
<!-- 										</td> -->
<!-- 									</tr> -->
<!-- 								</tbody> -->
<!-- 							</table> -->
							<table id="" class="data_table">
								<caption class="clipped">data table</caption>
								<colgroup>
									<col width="*">
<%-- 									<col width="5%"> --%>
<%-- 									<col width="5%"> --%>
								</colgroup>
								<thead class="">
									<tr>
										<th>내용</th>
<!-- 										<th>편집</th> -->
<!-- 										<th>삭제</th> -->
									</tr>
								</thead>
								<tbody class="tbody_input">
								</tbody>
								<tbody>
									<tr class="result_none none">
										<td colspan="1">조회 결과 없음</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-12 outputContextSearchList">
				<div class="table-result">
					<input type="hidden" id="outputContextErrorMsg" value="">
					<div class="data_table" id="outputArea">
						<div class="categy_title">
							<span>Output 컨텍스트</span><span id="questionCount"><em>(0)</em></span>
							<img alt="펼치기" src="/images/icon_arr_faq.png">
						</div>
						<div class="sub_data_table" style="display: none">
<!-- 							<table id="" class="add_data"> -->
<%-- 								<caption class="clipped">data add</caption> --%>
<%-- 								<colgroup> --%>
<%-- 									<col width="*"> --%>
<%-- 									<col width="10%"> --%>
<%-- 									<col width="10%"> --%>
<%-- 									<col width="10%"> --%>
<%-- 									<col width="10%"> --%>
<%-- 								</colgroup> --%>
<!-- 								<tbody> -->
<!-- 									<tr> -->
<!-- 										<td><input type="text" class="" -->
<!-- 											id="createOutputContextText"></td> -->
<!-- 										<td><select id="createOutputContextFunction"> -->
<!-- 												<option selected="selected">추가</option> -->
<!-- 												<option>유지</option> -->
<!-- 												<option>삭제</option> -->
<!-- 										</select></td> -->
<!-- 										<td><input type="text" class="" -->
<!-- 											id="createOutputContextLimitCount" maxlength="1" -->
<!-- 											placeholder="0~3"></td> -->
<!-- 										<td><input type="text" class="" -->
<!-- 											id="createOutputContextLimitTime" maxlength="1" -->
<!-- 											placeholder="1~5"></td> -->
<!-- 										<td> -->
<!-- 											<button class="scBtn" type="button" action-type="add" -->
<!-- 												id="outputService">추가</button> -->
<!-- 										</td> -->
<!-- 									</tr> -->
<!-- 								</tbody> -->
<!-- 							</table> -->
							<table id="" class="data_table">
								<caption class="clipped">data table</caption>
								<colgroup>
									<col width="*">
									<col width="12%">
									<col width="12%">
									<col width="12%">
<%-- 									<col width="5%"> --%>
<%-- 									<col width="5%"> --%>
								</colgroup>
								<thead class="">
									<tr>
										<th>내용</th>
										<th>동작</th>
										<th>횟수제한(회)</th>
										<th>시간제한(분)</th>
<!-- 										<th>편집</th> -->
<!-- 										<th>삭제</th> -->
									</tr>
								</thead>
								<tbody class="tbody_output">
								</tbody>
								<tbody>
									<tr class="result_none none">
										<td colspan="4">조회 결과 없음</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-12 taskSearchList">
				<div class="table-result">

					<input type="hidden" id="taskErrorMsg" value="">
					<div class="data_table" id="taskArea"
						style="display: block">
						<div class="categy_title">
							<span>TASK</span><span id="questionCount"><em>(0)</em></span>
							<img alt="펼치기" src="/images/icon_arr_faq.png">
						</div>
						<div class="sub_data_table" style="display: none">
<!-- 							<table class="add_data"> -->
<%-- 								<caption class="clipped">TASK add data table</caption> --%>
<%-- 								<colgroup> --%>
<%-- 									<col width="3%"> --%>
<%-- 									<col width="18%"> --%>
<%-- 									<col width="18%"> --%>
<%-- 									<col width="18%"> --%>
<%-- 									<col width="*"> --%>
<%-- 									<col width="10%"> --%>
<%-- 								</colgroup> --%>
<!-- 								<tbody> -->
<!-- 									<tr> -->
<!-- 										<td class="txt_cntr"><input type="checkbox" -->
<!-- 											name="createTaskRequireCheckbox" value="Y"></td> -->
<!-- 										<td><input type="text" class="" id="createTaskNameText"></td> -->
<!-- 										<td><input type="text" class="" id="createTaskEntityText"></td> -->
<!-- 										<td><input type="text" class="" id="createTaskValueText"></td> -->
<!-- 										<td><input type="text" class="" -->
<!-- 											id="createTaskAskAgainQuestionText"></td> -->
<!-- 										<td> -->
<!-- 											<button class="scBtn" type="button" action-type="add" -->
<!-- 												id="taskService">추가</button> -->
<!-- 										</td> -->
<!-- 									</tr> -->
<!-- 								</tbody> -->
<!-- 							</table> -->
							<table id="" class="data_table">
								<caption class="clipped">TASK data table</caption>
							    <colgroup>
									<col width="13.333%">
									<col width="20%">
									<col width="13.333%">
									<col width="20%">
									<col width="13.333%">
									<col width="20%">
								</colgroup>
								<tbody class="tbody_task">
									<tr>
										<th>필수</th><td>2</td>
										<th>슬롯</th><td>2</td>
										<th>값</th><td>2</td>
									</tr>
									<tr>
										<th>엔티티</th><td colspan="5"><textarea class="textarea">Information</textarea></td>
									</tr>
									<tr>
										<th>되묻기 질문</th><td colspan="5"><textarea class="textarea">Information</textarea></td>
									</tr>

									<tr>
										<th>횟수</th><td>3</td>
										<th>되뭇기후속동작</th><td>3</td>
										<th>초과메시지후속동작</th><td>3</td>
									</tr>
									<tr>
										<th>검증</th><td colspan="5"><textarea class="textarea">Information</textarea></td>
									</tr>
									<tr>
										<th>초과메시지</th><td colspan="5"><textarea class="textarea">Information</textarea></td>
									</tr>
									 <tr>
										<th>되묻기 Information</th><td colspan="5"><textarea class="textarea">Information</textarea></td>
									</tr>
									<tr>
										<th>초과메시지 Information</th><td colspan="5"><textarea class="textarea">Information</textarea></td>
									</tr>

								</tbody>
								<tbody>
									<tr class="result_none none">
										<!-- 결과 없을 경우 none지우고 block으로 -->
										<td colspan="10">조회 결과 없음</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-12 answerSearchList">
				<div class="table-result">

					<input type="hidden" id="answerErrorMsg" value="">
					<div class="data_table" id="answerArea" style="display: block">

						<div class="categy_title">
							<span>답변</span><span id="questionCount"><em>(0)</em></span>
							<img alt="펼치기" src="/images/icon_arr_faq.png">
						</div>

						<div class="sub_data_table" style="display: none">
<!-- 							<div class="aDD_GRUP"> -->
<!-- 								<BUTTON ID="ADDANSWERGROUPBTN" ONCLICK="ADDANSWERBTN()"> -->
<!-- 									<IMG ALT="추가하기" SRC="/IMAGES/PLUS_ON.PNG">답변 그룹 추가 -->
<!-- 								</BUTTON> -->
<!-- 							</DIV> -->
							<div class="ansr_wrapper" id="div_ansr_wrapper_id">
							</div>
						</div>
					</div>
				</div>
			</div>
	</div>
	</div>
</section>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-treetable/3.2.0/jquery.treetable.js"></script>
<script>
var fileList = [];
	$(document).ready(function() {
		initAcc();

		if ($("#domainId").val() != "" && $("#sessionId").val() != "") {
			getList();
		}
		
		$("#fileDrop").on("dragenter", function(e){
	        e.preventDefault();
	        e.stopPropagation();
	    }).on("dragover", function(e){
	        e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#FFD8D8");
	    }).on("dragleave", function(e){
	        e.preventDefault();
	        e.stopPropagation();
	        $(this).css("background-color", "#FFF");
	    }).on("drop", function(e){
	        e.preventDefault();

	        var files = e.originalEvent.dataTransfer.files;
	        if(files != null && files != undefined){
	            var tag = "";
	            for(i=0; i<files.length; i++){
	                var f = files[i];
	                fileList.push(f);
	                var fileName = f.name;
	                var fileSize = f.size / 1024 / 1024;
	                fileSize = fileSize < 1 ? fileSize.toFixed(3) : fileSize.toFixed(1);
	                tag += 
	                        "<div class='fileList'>" +
	                            "<span class='fileName'>"+fileName+"</span>" +
	                            "<span class='fileSize'>"+fileSize+" MB</span>" +
	                            "<span class='clear'></span>" +
	                        "</div>";
	            }
	            $(this).append(tag);
	        }

	        $(this).css("background-color", "#FFF");
	        $(this).css("background", "white");
	    });

	});
	
	/**
	 * 페이징 처리 공통 함수
	 */
	var num = '${pages.page}';
	var totalCount = $("#totalCount").val();
	
	$('#cancle').click(function(){
		fileList = [];
		$('#fileDrop').empty();
		$('#fileDrop').css("background", "");
	});
	
	$(document).on("click", "#save", function(){
        var formData = new FormData($("#fileForm")[0]);
        if(fileList.length > 0){
            fileList.forEach(function(f){
                formData.append("fileList", f);
            });
        }

        $.ajax({
            url : "scenario/detail/uploadPath",
            data : formData,
            type:'POST',
            enctype:'multipart/form-data',
            processData:false,
            contentType:false,
            dataType:'json',
            cache:false,
            success:function(res){
            	if(res == 'success'){
	                alert("업로드에 성공하셨습니다.");
            	}else{
            		alert("업로드에 실패하셨습니다.\n다시 확인 부탁드립니다.");
            	}
            },error:function(res){
//                 alert("오류 발생.\n관리자에게 문의해주세요.");
            }
        });
    });
	
	

	function initAcc() {
		let Accordion = function(el, multiple) {
			this.el = el || {};
			this.multiple = multiple || false;

			// Variables privadas
			let links = this.el.find('div.categy_title');
			// Evento
			links.on('click', {
				el : this.el,
				multiple : this.multiple
			}, this.dropdown);
		};

		Accordion.prototype.dropdown = function(e) {
			let $el = e.data.el;
			$this = $(this), $next = $this.next();

			$next.slideToggle();
			$this.parent().toggleClass('is-open');
			if (!e.data.multiple) {
				$el.find('.sub_data_table').not($next).slideUp().parent()
						.removeClass('is-open');
			}
			;
		};

		let accordion = new Accordion($('div.data_table'), true);
	}

	function getList() {
		let doId = new Number($('#domainId').val());
		params = {
			domainId : doId,
			cookieId : $('#cookieId').val(),
			page: $('#page').val()
		}
		$.ajax({
			type : "post",
			url : "/project/scenario/detail",
			dataType : "json",
			contentType : "application/json",
			data : JSON.stringify(params),
			async : true,
			success : function(result) {
				console.log(result);
				setList(result);
			},
			error : function(result) {
				console.log("error result : ", result);
			}
		});
	}

	function setList(data) {
		var html = "";
		$('#htmlView').empty();
		$('#totalCount').val(data.totalCount);
		let scenario = data.data;
		if(scenario.length > 0){
			$('#chatListCount').html(scenario.length);
			for (var i = 0; i < scenario.length; i++) {
				let data = null;
				let isFolder = false;
				if (scenario[i].data != undefined) {
					isFolder = true;
					data = JSON.parse(scenario[i].data);
				}
				html += '<tr data-tt-id="'+scenario[i].nodeId+'" data-tt-parent-id="'+scenario[i].parentId+'">';
				html += '<td>'
				if (isFolder) {
					html += '<input type="checkbox" name="user_CheckBox" id="user_CheckBox_'+data.id+'">';
				} else {
					html += '<input type="checkbox" name="user_CheckBox" id="user_CheckBox_none_'+i+'">';
				}
				if (isFolder) {
					html += '<span class="file">' + scenario[i].name + '</span>';
				} else {
					html += '<span class="folder">' + scenario[i].name + '</span>';
				}
				html += '</td>';
				if (isFolder) {
					html += '<td class="sc_rw" id="'+ data.id +'" qsId="'+data.chatQSessionId+'"  asId="'+data.chatASessionId+'">';
				} else {
					html += '<td class="sc_rw">';
				}
	
				html += '<input type="text" class="chat_txt" readonly="true" value="'+scenario[i].name+'">';
				html += '</td>';
				if(isFolder){
					html += '<td class="io_img_set" onclick="goLink('+data.id+');">';
				}else{
					html += '<td class="io_img_set">';
				}
				html += '<ul class="io_set">';
				html += '<li>';
				if(isFolder){
					html += '<img alt="링크 연결" class="pointer" src="/images/icon_blank.png">';
				}
				html += '</li>';
				html += '</ul>';
				html += '</td>';
				html += '</tr>';
			}
		}
		
		$('.page').bootpag({		// 페이징을 표시할 div의 클래스
			total: data.totalPage,  // 페이징모델의 전체페이지수
			page: data.page,		// 페이징모델의 현재페이지번호
			maxVisible: data.pageSize,  // 보여질 최대 페이지수
			firstLastUse: true,			 // first와 last사용유무
			wrapClass: 'page',			  // 페이징을 감싼 클래스명
			activeClass: 'on',			  // 현재페이지의 클래스명
			disabledClass: 'disabled',	  // 각 항목별 클래스 지정
			nextClass: 'next',
			prevClass: 'prev',
			lastClass: 'last',
			firstClass: 'first'
		});

		$('#htmlView').html(html);
		
		this.treeTable();
		

	}
	
	$(document).on("click", ".page a", function() {
		$("#page").val($(this).attr("data-lp"));
// 		getList();
console.log($("#page").val());
		$('#scenarioForm').submit();
	});
	
	function treeTable(){
		$("#example-advanced").treetable({
			expandable : true
		});

		// Highlight selected row
		$("#example-advanced tbody").on("mousedown", "tr", function() {
			$(".selected").not(this).removeClass("selected");
			$(this).toggleClass("selected");
		});

		$("#example-advanced .folder").each(function() { 
			$(this).parents("#example-advanced tr").droppable({
				accept : ".file, .folder",
				drop : function(e, ui) {
					let droppedEl = ui.draggable.parents("tr");
					$("#example-advanced").treetable("move",droppedEl.data("ttId"),$(this).data("ttId"));
				},
				hoverClass : "accept",
				over : function(e, ui) {
					let droppedEl = ui.draggable.parents("tr");
					if (this != droppedEl[0]&& !$(this).is(".expanded")) {
						$("#example-advanced").treetable("expandNode",$(this).data("ttId"));
					}
				}
			});
		});
	}
	
	function goLink(id){
		window.open('https://clovachatbot.fin-ncloud.com/dmManagementModify?domainId='+$('#domainId').val()+'&id='+id,'_blank');
	}
	
	function search() {
		if ($("#domainId").val() == "") {
			alert('도메인 번호를 입력해 주세요.');
			return;
		}
		if ($("#sessionId").val() == "") {
			alert('쿠키값을 입력해 주세요.');
			return;
		}

		$('#scenarioForm').submit();
		// 		getList();

	}
	
	function showUpload(){
		if($('#uploadShow').val() == '업로드 접기'){
			$('#uploadShow').val('업로드 펼치기');
			$('.showUpload').css('display','none');
		}else{
			$('#uploadShow').val('업로드 접기');
			$('.showUpload').css('display','block');
		}
	}

	function callInfoApi(serviceName, params) {
		let model = new Object();
		model.domainId = $("#domainId").val();
		model.cookie = $("#cookieId").val();
		model.id = $("#selectedId").val();
		model.serviceName = serviceName;
		for ( var key in params) {
			model[key] = params[key];
		}

		$.ajax({
			type : 'POST', // method
			url : '/project/scenario/detail/info', // POST 요청은 데이터가 요청 바디에 포함됩니다.
			// 			async: 'true', // true
			data : JSON.stringify(model),
			contentType : 'application/json'
		}).done(function(res) {
			let data = JSON.parse(res);
			console.log(data);
			setChatInfo(data);

			callSelectApi("selectChatSelect", model);
		});

	}

	function callSelectApi(serviceName, params) {
		let model = new Object();
		model.domainId = $("#domainId").val();
		model.cookieId = $("#cookieId").val();
		model.id = $("#selectedId").val();
		model.serviceName = serviceName;
		for ( var key in params) {
			model[key] = params[key];
		}

		$.ajax({
			type : 'POST', // method
			url : '/project/scenario/detail/select', // POST 요청은 데이터가 요청 바디에 포함됩니다.
			// 			async: 'true', // true
			data : JSON.stringify(model),
			contentType : 'application/json'
		}).done(function(res) {
			let data = JSON.parse(res);
			console.log(data);

			makeQeustionTable(JSON.parse(data.questionData));

			makeAnswerTable(JSON.parse(data.answerData));
			
			makeInputContext(JSON.parse(data.inputData));
			
			makeOutputContext(JSON.parse(data.outputData));

		});
	}

	// 질문 추가
	$(document).on("click",".scBtn",function() {
		if (!validation()) {
			console.log("service : "+ $(this).attr("id").replace("Service", ""));
			if ($("#" + $(this).attr("id").replace("Service", "")+ "Text").val().trim() == "") {
				alert('질문을 입력해 주세요.');
				// 	        		return;
			}
			params = {
				questionId : $('#questionId').val(),
				questionType : $('#questionType').val(),
				questionText : $('#questionText').val(),
				questionAction : $(this).attr("action-type")
			}
			callApi($(this).attr("id"), params);
			$("#questionText").val("");
		}
	});

	function validation() {
		var check = true;
		if (($("#domainId").val() == "") || ($("#sessionId").val() == "")
				|| ($("#selectId").val() == "")) {
			alert('대화목록을 선택 하세요');
			check = false;
		}
		return check;
	};

	$(document).on("click", ".sc_rw", function() {
		if ($(this).attr('id')) {
			let data = $('#sel_data_' + $(this).attr('id')).val();
			params = {
				id : $(this).attr('id'),
				chatQSessionId : $(this).attr('qsId'),
				chatASessionId : $(this).attr('asId')
			}
			callInfoApi("selectChatInfo", params);
		} else {
			$('.data_table').removeClass('is-open');
			$('.data_table').children('.sub_data_table').css('display','none');
			$('.tbody_question').empty();
			$('#div_ansr_wrapper_id').empty();
			$('.result_none').show();
			$('#questionCount').html(0);
			$('#inputCount').html(0);
			$('#outputCount').html(0);
			$('#taskCount').html(0);
			$('#answerCount').html(0);
// 			let accordion = new Accordion($('div.data_table'), false);
		}
	});

	function makeQeustionTable(data) {
		$('.tbody_question').empty();
		if (data.count > 0) {
			$('#questionCount').html(data.count);
			let arr = data.data;
			let html = "";
			for (i = 0; i < arr.length; i++) {
				let chat = arr[i].chat;
				let id = arr[i].id;
				let chatType = arr[i].chatType;
				let component = JSON.parse(chat);
				let descriptionData = component[0];
				let desc = descriptionData.component.data.description
				desc = desc.replace(/"/gi, '');
				let answerTypeResult = '';
				if (chatType == 'TEXT') {
					typeResult = '일반 질문';
				} else if (chatType == 'NLU_PATTERN') {
					typeResult = '정규식 질문';
				} else if (chatType == 'INTENT') {
					typeResult = '인텐트';
				}

				html += '<tr>';
				html += '	<td><input style="text-align: center;" type="text" class="chat_txt ml5 fts12" value="'+ typeResult +'" readonly="readonly"></td>';
				html += '	<td><input type="text" class="chat_txt ml5 fts12" value="'+ desc +'" readonly="readonly"></td>';
// 				html += '	<td>';
// 				html += '		<ul>';
// 				html += '			<li>';
// 				html += '				<img alt="펼치기" src="/images/icon_user_btn1.png">';
// 				html += '			</li>';
// 				html += '		</ul>';
// 				html += '	</td>';
// 				html += '	<td>';
// 				html += '		<ul>';
// 				html += '			<li>';
// 				html += '				<img alt="펼치기" src="/images/icon_btn_delete.png">';
// 				html += '			</li>';
// 				html += '		</ul>';
// 				html += '	</td>';
				html += '</tr>';
			}
			;
			$('.tbody_question').html(html);
			$('.result_none').hide();
			$('#questionArea').addClass('is-open');
			$('#questionArea').children('.sub_data_table').css('display','block');
			
		} else {
			$('.tbody_question').empty();
			$('.result_none').show();
			$('#questionArea').removeClass('is-open');
			$('#questionArea').children('.sub_data_table').css('display','none');
		}

	}
	
	function answerList(chatType,jdata){
		let html = '';
		let chatTypeText = '';
		let chatTypeAudio = '';
		let chatTypeNo = '';
		
		if(chatType == 'TEXT'){
			chatTypeText = 'selected';
		}else if(chatType == 'AUDIO'){
			chatTypeAudio = 'selected';
		}else{
			chatTypeNo = 'selected';
		}
	
		for(var i = 0 ; i < jdata.length ; i++){
			let component = jdata[i].component;
			let marker = '';
			if(jdata[i].marker){
				marker = 'checked';
			}
			html += ' <li class="select">';
			html += ' 	<select id="selectAnswerType_'+ jdata.id +'" onchange="fnSelectAnswerType(0, 0)" disabled="true" selected="selected">';
			html += ' 		<option value="TEXT" '+chatTypeText+'>기본답변</option>';
			html += ' 		<option value="AUDIO" '+chatTypeAudio+'>오디오답변</option>';
			html += ' 		<option value="NOANSWER" '+chatTypeNo+'>답변없음</option>';
			html += ' 	</select>';
			html += ' </li>';
			html += ' <li>';
			html += ' 	<textarea id="chat_'+ jdata.id +'" row="6" value="" class="" disabled>'+ component.data.description +'</textarea>';
			html += ' 	<div class="answr_makr" id="answr_makr_'+ jdata.id +'" disabled="true">';
			html += ' 		<input type="checkbox" id="makr_'+ jdata.id +'" '+ marker +' onclick="fnMarkerChange(0, 0)">';
			html += ' 		<label for="makr_'+ jdata.id +'">마커</label>';
			html += ' 	</div>';
			html += ' 	<button class="icoBtn" title="삭제" id="deleteAnswerItemBtn_'+ jdata.id +'" onclick="fnDeleteAnswerItemBtn(0, 0)" disabled="disabled">';
// 			html += ' 		<img alt="삭제하기" src="/images/icon_file_de_user.png">';
			html += ' 	</button>';
			html += ' </li>';
		}
		
		return html;
	}
	
	function afterAnswerList(selectChatType,jdata){
		let html = '';
		if(selectChatType == 'UTTSET'){
			afterActionMove = 'checked';
		}
		for(var i = 0 ; i < jdata.length ; i++){
			
			let afterActionMove = '';
			let afterActionEnd = '';
			let afterActionConnect = '';
			let afterActionWaitingVoice = '';
			let afterActionWaitingKeyPad = '';
			let information = jdata[i].information;
			let keyInputCount = '';
			let keyTimeout = '';
			let keybubble = '';
			let timeOut = '';
			let callNumber = '';
			let none = 'selected';
			let appendHtml = '';
			
			if(information){
				for(var j = 0 ; j < information.length ; j++){
					if( information[j].key == 'clovaDirectiveHeader-name-ReadDTMF'){
						afterActionWaitingKeyPad = 'selected';
						none = '';
					}else if( information[j].key == 'clovaDirectivePayload-maxdigits-ReadDTMF'){
						keyInputCount = information[j].value;
						appendHtml += '<input class="answerAfterInput" style="width:30px;" type="text" id="subsequentText_'+ jdata.id +'" value="'+ keyInputCount +'" disabled="true"><span  style="margin-right:10px;">자리 입력 시 키패드 모드 종료</span>';
					}else if( information[j].key == 'clovaDirectivePayload-timeout-ReadDTMF'){
						keyTimeout = information[j].value;
						appendHtml += '<input class="answerAfterInput" type="text" id="subsequentText_'+ jdata.id +'" value="'+ (keyTimeout/1000) +'" disabled="true"><span  style="margin-right:10px;">초 동안 키패드 입력 대기</span>';
					}else if( information[j].key == 'clovaDirectivePayload-ttsIndex-ReadDTMF'){
						keybubble = information[j].value;
						appendHtml += '<input class="answerAfterInput" type="text" id="subsequentText_'+ jdata.id +'" value="'+ (Number(keybubble)+1) +'" disabled="true"><span>번째 말풍선부터 키패드 입력 가능</span>';
					}else if(information[j].key == 'clovaDirectiveHeader-name-SetTimeout'){
						afterActionWaitingVoice = 'selected';
						none = '';
					}else if( information[j].key == 'clovaDirectivePayload-timeout-SetTimeout'){
						timeOut = information[j].value;
						appendHtml += '<input class="answerAfterInput" type="text" id="subsequentText_'+ jdata.id +'" value="'+(timeOut/1000) +'" disabled="true"><span>초 동안 음성 입력 대기</span>';
					}else if(information[j].key == 'clovaShouldEndSession'){
						afterActionEnd = 'selected';
						none = '';
					}else if(information[j].key == 'clovaDirectiveHeader-name-TransferCall'){
						afterActionConnect = 'selected';
						none = '';
					}else if(information[j].key == 'clovaDirectivePayload-number-TransferCall'){
						callNumber = information[j].value;;
						appendHtml += '<input class="answerAfterInput" type="text" id="subsequentText_'+ jdata.id +'" value="' + callNumber +'" disabled="true">';;
					}
					
					if(information == null || information == undefined){
						none='selected';
					}
				}
				console.log(appendHtml);
				html += ' <li class="select">';
				html += ' 	<select id="selectSubsequentAction_'+ jdata.id +'" onchange="fnSelectSubsequentAction(0)" disabled="true" selected="selected">';
				html += ' 		<option value="대기" '+none+'>대기</option>';
				html += ' 		<option value="대기(음성)" '+afterActionWaitingVoice+'>대기(음성)</option>';
				html += ' 		<option value="대기(키패드)" '+afterActionWaitingKeyPad+'>대기(키패드)</option>';
				html += ' 		<option value="대화이동" '+afterActionMove+'>대화이동</option>';
				html += ' 		<option value="번호연결" '+afterActionConnect+'>번호연결</option>';
				html += ' 		<option value="통화종료" '+afterActionEnd+'>통화종료</option>';
				html += ' 	</select>';
				html += ' </li>';
				html += ' <li>'+appendHtml+'</li>';
			}
		}
		
		return html;
	}

	function makeAnswerTable(data) {
		$('#div_ansr_wrapper_id').empty();
		$('#answerCount').html(0);
		let html = "";
		if (data != undefined) {
			$('#answerCount').html(data.count);
			let arr = data.data;
			for (i = 0; i < arr.length; i++) {
				let chat = arr[i].chat;
				let chatStatusCode = arr[i].chatStatusCode;
				let chatUserVariables = arr[i].chatUserVariables;
				let chatTags = arr[i].chatTags;
				let id = arr[i].id;
				let chatType = arr[i].chatType;
				let answerType = arr[i].answerType;
				let subsequentAction = arr[i].subsequentAction
				
				let jdata = JSON.parse(chat);
				
				let component = jdata[0].component;
				let information = jdata[0].information;
				let desc = component.data.description;
				
				desc = desc.replace(/"/gi, '');
				
				let answerTypeResult = '';
				let radioChkY = '';
				let radioChkN = '';
				
				console.log('chatStatusCode : '+chatStatusCode);
				
				var infoArray = '';
				if(information){
					for(var n = 0 ; n < information.length ; n++ ){
						if(information[n].key == 'clovaDirectivePayload-submissionCode-CallDetailRecord'){
							console.log(information[n].value);
							var json = JSON.stringify(information[n].value);
							json = json.replace(/\\"/gi, '"');
							infoArray = json;
						}
						
					}
				}
				
				var jsonVari;
				var jArray = new Array();
				for(var j = 0 ; j < chatUserVariables.length ; j++ ){
					var str = '';
					var jobj = new Object();
					str += '{\"'+ chatUserVariables[j].name +'\"=\"'+ chatUserVariables[j].value +'\"}';
					str = JSON.stringify(str);
					jArray.push(JSON.parse(str));
				}
				
				var ifArray = new Array();
				for(var k = 0 ; k < chatTags.length ; k++){
					var str = '';
					var key = '';
					var val = '';
					var jobj = new Object();
					if(chatTags[k].key == 'timeRange'){
						key = '시간';
						val = chatTags[k].value.substring(0,4)+'~'+chatTags[k].value.substring(4,8);
						str += '{\"'+ key +'\"=\"'+ val +'\"}';
					}else if(chatTags[k].key == 'day'){
						key = '요일';
						val = chatTags[k].value;
						str += '{\"'+ key +'\"=\"'+ val +'\"}';
					}else if(chatTags[k].key == 'date'){
						key = '일자';
						val = chatTags[k].value;
						str += '{\"'+ key +'\"=\"'+ val +'\"}';
					}else if(chatTags[k].key == 'excludeTimeRange'){
						key = '시간';
						val = chatTags[k].value.substring(0,4)+'~'+chatTags[k].value.substring(4,8);
						str += '{\"'+ key +'\"!=\"'+ val +'\"}';
					}else if(chatTags[k].key == 'excludeDay'){
						key = '요일';
						val = chatTags[k].value;
						str += '{\"'+ key +'\"!=\"'+ val +'\"}';
					}else if(chatTags[k].key == 'excludeDate'){
						key = '일자';
						val = chatTags[k].value;
						str += '{\"'+ key +'\"!=\"'+ val +'\"}';
					}else if(chatTags[k].key == 'userVariable'){
						key = '노드';
						val = chatTags[k].value;
						let vals = val.split('␞=␞');
						if( val.indexOf('␞=␞') > -1 ){
							str += '{\"'+ vals[0] +'\"=\"'+ vals[1] +'\"}';
						}else{
							
						}
					}
					
					str = JSON.stringify(str);
					
					if( chatTags[k].key != 'platformExactMatch'){
						ifArray.push(JSON.parse(str));
					}
				}
				
				if(chatStatusCode == 'ENABLED'){
					radioChkY = 'checked';
				}else{
					radioChkN = 'checked';
				}
				
				if(chatType == 'TEXT'){
					chatTypeText = 'checked';
				}else if(chatType == 'AUDIO'){
					chatTypeAudio = 'checked';
				}else{
					ChatTypeNo = 'checked';
				}
				
				
				html += '<div class="wrap">';
				html += '	<div class="editGrup">';
				html += '		<div class="serve_onoff">';
				html += '			<span>서비스 여부</span>';
				html += '			<input type="radio" name="chatStatusCode_'+ arr[i].id +'" class="dsn_radoBtn" id="chatStatusCodeOn_'+ arr[i].id +'" onchange="fnChatStatusCode(1, 0)" value="on" '+radioChkY+' disabled>';
				html += '			<label for="chatStatusCodeOn_'+ arr[i].id +'">on</label>';
				html += '			<input type="radio" class="dsn_radoBtn" id="chatStatusCodeOff_'+ arr[i].id +'" name="chatStatusCode_'+ arr[i].id +'" onchange="fnChatStatusCode(2, 0)" value="off" '+radioChkN+' disabled>';
				html += '			<label for="chatStatusCodeOff_'+ arr[i].id +'">off</label>';
				html += '		</div>';
// 				html += '		<div class="edit_btn">';
// 				html += '			<button id="saveAnswerId_'+ arr[i].id +'" onclick="fnSaveAnswerBtn(0)">수정</button>';
// 				html += '			<button id="deleteAnswerId_'+ arr[i].id +'" onclick="fnDeleteAnswerBtn(0)">삭제</button>';
// 				html += '		</div>';
				html += '	</div>';
				html += '	<input type="checkbox" id="tab_'+ arr[i].id +'" name="tabs_'+ arr[i].id +'">';
				html += '	<input type="text" id="answerId_'+ arr[i].id +'">';
				html += '	<label class="label" for="tab_'+ arr[i].id +'">';
				html += '		<div>';
				html += '			<span class="answr_title" id="answerText_'+ arr[i].id +'">'+ desc +'</span>';
				html += '		</div>';
				html += '		<div class="cross">';
				html += '			<img alt="펼치기" src="/images/icon_arr_faq.png">';
				html += '		</div>';
				html += '	</label>';
				html += '	<div class="answr">';
				html += '		<div class="answr-wrap">';
				html += '			<div class="anwser-content">';
				html += '				<ul class="answer-ul">';
				html += '					<li>';
				html += '						<dl>';
				html += '							<dt>조건</dt>';
				html += '							<dd>';
				html += '								<textarea id="chatTagsString_'+ arr[i].id +'" row="5" value="" class="" readonly="">'+ ifArray +'</textarea>';
				html += '							</dd>';
				html += '						</dl>';
				html += '					</li>';
				html += '					<li>';
				html += '						<dl>';
				html += '							<dt>사용자변수</dt>';
				html += '							<dd>';
				html += '								<textarea id="chatUserVariablesString_'+ arr[i].id +'" row="5" value="" class="" readonly="">'+jArray+'</textarea>';
				html += '							</dd>';
				html += '						</dl>';
				html += '					</li>';
				html += '					<li>';
				html += '						<dl>';
				html += '							<dt>Information</dt>';
				html += '							<dd>';
				html += '								<textarea id="chatInformationsString_'+ arr[i].id +'" row="5" value="" class="" readonly="">'+ infoArray +'</textarea>';
				html += '							</dd>';
				html += '						</dl>';
				html += '					</li>';
				html += '					<li>';
				html += '						<dl>';
				html += '							<dt>';
				html += '								답변';
// 				html += '								<button class="icoBtn" id="chatAddBtn_'+ arr[i].id +'" onclick="fnChatAddBtn(0)" disabled="true">';
// 				html += '									<img alt="추가하기" src="/images/plus.png">';
// 				html += '								</button>';
				html += '							</dt>';
				html += '							<dd>';
				html += '								<div class="ansr_wrapper_chat" id="div_ansr_wrapper_chat_id_'+ arr[i].id +'">';
				html += '									<div class="answr_grup">';
				html += '										<ul>';
				html +=	answerList(chatType,jdata);	
				html += '										</ul>';
				html += '									</div>';
				html += '								</div>';
				html += '							</dd>';
				html += '						</dl>';
				html += '					</li>';
				html += '					<li>';
				html += '						<dl>';
				html += '							<dt>후속동작</dt>';
				html += '							<dd>';
				html += '								<ul>';
				html += afterAnswerList(subsequentAction,jdata);
				html += '								</ul>';
				html += '							</dd>';
				html += '						</dl>';
				html += '					</li>';
				html += '				</ul>';
				html += '			</div>';
				html += '		</div>';
				html += '	</div>';
				html += '</div>';
			}
			$('#answerArea').addClass('is-open');
			$('#answerArea').children('.sub_data_table').css('display','block');
		}else{
			$('#answerArea').removeClass('is-open');
			$('#answerArea').children('.sub_data_table').css('display','none');
		}
		$('#div_ansr_wrapper_id').html(html);

	}

	function setChatInfo(res) {
		let data = res.data;
		$('#domainId').val(data.domainId);
		$('#selectId').val(data.id);
		$('#selectName').val(data.name);
		$('#radioType' + data.type).prop('checked', true);
	}
	
	function makeInputContext(data){
		let html = '';
		let arr = data.data;
		if(arr.length > 0){
			$('#inputCount').html(arr.length);
			for(var i = 0 ; i < arr.length ; i++){
				html += '<tr data-id="'+ arr[i].id +'" data-uttId="'+ arr[i].chatUtterancesetId +'">';
				html += '	<td>';
				html += '		<input type="text" class="chat_txt" value="'+ arr[i].name +'" readonly="readonly">';
				html += '	</td>';
// 				html += '	<td>';
// 				html += '		<ul>';
// 				html += '			<li>';
// 				html += '				<span class="material-icons">create</span>';
// 				html += '			</li>';
// 				html += '		</ul>';
// 				html += '	</td>';
// 				html += '	<td>';
// 				html += '		<ul>';
// 				html += '			<li>';
// 				html += '				<span class="material-icons">delete</span>';
// 				html += '			</li>';
// 				html += '		</ul>';
// 				html += '	</td>';
				html += '</tr>';
			}
			$('#inputArea').addClass('is-open');
			$('#inputArea').children('.sub_data_table').css('display','block');
		}else{
			$('#inputCount').html(0);
			$('#inputArea').removeClass('is-open');
			$('#inputArea').children('.sub_data_table').css('display','none');
		}
		$('.tbody_input').html(html);
	}
	
	function makeOutputContext(data){
		let html = '';
		let arr = data.data;
		let addSel = '';
		let keepSel = '';
		let delDel = '';
		if(arr.length > 0){
			$('#outputCount').html(arr.length);
			for(var i = 0 ; i < arr.length ; i++){
				if(arr[i].function == "ADD"){
					addSel = 'selected';
				}else if(arr[i].function == "KEEP"){
					keepSel = 'selected';
				}else if(arr[i].function == "DELETE"){
					delDel = 'selected';
				}
				html += '<tr data-id="'+ arr[i].id +'" data-uttId="'+ arr[i].chatUtterancesetId +'">';
				html += '	<td>';
				html += '		<input type="text" class="chat_txt" value="'+ arr[i].name +'" readonly="readonly">';
				html += '	</td>';
				html += '	<td>';
				html += '		<select id="createOutputContextFunction" value="추가" disabled="disabled">';
				html += '			<option val="ADD" '+addSel+'>추가</option>';
				html += '			<option val="KEEP" '+keepSel+'>유지</option>';
				html += '			<option val="DELETE" '+delDel+'>삭제</option>';
				html += '		</select>';
				html += '	</td>';
				html += '	<td><input style="text-align: center;" type="text" class="chat_txt" value="'+ arr[i].limitCount +'" readonly="readonly"></td>';
				html += '	<td><input style="text-align: center;" type="text" class="chat_txt" value="'+ (arr[i].limitTime/60) +'" readonly="readonly"></td>';
// 				html += '	<td>';
// 				html += '		<ul>';
// 				html += '			<li>';
// 				html += '				<span class="material-icons">create</span>';
// 				html += '			</li>';
// 				html += '		</ul>';
// 				html += '	</td>';
// 				html += '	<td>';
// 				html += '		<ul>';
// 				html += '			<li>';
// 				html += '				<span class="material-icons">delete</span>';
// 				html += '			</li>';
// 				html += '		</ul>';
// 				html += '	</td>';
				html += '</tr>';
			}
			$('#outputArea').addClass('is-open');
			$('#outputArea').children('.sub_data_table').css('display','block');
		}else{
			$('#outputCount').html(0);
			$('#outputArea').removeClass('is-open');
			$('#outputArea').children('.sub_data_table').css('display','none');
		}
		$('.tbody_output').html(html);
		
	}
	
</script>
<style>
</style>
