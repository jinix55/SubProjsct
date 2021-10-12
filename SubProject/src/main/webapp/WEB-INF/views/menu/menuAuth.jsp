<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="/js/menu.js"></script>
<form name="menuForm" method="post">
<input type="hidden" name="chkBrowser" value="chkBrowser" />
<input type="hidden" name="tmp_CheckVal" />
<c:forEach var="menu" items="${menus}" varStatus="status">
    <input type="hidden" name="tmp_menuNmVal" value="${menu.menuId}|${menu.upMenuId}|${menu.menuNm}|${menu.menuUrl}|${menu.menuId}|${menu.upMenuId}|${menu.menuNm}|${menu.menuUrl}|${menu.menuDsc}|${menu.ordSeq}|${menu.menuSe}|${menu.menuAttr}|${menu.useYn}|${menu.lv}|${menu.fullPathId}|${menu.fullPathNm}|${menu.fullOrdSeq}|" />
</c:forEach>
<section class="content">
	<div class="content_tit">
	    <div><span class="content_h1">메뉴 권한 관리</span></div>
	    <ul class="content_nav">
	        <li>HOME</li>
	        <li>시스템 관리</li>
	        <li>메뉴 권한 관리</li>
	    </ul>
	</div>

	<div class="box_wrap">
    <input type="hidden" id="authId" name="authId">
      <div class="box_left70">
      <div class="nav_wrap">
      <form id="frm" name="frm" action="/admin/menuAuth" method="post">   	
           <div class="form-group box_select">
			<div class="form-inline">
				<div class="search-box">
				    <label class="font_ws"><span class="required"></span> 권한목록</label>
					<input type="text" class="text-input w30" name="authNm" placeholder="권한그룹목록을 입력하세요.">
					<span class="search-box-append">
						<button type="button" class="btn-search" onclick="roleSearch()"><img src="/images/icon_search.png" title="검색"></button>
					</span>
				</div>
			</div>
		</div>												
        </form>
  
        <div class="tb01_wrap">
          <table class="tb01 line ck" summary="권한ID, 권한명, 권한분류에 대한 내용입니다.">
            <caption class="hidden">권한 목록 이름 목록</caption>
            <colgroup>
              <col style="width:33.33%">
              <col style="width:33.33%">
              <col style="width:33.33%">
            </colgroup>
            <thead>
              <th scope="col">권한ID</th>
              <th scope="col">권한명</th>
              <th scope="col">권한분류</th>
            </thead>
            <tbody>
              <c:forEach var="role" items="${roles}">
		        <tr class="roleTable" style="cursor:pointer" name="roleTable" id="${role.authId}" onclick="menuAuthUser('${role.rownum}', '${role.authId}', '${role.authCl}', '${role.authNm}', '${role.authDsc}')">
		        	<td id="${role.authId }"><c:out value="${role.authId}"/></td>
		            <td id="${role.authNm}"><c:out value="${role.authNm}"/></td>
		            <td id="${role.authCl}">
		            	<c:if test="${role.authCl == 'U' }">참여자</c:if>
		            	<c:if test="${role.authCl == 'A' }">담당자</c:if>
		            	<c:if test="${role.authCl == 'D' }">임원</c:if>
		            	<input type="hidden" id="${role.authId}" value="${role.authId}">
		            </td>
		        </tr>
	        </c:forEach>
            </tbody>
          </table>
        </div> 
      </div>
      </div>
      
      <div class="box_right30">
      <div class="nav_tree_wrap">
       <!-- <div class="clearfix"><h2 class="fl"><span class="required"></span> 메뉴목록</h2></div> -->
        <div class="form-group box_select">
			<div class="form-inline">
				<div class="search-box">
					<input type="text" class="text-input w30" id="divAuthNm" readonly="readlony">
					<button type="button" id="saveMenu" class="btn big success">저장</button>
				</div>
			</div>
		</div>
        
      
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
      </div>
    </div>
    

 </div>
