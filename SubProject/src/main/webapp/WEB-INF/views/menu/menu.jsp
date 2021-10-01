<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<script type="text/javascript" src="/js/menu.js"></script>

<form name="menuForm" method="POST">
<input type="hidden" name="chkBrowser" value="chkBrowser" />
<input type="hidden" name="tmp_CheckVal" />
 <!-- menu.menuAttr Json 형태 못받음. -->
<c:forEach var="menu" items="${menus}" varStatus="status">
<c:set var = "string1" value='${fn:replace(menu.menuAttr,\'\"\',\'`\')}' />
<c:set var = "string2" value='${fn:replace(menu.fullPathId,\'\"\',\'`\')}' />
<c:set var = "string3" value='${fn:replace(menu.fullPathNm,\'\"\',\'`\')}' />
<input type="hidden" name="tmp_menuNmVal" value="${menu.menuId}|${menu.upMenuId}|${menu.menuNm}|${menu.menuUrl}|${menu.menuDsc}|${menu.ordSeq}|${menu.menuSe}|${menu.useYn}|${string1}|${menu.lv}|${string2}|${string3}|${menu.fullOrdSeq}" />
</c:forEach>

<section class="content">
	<div class="content_tit">
	    <div><span class="content_h1">메뉴 관리</span></div>
	    <ul class="content_nav">
	        <li>HOME</li>
	        <li>시스템 관리</li>
	        <li>메뉴 관리</li>
	    </ul>
	</div>

	<div class="box_wrap">
      <div class="box_left30">
        <div class="nav_tree_wrap">
        <div class="clearfix mb10"><span class="required"></span><h2 class="content_h2">메뉴목록</h2></div> 
	
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
<!--            </div> -->
<!--             <ul> -->
<!--               <li><button type="button"><span class="ico"></span><span class="txt">사용자 포털</span></button> -->
<!--                 <ul> -->
<!--                   <li><button type="button"><span class="ico"></span><span class="txt">사용자 메인</span></button> -->
<!--                     <ul> -->
<!--                       <li><button type="button"><span class="ico"></span><span class="txt">뎁스</span></button> -->
<!--                         <ul> -->
<!--                           <li><button type="button" class="last"><span class="ico"></span><span class="txt">마지막뎁스</span></button></li> -->
<!--                         </ul> -->
<!--                       </li> -->
<!--                       <li><button type="button" class="last"><span class="ico"></span><span class="txt">마지막뎁스</span></button></li> -->
<!--                     </ul> -->
<!--                   </li> -->
<!--                   <li><button type="button" class="last"><span class="ico"></span><span class="txt">마지막뎁스</span></button></li> -->
<!--                 </ul> -->
<!--               </li> -->
<!--               <li><button type="button"><span class="ico"></span><span class="txt">분석가 포털</span></button> -->
<!--                 <ul> -->
<!--                   <li><button type="button"><span class="ico"></span><span class="txt">뎁스</span></button> -->
<!--                     <ul> -->
<!--                       <li><button type="button"><span class="ico"></span><span class="txt">뎁스</span></button> -->
<!--                         <ul> -->
<!--                           <li><button type="button" class="last"><span class="ico"></span><span class="txt">마지막뎁스</span></button></li> -->
<!--                         </ul> -->
<!--                       </li> -->
<!--                       <li><button type="button" class="last"><span class="ico"></span><span class="txt">마지막뎁스</span></button></li> -->
<!--                     </ul> -->
<!--                   </li> -->
<!--                   <li><button type="button" class="last"><span class="ico"></span><span class="txt">마지막뎁스</span></button></li> -->
<!--                 </ul> -->
<!--               </li> -->
<!--               <li><button type="button" class="last"><span class="ico"></span><span class="txt">마지막뎁스</span></button></li> -->
<!--               <li><button type="button" class="last"><span class="ico"></span><span class="txt">마지막뎁스</span></button></li> -->
<!--             </ul> -->
 
        </div>
      </div>
    </div>
      <div class="box_right70">
      <div class="clearfix mb10"><span class="required"></span><h2 class="content_h2">메뉴적용 현황</h2></div> 
          <table class="tb02 tl mt10">
		    <colgroup>
			<col style="width:22%">
			<col style="width:78%">
			</colgroup>
			<tbody>
			  <tr class="tb02_line">
			      <th>상위 메뉴ID</th>
			      <td>
			          <div class="search-box">
				           <input type="text" name="upMenuId" id="upMenuId" readonly style="width:85%;" disabled/>
				           <span class="search-box-append" id="popupUpperMenuId" href="/admin/menu/popup" target="_blank">
								<button type="button" class="btn-search" ><img src="/images/icon_search.png" title="검색"></button>
							</span>
			          </div>
			        </td>
		      </tr>
		      <tr>
		          <th>메뉴ID<br/><em>(ex:mn30000000001)</em></th>
		          <td>
		              <input type="text" class="w100" name="menuId" id="menuId" readonly disabled/>
		          </td>
		      </tr>
		      <tr>
		          <th>메뉴명</th>
		          <td>
		              <input  type="text" class="w100" name="menuNm" id="menuNm" />
		          </td>
		      </tr>
		      <tr>
		          <th>메뉴URL</th>
		          <td>
		              <input  type="text" class="w100" name="menuUrl" id="menuUrl" readonly disabled/>
		          </td>
		      </tr>
		      <tr>
		          <th>메뉴설명</th>
		          <td>
		              <input  type="text" class="w100" name="menuDsc" id="menuDsc" />
		          </td>
		      </tr>
		      <tr>
		          <th>메뉴순서</th>
		          <td>
		              <input  type="text" class="w100" name="ordSeq" id="ordSeq" />
		          </td>
		      </tr>
		      <tr>
		          <th>사용여부<br/><em>(사용 : Y / 미사용 : N)</em></th>
		          <td>
		              <input  type="text" class="w100" name="useYn" id="useYn" />
		          </td>
		      </tr>
		      <tr>
		          <th>메뉴구분<br/><em>(메뉴 : M / 기능 : F)</em></th>
		          <td>
		              <input  type="text" class="w100" name="menuSe" id="menuSe" />
		          </td>
		      </tr>
		      <tr>
		          <th>메뉴속성</th> 
		          <td>
		              <input  type="text" class="w100" name="menuAttr" id="menuAttr" readonly />
		          </td>
		      </tr>
		    </tbody>
          	</table>
	   		<div class="btn_wrap tr">
			   <button type="button" id="newMenu" class="btn big new">신규</button>
			   <button type="button" id="addMenu" class="btn big new" style="display:none;">추가</button>
			   <button type="button" id="saveMenu" class="btn big success" style="display:none;">저장</button>
			   <button type="button" id="cancle" class="btn big clear" style="display:none;">취소</button>
		    </div>
      </div>	     
    </div>
