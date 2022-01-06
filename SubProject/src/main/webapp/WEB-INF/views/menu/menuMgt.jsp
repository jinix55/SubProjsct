<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<script type="text/javascript">

	var treeNodes			= new Array();
	var openTreeNodes	    = new Array();
	var treeIcons			= new Array(6);
	var imgpath         = "/images/menu/";
	var treeYeobu       = false;
	
	/*
	* 트리생성함수
	*/
	function createTree(arrName, vYeobu) {
	    var startNode, openNode;
	    treeNodes = arrName;
	    treeYeobu = vYeobu;
	    var rootMemuId = getRootMenuId();
	    if (treeNodes.length > 0) {
	        preloadIcons();
	        if (startNode == null) {
	            startNode = rootMemuId;
	        }
	        if (openNode != 0 || openNode != null) {
	            setOpenTreeNodes(openNode);
	        }
	        if (startNode != rootMemuId) {
	            var nodeValues = treeNodes[getTreeArrayId(startNode)].split("|");
	            document.write("<a href='" + nodeValues[3] + "' onmouseover='window.status='" + nodeValues[3] + "';return true;' onmouseout='window.status=' ';return true;'><img src='"+imgpath+"menu_folderopen.gif' border='0' align='absbottom' alt=''>" + nodeValues[2] + "</a><br>");
	        } else {
	            document.write("<img src='"+imgpath+"menu_base.gif' border='0' align='absbottom' alt='' >root<br>");
	        }
	        var recursedNodes = new Array();
	        addTreeNode(startNode, recursedNodes);
	    }
	}
	
	/*
	* 최상위 메뉴 ID 확인
	*/
	function getRootMenuId() {
	    for (i=0; i<treeNodes.length; i++) {
	        var nodeValues = treeNodes[i].split("|");
	        if (nodeValues[13]==0) return nodeValues[0];
	    }
	    return 0;
	}
	
	/*
	 * 노드 , 트리 구성 이미지 정보
	 */
	function preloadIcons() {
	    treeIcons[0] = new Image();
	    treeIcons[0].src = imgpath+"menu_plus.gif";
	    treeIcons[1] = new Image();
	    treeIcons[1].src = imgpath+"menu_plusbottom.gif";
	    treeIcons[2] = new Image();
	    treeIcons[2].src = imgpath+"menu_minus.gif";
	    treeIcons[3] = new Image();
	    treeIcons[3].src = imgpath+"menu_minusbottom.gif";
	    treeIcons[4] = new Image();
	    treeIcons[4].src = imgpath+"menu_folder.gif";
	    treeIcons[5] = new Image();
	    treeIcons[5].src = imgpath+"menu_folderopen.gif";
	}
	
	/*
	* 트리 노드 열기
	*/
	function setOpenTreeNodes(openNode) {
	    for (i=0; i<treeNodes.length; i++) {
	        var nodeValues = treeNodes[i].split("|");
	        if (nodeValues[0]==openNode) {
	            openTreeNodes.push(nodeValues[0]);
	            setOpenTreeNodes(nodeValues[1]);
	        }
	    }
	}
	
	/*
	* 신규 트리노드 추가
	*/
	function addTreeNode(parentNode, recursedNodes) {
	    for (var i = 0; i < treeNodes.length; i++) {

	        var nodeValues = treeNodes[i].split("|");
	        if (nodeValues[1] == parentNode) {

	            var lastSibling	= lastTreeSibling(nodeValues[0], nodeValues[1]);
	            var hasChildNode	= hasChildTreeNode(nodeValues[0]);
	            var isNodeOpen = isTreeNodeOpen(nodeValues[0]);
	            for (g=0; g<recursedNodes.length; g++) {
	                if (recursedNodes[g] == 1) document.write("<img src='"+imgpath+"menu_line.gif' border='0' align='absbottom' alt='' >");
	                else  document.write("<img src='"+imgpath+"menu_empty.gif' border='0' align='absbottom' alt='' >");
	            }
	            if (lastSibling) {
	                recursedNodes.push(0);
	            } else {
	                recursedNodes.push(1);
	            }
	            if (hasChildNode) {
	                if (lastSibling) {
	                    document.write("<a href='javascript: openCloseEx(\"" + nodeValues[0] + "\", 1);'><img id='join" + nodeValues[0] + "' src='"+imgpath);
	                    if (isNodeOpen) document.write("menu_minus");
	                    else document.write("menu_plus");
	                    document.write("bottom.gif' border='0' align='absbottom' alt='Open/Close node' ></a>");
	                } else {
	                    document.write("<a href='javascript: openCloseEx(\"" + nodeValues[0] + "\", 0);'><img id='join" + nodeValues[0] + "' src='"+imgpath);
	                    if (isNodeOpen) document.write("menu_minus");
	                    else document.write("menu_plus");
	                    document.write(".gif' border='0' align='absbottom' alt='Open/Close node' /></a>");
	                }
	            } else {
	                if (lastSibling) document.write("<img src='"+imgpath+"menu_joinbottom.gif' border='0' align='absbottom' alt='' >");
	                else document.write("<img src='"+imgpath+"menu_join.gif' border='0' align='absbottom' alt='' >");
	            }
	            var classColor = '';
	            if(nodeValues[7] == 'N'){
	            		classColor = 'backColorRed';
	            }
	            document.write("<a id='ad"+nodeValues[0]+"' class='"+classColor+"' href=javascript:choiceNodes('" + i + "');>");
	            if (hasChildNode) {
	                document.write("<img id='icon" + nodeValues[0] + "' src='"+imgpath+"menu_folder")
	                if (isNodeOpen) document.write("open");
	                document.write(".gif' border='0' alt='Folder' >");
	            } else document.write("<img id='icon" + nodeValues[0] + "' src='"+imgpath+"menu_page.gif' border='0' align='absbottom' alt='Page'>");

	            document.write(nodeValues[2]);
	            document.write("</a><br>");
	            if (hasChildNode) {
	                document.write("<div id='div" + nodeValues[0] + "'");
	                if (!isNodeOpen) document.write(" style='display: none;'");
	                document.write(">");
	                addTreeNode(nodeValues[0], recursedNodes);
	                document.write("</div>");
	            }
	            recursedNodes.pop();
	        }
	    }
	}
	
	/*
	* 트리노드 최하위 여부 확인
	*/
	function lastTreeSibling (node, parentNode) {
	    var lastChild = 0;
	    for (i=0; i< treeNodes.length; i++) {
	        var nodeValues = treeNodes[i].split("|");
	        if (nodeValues[1] == parentNode)
	            lastChild = nodeValues[0];
	    }
	    if (lastChild==node) return true;
	    return false;
	}
	
	/*
	* 하위 트리노드 존재여부 확인
	*/
	function hasChildTreeNode(parentNode) {
	    for (i=0; i< treeNodes.length; i++) {
	        var nodeValues = treeNodes[i].split("|");
	        if (nodeValues[1] == parentNode) return true;
	    }
	    return false;
	}
	
	/*
	* 트리노드 오픈 여부 확인
	*/
	function isTreeNodeOpen(node) {
	    if (treeYeobu){ return true; }
	    for (i=0; i<openTreeNodes.length; i++){
	        if (openTreeNodes[i]==node){ return true; }
	    }
	    return false;
	}
	
	/*
	* 트리노드 액션(열기,닫기)
	*/
	function openCloseEx(node, bottom) {
	    var treeDiv = document.getElementById("div" + node);
	    var treeJoin	= document.getElementById("join" + node);
	    var treeIcon = document.getElementById("icon" + node);

	    if (treeDiv.style.display == 'none') {
	        if (bottom==1) treeJoin.src = treeIcons[3].src;
	        else treeJoin.src = treeIcons[2].src;
	        treeIcon.src = treeIcons[5].src;
	        treeDiv.style.display = '';
	    } else {
	        if (bottom==1) treeJoin.src = treeIcons[1].src;
	        else treeJoin.src = treeIcons[0].src;
	        treeIcon.src = treeIcons[4].src;
	        treeDiv.style.display = 'none';
	    }
	}
	if(!Array.prototype.push) {
	    function fnArrayPush() {
	        for(var i=0;i<arguments.length;i++)
	            this[this.length]=arguments[i];
	        return this.length;
	    }
	    Array.prototype.push = fnArrayPush;
	}
	if(!Array.prototype.pop) {
	    function fnArrayPop(){
	        lastElement = this[this.length-1];
	        this.length = Math.max(this.length-1,0);
	        return lastElement;
	    }
	    Array.prototype.pop = fnArrayPop;
	}
	
