<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<section class="content">
	<div class="content_tit">
		<div><span class="content_h1">회사 관리</span></div>
		<ul class="content_nav">
			<li>HOME</li>
			<li>시스템 관리</li>
			<li>회사 관리</li>
		</ul>
	</div>
    <div class=radius_box>
	<form name="searchForm" id="searchForm" method="post" action="/admin/company">
		<input type="hidden" name="page" id="page" value="<c:out value='${pages.page}'/>" />
		<input type="hidden" name="sortType" id="sortType" >
		<input type="hidden" name="sortDirection" id="sortDirection" >
	<div class="search_wrap mb10 tr">
		<div class="form-inline">
			<div class="select">
			<select name="uesYn" id="uesYn">
					<option value="">전체</option>
					<option value="Y">사용</option>
					<option value="N">미사용</option>
				</select>
			</div>
			<button type="button" class="btn small search" onclick="search();">검색</button>
		</div>
    </div>				
	<table class="tb01 cursor">
		<caption class="hidden">회사 목록</caption>
		<colgroup>
			<col style="width:5%">
			<col style="width:10%">
			<col style="width:10%">
			<col style="width:20">
			<col style="width:*%">
			<col style="width:*%">
			<col style="width:10%">
			<col style="width:7%">
		</colgroup>
		<thead>
		<tr>
			<th scope="col">No</th>
			<th scope="col">회사 ID</th>
			<th scope="col">회사 코드</th>
			<th scope="col">회사 명</th>
			<th scope="col">회사 설명</th>
			<th scope="col">비고</th>
			<th scope="col">등록일</th>
			<th scope="col">사용여부</th>
		</tr>
		</thead>
		<tbody id="companyListTbody">
			<c:choose>
				<c:when test="${!empty companys }">
				<c:forEach var="company" items="${companys}" varStatus="status">
				<tr userId="${company.companyId}">
					<td scope="row" class="this_no"><c:out value="${pages.totalCount - (status.index + (pages.page -1) * pages.pageSize)}"/></td>
					<td><c:out value="${company.companyId}"/></td>
					<td><c:out value="${company.companyCode}"/></td>
					<td><c:out value="${company.companyNm}"/></td>
					<td><c:out value="${company.companyDsc}"/></td>
					<td><c:out value="${company.note}"/></td>
					<td><spring:eval expression="company.restDt" /></td>
					<td>
						<c:choose>
							<c:when test="${company.useYn eq 'Y' }">
								<span class="btn yes">Yes</span>
							</c:when>
							<c:when test="${company.useYn eq 'N'}">
								<span class="btn no">No</span>
							</c:when>	
					    </c:choose>
					</td>
				</tr>
				</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="8">
							등록된 회사가 없습니다.
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
			
		</tbody>
	</table>

	<div class="page"></div>

	<div class="search_wrap">
		<div class="form-inline mr5">
			<div class="select">
			<select name="pageSize" id="pageSize">
				<option value="10">10건</option>
				<option value="20">20건</option>
				<option value="50">50건</option>
			</select>
			</div>
		</div>
<!-- 		<div class="form-inline mr5"> -->
<!-- 			<div class="select"> -->
<!-- 			<select name="searchKey" id="searchKey" > -->
<!-- 				<option value="ALL">전체</option> -->
<%-- 				<c:forEach var="memSearchCd" items="${codeMemSearchCdList}" varStatus="status"> --%>
<%-- 					<option value="<c:out value='${memSearchCd.codeId}'/>">${memSearchCd.codeNm}</option> --%>
<%-- 				</c:forEach> --%>
<!-- 			</select> -->
<!-- 			</div> -->
<!-- 		</div> -->
		<div class="form-inline">
			<div class="search-box">
				<input type="text" id="searchValue" name="searchValue" placeholder="검색어를 입력하세요." class="w30">
				<span class="search-box-append">
					<button type="button" class="btn-search" onclick="search();"><img src="/images/icon_search.png" title="검색"></button>
				</span>
			</div>
		</div>
	</div>			

	</form>

