<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<section class="content">
	<div class="content_tit">
		<div><span class="content_h1">휴일 관리</span></div>
		<ul class="content_nav">
			<li>HOME</li>
			<li>ADMIN</li>
			<li>휴일 관리</li>
		</ul>
	</div>
	<div class="radius_box">
	<form name="holiBdForm" id="holiBdForm" method="post" action="/admin/holiday">
		<input type="hidden" name="page" id="page" value="<c:out value='${pages.page}'/>" /> 
		<input type="hidden" name="sortType" id="sortType"> 
		<input type="hidden" name="sortDirection" id="sortDirection">
        <div class="d-block justify-content-between mb10">
			<div class="form-group">
				<div class="form-inline">
					<div class="search-date">
					<input type="text" name="startDate" id="date_before" class="text-input">
					</div>
					<div class="search-date search-date-shape">
						<input type="text" name="endDate" id="date_after" class="text-input">
					</div>
					<button type="button" class="btn small search" onclick="search();">검색</button>
				</div>
			</div>
			<div class="form-group">
				<div class="form-inline mr5">
					<div class="select">
					<select name="holiType" id="holiType">
						<option value="">전체</option>
						<option value='C'>국가공휴일</option>
						<option value='W'>주말</option>
						<option value='T'>임시공휴일</option>
					</select>
					</div>
					<button type="button" class="btn small search" onclick="search();">검색</button>
				</div>
				<div class="form-inline mr5">
					<div class="select">
					<select name="useYn" id="useYn">
						<option value="">전체</option>
						<option value='Y'>ON</option>
						<option value='N'>OFF</option>
					</select>	
					</div>
					<button type="button" class="btn small search" onclick="search();">검색</button>
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
	    </div>	
		<div class="tb01_line"></div>
		<table class="tb01 cursor">
			<caption class="hidden">코드그룹 목록</caption>
			<colgroup>
				<col style="width: 15%">
				<col style="width: 12%">
				<col style="width: 10%">
				<col style="width: *%">
				<col style="width: 15%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">일자</th>
					<th scope="col">휴일명</th>
					<th scope="col">휴일 타입</th>
					<th scope="col">메모</th>
					<th scope="col">서비스</th>
				</tr>
			</thead>
			<tbody id="holiListTbody">
				<c:forEach var="holi" items="${list}">
					<tr solardate="${holi.solarDate}">
						<td>${holi.solarDate }</td>
						<td>${holi.holiNm }</td>
						<td><c:choose>
								<c:when test="${holi.holiType eq 'W' }">
									<span class="text">주말</span>
								</c:when>
								<c:when test="${holi.holiType eq 'C'}">
									<span class="text">국가 공휴일</span>
								</c:when>
								<c:otherwise>
									<span class="text">임시 공휴일</span>
								</c:otherwise>
							</c:choose></td>
						<td>${holi.memo }</td>
						<td  useYn="${holi.useYn}"> 
						    <label class="switch"> <input class="switchYn" type="checkbox" id="checkBox"<c:if test="${holi.useYn eq 'Y'}">checked</c:if> />
							<span class="slider round"></span>
						</label>
						</td>
				</c:forEach>
			</tbody>
		</table>

		<div class="page"></div>
	</form>
	<div id="holiInput">
		<form name="holiForm" id="holiForm" action="/admin/holiday">
			<input type="hidden" name="page2" id="page2" /> 
			<input type="hidden" name="pageSize2" id="pageSize2" value="10" />
			<div class="mb10"><span class="required"></span><h2 class="content_h2">휴일 등록</h2></div>
			<table class="tb02">
				<caption class="hidden">휴일 등록 목록</caption>
				<colgroup>
					<col style="width: 12.5%">
					<col style="width: 37.5%">
					<col style="width: 12.5%">
					<col style="width: 37.5%">
				</colgroup>
				<tbody>
					<tr class="tb02_line">
						<th scope="row"><label for="solarDateView">휴일일자</label></th>
						<td>
						   <input type="text" class="w100" id="solarDateView" name="solarDateView" maxlength="16">
						</td>
						<th scope="row"><label for="holiNmView">휴일명</label></th>
						<td>
						   <input type="text" class="w100" id="holiNmView" name="holiNmView" maxlength="50">
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="holiTypeView">휴일타입</label></th>
						<td>
						   <input type="text" class="w100" id="holiTypeView" name="holiTypeView" maxlength="16">
						</td>
						<th scope="row"><label>서비스</label></th>
						<td colspan="3">
							<!-- <label style="margin: 0 10px; color: blue;">
							<input style="-webkit-appearance: radio !important;" type="radio" name="useYnView" id="useYView" value="Y" /> ON</label> 
							<label style="margin: 0 10px; color: red;">
						  <input style="-webkit-appearance: radio !important;" type="radio" name="useYnView" value="N" id="useNView" /> OFF</label> -->
			              <input type="radio" name="useYnView" id="useYView" value="Y" checked="checked">
			              <label for="useYView">ON</label>
			              <input type="radio" name="useYnView" value="N" id="useNView">
			              <label for="useNView">OFF</label>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="memo">메모</label></th>
						<td colspan="3">
						   <input type="text" class="w100" id="memo" name="memo" maxlength="500">
						</td>
					</tr>
				</tbody>
			</table>

			<div class="btn_wrap tr">
				<button type="button" id="newbt" class="btn big new">신규</button>
				<button type="button" id="modibt" class="btn big edit">수정</button>
				<button type="button" id="inserbt" class="btn big new" style="display: none;">추가</button>
				<button type="button" id="savebt" class="btn big success">저장</button>
				<%-- <button type="button" id="deleteholi" class="btn small grayb">삭제</button>--%>
			</div>
		</form>
	</div>
	</div>
</section>
<script type="text/javascript" src="/js/holiday.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
		$('#pageSize').val('${pages.pageSize}');
		$('#holiType').val('${pages.holiType}');
		$('#useYn').val('${pages.useYn}');
		$('#holiNm').val('${pages.holiNm}');
		$('#startDate').val('${pages.startDt}');
		$('#endDate').val('${pages.endDt}');

//         $('#codeInput').hide();
//         viewCode('<c:out value="${firstCodeId}"/>', '<c:out value="${firstCodeNm}"/>', '<c:out value="${firstCodeDsc}"/>', '<c:out value="${firstCodeUseYn}"/>');
    });
	$("#date_before").datepicker({
//			showOn : "both",
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
//			showOn : "both",
		dateFormat : 'yy-mm-dd',
		onClose : function(selectedDate){
			$("#date_before").datepicker(
				"option",
				"maxDate",
				selectedDate
			);
		}
	});
	
	$("#holiListTbody td").click(function () {
		var solarDate = $(this).parent().attr('solarDate');
		getHoliData(solarDate);
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
        $("#holiBdForm").submit();
    });
    /* 유효성 검사 */ 
    var ordSeq = RegExp(/[^0-9]$/);
    $("#ordSeq").on("propertychange keyup paste input",function(){
    	$("#ordSeq").val($("#ordSeq").val().replace(/[^0-9]/gi,''));
    	$("#ordSeq").val($.trim($("#ordSeq").val().substring(0,2)));
    }); 
</script>