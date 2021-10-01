<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<section class="content">
	<div class="content_tit">
		<div><span class="content_h1">사용자 관리</span></div>
		<ul class="content_nav">
			<li>HOME</li>
			<li>시스템 관리</li>
			<li>사용자 관리</li>
		</ul>
	</div>
    <div class=radius_box>
	<form name="searchForm" id="searchForm" method="post" action="/admin/member">
		<input type="hidden" name="page" id="page" value="<c:out value='${pages.page}'/>" />
		<input type="hidden" name="sortType" id="sortType" >
		<input type="hidden" name="sortDirection" id="sortDirection" >
	<%-- 				
						<legend class="hidden">사용자 목록 종류 선택</legend>
						<label class="hidden" for="searchCompanyCode">신한 종류 선택</label>
						<select name="searchCompanyCode" id="searchCompanyCode">
							<option value="">전체</option>
						<c:forEach var="companyCd" items="${codeCompanyCdList}">
							<option value="<c:out value='${companyCd.codeId}'/>">${companyCd.codeNm}</option>
						</c:forEach>
						</select>
	--%>
	<div class="search_wrap mb10 tr">
		<div class="form-inline mr5">
			<div class="select">
			<select name="searchRoleCode" id="searchRoleCode">
					<option value="">전체</option>
					<c:forEach var="role" items="${roles}" varStatus="status">
					<option value='<c:out value="${role.authId}"/>'><c:out value="${role.authNm}"/></option>
					</c:forEach>	
				</select> 
			</div>
			<button type="button" class="btn small search" onclick="search();">검색</button>
		</div>
		<div class="form-inline mr5">
			<div class="select">
			<select name="searchUseYn" id="searchUseYn">
					<option value="">전체</option>
					<c:forEach var="useYn" items="${codeUseYnList}">
						<option value="<c:out value='${useYn.codeId}'/>">${useYn.codeNm}</option>
					</c:forEach>
				</select>	
			</div>
			<button type="button" class="btn small search" onclick="search();">검색</button>
		</div>
		<div class="form-inline">
			<div class="select">
			<select name="filterLockYn" id="filterLockYn">
					<option value="">전체</option>
					<option value="Y">잠김</option>
					<option value="N">미잠김</option>
				</select>
			</div>
			<button type="button" class="btn small search" onclick="search();">검색</button>
		</div>
    </div>				
	<!-- <div class="tb01_line"></div> -->
	<table class="tb01 cursor">
		<caption class="hidden">사용자 목록</caption>
		<colgroup>
			<col style="width:5%">
			<col style="width:12%">
			<col style="width:12%">
			<%--
			<col style="width:7%">
			<col style="width:*">
			<col style="width:10%">
			 --%>
			<col style="width:*">
			<col style="width:13%">
			<col style="width:13%">
			<col style="width:7%">
			<col style="width:7%">
		</colgroup>
		<thead>
		<tr>
			<th scope="col">No</th>
			<th scope="col">
				아이디
				<div class="tb_btn">
					<button type="button" class="btn_up" onclick="searchSort('user_id', 'asc');">아이디 오름차순</button>
					<button type="button" class="btn_down" onclick="searchSort('user_id', 'desc');">아이디 내림차순</button>
				</div>
			</th>
			<th scope="col">성명
				<div class="tb_btn">
					<button type="button" class="btn_up" onclick="searchSort('user_nm', 'asc');">성명 오름차순</button>
					<button type="button" class="btn_down" onclick="searchSort('user_nm', 'desc');">성명 내림차순</button>
				</div>
			</th>
			<%-- 
			<th scope="col">직위</th>
			<th scope="col">부서명
				<div class="tb_btn">
					<button type="button" class="btn_up" onclick="searchSort('dept_nm', 'asc');">부서명 오름차순</button>
					<button type="button" class="btn_down" onclick="searchSort('dept_nm', 'desc');">부서명 내림차순</button>
				</div>
			</th>
			<th scope="col">회사구분</th>
			 --%>
			<th scope="col">권한</th>
			
			<th scope="col">
				최종접속
				<div class="tb_btn">
					<button type="button" class="btn_up" onclick="searchSort('last_log_dt', 'asc');">최종접속 오름차순</button>
					<button type="button" class="btn_down" onclick="searchSort('last_log_dt', 'desc');">최종접속 내림차순</button>
				</div>
			</th>
			<th scope="col">
				사용기간
				<div class="tb_btn">
					<button type="button" class="btn_up" onclick="searchSort('end_dt', 'asc');">사용기간 오름차순</button>
					<button type="button" class="btn_down" onclick="searchSort('end_dt', 'desc');">사용기간 내림차순</button>
				</div>
			</th>
			<th scope="col">사용여부</th>
			<th scope="col">잠김여부</th>
		</tr>
		</thead>
		<tbody id="memberListTbody">
		<c:forEach var="member" items="${members}" varStatus="status">
		<tr <c:if test="${member.lockYn eq 'Y'}">class="tb_old"</c:if> userId="${member.userId}">
			<td scope="row" class="this_no"><c:out value="${pages.totalCount - (status.index + (pages.page -1) * pages.pageSize)}"/></td>
			<td><c:out value="${member.userId}"/></td>
			<td><c:out value="${member.userNm}"/></td>
			<%-- 
			<td><c:out value="${member.pstnNm}"/></td>
			<td><c:out value="${member.deptNm}"/></td>
			<td><c:out value="${member.companyNm}"/></td>
			--%>
			<td class="this_auth">
			<c:choose>
				<c:when test="${!empty member.mgrAuthNm && member.mgrAuthNm ne 'Y'}">
					<c:out value="${member.mgrAuthNm}"/>
				</c:when>
				<c:otherwise>-</c:otherwise>
			</c:choose>				
			</td>
			<td><spring:eval expression="member.lastLogDt" /></td>
			<td><spring:eval expression="member.startDt"/> ~ <spring:eval expression="member.endDt"/></td>
			<td>
				<c:choose>
					<c:when test="${member.useYn eq 'Y' }">
						<span class="btn yes">Yes</span>
					</c:when>
					<c:when test="${member.useYn eq 'N'}">
						<span class="btn no">No</span>
					</c:when>	
			    </c:choose>
			</td>
			<td class="unlockAccount" id="unlock_${member.userId}">
				<c:if test="${member.lockYn eq 'Y'}"><div class="unlockAccount2"><!-- <i class="fas fa-lock" style="font-size: 48px;"></i> 잠김--><i class="fas fa-lock-open" style="font-size: 16px;"></i> 해제</div></c:if>
			</td>
			<%-- <td class="unlockAccount" id="unlock_${member.userId}"><c:if test="${member.lockYn eq 'Y'}">[해제]</c:if></td> --%>
		</tr>
		</c:forEach>
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
		<div class="form-inline mr5">
			<div class="select">
			<select name="searchKey" id="searchKey" >
				<option value="ALL">전체</option>
				<c:forEach var="memSearchCd" items="${codeMemSearchCdList}" varStatus="status">
					<option value="<c:out value='${memSearchCd.codeId}'/>">${memSearchCd.codeNm}</option>
				</c:forEach>
			</select>
			</div>
		</div>
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

	<form name="memberForm" id="memberForm" method="post">
		<div class="mb10 mt20"><span class="required"></span><h2 class="content_h2">사용자 기본 정보</h2></div>
		<table class="tb02">
			<caption class="hidden">사용자 기본 정보</caption>
			<colgroup>
				<col style="width:12.5%">
				<col style="width:37.5%">
				<col style="width:12.5%">
				<col style="width:37.5%">
			</colgroup>
			<tbody>
			<tr class="tb02_line">
				<th scope="row"><label for="orgUserId">아이디</label></th>
				<td>
					<input type="text" class="w100" id="orgUserId" disabled placeholder="아이디를 입력 또는 사용자를 선택 해주세요.">
					<input type="hidden" id="userId" name="userId" />
				</td>
				<th scope="row"><label for="orgUserNm">성명</label></th>
				<td>
					<input type="text" class="w100" id="orgUserNm" disabled placeholder="성명을 입력 또는 사용자를 선택 해주세요">
					<input type="hidden" id="userNm" name="userNm" />
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="authId">권한 관리</label></th>
				<td>
					<div class="select">
						<input type="hidden" id="mgrAuthChange" name="mgrAuthChange" value="N"/>
						<select name="mgrAuthId" id="mgrAuthId">
							<option value="">권한 없음</option>
							<c:forEach var="mgrRole" items="${mgrRoles}" varStatus="status">
								<option value='<c:out value="${mgrRole.authId}"/>'><c:out value="${mgrRole.authNm}"/></option>
							</c:forEach>
						</select>
					</div>
				</td>
				<th scope="row"><label>사용기간 등록</label></th>
				<td>
					<div class="form-group">
						<div class="form-inline">
							<div class="search-date">
							<input type="text" name="startDate" id="date_before" class="text-input">
							</div>
							<div class="search-date search-date-shape">
								<input type="text" name="endDate" id="date_after" class="text-input">
							</div>
						</div>
					</div>
				</td>
			</tr>
			<tr>
                <th scope="row"><label for="useYn">사용 여부</label></th>
                <td>
                    <div class="select">
                        <select name="useYn" id="useYn">
                            <c:forEach var="useYn" items="${codeUseYnList}">
                                <option value="<c:out value='${useYn.codeId}'/>">${useYn.codeNm}</option>
                            </c:forEach>
                        </select>
                    </div>
                </td>
				<th scope="row"><label>사용기간 적용</label></th>
				<td>
					<div class="select">
                        <select name="dtLimitYn" id="dtLimitYn">
                            <c:forEach var="limitYn" items="${dateLimitYnList}">
                                <option value="<c:out value='${limitYn.codeId}'/>">${limitYn.codeNm}</option>
                            </c:forEach>
                        </select>
                    </div>
				</td>
			</tr>
			</tbody>
		</table>

		<div class="btn_wrap tr">
			<button type="button" id="regist" class="btn big new">신규</button>
			<button type="button" id="insertMember" class="btn big new" style="display:none;">추가</button>
			<button type="button" id="saveMember" class="btn big success">저장</button>
		</div>
	</form>