</script>

<form name="menuForm" method="POST">
<input type="hidden" name="chkBrowser" value="chkBrowser" />
<input type="hidden" name="tmp_CheckVal" />
<!-- menu.menuAttr Json 형태 못받음. -->
<c:forEach var="menu" items="${menus}" varStatus="status">
<c:set var="string1" value='${fn:replace(menu.menuAttr,\'\"\',\'`\')}' />
<c:set var="string2" value='${fn:replace(menu.fullPathId,\'\"\',\'`\')}' />
<c:set var="string3" value='${fn:replace(menu.fullPathNm,\'\"\',\'`\')}' />
<input type="hidden" name="tmp_menuNmVal" value="${menu.menuId}|${menu.upMenuId}|${menu.menuNm}|${menu.menuUrl}|${menu.menuDsc}|${menu.ordSeq}|${menu.menuSe}|${menu.useYn}|${string1}|${menu.lv}|${string2}|${string3}|${menu.fullOrdSeq}|${menu.iconNm}" />
</c:forEach>

<div class="content">
	<div class="row">
		<!-- S_left-area -->
		<div class="col-35-area pr16-area">
			<div class="left-area">
				<h4 class="tree_tab"><span>메뉴목록</span></h4>
				<div class="nav_tree">
				<script language="javascript" type="text/javaScript">
					var chk_Object = true;
					var chk_browse = "";
					if (eval(document.menuForm.chkBrowser)=="[object]") chk_browse = "IE";
					if (eval(document.menuForm.chkBrowser)=="[object NodeList]") chk_browse = "Fox";
					if (eval(document.menuForm.chkBrowser)=="[object Collection]") chk_browse = "safai";
					
					var Tree = new Array;
					if(chk_browse=="IE"&&eval(document.menuForm.tmp_menuNmVal)!="[object]"){
					    alert("메뉴 목록 데이타가 존재하지 않습니다."); //메뉴 목록 데이타가 존재하지 않습니다.
					    chk_Object = false;
					}
					if(chk_browse=="Fox"&&eval(document.menuForm.tmp_menuNmVal)!="[object NodeList]"){
					    alert("메뉴 목록 데이타가 존재하지 않습니다."); //메뉴 목록 데이타가 존재하지 않습니다.
					    chk_Object = false;
					}
					if(chk_browse=="safai"&&eval(document.menuForm.tmp_menuNmVal)!="[object Collection]"){
					    alert("메뉴 목록 데이타가 존재하지 않습니다."); //메뉴 목록 데이타가 존재하지 않습니다.
					    chk_Object = false;
					}
					if( chk_Object ){
					    for (var j = 0; j < document.menuForm.tmp_menuNmVal.length; j++) {
					        Tree[j] = document.menuForm.tmp_menuNmVal[j].value;
					    }
					    createTree(Tree, true);
					}else{
					    alert("메뉴가 존재하지 않습니다. 메뉴 등록 후 사용하세요."); //메뉴가 존재하지 않습니다. 메뉴 등록 후 사용하세요.
					}
				</script>
				</div>
