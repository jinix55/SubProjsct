<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<section class="content">
    <div class="content_tit">
        <div><span class="content_h1">프로젝트</span></div>
        <ul class="content_nav">
            <li>HOME</li>
            <li>프로젝트</li>
            <li>프로젝트 관리</li>
        </ul>
    </div>
    <div class="radius_box">
	
	<div class="search_wrap mb10 tr">
			<div class="form-inline mr5">
				<div class="select">
				<select name="holiType" id="holiType">
					<option value="">전체</option>
					<option value="C">국가공휴일</option>
					<option value="W">주말</option>
					<option value="T">임시공휴일</option>
				</select>
				</div>
				<button type="button" class="btn small search" onclick="search();">검색</button>
			</div>
			<div class="form-inline mr5">
				<div class="select">
				<select name="useYn" id="useYn">
					<option value="">전체</option>
					<option value="Y">ON</option>
					<option value="N">OFF</option>
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
	    
	<div class="content-body">
		<div class="card-list">
			<c:forEach items="${list}" var="list">
			<div class="card-item chatbot-management-card">
				<div class="box-header">
					<p>
						<span class="title">
							${list.deptNm }
						</span>
					</p>
				</div>
				<div class="box-body">
					<p class="font-weight-bold">
						${list.projectNm }
					</p>
				</div>
			</div>
			</c:forEach>
			<div class="card-item chatbot-management-card">
				<div class="box-header">
					<p>
						<span class="title">
							부서명
						</span>
					</p>
				</div>
				<div class="box-body">
					<p class="font-weight-bold">
						<i class="fas fa-hockey-puck" style="font-size: 28px;"></i>프로젝트명
					</p>
				</div>
			</div>
			<div class="card-item chatbot-management-card">
				<div class="box-header">
					<p>
						<span class="title">
							부서명
						</span>
					</p>
				</div>
				<div class="box-body">
					<p class="font-weight-bold">
						프로젝트명
					</p>
				</div>
			</div>
			<div class="card-item chatbot-management-card">
				<div class="box-header">
					<p>
						<span class="title">
							부서명
						</span>
					</p>
				</div>
				<div class="box-body">
					<p class="font-weight-bold">
						프로젝트명
					</p>
				</div>
			</div>
			<div class="card-item chatbot-management-card">
				<div class="box-header">
					<p>
						<span class="title">
							부서명
						</span>
					</p>
				</div>
				<div class="box-body">
					<p class="font-weight-bold">
						프로젝트명
					</p>
				</div>
			</div>
			<div class="card-item chatbot-management-card">
				<div class="box-header">
					<p>
						<span class="title">
							부서명
						</span>
					</p>
				</div>
				<div class="box-body">
					<p class="font-weight-bold">
						프로젝트명
					</p>
				</div>
			</div>
			<div class="card-item chatbot-management-card">
				<div class="box-header">
					<p>
						<span class="title">
							부서명
						</span>
					</p>
				</div>
				<div class="box-body">
					<p class="font-weight-bold">
						프로젝트명
					</p>
				</div>
			</div>
		</div>
	</div>
	
	<div class="page"></div>
	<div class="btn_wrap tr">
	    <button type="button" onclick="modalOpen();" class="btn big new" data-toggle="modal" data-target="#my80sizeCenterModal">신규</button>
	</div>
	<div class="modal modal-center fade" id="CenterModal" tabindex="-1" style="display: none;">
		<div class="modal-dialog modal-center" style="width: 500px;height: auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close"  onclick="modalClose();">
					<span aria-hidden="true"></span>&times;</button>
					<h4 class="modal-title" id="myModalLabel">프로젝트 등록</h4>
				</div>
					<div class="modal-body">
						<table class="tb02">
						<caption class="hidden">프로젝트 등록</caption>
						<colgroup>
							<col style="width: 12.5%">
							<col style="width: 37.5%">
						</colgroup>
						<tbody>
							<tr class="tb02_line">
								<th scope="row"><label for="solarDateView">이름</label></th>
								<td>
								   <input type="text"/>
								</td>
								
							</tr>
							<tr>
								<th scope="row"><label for="holiTypeView">설명</label></th>
								<td>
								   <textarea class="textarea"></textarea>
								</td>
								
							</tr>
							<tr>
								<th scope="row"><label for="memo">기간</label></th>
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
						</tbody>
					</table>
					<div class="btn_wrap modal_btn">
						<button type="button" class="btn small clear">프로젝트 삭제</button>
						<button type="button" class="btn small success">저장</button>
					</div>
					<div class="mb10"><span class="required"></span><h3 class="content_h3">대화엔진</h3></div>
					<div><textarea class="textarea"></textarea></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default small clear"  onclick="modalClose();">닫기</button>
				</div>
			</div>
		</div>
	</div>
	</div>
</section>
<script>
$(document).ready(function() {
	$('#pageSize').val('${pages.pageSize}');
});

function modalClose(){
	$('.modal.modal-center').toggleClass(' in');
	$('.modal.modal-center').css('display','none');
	$(".modal-backdrop").detach();
};

function modalOpen(){
	$('.modal.modal-center').toggleClass(' in');
	$('.modal.modal-center').css('display','block');
	$('.content').append('<div class="modal-backdrop fade in"></div>');
};

$("#date_before").datepicker({
//	showOn : "both",
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
//	showOn : "both",
dateFormat : 'yy-mm-dd',
onClose : function(selectedDate){
	$("#date_before").datepicker(
		"option",
		"maxDate",
		selectedDate
	);
}
});

/**
 * 페이징 처리 공통 함수
 */
$('.page').bootpag({        // 페이징을 표시할 div의 클래스
    total: 10,  // 페이징모델의 전체페이지수
    page: 1,        // 페이징모델의 현재페이지번호
    maxVisible: 1,  // 보여질 최대 페이지수
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
});
</script>
<style>


</style>