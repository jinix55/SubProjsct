<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<section class="content">
	<div class="content_tit">
		<div><span class="content_h1">작업 이력 관리</span></div>
		<ul class="content_nav">
			<li>HOME</li>
			<li>ADMIN</li>
			<li>작업 이력 관리</li>
		</ul>
	</div>
	<div class="radius_box">
	<form name="logForm" id="logForm" method="get" action="/admin/jobHst">
		<input type="hidden" name="page" id="page" value="<c:out value='${pages.page}'/>" />
		<input type="hidden" name="sortType" id="sortType" >
		<input type="hidden" name="sortDirection" id="sortDirection" >

		<!-- <div class="tb01_line"></div> -->
		<table class="tb01">
			<caption class="hidden">코드그룹 목록</caption>
			<colgroup>
				<col style="width: 5%">
				<col style="width: 10%">
				<col style="width: 10%">
				<col style="width: 10%">
				<col style="width: 10%">
				<col style="width: *">
				<col style="width: 10%">
				<col style="width: 15%">
				<col style="width: 15%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">No</th>
					<th scope="col">ID</th>
					<th scope="col">이름</th>
					<th scope="col">권한</th>
					<th scope="col">클라이언트IP</th>
					<th scope="col">URI</th>
					<th scope="col">작업 내역</th>
					<th scope="col">프로그램명</th>
					<th scope="col">일자</th>
				</tr>
			</thead>
			<tbody id="jobHstBody">
				<c:forEach var="log" items="${logs}" varStatus="status">
					<tr <c:if test="${log.userId eq 'admin'}">class="log_old"</c:if>
						userId="${log.userId}">
						<td scope="row" class="this_no">
							<c:out value="${pages.totalCount - (status.index + (pages.page -1) * pages.pageSize)}" />
						</td>
						<td><c:out value="${log.userId}" /></td>
						<td><c:out value="${log.userNm}" /></td>
						<td class="this_auth"><c:out value="${log.authNm}" /></td>
						<td><c:out value="${log.clientIp}" /></td>
						<td><c:out value="${log.rqstUri}" /></td>
						<td><c:out value="${log.programNm}" /></td>
						<td><c:out value="${log.controllerNm}" /></td>
						<td><spring:eval expression="log.logDt" /></td>
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
			<select name="searchKey" id="searchKey">
				<option value="ALL">전체</option>
				<option value="userId">ID</option>
				<option value="userNm">이름</option>
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
    </div>	
</section>
<script type="text/javascript" src="/js/loginHst.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#pageSize').val('${pages.pageSize}');
		$('#searchKey').val('${pages.searchKey}');
		$('#searchValue').val('${pages.searchValue}');
	});
    /**
     * 페이징 처리 공통 함수
     */
	$('.page').bootpag({        // 페이징을 표시할 div의 클래스
		total: ${pages.totalPage},  // 페이징모델의 전체페이지수
		page: ${pages.page},		// 페이징모델의 현재페이지번호
		maxVisible: 10,  // 보여질 최대 페이지수
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
        $("#logForm").submit();
    });

    /* 유효성 검사 */ 
    var ordSeq = RegExp(/[^0-9]$/);
    $("#ordSeq").on("propertychange keyup paste input",function(){
    	$("#ordSeq").val($("#ordSeq").val().replace(/[^0-9]/gi,''));
    	$("#ordSeq").val($.trim($("#ordSeq").val().substring(0,2)));
    }); 
</script>