<!-- 				<div class="menu-inner"> -->
<!-- 					<form action="javascript:void(0)"> -->
<!-- 						<ul id="tree-checkmenu" class="checktree"> -->
<!-- 							<li id="show-explorer"><input id="check-explorer" -->
<!-- 								type="checkbox" />Administrator <span id="count-explorer" -->
<!-- 								class="count"></span> -->
<!-- 								<ul id="tree-explorer"> -->
<!-- 									<li id="show-iewin"><input id="check-iewin" -->
<!-- 										type="checkbox" />프로젝트관리 <span id="count-iewin" class="count"></span> -->
<!-- 										<ul id="tree-iewin"> -->
<!-- 											<li><input type="checkbox" />프로젝트관리</li> -->
<!-- 											<li><input type="checkbox" />그룹등록</li> -->
<!-- 											<li><input type="checkbox" />사용자등록</li> -->
<!-- 										</ul></li> -->
<!-- 									<li id="show-iemac"><input id="check-iemac" -->
<!-- 										type="checkbox" />시스템관리 <span id="count-iemac" class="count"></span> -->
<!-- 										<ul id="tree-iemac"> -->
<!-- 											<li><input type="checkbox" />권한목록등록</li> -->
<!-- 											<li><input type="checkbox" />계정권한부여</li> -->
<!-- 											<li class="last"><input type="checkbox" />권한별메뉴적용</li> -->
<!-- 										</ul></li> -->
<!-- 									<li id="show-iemac2"><input id="check-iemac2" -->
<!-- 										type="checkbox" />메뉴관리 <span id="count-iemac2" class="count"></span> -->
<!-- 										<ul id="tree-iemac2"> -->
<!-- 											<li><input type="checkbox" />관리자메뉴관리</li> -->
<!-- 										</ul></li> -->
<!-- 									<li id="show-iemac3"><input id="check-iemac3" -->
<!-- 										type="checkbox" />로그관리 <span id="count-iemac3" class="count"></span> -->
<!-- 										<ul id="tree-iemac3"> -->
<!-- 											<li><input type="checkbox" />계정권한정보</li> -->
<!-- 											<li><input type="checkbox" />레포트</li> -->
<!-- 										</ul></li> -->
<!-- 								</ul></li> -->
<!-- 							<li id="show-netscape"><input id="check-netscape" -->
<!-- 								type="checkbox" />Data Visualization <span id="count-netscape" -->
<!-- 								class="count"></span> -->
<!-- 								<ul id="tree-netscape"> -->
<!-- 									<li id="show-iemac4"><input id="check-iemac4" -->
<!-- 										type="checkbox" />데이터분석 <span id="count-iemac4" class="count"></span> -->
<!-- 										<ul id="tree-iemac4"> -->
<!-- 											<li><input type="checkbox" />대여소 현황</li> -->
<!-- 											<li><input type="checkbox" />이용현황 분석</li> -->
<!-- 											<li><input type="checkbox" />회원 분석</li> -->
<!-- 											<li><input type="checkbox" />수요예측 모델 분석</li> -->
<!-- 										</ul></li> -->
<!-- 								</ul></li> -->
<!-- 							<li class="last"><input type="checkbox" />기타</li> -->
<!-- 						</ul> -->
<!-- 					</form> -->
<!-- 				</div> -->
			</div>
		</div>
		<!-- E_left-area -->
		<!-- S_right-area -->
		<div class="col-65-area">
			<div class="right-area">
			<!-- <h4 class="tab"><span>메뉴적용 현황</span></h4> -->
				<div class="row pt30">
					<div class="col-100">
						<input type="hidden" class="text-input" name="defaulttMenuUrl" id="defaulttMenuUrl" readonly disabled/>
						<div class="form-group">
							<label class="col-25 form-label">상위 메뉴ID</label>
							<div class="col-75">
								<div class="form-input">
									<input type="text" class="text-input" name="upMenuId" id="upMenuId" readonly style="width:100%;" disabled/>
