<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:forEach var="menu" items="${menus}" varStatus="status">
    <input type="hidden" name="tmp_menuNmVal" value="${menu.menuId}|${menu.upMenuId}|${menu.menuNm}|${menu.menuUrl}|${menu.menuId}|${menu.upMenuId}|${menu.menuNm}|${menu.menuUrl}|${menu.menuDsc}|${menu.ordSeq}|${menu.menuSe}|${menu.menuAttr}|${menu.useYn}|${menu.lv}|${menu.fullPathId}|${menu.fullPathNm}|${menu.fullOrdSeq}|" />
</c:forEach>
<div class="content">
	<!-- S_검색-->
	<form id="searchFrm" action="/role/role" method="POST">
		<input type="hidden" id="page" name="page" value="${pages.page}">
		<div class="justify-content-between">
			<div class="form-group">
				<div class="form-inline">
					<select class="select-box w150" id="searchKey" name ="searchKey">
						<option value="authId">사용자 ID</option>
						<option value="authNm">사용자 명</option>
					</select>
				</div>
				<div class="form-inline">
					<div class="search-box w250">
						<input id="searchValue" name="searchValue" value="${pages.searchValue }" type="text" class="text-input"> <span
							class="search-box-append">
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
					<col style="width: 5%;">
					<col style="width: 6%;">
					<col style="width: 12%;">
					<col style="width: 15%;">
					<col style="width: *%;">
					<col style="width: 14%;">
					<col style="width: 8%;">
					<col style="width: 8%;">
					<col style="width: 8%;">
				</colgroup>
				<thead>
					<tr class="th-bg">
						<th>
<!-- 							<input type="checkbox" name="all" id="checkAll"> -->
						</th>
						<th scope="col">번호</th>
						<th scope="col">사용자 ID</th>
						<th scope="col">사용자 이름</th>
						<th scope="col">그룹 ID</th>
						<th scope="col">등록일</th>
						<th scope="col">사용유무</th>
						<th scope="col">메뉴생성</th>
						<th scope="col">관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="role" items="${roles}" varStatus="status">
						<tr>
							<th><input type="checkbox" name="chk"></th>
							<td>${pages.totalCount - (status.index + (pages.page -1) * pages.pageSize)}</td>
							<td class="text-point">${role.authId}</td>
							<td>${role.authNm}</td>
							<td>${role.authNm}</td>
							<td><spring:eval expression="role.rgstDt" /></td>
							<td>
							<c:choose>
								<c:when test="${role.useYn eq 'Y' }">
									<button type="button" class="btn-yes">YES</button>
								</c:when>
								<c:otherwise>
									<button type="button" class="btn-no">NO</button>
								</c:otherwise>
							</c:choose>
							</td>
							<td>
								<div class="btn-group">
									<a href="" onclick="sidebar_open('${role.authId}')" role="button" data-toggle="modal" class="btn-tbl_icon menuAuthOpen">
										<img src="/images/icon_genemenu.png" title="메뉴생성" class="tbl-icon">
									</a>
								</div>
							</td>
							<td>
								<div class="btn-group">
									<a href="#register" onclick="detailView('${role.authId}');" role="button" data-toggle="modal" class="btn-tbl_icon">
										<img src="/images/icon_edit.png" alt="수정하기" class="tbl-icon2">
									</a>
									<a href="#delete" onclick="deleteSet('${role.authId}');" role="button" data-toggle="modal" class="btn-tbl_icon">
										<img src="/images/icon_delete2.png" alt="삭제하기" class="tbl-icon2">
									</a>
								</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<!-- E_그리드-->
	<div class="btn-group pt15 tr">
		<button type="button" class="button btn-success" id="registView" href="#register"
			data-toggle="modal">
			등록
			<!-- 			<a href="#register" data-toggle="modal">등록</a> -->
		</button>
	</div>
	<!-- S_페이징-->
	<div class="board-paging">
	</div>
	<!-- E_페이징-->
</div>