</div>
</section>
<script type="text/javascript" src="/js/member.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#searchCompanyCode').val('${pages.searchCompanyCode}');
		$('#searchRoleCode').val('${pages.searchRoleCode}');
		$('#searchUseYn').val('${pages.searchUseYn}');
		$('#filterLockYn').val('${pages.filterLockYn}');
		$('#pageSize').val('${pages.pageSize}');
		$('#searchKey').val('${pages.searchKey}');
		$('#searchValue').val('${pages.searchValue}');

		$("#date_before").datepicker({
// 			showOn : "both",
			dateFormat : 'yy-mm-dd',
			onClose : function(selectedDate){
				$("#date_after").datepicker(
					"option",
					"minDate",
					selectedDate
				);
			}
		});

		$("#date_after").datepicker({
// 			showOn : "both",
			dateFormat : 'yy-mm-dd',
			onClose : function(selectedDate){
				$("#date_before").datepicker(
					"option",
					"maxDate",
					selectedDate
				);
			}
		});

		$("#authId").on("change", function(){
			$("#userAuthChage").val("Y");
		});

		$("#mgrAuthId").on("change", function(){
			$("#mgrAuthChange").val("Y");
		});

		$("#memberListTbody td").click(function () {
			var userId = $(this).parent().attr("userId");
			if ($(this).hasClass("unlockAccount")) {
				unlockAccount(userId);
			} else {
				getMemberData(userId);
			}
		});
	});

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
	
</script>