<!-- 									<input type="text" class="text-input"> -->
								</div>
							</div>
						</div>
						<input type="hidden" class="text-input" name="menuId" id="menuId">
<!-- 						<div class="form-group mnIdView"> -->
<!-- 							<label class="col-25 form-label">메뉴ID</label> -->
<!-- 							<div class="col-75"> -->
<!-- 								<div class="form-input"> -->
<!-- 									<input type="text" class="text-input" name="menuId" id="menuId" readonly disabled> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
						<div class="form-group">
							<label class="col-25 form-label">메뉴명</label>
							<div class="col-75">
								<div class="form-input">
									<input type="text" class="text-input" name="menuNm" id="menuNm" readonly disabled>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label">메뉴순서</label>
							<div class="col-75">
<!-- 								<div class="form-input"> -->
<!-- 									<input type="text" class="text-input" name="ordSeq" id="ordSeq"> -->
<!-- 								</div> -->
								<select id="ordSeq" name="ordSeq" class="select-box" disabled>
								<option value="none" >선택</option>
								<c:forEach items="${menus}" var="menu">
									<option value="${menu.ordSeq}">${menu.ordSeq }</option>
								</c:forEach> 
							</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label">메뉴구분</label>
							<div class="col-75">
								<div class="form-input-box">
									<div class="button-Rsmall d-inblock">
										<input type="radio" id="radioA" name="menuSe" value="A" disabled>
										<label for="radioA" class="mr05">폴더(A)</label> 
									</div>
									<div class="button-Rsmall d-inblock">
										<input type="radio" id="radioM" name="menuSe" value="M" disabled>
										<label for="radioM" class="mr05">메뉴(M)</label> 
									</div>
									<div class="button-Rsmall d-inblock">
										<input type="radio" id="radioF" name="menuSe" value="F" disabled>
										<label for="radioF" class="mr05">기능(F)</label>
									</div>
									<div class="button-Rsmall d-inblock">
										<input type="radio" id="radioL" name="menuSe" value="L" disabled>
										<label for="radioL" class="mr05">레포트 링크(L)</label>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group folderImg">
							<label class="col-25 form-label">폴더 이미지</label>
							<div class="col-75">
								<div class="form-input">
									<input type="text" class="text-input" name="iconNm" id="iconNm" disabled>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label">메뉴URL</label>
							<div class="col-75">
								<div class="form-input">
									<input type="text" class="text-input" name="menuUrl" id="menuUrl" disabled>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label">메뉴속성</label>
							<div class="col-75">
								<input type="hidden" class="text-input" name="menuAttr" id="menuAttr" readonly>
								<div class="form-input-box">
									<div class="button-Rsmall d-inblock">
										<input type="checkbox" name="menuAttrIns" id="menuAttrIns" disabled>
										<label for="menuAttrIns" class="mr05 pt1">Insert</label>
									</div>
									<div class="button-Rsmall d-inblock">
										<input type="checkbox" name="menuAttrUpd" id="menuAttrUpd" disabled>
										<label for="menuAttrUpd" class="mr05 pt1">Update</label>
									</div>
									<div class="button-Rsmall d-inblock">
										<input type="checkbox" name="menuAttrDet" id="menuAttrDet" disabled>
										<label for="menuAttrDet" class="mr05 pt1">Detail</label>
									</div>
									<div class="button-Rsmall d-inblock">
										<input type="checkbox" name="menuAttrDel" id="menuAttrDel" disabled>
										<label for="menuAttrDel" class="mr05 pt1">Delete</label>
									</div>
								</div>
							</div>
						</div>

						<div class="form-group">
							<label class="col-25 form-label">메뉴사용여부</label>
							<div class="col-75">
								<div class="form-input-box">
									<div class="button-Rsmall d-inblock">
										<input type="radio" id="useY" name="useYn" value="Y" disabled>
										<label for="useY" class="mr05">사용(Y)</label>
										
									</div>
									<div class="button-Rsmall d-inblock">
										<input type="radio" id="useN" name="useYn" value="N" disabled>
										<label for="useN" class="mr05">미사용(N)</label> 
									</div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-25 form-label-textarea" style="height: 100px;">설명</label>
							<div class="col-75">
								<div class="form-input">
									<textarea cols="50" rows="10" class="textarea" style="height: 100px;" id="menuDsc" name="menuDsc" disabled></textarea>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="btn-group tr">
					<button type="button" class="button-small btn-success newMenu">신규</button>
					<button type="button" class="button-small btn-success saveMenu">저장</button>
					<button type="button" class="button-small btn-warning delMenu">삭제</button>
					<button type="button" class="button-small btn-cancel cancel">취소</button>
				</div>
			</div>
		</div>
	</div>
	<!-- E_right-area -->