</section>
</form>
<script type="text/javascript">

    /* ********************************************************
     * 메뉴 등록 처리 함수
     ******************************************************** */
    function insertMenuList() {
        if(!fn_validatorMenuList()){return;}
        //if(document.menuForm.tmp_CheckVal.value != "U"){alert("상세조회시는 수정혹은 삭제만 가능합니다. 추가하신 후 등록하세요."); return;} //상세조회시는 수정혹은 삭제만 가능합니다. 초기화 하신 후 등록하세요.
        document.menuForm.action = "/admin/menu/insert";
        document.menuForm.upMenuId.disabled=false;
        document.menuForm.menuId.disabled=false;
        document.menuForm.menuUrl.disabled=false;
        document.menuForm.submit();
    }
    
    /* ********************************************************
     * 메뉴 수정 처리 함수
     ******************************************************** */
    function updateMenuList() {
        if(!fn_validatorMenuList()){return;}
        //if(document.menuForm.tmp_CheckVal.value != "U"){alert("상세조회시는 수정혹은 삭제만 가능합니다. 추가하신 후 등록하세요."); return;} //상세조회시는 수정혹은 삭제만 가능합니다. 초기화 하신 후 등록하세요.
        document.menuForm.action = "/admin/menu/update";
        document.menuForm.upMenuId.disabled=false;
        document.menuForm.menuId.disabled=false;
        document.menuForm.menuUrl.disabled=false;
        document.menuForm.actionType = 'I'
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
        document.menuForm.menuId.readOnly=true;
        document.menuForm.menuId.disabled=true;
        $('#addMenu').text('신규');
        $('#addMenu').show();
        $('#saveMenu').hide();
        $('#cancle').hide();
//         $('#menuUrl').attr('disabled',false);
//         $('#menuUrl').attr('readOnry',false);
    }
    
    /* ********************************************************
     * 신규 등록 함수
     ******************************************************** */
    function newMenuList() {
        document.menuForm.upMenuId.value="";
        document.menuForm.menuId.value="mn";
        document.menuForm.menuNm.value="";
        document.menuForm.menuUrl.value="";
        document.menuForm.menuDsc.value="";
        document.menuForm.ordSeq.value="";
        document.menuForm.tmp_CheckVal.value = "";
        document.menuForm.useYn.value="Y";
        document.menuForm.menuSe.value="M";
        document.menuForm.menuAttr.value='{"attr": {"delete": true, "detail": true, "insert": true, "update": true}}';
        document.menuForm.menuUrl.readOnly=false;
        document.menuForm.menuUrl.disabled=false;
        document.menuForm.menuId.readOnly=false;
        document.menuForm.menuId.disabled=false;
        $('#newMenu').hide();
        $('#addMenu').show();
        $('#saveMenu').hide();
        $('#cancle').show();
//         $('#menuUrl').attr('disabled',false);
//         $('#menuUrl').attr('readOnry',false);
    }

    /* ********************************************************
     * 상세내역조회 함수
     ******************************************************** */
    function choiceNodes(nodeNum) {
        var nodeValues = treeNodes[nodeNum].split("|");
        console.log(nodeValues);
        document.menuForm.upMenuId.value = nodeValues[1];
        document.menuForm.menuId.value = nodeValues[0];
        document.menuForm.ordSeq.value = nodeValues[5];
        document.menuForm.menuNm.value = nodeValues[2];
        document.menuForm.menuDsc.value = nodeValues[4];
        document.menuForm.menuUrl.value = nodeValues[3];
        document.menuForm.useYn.value = nodeValues[7];
        document.menuForm.menuSe.value = nodeValues[6];
        document.menuForm.menuAttr.value = nodeValues[8].replace(/`/gi,'"');
        document.menuForm.menuUrl.readOnly=true;
        document.menuForm.menuUrl.disabled=true;
        document.menuForm.menuId.readOnly=true;
        document.menuForm.menuId.disabled=true;
        document.menuForm.tmp_CheckVal.value = "U";
        $('#newMenu').hide();
        $('#addMenu').hide();
        $('#saveMenu').show();
        $('#cancle').show();
    }

    /* ********************************************************
     * 입력값 validator 함수
     ******************************************************** */
    function fn_validatorMenuList() {

        if(document.menuForm.menuId.value.replace('mn','') == ""){alert("메뉴번호는 Not Null 항목입니다"); return false;} //메뉴번호는 Not Null 항목입니다.
        //if(!checkNumber(document.menuForm.menuId.value)){alert("메뉴번호는 숫자만 입력 가능합니다."); return false;} //메뉴번호는 숫자만 입력 가능합니다.

        if(document.menuForm.ordSeq.value == ""){alert("메뉴순서는 Not Null 항목입니다."); return false;} //메뉴순서는 Not Null 항목입니다.
        if(!checkNumber(document.menuForm.ordSeq.value)){alert("메뉴순서는 숫자만 입력 가능합니다."); return false;} //메뉴순서는 숫자만 입력 가능합니다.

        if(document.menuForm.upMenuId.value == ""){alert("상위메뉴번호는 Not Null 항목입니다."); return false;} //상위메뉴번호는 Not Null 항목입니다.
        //if(!checkNumber(document.menuForm.upMenuId.value)){alert("상위메뉴번호는 숫자만 입력 가능합니다."); return false;} //상위메뉴번호는 숫자만 입력 가능합니다.

        if(document.menuForm.menuUrl.value == ""){alert("메뉴URL은 Not Null 항목입니다."); return false;} //프로그램파일명은 Not Null 항목입니다.
        if(document.menuForm.menuNm.value == ""){alert("메뉴명은 Not Null 항목입니다."); return false;} //메뉴명은 Not Null 항목입니다.

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

    $("#newMenu").click(function () {
        let result = confirm("메뉴입력 창이 모두 초기화 됩니다.\n진행하시겠습니까?");

        if(result) {
        		newMenuList();
        }
    });
    
    $("#addMenu").click(function () {
        let result = confirm("메뉴를 추가하시겠습니까?");

        if(result) {
        		insertMenuList();
        }
    });

    $("#saveMenu").click(function () {
        let result = confirm("메뉴를 수정하시겠습니까?");

        if(result) {
            updateMenuList();
        }

    });

    $("#cancle").click(function () {
        let result = confirm("메뉴입력 창이 모두 초기화 됩니다.\n진행하시겠습니까?");

        if(result) {
            initlMenuList();
        }
    });
    
    $("#deleteMenu").click(function () {
        let result = confirm("메뉴를 삭제하시겠습니까?");

        if(result) {
            deleteMenuList();
        }

    });
</script>