</section>
</form>
<script type="text/javascript">

    /* ********************************************************
     * 메뉴등록/수정 처리 함수
     ******************************************************** */
    function updateMenuList() {
        if(!fn_validatorMenuList()){return;}
        //if(document.menuForm.tmp_CheckVal.value != "U"){alert("상세조회시는 수정혹은 삭제만 가능합니다. 추가하신 후 등록하세요."); return;} //상세조회시는 수정혹은 삭제만 가능합니다. 초기화 하신 후 등록하세요.
        document.menuForm.action = "/admin/menu/insert";
        document.menuForm.submit();
    }

    /* ********************************************************
     * 메뉴삭제 처리 함수
     ******************************************************** */
    function deleteMenuList() {
        if(!fn_validatorMenuList()){return;}
        if(document.menuForm.tmp_CheckVal.value != "U"){alert("상세조회시는 수정혹은 삭제만 가능합니다."); return;} //상세조회시는 수정혹은 삭제만 가능합니다.
        document.menuForm.action = "/admin/menu/delete";
        document.menuForm.submit();
    }

    /* ********************************************************
     * 초기화 함수
     ******************************************************** */
    function initlMenuList() {
        document.menuForm.selectUpMenuId.value="";
        document.menuForm.selectMenuId.value="";
        document.menuForm.selectMenuNm.value="";
        document.menuForm.selectMenuUrl.value="";
        document.menuForm.selectMenuDsc.value="";
        document.menuForm.selectOrdSeq.value="";
        document.menuForm.selectMenuId.readOnly=false;
        document.menuForm.tmp_CheckVal.value = "";
    }

     function choiceNodes(nodeNum) {
         var nodeValues = treeNodes[nodeNum].split("|");
         $("#selectUpMenuId").val(nodeValues[5]);
         $("#selectMenuId").val(nodeValues[4]);
         $("#selectOrdSeq").val(nodeValues[9]);
         $("#selectMenuNm").val(nodeValues[6]);
         $("#selectMenuDsc").val(nodeValues[8]);
         $("#selectMenuUrl").val(nodeValues[7]);
         document.menuForm.tmp_CheckVal.value = "U";
     }

     function menuAuthUser(rownum, authId, authCl, authNm, authDsc){
         $("#rownum").val(rownum);
         $("#authId").val(authId);
         $('.roleTable').removeClass(' on');
         $('#'+authId).addClass(' on');
         var clValue = '';
         if(authCl == 'U'){
         	clValue = '참여자';
         }
         if(authCl == 'A'){
         	clValue = '담당자';
         }
         $("#clValue").val(clValue);
         $("#authCl").val(authCl);
         $("#authNm").val(authNm);
         $("#authDsc").val(authDsc);
         //$("#divAuthNm").text(authNm);
         $("#divAuthNm").val(authNm);

         $.ajax({
             type: "post",
             url: "/admin/menuAuth/" + $("#authId").val() + "/popup",
             dataType: "json",
             data: "",
             success: function (data) {
            	 console.log(data);
                 if(data.result){
					$.ui.fancytree.getTree("#tree").selectAll(false);
					//console.log("data : ", data.menuAuths);
					for(var i=0;i < data.menuAuths.length;i++){
						var item = data.menuAuths[i];
						if(item.useYn == "Y"){
							//console.log("useYn : ", item.useYn);
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
        var node = $.ui.fancytree.getTree("#tree");
     }

    /* ********************************************************
     * 입력값 validator 함수
     ******************************************************** */
    function fn_validatorMenuList() {

        //if(document.menuForm.menuId.value == ""){alert("메뉴번호는 Not Null 항목입니다"); return false;} //메뉴번호는 Not Null 항목입니다.
        //if(!checkNumber(document.menuForm.menuId.value)){alert("메뉴번호는 숫자만 입력 가능합니다."); return false;} //메뉴번호는 숫자만 입력 가능합니다.

        if(document.menuForm.selectOrdSeq.value == ""){alert("메뉴순서는 Not Null 항목입니다."); return false;} //메뉴순서는 Not Null 항목입니다.
        if(!checkNumber(document.menuForm.ordSeq.value)){alert("메뉴순서는 숫자만 입력 가능합니다."); return false;} //메뉴순서는 숫자만 입력 가능합니다.

        if(document.menuForm.selectUpMenuId.value == ""){alert("상위메뉴번호는 Not Null 항목입니다."); return false;} //상위메뉴번호는 Not Null 항목입니다.
        //if(!checkNumber(document.menuForm.upMenuId.value)){alert("상위메뉴번호는 숫자만 입력 가능합니다."); return false;} //상위메뉴번호는 숫자만 입력 가능합니다.

        if(document.menuForm.selectMenuUrl.value == ""){alert("메뉴URL은 Not Null 항목입니다."); return false;} //프로그램파일명은 Not Null 항목입니다.
        if(document.menuForm.selectMenuNm.value == ""){alert("메뉴명은 Not Null 항목입니다."); return false;} //메뉴명은 Not Null 항목입니다.

        return true;
    }

    /* ********************************************************
     * 필드값 Number 체크 함수
     ******************************************************** */
    function checkNumber(str) {
        var flag=true;
        if (str.length > 0) {
            for (i = 0; i < str.length; i++) {
                if (str.charAt(i) < '0' || str.charAt(i) > '9') {
                    flag=false;
                }
            }
        }
        return flag;
    }

    function roleSearch(){
		var frm = $("#frm");
		frm.submit();
	}
</script>
<script type="text/javascript">
    $(document).ready(function () {
        // 메뉴이동 화면 호출 함수
        $('#popupUpperMenuId').click(function (e) {
            e.preventDefault();
            var pagetitle = $(this).attr("title");
            var page = "/admin/menu/popup";
            var $dialog = $('<div style="overflow:hidden;padding: 0px 0px 0px 0px;"></div>')
                .html('<iframe style="border: 0px; " src="' + page + '" width="100%" height="100%"></iframe>')
                .dialog({
                    autoOpen: false,
                    modal: true,
                    width: 600,
                    height: 550,
                    title: pagetitle
                });
            $dialog.dialog('open');
        });
    });

    let treeJson = new Array();
    $("#saveMenu").click(function () {
        if($("#authId").val() == ""){
			alert("권한을 선택하세요.");
			return;
		}
        treeJson = new Array();
		var _tree = $.ui.fancytree.getTree("#tree"); 

		var rootnode = _tree.getRootNode().children[0];
		treeJson.push(JSON.parse('{ "menuId" : "'+rootnode.data.menuId+'", "checked" : "'+rootnode.partsel+'", "authId" : "'+$("#authId").val()+'" }'));
		if(rootnode.children != null){ 
			nodeLoop(rootnode.children);
		}
		
		$.ajax({
            type: "post",
            url: "/admin/menuAuth/update/" + $("#authId").val() + "/popup",
            dataType: "json",
            data: "treeJson="+JSON.stringify(treeJson),
            success: function (data) {
                if(data.result){
                    //console.log("메뉴 권한을 저장하였습니다.");
                    alert("메뉴 권한을 저장하였습니다.");
                    location.reload();
                }
            }
        });
        
//         let result = confirm("메뉴를 저장하시겠습니까?");
//         if(result) {
//             updateMenuList();
//         }

    });

	function nodeLoop(nodes){
		$.map(nodes, function(node){
			//console.log(node);
			//console.log(node.getLevel());
			treeJson.push(JSON.parse('{ "menuId" : "'+node.data.menuId+'", "checked" : "'+node.partsel+'", "authId" : "'+$("#authId").val()+'" }'));
			//node.setSelected(true);
			if(node.children != null){
				nodeLoop(node.children);
			}
		});
	}

	function nodeLoopCheck(nodes, menuId){
		$.map(nodes, function(node){
			//console.log(node);
			//console.log(node.getLevel());
			//console.log("node.data.menuId : " + node.data.menuId);
			//console.log("menuId : " + menuId);
			if(menuId == node.data.menuId && node.folder == false){
				node.setSelected(true);
			}			
			if(node.children != null){
				nodeLoopCheck(node.children, menuId);
			}
		});
	}

	//tree 전체 펼침
	function treeExpandAll(){
		$.ui.fancytree.getTree("#tree").expandAll();
	}

	function treeCollapseAll(){
		$.ui.fancytree.getTree("#tree").expandAll(false);
	}
</script>
<script type="text/javascript">
$(document).ready(function() {
	$('#chkAll').on("click", function(){
		$(".memberChk").prop("checked", $(this).prop("checked"));
	});
});




//조직도에서 조직선택시 소속 직원들 출력
function searchUserByTree(node) {
	$('#fancytreeKey').val(node.key);
	$('#menuId').val(node.data.menuId);
	$("#userPopupSearchForm").submit();
};	

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


</script>