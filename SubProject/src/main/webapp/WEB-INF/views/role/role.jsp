<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<section class="content">
    <div class="content_tit">
        <div><span class="content_h1">권한 그룹 관리</span></div>
        <ul class="content_nav">
            <li>HOME</li>
            <li>시스템 관리</li>
            <li>권한 그룹 관리</li>
        </ul>
    </div>

    <div class="radius_box">
    <div class="tb01_line"></div>
    <table class="tb01">
        <caption class="hidden">권한 관리 목록</caption>
        <colgroup>
            <col style="width:6%">
            <col style="width:22%">
            <col style="width:6%">
            <col style="width:22%">
            <col style="width:25%">
            <col style="width:25%">
        </colgroup>
        <thead>
        <tr>
            <th scope="col">No</th>
            <th scope="col">권한ID</th>
            <th scope="col">권한 분류</th>
            <th scope="col">권한명</th>
            <th scope="col">비고</th>
            <th scope="col">생성일시</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="role" items="${roles}" varStatus="status">
        <tr onclick="getRoleData('<c:out value="${role.authId}"/>')">
            <td scope="row" class="this_no"><c:out value="${criteria.totalCount - (status.index + (pages.page -1) * pages.pageSize)}"/></td>
            <td><c:out value="${role.authId}"/></td>
            <td>
            	<c:if test="${role.authCl == 'U' }">참여자</c:if>
            	<c:if test="${role.authCl == 'A' }">담당자</c:if>
            	<c:if test="${role.authCl == 'D' }">임원</c:if>
            </td>
            <td class="this_auth"><c:out value="${role.authNm}"/></td>
            <td><c:out value="${role.authDsc}"/></td>
            <td><spring:eval expression="role.rgstDt"/></td>
        </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="page"></div>

    <form name="roleForm" id="roleForm" method="post">
        <input type="hidden" name="page" id="page" />
        <input type="hidden" name="pageSize" id="pageSize" value="10" />
        <div class="mb10"><span class="required"></span><h2 class="content_h2">권한 등록</h2></div>
        <table class="tb02">
            <caption class="hidden">권한 등록 목록</caption>
            <colgroup>
                <col style="width:12.5%">
                <col style="width:37.5%">
                <col style="width:12.5%">
                <col style="width:37.5%">
            </colgroup>
            <tbody>
            <tr class="tb02_line">
                <th scope="row"><label for="authId">권한ID</label></th>
                <td>
                    <input type="text" class="w100" id="authId" name="authId" readonly maxlength="32">
                </td>
                <th scope="row"><label for="authNm">권한명</label></th>
                <td><input type="text" class="w100" id="authNm" name="authNm" maxlength="50"></td>
            </tr>
            <tr>
                <th scope="row"><label for="authDsc">비고</label></th>
                <td><input type="text" class="w100" id="authDsc" name="authDsc" maxlength="500"></td>
                <th scope="row"><label for="authDsc">권한 분류</label></th>
                <td>
					<div class="select">
	                	<select id="authCl" name="authCl">
	                		<option value="U" >참여자</option>
	                		<option value="A" >담당자</option>
	                		<option value="D" >임원</option>
	                	</select>
					</div>                
                </td>
            </tr>
            </tbody>
        </table>

        <div class="btn_wrap tr">
            <button type="button" id="addRole" class="btn big new">신규</button>
            <button type="button" id="saveRole" class="btn big success">저장</button>
            <button type="button" id="deleteRole" class="btn big clear">삭제</button>
        </div>
    </form>
</div>
</section>
<script type="text/javascript" src="/js/role.js"></script>
<script type="text/javascript">
    $(document).ready(function() {

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
        $("#roleForm").submit();
    });
</script>