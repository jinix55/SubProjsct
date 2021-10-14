<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>      
<section class="content">
    <div class="content_tit">
        <div><span class="content_h1">공통코드 관리</span></div>
        <ul class="content_nav">
            <li>HOME</li>
            <li>시스템 관리</li>
            <li>공통코드 관리</li>
        </ul>
    </div>

    <div class="box_wrap2">
    <div class="box_cont">
    <div class="mb10"><span class="required"></span><h2 class="content_h2">코드그룹 등록</h2></div>
	    <table class="tb01 state_list">
	        <caption class="hidden">코드그룹 목록</caption>
	        <colgroup>
	            <col style="width:6%">
	            <col style="width:22%">
	            <col style="width:22%">
	            <col style="width:*">
	            <col style="width:20%">
	            <col style="width:6%">
	        </colgroup>
	        <thead>
	        <tr>
	            <th scope="col">No</th>
	            <th scope="col">코드그룹ID</th>
	            <th scope="col">코드그룹명</th>
	            <th scope="col">비고</th>
	            <th scope="col">생성일시</th>
	            <th scope="col">사용여부</th>
	        </tr>
	        </thead>
	        <tbody>
	            <c:forEach var="code" items="${codes}" varStatus="status">
	            <tr onclick="viewCode('<c:out value="${code.codeId}"/>', '<c:out value="${code.codeNm}"/>', '<c:out value="${code.codeDsc}"/>', '<c:out value="${code.useYn}"/>')">
	                <td scope="row" class="this_no"><c:out value="${pages.totalCount - (status.index + (pages.page -1) * pages.pageSize)}"/></td>
	                <td><c:out value="${code.codeId}"/></td>
	                <td><c:out value="${code.codeNm}"/></td>
	                <td><c:out value="${code.codeDsc}"/></td>
	                <td><spring:eval expression="code.rgstDt"/></td>
	                <td>
	                <c:choose>
		                <c:when test="${code.useYn eq 'Y'}">
		                <span class="btn yes">사용</span>
		                </c:when>
		                <c:otherwise>
		                <span class="btn no">미사용</span>
		                </c:otherwise>                
	                </c:choose>
	                </td>
	            </tr>
	            </c:forEach>
	        </tbody>
	    </table>

    	<div class="page"></div>
	    <div id="groupCodeInput" class="mt60">
	        <form name="codeGroupForm" id="codeGroupForm">
	            <input type="hidden" name="page" id="page" />
	            <input type="hidden" name="pageSize" id="pageSize" value="10" />
	            <div class="mb10"><span class="required"></span><h2 class="content_h2">코드그룹 등록</h2></div>
	            <table class="tb02" summary="코드 ID, 코드명, 비고에 대한 내용입니다.">
	                <caption class="hidden">코드그룹 등록 목록</caption>
	                <colgroup>
	                    <col style="width:15%">
	                    <col style="width:35%">
	                    <col style="width:15%">
	                    <col style="width:35%">
	                </colgroup>
	                <tbody>
	                <tr class="tb02_line">
	                    <th scope="row"><label for="groupCodeId">코드그룹 ID</label></th>
	                    <td>
	                        <input type="text" class="w100" id="groupCodeId" name="groupCodeId" maxlength="16">
	                    </td>
	                    <th scope="row"><label for="groupCodeNm">코드그룹명</label></th>
	                    <td><input type="text" class="w100" id="groupCodeNm" name="groupCodeNm" maxlength="50"></td>
	                </tr>
	                <tr>
	                    <th scope="row"><label for="groupCodeDsc">코드그룹비고</label></th>
	                    <td colspan="3"><input type="text" class="w100" id="groupCodeDsc" name="groupCodeDsc" maxlength="500"></td>
	                </tr>
	                <tr>
	                    <th scope="row"><label>코드그룹<br>사용여부</label></th>
	                    <td colspan="3">
	                   	<input type="radio" name="groupCodeUseYn" value="Y" checked="checked">
			              <label for="groupCodeUseYn">사용</label>
			             <input type="radio" name="groupCodeUseYn" value="N">
			              <label for="groupCodeUseYn">미사용</label>
	                    </td>
	                </tr>                
	                </tbody>
	            </table>
	
	            <div class="btn_wrap tr">
	                <button type="button" id="addGroupCode" class="btn big new">코드그룹 신규</button>
	                <button type="button" id="saveGroupCode" class="btn big success">코드그룹 저장</button>
	                <%-- <button type="button" id="deleteGroupCode" class="btn small grayb">삭제</button>--%>
	            </div>
	        </form>
	    </div>
	</div>

    <div class="box_cont type_play">
    	<div id="codeDiv"></div>
	    <div id="codeInput" class="mt60">
	        <form name="codeForm" id="codeForm">
	            <div class="mb10"><span class="required"></span><h2 class="content_h2">코드 등록</h2></div>
	            <table class="tb02" summary="코드 ID, 코드명, 비고에 대한 내용입니다.">
	                <caption class="hidden">코드 등록 목록</caption>
	                <colgroup>
	                    <col style="width:12.5%">
	                    <col style="width:37.5%">
	                    <col style="width:12.5%">
	                    <col style="width:37.5%">
	                </colgroup>
	                <tbody>
	                <tr class="tb02_line">
	                    <th scope="row"><label for="groupId">코드그룹 ID</label></th>
	                    <td>
	                        <input type="text" class="w100" id="groupId" name="groupId" value="{{firstCodeId}}" readonly>
	                    </td>
	                    <th scope="row"><label for="groupNm">코드그룹명</label></th>
	                    <td><input type="text" class="w100" id="groupNm" value="{{firstCodeNm}}" readonly></td>
	                </tr>
	                <tr>
	                    <th scope="row"><label for="codeId">코드 ID</label></th>
	                    <td>
	                        <input type="text" class="w100" id="codeId" name="codeId" readonly maxlength="16">
	                    </td>
	                    <th scope="row"><label for="codeNm">코드명</label></th>
	                    <td><input type="text" class="w100" id="codeNm" name="codeNm" maxlength="50"></td>
	                </tr>
	                <tr>
	                    <th scope="row"><label for="codeDsc">비고</label></th>
	                    <td colspan="3"><input type="text" class="w100" id="codeDsc" name="codeDsc" maxLength="500"></td>
	                </tr>
	                <tr>
	                    <th scope="row"><label for="ordSeq">정렬순서</label></th>
	                    <td colspan="3"><input type="text" class="w100" id="ordSeq" name="ordSeq" maxLength="2"></td>
	                </tr>
	                <tr>
	                    <th scope="row"><label>사용여부</label></th>
	                    <td colspan="3">
	                    <input type="radio" name="useYn" value="Y" checked="checked">
			              <label for="useYn">사용</label>
			             <input type="radio" name="useYn" value="N">
			              <label for="useYn">미사용</label>                    	
	                    </td>
	                </tr>
	                </tbody>
	            </table>
	
	            <div class="btn_wrap tr">
	                <button type="button" id="addCode" class="btn big new">코드 신규</button>
	                <button type="button" id="saveCode" class="btn big success">코드 저장</button>
	                <%--<button type="button" id="deleteCode" class="btn small grayb">삭제</button>--%>
	            </div>
	        </form>
	    </div>
    </div>
   </div>