<section class="menu-chat sidebar-animate" id="Sidebar">
	<div class="modal-header">
		<h4 class="modal-title">권한별 메뉴 변경</h4>
		<a href="javascript:layerPopupClose(sidebar_close);"><img
			src="/images/icon_close.png"></a>
	</div>
	<div class="modal-body">
		<!-- 버튼 -->
		<div class="modal-title">ROLE_SITE_ADMIN</div>
		<div class="btn-group line-item">
			<button type="button" class="button-small btn-success">초기화</button>
			<button type="button" class="button-small btn-warning">적용</button>
			<button type="button" class="button-small btn-cancel"
				onclick="sidebar_close()">취소</button>
		</div>
		<form action="javascript:void(0)">
			<div class="nav_tree">      
				<div>
					<span id="tree">
					</span>
					<span id="fancytreeKey" style="display:none;">
					
					</span>
					<span id="fancytreeRootKey" style="display:none;">
					
					</span>
				</div>
			</div>
<!-- 			<ul id="tree-checkmenu" class="checktree"> -->
<!-- 				<li id="show-explorer"> -->
<!-- 					<input id="check-explorer" type="checkbox" /> Administrator <span id="count-explorer" class="count"></span> -->
<!-- 					<ul id="tree-explorer"> -->
<!-- 						<li id="show-iewin">
								<input id="check-iewin" type="checkbox" />프로젝트관리 -->
<!-- 							<span id="count-iewin" class="count"></span> -->
<!-- 							<ul id="tree-iewin"> -->
<!-- 								<li><input type="checkbox" />프로젝트관리</li> -->
<!-- 								<li><input type="checkbox" />그룹등록</li> -->
<!-- 								<li><input type="checkbox" />사용자등록</li> -->
<!-- 							</ul></li> -->
<!-- 						<li id="show-iemac"><input id="check-iemac" type="checkbox" />시스템관리 -->
<!-- 							<span id="count-iemac" class="count"></span> -->
<!-- 							<ul id="tree-iemac"> -->
<!-- 								<li><input type="checkbox" />권한목록등록</li> -->
<!-- 								<li><input type="checkbox" />계정권한부여</li> -->
<!-- 								<li class="last"><input type="checkbox" />권한별메뉴적용</li> -->
<!-- 							</ul></li> -->
<!-- 						<li id="show-iemac2"><input id="check-iemac2" type="checkbox" />메뉴관리 -->
<!-- 							<span id="count-iemac2" class="count"></span> -->
<!-- 							<ul id="tree-iemac2"> -->
<!-- 								<li><input type="checkbox" />관리자메뉴관리</li> -->
<!-- 							</ul></li> -->
<!-- 						<li id="show-iemac3"><input id="check-iemac3" type="checkbox" />로그관리 -->
<!-- 							<span id="count-iemac3" class="count"></span> -->
<!-- 							<ul id="tree-iemac3"> -->
<!-- 								<li><input type="checkbox" />계정권한정보</li> -->
<!-- 								<li><input type="checkbox" />레포트</li> -->
<!-- 							</ul></li> -->
<!-- 					</ul> -->
<!-- 				</li> -->
<!-- 				<li id="show-netscape"><input id="check-netscape" -->
<!-- 					type="checkbox" />Data Visualization <span id="count-netscape" -->
<!-- 					class="count"></span> -->
<!-- 					<ul id="tree-netscape"> -->
<!-- 						<li id="show-iemac4"><input id="check-iemac4" type="checkbox" />데이터분석 -->
<!-- 							<span id="count-iemac4" class="count"></span> -->
<!-- 							<ul id="tree-iemac4"> -->
<!-- 								<li><input type="checkbox" />대여소 현황</li> -->
<!-- 								<li><input type="checkbox" />이용현황 분석</li> -->
<!-- 								<li><input type="checkbox" />회원 분석</li> -->
<!-- 								<li><input type="checkbox" />수요예측 모델 분석</li> -->
<!-- 							</ul></li> -->
<!-- 					</ul> -->
<!-- 				</li> -->
<!-- 				<li class="last"><input type="checkbox" />기타</li> -->
<!-- 			</ul> -->
		</form>
	</div>
</section>