</div>
</form>

<script type="text/javascript">

/* ********************************************************
 * 메뉴 등록 처리 함수
 ******************************************************** */
function insertMenuList() {
    if(!fn_validatorMenuList()){return;}
    //if(document.menuForm.tmp_CheckVal.value != "U"){alert("상세조회시는 수정혹은 삭제만 가능합니다. 추가하신 후 등록하세요."); return;} //상세조회시는 수정혹은 삭제만 가능합니다. 초기화 하신 후 등록하세요.
    document.menuForm.action = "/menu/menu/insert";
    document.menuForm.upMenuId.disabled=false;
    document.menuForm.menuUrl.disabled=false;
    allDisabled(false);
    btnCheck();
	if(isDisabled){
		return false;
	}else{
		isDisabled = true;
    	document.menuForm.submit();
	}
}

/* ********************************************************
 * 메뉴 수정 처리 함수
 ******************************************************** */
function updateMenuList() {
    if(!fn_validatorMenuList()){return;}
    //if(document.menuForm.tmp_CheckVal.value != "U"){alert("상세조회시는 수정혹은 삭제만 가능합니다. 추가하신 후 등록하세요."); return;} //상세조회시는 수정혹은 삭제만 가능합니다. 초기화 하신 후 등록하세요.
    document.menuForm.action = "/menu/menu/update";
    document.menuForm.upMenuId.disabled=false;
    btnCheck();
    document.menuForm.actionType = 'I';
   	allDisabled(false);
	if(isDisabled){
		return false;
	}else{
		isDisabled = true;
   		document.menuForm.submit();
	}
}