</section>
<script type="text/javascript" src="/js/code.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $('#codeInput').hide();
        viewCode('<c:out value="${firstCodeId}"/>', '<c:out value="${firstCodeNm}"/>', '<c:out value="${firstCodeDsc}"/>', '<c:out value="${firstCodeUseYn}"/>');
    });

    /**
     * 페이징 처리 공통 함수
     */
	$('.page').bootpag({        // 페이징을 표시할 div의 클래스
        total: ${pages.totalPage},  // 페이징모델의 전체페이지수
        page: ${pages.page},        // 페이징모델의 현재페이지번호
        maxVisible: ${pages.pageSize},  // 보여질 최대 페이지수
        firstLastUse: true,             // first와 last사용유무
        wrapClass: 'page',              // 페이징을 감싼 클래스명
        activeClass: 'on',              // 현재페이지의 클래스명
        disabledClass: 'disabled',      // 각 항목별 클래스 지정
        nextClass: 'next',
        prevClass: 'prev',
        lastClass: 'last',
        firstClass: 'first'
    }).on("page", function(event, num){
        $("#page").val(num);
        $("#codeGroupForm").submit();
    });

    /* 유효성 검사 */ 
    var ordSeq = RegExp(/[^0-9]$/);
    $("#ordSeq").on("propertychange keyup paste input",function(){
    	$("#ordSeq").val($("#ordSeq").val().replace(/[^0-9]/gi,''));
    	$("#ordSeq").val($.trim($("#ordSeq").val().substring(0,2)));
    }); 
</script>