<!-- 레이어 팝업 - 등록  -->
<form id="frm">
<div id="register" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-content" style="width: 800px">
		<div class="modal-header">
			<h4 class="modal-title">수정</h4>
			<button type="button" class="close" data-dismiss="modal">
				<img src="/images/icon_close.png">
			</button>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">등록일</label>
						<div class="col-75">
							<div class="form-input">
								<input id="rgstDt" name="rgstDt" type="text" class="text-input">
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">수정일</label>
						<div class="col-75">
							<div class="form-input">
								<input id="modiDt" name="modiDt" type="text" class="text-input">
							</div>
						</div>
					</div>
				</div>
				<div class="col-50 grpIdDiv">
					<div class="form-group">
						<label class="col-25 form-label">그룹 ID</label>
						<div class="col-75">
							<div class="form-input">
								<input id="authId" name="authId" type="text" class="text-input">
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">회사명</label>
						<div class="col-75">
							<select id="companyCode" name="companyCode" class="select-box">
								<option value="none">선택안함</option>
								<c:forEach items="${companys }" var="company">
									<option value="${company.companyCode}">${company.companyNm }</option>
								</c:forEach> 
							</select>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">그룹분류</label>
						<div class="col-75">
							<select id="authCl" name="authCl" class="select-box">
								<option value="none">선택안함</option>
								<option value="A">시스템 관리자</option>
								<option value="P">관리자</option>
								<option value="U">참여자</option>
							</select>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">그룹명</label>
						<div class="col-75">
							<div class="form-input">
								<input id="authNm" name="authNm" type="text" class="text-input">
							</div>
						</div>
					</div>
				</div>
				<div class="col-50">
					<div class="form-group">
						<label class="col-25 form-label">사용여부</label>
						<div class="col-75">
							<div class="form-input-box">
								<div class="btn-sm di-inblock">
									<input id="useY" name="useYn" type="radio" value="Y">
									<label for="useY" class="mr05">사용</label>
								</div>
								<div class="btn-sm di-inblock">
									<input id="useN" name="useYn" type="radio" value="N">
									<label for="useN" class="mr05">미사용</label>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-100">
					<div class="form-group">
						<label class="col-25 form-label-textarea">그룹 설명</label>
						<div class="col-75">
							<div class="form-input">
								<textarea id="authDsc" name="authDsc" class="textarea"></textarea>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 버튼 -->
		<div class="modal-footer btn-group">
			<button id="regBtn" type="button" class="button btn-success insert" >저장</button>
			<button type="button" class="button btn-cancel cancle" data-dismiss="modal">취소</button>
<!-- 			<button type="button" class="button btn-success" data-dismiss="modal">확인</button> -->
		</div>
	</div>
</div>
</form>

<!-- 레이어 팝업 - delete -->
<form action="/role/role/delete" method="POST">
<div id="delete" class="modal" data-backdrop-limit="1" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
	data-modal-parent="#myModal">
	<!-- Modal content-->
	<input type="hidden" id="del_authId" name="del_authId">
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
							<em class="text-bold delName">PEuser01</em> 삭제하시겠습니까?
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="modal-footer btn-group">
			<button type="button" class="button btn-warning delete" data-dismiss="modal">삭제</button>
			<button type="button" class="button btn-cancel" data-dismiss="modal">취소</button>
		</div>
	</div>
</div>
</form>
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
							<em class="text-bold">14 items selected</em><br />삭제하시겠습니까?
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