/* ********************************************************
 * 메뉴삭제 처리 함수
 ******************************************************** */
function deleteMenuList() {
    if(!fn_validatorMenuList()){return;}
    if(document.menuForm.tmp_CheckVal.value != "U"){alert("상세조회시는 수정혹은 삭제만 가능합니다."); return;} //상세조회시는 수정혹은 삭제만 가능합니다.
    if(confirm('삭제할 경우 복구할수 없습니다.\n진행하시겠습니까?')){
	    document.menuForm.menuId.disabled=false;
	    document.menuForm.menuId.readOnly=false;
	    document.menuForm.action = "/menu/menu/delete";
		if(isDisabled){
			return false;
		}else{
			isDisabled = true;
	    	document.menuForm.submit();
		}
    }
}

/* ********************************************************
 * 입력값 validator 함수
 ******************************************************** */
function fn_validatorMenuList() {
    if(document.menuForm.ordSeq.value == ""){alert("메뉴순서는 선택해 주세요."); return false;} //메뉴순서는 Not Null 항목입니다.
    if(document.menuForm.upMenuId.value == ""){alert("생성할 메뉴 위치를 선택해 주세요."); return false;} //상위메뉴번호는 Not Null 항목입니다.
    if(document.menuForm.menuUrl.value == ""){alert("메뉴URL을 입력해 주세요."); return false;} //프로그램파일명은 Not Null 항목입니다.
    if(document.menuForm.menuNm.value == ""){alert("메뉴명을 입력해 주세요."); return false;} //메뉴명은 Not Null 항목입니다.
    if(!document.menuForm.menuUrl.value.startsWith($('#defaulttMenuUrl').val())){alert('카테고리 범위에서 벗어날수 없습니다.\nURL을 확인해 주세요.'); return false;}
    return true;
}

function btnCheck(){
    document.menuForm.menuAttr.value = '{"attr": {"insert": '+$('#menuAttrIns').prop('checked')+', "update": '+$('#menuAttrUpd').prop('checked')+',  "detail": '+$('#menuAttrDet').prop('checked')+', "delete": '+$('#menuAttrDel').prop('checked')+'}}';
}

/* ********************************************************
 * 초기화 함수
 ******************************************************** */
function initlMenuList() {
	$('#ad'+document.menuForm.upMenuId.value).css('border','');
    document.menuForm.upMenuId.value="";
    document.menuForm.menuId.value="";
    document.menuForm.menuNm.value="";
    document.menuForm.menuUrl.value="";
    document.menuForm.menuDsc.value="";
    document.menuForm.ordSeq.value="";
    document.menuForm.tmp_CheckVal.value = "";
    document.menuForm.useYn.value="";
    document.menuForm.menuSe.value="";
    document.menuForm.menuAttr.value="";
    document.menuForm.menuUrl.readOnly=true;
    document.menuForm.menuUrl.disabled=true;
	$('select').attr('disabled',true);
	$('radio').attr('disabled',true);
	$('checkbox').attr('disabled',true);
	$('select').attr('readOnly',true);
	$('radio').attr('readOnly',true);
	$('checkbox').attr('readOnly',true);
	if(!$('.saveMenu').hasClass('modiMode') || $('.newMenu').hasClass('new')){
	    $('#ordSeq option:last').remove();
	}
	$('.saveMenu').text('저장');
	$('.saveMenu').removeClass('modiMode');
	$('.newMenu').removeClass('new');
    $('#ordSeq').val('none');
    $('.newMenu').show();
    $('.saveMenu').hide();
    $('.delMenu').hide();
    $('.cancel').hide();
}