<!-- 	<form name="companyForm" id="companyForm" method="post"> -->
<!-- 		<div class="mb10 mt20"><span class="required"></span><h2 class="content_h2">사용자 기본 정보</h2></div> -->
<!-- 		<table class="tb02"> -->
<%-- 			<caption class="hidden">사용자 기본 정보</caption> --%>
<%-- 			<colgroup> --%>
<%-- 				<col style="width:12.5%"> --%>
<%-- 				<col style="width:37.5%"> --%>
<%-- 				<col style="width:12.5%"> --%>
<%-- 				<col style="width:37.5%"> --%>
<%-- 			</colgroup> --%>
<!-- 			<tbody> -->
<!-- 			<tr class="tb02_line"> -->
<!-- 				<th scope="row"><label for="orgUserId">아이디</label></th> -->
<!-- 				<td> -->
<!-- 					<input type="text" class="w100" id="orgUserId" disabled placeholder="아이디를 입력 또는 사용자를 선택 해주세요."> -->
<!-- 					<input type="hidden" id="userId" name="userId" /> -->
<!-- 				</td> -->
<!-- 				<th scope="row"><label for="orgUserNm">성명</label></th> -->
<!-- 				<td> -->
<!-- 					<input type="text" class="w100" id="orgUserNm" disabled placeholder="성명을 입력 또는 사용자를 선택 해주세요"> -->
<!-- 					<input type="hidden" id="userNm" name="userNm" /> -->
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<th scope="row"><label for="authId">권한 관리</label></th> -->
<!-- 				<td> -->
<!-- 					<div class="select"> -->
<!-- 						<input type="hidden" id="mgrAuthChange" name="mgrAuthChange" value="N"/> -->
<!-- 						<select name="mgrAuthId" id="mgrAuthId"> -->
<!-- 							<option value="">권한 없음</option> -->
<%-- 							<c:forEach var="mgrRole" items="${mgrRoles}" varStatus="status"> --%>
<%-- 								<option value='<c:out value="${mgrRole.authId}"/>'><c:out value="${mgrRole.authNm}"/></option> --%>
<%-- 							</c:forEach> --%>
<!-- 						</select> -->
<!-- 					</div> -->
<!-- 				</td> -->
<!-- 				<th scope="row"><label>사용기간 등록</label></th> -->
<!-- 				<td> -->
<!-- 					<div class="form-group"> -->
<!-- 						<div class="form-inline"> -->
<!-- 							<div class="search-date"> -->
<!-- 							<input type="text" name="startDate" id="date_before" class="text-input"> -->
<!-- 							</div> -->
<!-- 							<div class="search-date search-date-shape"> -->
<!-- 								<input type="text" name="endDate" id="date_after" class="text-input"> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!--                 <th scope="row"><label for="useYn">사용 여부</label></th> -->
<!--                 <td> -->
<!--                     <div class="select"> -->
<!--                         <select name="useYn" id="useYn"> -->
<%--                             <c:forEach var="useYn" items="${codeUseYnList}"> --%>
<%--                                 <option value="<c:out value='${useYn.codeId}'/>">${useYn.codeNm}</option> --%>
<%--                             </c:forEach> --%>
<!--                         </select> -->
<!--                     </div> -->
<!--                 </td> -->
<!-- 				<th scope="row"><label>사용기간 적용</label></th> -->
<!-- 				<td> -->
<!-- 					<div class="select"> -->
<!--                         <select name="dtLimitYn" id="dtLimitYn"> -->
<%--                             <c:forEach var="limitYn" items="${dateLimitYnList}"> --%>
<%--                                 <option value="<c:out value='${limitYn.codeId}'/>">${limitYn.codeNm}</option> --%>
<%--                             </c:forEach> --%>
<!--                         </select> -->
<!--                     </div> -->
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 			</tbody> -->
<!-- 		</table> -->

<!-- 		<div class="btn_wrap tr"> -->
<!-- 			<button type="button" id="regist" class="btn big new">신규</button> -->
<!-- 			<button type="button" id="insertMember" class="btn big new" style="display:none;">추가</button> -->
<!-- 			<button type="button" id="saveMember" class="btn big success">저장</button> -->
<!-- 		</div> -->
<!-- 	</form> -->
</div>
</section>
<script type="text/javascript" src="/js/company.js"></script>
<script type="text/javascript">
	$(document).ready(function() {


	/**
	 * 페이징 처리 공통 함수
	 */
	$('.page').bootpag({		// 페이징을 표시할 div의 클래스
		total: ${pages.totalPage},  // 페이징모델의 전체페이지수
		page: ${pages.page},		// 페이징모델의 현재페이지번호
		maxVisible: 10,  // 보여질 최대 페이지수
		firstLastUse: true,			 // first와 last사용유무
		wrapClass: 'page',			  // 페이징을 감싼 클래스명
		activeClass: 'on',			  // 현재페이지의 클래스명
		disabledClass: 'disabled',	  // 각 항목별 클래스 지정
		nextClass: 'next',
		prevClass: 'prev',
		lastClass: 'last',
		firstClass: 'first'
	}).on("page", function(event, num){
		$("#page").val(num);
		$("#searchForm").submit();
	});
	});
	
</script>