<script>

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
	    $("#searchFrm").submit();
	});
	
	function sidebar_open(authId) {
		document.getElementById("Sidebar").style.display = "block";
		selectMenuAuth(authId);
	}

	function sidebar_close() {
		document.getElementById("Sidebar").style.display = "none";
	}
	
	function deleteSet(authId){
		$('#del_authId').val(authId);
		$('.delName').text(authId);
	}
	
	function detailView(id){
		resetView();
		$('#rgstDt').attr('disabled',true);
		$('#rgstDt').parents('.col-50').show();
		$('#modiDt').attr('disabled',true);
		$('#modiDt').parents('.col-50').show();
		$('#register input').attr('disabled',true);
		$('#register textarea').attr('disabled',true);
		$('.grpIdDiv').show();
		
		$.ajax({
			url : '/system/role/detail/'+id,
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
	
	function setView(data){
		var companyCd = 'none';
		var authCl = 'none';
		if(data.companyCode){
			companyCd = data.companyCode;
		}
		if(data.authCl){
			authCl = data.authCl;
		}
		$('#authCl').val(authCl);
		$('#authId').val(data.authId);
		$('#authNm').val(data.authNm);
		$('#authDsc').val(data.authDsc);
		$('#companyCode').val(companyCd);
		$('#use'+data.useYn).prop('checked',true);
		$('#rgstDt').val(data.rgstDt);
		$('#modiDt').val(data.modiDt);
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
	
	function resetInput(){
		$('#register input').attr('disabled',false);
		$('#register select').attr('disabled',false);
		$('#register textarea').attr('disabled',false);
		$('.search-box-append').show();
		$('#register input').val('');
		$('#lockY').val('Y');
		$('#lockN').val('N');
		$('#dtLimitY').val('Y');
		$('#dtLimitN').val('N');
		$('#useY').val('Y');
		$('#useN').val('N');
		$('#companyCode').val('none');
		$('#authCl').val('none');
		$('#lockN').prop('checked',true);
		$('#dtLimitY').prop('checked',true);
		$('#useY').prop('checked',true);
		$('#regBtn').removeClass('edit');
		$('#regBtn').removeClass('save');
		$('#regBtn').addClass('insert');
	}
	
	function resetView(){
		$('.search-box-append').hide();
		$('#rgstDt').attr('disabled',true);
		$('#rgstDt').parents('.col-50').show();
		$('#modiDt').attr('disabled',true);
		$('#modiDt').parents('.col-50').show();
		$('#register .modal-title').text('상세');
		$('#register input').attr('disabled',true);
		$('#register select').attr('disabled',true);
		$('#regBtn').removeClass('insert');
		$('#regBtn').addClass('edit');
		$('#regBtn').text('수정');
	}
	
	
	
	function setEdit(){
		$('#register input').attr('disabled',false);
		$('#register select').attr('disabled',false);
		$('#register textarea').attr('disabled',false);
		$('#authNm').attr('disabled',false);
		$('#authCl').attr('disabled',false);
		$('#authDsc').attr('disabled',false);
		$('#authId').attr('disabled',true);
		$('#rgstDt').attr('disabled',true);
		$('#modiDt').attr('disabled',true);
		$('#regBtn').text('저장');
		$('#regBtn').removeClass('edit');
		$('#regBtn').addClass('save');
	}
	
	function authInsert(){
		var param =  $('#frm').serialize();
		insertAjax(param,'insert');
	}
	
	function authUpdate(){
		var param =  $('#frm').serialize();
		insertAjax(param,'update');
	}
	
	function insertAjax(param,action){
		$.ajax({
		    type : 'post',
		    url : '/system/role/'+action,
		    data : param,
		    dataType : 'text',
		    error: function(xhr, status, error){
		        console.log(error);
		    },
		    success : function(result){
		    	if(result == 'Update' || result == 'Insert'){
		    		location.href = '/system/role';
		    	}
		    }
		});
	}
	
	function deleteAjax(param,action){
		param = {
				authId : $('#del_authId').val()
		}
		$.ajax({
		    type : 'post',
		    url : '/system/role/delete',
		    data : param,
		    dataType : 'text',
		    error: function(xhr, status, error){
		        console.log(error);
		    },
		    success : function(result){
		    	console.log(result);
		    	if(result == 'Delete'){
		    		location.href = '/system/role';
		    	}
		    }
		});
	}
	
	function setNumber(objValue){
		str = objValue.replace(/[^0-9]/gi,"").toUpperCase();
	    return str;
	}
	
	
	function selectMenuAuth(authId){
		$.ajax({
		    type : 'post',
		    url : '/system/role/'+authId+'/popup',
		    dataType : 'json',
		    error: function(xhr, status, error){
		        console.log(error);
		    },
		    success : function(data){
		    	if(data.result){
					$.ui.fancytree.getTree("#tree").selectAll(false);
					for(var i=0;i < data.menuAuths.length;i++){
						var item = data.menuAuths[i];
						if(item.useYn == "Y"){
							var _tree = $.ui.fancytree.getTree("#tree"); 

							var rootnode = _tree.getRootNode().children[0]; 
							if(rootnode.children != null){
								nodeLoopCheck(rootnode.children, item.menuId);
							}
						}
					}
                 }
		    }
		});
	}
	
	function nodeLoop(nodes){
		$.map(nodes, function(node){
			treeJson.push(JSON.parse('{ "menuId" : "'+node.data.menuId+'", "checked" : "'+node.partsel+'", "authId" : "'+$("#authId").val()+'" }'));
			if(node.children != null){
				nodeLoop(node.children);
			}
		});
	}
	
	function nodeLoopCheck(nodes, menuId){
		$.map(nodes, function(node){
			if(menuId == node.data.menuId && node.folder == false){
				node.setSelected(true);
			}			
			if(node.children != null){
				nodeLoopCheck(node.children, menuId);
			}
		});
	}
	
	let tree = [];
	$(function() {
		<c:forEach var='menus' items='${menus }'>
			createTree(${menus.fullPathId}, ${menus.fullPathNm});
		</c:forEach>


		/**
		*	노드 생성 함수
		*/		
		function createTree(fullPathId, fullPathNm) {
			tree.push({title: fullPathNm[fullPathNm.length - 1], checkbox:true, selected : true, expanded: true, children: [], data: { menuId: fullPathId[fullPathId.length - 1], upMenuId: fullPathId[fullPathId.length - 2]}});
		}

		/**
		*	트리 구성 함수
		*/
		function setTree(nodes) {
			for (let index = nodes.length - 1; index > -1; index--) {
				const parent = nodes.find(n => n.data.menuId == nodes[index].data.upMenuId);
				if (parent) parent.children.unshift(nodes.pop(index));
			}
		};

		/**
		*	트리 이미지 변경 함수
		*/
		function checkNodesForChildren(nodes) {
			$.each(nodes, function(index, node) {
				if (node.children && node.children.length > 0) {
					node.folder = true;
					checkNodesForChildren(node.children);
				} else {
					node.folder = false;
				}
			});
		}

		$(document).ready(function() {
			$('#tree').fancytree({
				checkbox: true,
				selectMode: 3,
				source: tree,
				init: function(e, d){
					d.tree.visit(function(n){
						n.key = n.data.menuId;
						n.expanded = true;
					});
				},
				loadChildren : function(e, d){
					d.node.fixSelection3AfterClick();

				},
				laztLoad : function(e, d){
					d.result = tree;
				},
				activate: function(e, d) {
					var selKeys = $.map(d.tree.getSelectedNodes(), function(node){
						return node.key;
					});
					$("#fancytreeKey").text(selKeys.join(", "));

					var selRootNodes = d.tree.getSelectedNodes(true);
					var selRootKeys = $.map(selRootNodes, function(node){
						return node.key;
					});
				},
				select: function(e, d){
					var selKeys = $.map(d.tree.getSelectedNodes(), function(node){
						//console.log(node.parent);
						//console.log(node.data);
						//console.log(node);
						//console.log(node.getLevel());
						var parents = "";
						for(var i =0;i < node.getLevel()-1;i++){
							//parents += ".parent";
							//console.log(node+parents+".menuId");
							//console.log("menuId : ",node.parent.data.menuId);
						}
						return node.key;
					});
					//$("#fancytreeKey").text(selKeys.join(","));
				},
	 			postProcess: function(e, d) { setTree(d.response); checkNodesForChildren(d.response); }
			});

			$('#pageSize').val('${pages.pageSize}');
			$('#searchKey').val('${pages.searchKey}');
			$('#searchValue').val('${pages.searchValue}');
		});
	});
	
	
	$(document).ready(function() {
		$('#registView').click(function(){
			resetInput();
			$('#register .modal-title').text('등록');
			$('#register .insert').text('저장');
			$('#register .textarea').val('');
			
			$('.grpIdDiv').hide();
			$('#rgstDt').attr('disabled',true);
			$('#rgstDt').parents('.col-50').hide();
			$('#modiDt').attr('disabled',true);
			$('#modiDt').parents('.col-50').hide();
		});
		
		
		$('.close, .cancle').click(function(){
			resetInput();
		});
		
		$('#regBtn').click(function(){
			if($('#regBtn').hasClass('insert')){
				authInsert();
			}
			if($('#regBtn').hasClass('save')){
				authUpdate();
			}
			if($('#regBtn').hasClass('edit')){
				setEdit();
			}
		});
		
		$('.delete').click(function(){
			deleteAjax();
		});
		
		$('.search-box-append').click(function(){
			$('#searchFrm').submit();
		});
	});
</script>