/* ********************************************************
 * 신규 등록 함수
 ******************************************************** */
function newMenuList() {
	$('input').attr('disabled',false);
	$('textarea').attr('disabled',false);
	$('select').attr('disabled',false);
	
	$('input').attr('readOnly',false);
	$('textarea').attr('readOnly',false);
	$('select').attr('readOnly',false);
	$('#upMenuId').attr('disabled',true);
	$('#upMenuId').attr('placeholder','추가될 곳의 메뉴를 선택해 주세요.');
    document.menuForm.upMenuId.value="";
    document.menuForm.menuId.value="NEW";
    document.menuForm.menuNm.value="";
    document.menuForm.menuUrl.value="";
    document.menuForm.menuDsc.value="";
    document.menuForm.ordSeq.value="";
    document.menuForm.tmp_CheckVal.value = "";
    document.menuForm.useYn.value="Y";
    document.menuForm.menuSe.value="M";
    document.menuForm.menuAttr.value='{"attr": {"delete": true, "detail": true, "insert": true, "update": true}}';
    $('#menuAttrIns').prop('checked',true);
    $('#menuAttrUpd').prop('checked',true);
    $('#menuAttrDet').prop('checked',true);
    $('#menuAttrDel').prop('checked',true);
    document.menuForm.menuUrl.readOnly=false;
    document.menuForm.menuUrl.disabled=false;
    $('#ordSeq option:eq('+($('#ordSeq option').length-1)+')').after('<option value="'+$('#ordSeq option').length+'">'+$('#ordSeq option').length+'</option>');
    $('#ordSeq').val($('#ordSeq option').length-1);
    $('.mnIdView').hide();
    $('.newMenu').hide();
    $('.saveMenu').show();
    $('.cancel').show();
    $('.newMenu').addClass('new');
}

/* ********************************************************
 * 상세내역조회 함수
 ******************************************************** */
 
function allDisabled(isDisabled)  {
	if(isDisabled){
		for(var i = 0 ; i < document.getElementsByName('menuSe').length ; i++){
			document.getElementsByName('menuSe')[i].disabled = true;
		}
	}else{
		for(var i = 0 ; i < document.getElementsByName('menuSe').length ; i++){
			document.getElementsByName('menuSe')[i].disabled = false;
		}
	}
}

function choiceNodes(nodeNum) {
	var nodeValues = treeNodes[nodeNum].split("|");
	$('#ad'+document.menuForm.upMenuId.value).css('border','');
	if($('.newMenu').hasClass('new')){
		allDisabled(false);
		$('#upMenuId').attr('disabled',true);
		$('#radio'+nodeValues[6]).prop('checked',true);
		if(nodeValues[6] != 'A'){
			document.menuForm.upMenuId.value = nodeValues[1];	
		}else{
			document.menuForm.upMenuId.value = nodeValues[0];
		}
		if(nodeValues[1] == '' || nodeValues[1] == undefined ){
			document.menuForm.upMenuId.value = nodeValues[0];
		}
		
	    if(nodeValues[6] == 'L'){
	    	allDisabled(true);
	    	$('#radioL').prop('checked',true);
	    	$('#menuUrl').val('/report/reportView/');
	    }else{
	    	var sl = nodeValues[3].indexOf('/',1);
	    	if(sl == -1){
		    	$('#menuUrl').val(nodeValues[3]+'/');
		    	if(nodeValues[3].startsWith('/report')){
		    		allDisabled(true);
		    		$('#radioL').prop('checked',true);
		    		$('#menuUrl').val('/report/reportView/');
		    	}
		    	if(nodeValues[1] == '' || nodeValues[1] == undefined){
		    		$('#menuUrl').val(nodeValues[3]);
		    	}
	    	}else{
		    	var str = nodeValues[3].substring(0,sl);
		    	$('#menuUrl').val(str+'/');
		    	if(str == '/report'){
		    		allDisabled(true);
		    		$('#radioL').prop('checked',true);
		    		$('#menuUrl').val('/report/reportView/');
		    	}else{
		    		$('#menuUrl').val(str);
		    	}
	    	}
	    }
	    
	    $('#defaulttMenuUrl').val($('#menuUrl').val());
		$('#ad'+document.menuForm.upMenuId.value).css('border','dashed red');
		
	}else{
		$('input').attr('disabled',true);
		$('textarea').attr('disabled',true);
		$('select').attr('disabled',true);
		$('radio').attr('disabled',true);
		$('checkbox').attr('disabled',true);
		
		$('input').attr('readOnly',true);
		$('textarea').attr('readOnly',true);
		$('select').attr('readOnly',true);
		$('radio').attr('readOnly',true);
		$('checkbox').attr('readOnly',true);
	    document.menuForm.upMenuId.value = nodeValues[1];
	    document.menuForm.menuId.value = nodeValues[0];
	    document.menuForm.ordSeq.value = nodeValues[5];
	    document.menuForm.menuNm.value = nodeValues[2];
	    document.menuForm.menuDsc.value = nodeValues[4];
	    document.menuForm.menuUrl.value = nodeValues[3];
	    document.menuForm.iconNm.value = nodeValues[13];
	//     document.menuForm.useYn.value = nodeValues[7];
	//     document.menuForm.menuSe.value = nodeValues[6];
	    $('#use'+nodeValues[7]).prop('checked',true);
	    $('#radio'+nodeValues[6]).prop('checked',true);
	    document.menuForm.menuAttr.value = nodeValues[8].replace(/`/gi,'"');
	    var attrPerson = JSON.parse(document.menuForm.menuAttr.value);
	    $('#menuAttrIns').prop('checked',attrPerson.attr.insert);
	    $('#menuAttrUpd').prop('checked',attrPerson.attr.update);
	    $('#menuAttrDet').prop('checked',attrPerson.attr.detail);
	    $('#menuAttrDel').prop('checked',attrPerson.attr.delete);
	    document.menuForm.ordSeq.disabled=true;
	    document.menuForm.menuUrl.readOnly=true;
	    document.menuForm.menuUrl.disabled=true;
	    
	    document.menuForm.tmp_CheckVal.value = "U";
	    $('.newMenu').hide();
	    $('.saveMenu').text('수정');
	    $('.saveMenu').addClass('modiMode');
	    $('.saveMenu').show();
	    $('.delMenu').show();
	    $('.cancel').show();
	}
}

/*메뉴 수정
 * 모든 인풋태그 에이블 처리
 */
function modiModeMenu(){
	$('input').attr('disabled',false);
	$('textarea').attr('disabled',false);
	$('select').attr('disabled',false);
	$('radio').attr('disabled',false);
	$('checkbox').attr('disabled',false);
	
	$('input').attr('readOnly',false);
	$('textarea').attr('readOnly',false);
	$('select').attr('readOnly',false);
	$('radio').attr('readOnly',false);
	$('checkbox').attr('readOnly',false);
	
    document.menuForm.upMenuId.disabled=true;
    
    $('.saveMenu').text('저장');
    $('.saveMenu').removeClass('modiMode');
    $('.cancel').show();
}



$(document).ready(function () {
	$('.saveMenu').hide();
	$('.delMenu').hide();
	$('.cancel').hide();
	
	$('.newMenu').click(function(){
		newMenuList();
	});
	
	$('.saveMenu').click(function(){
		if($('.saveMenu').hasClass('modiMode')){
			modiModeMenu();
		}else{
			if($('.newMenu').hasClass('new')){
				insertMenuList();
			}else{
				updateMenuList();
			}
		}
	});
	
	$('.cancel').click(function(){
		initlMenuList();
	});
	
	$('.delMenu').click(function(){
		deleteMenuList();
	});
	
	$('#radioL').click(function(){
		$('#menuUrl').val('/report/reportView/');
	});
	
	$('#radioF, #radioM, #radioA').click(function(){
		$('#menuUrl').val($('#defaulttMenuUrl').val());
	});
});
</script>