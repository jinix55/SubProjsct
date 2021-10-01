<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<section class="content">

    <div class="content_tit">
        <h1 class="content_h1">휴일 관리</h1>
        <ul class="content_nav">
            <li>HOME</li>
            <li>시스템 관리</li>
            <li>휴일 관리</li>
        </ul>
    </div>
    
     <div class="tb01_line"></div>
     <table class="tb01 cursor" summary="첫째줄은 순차적인 게시물 번호이며, 다른 칼럼들은 행사/사번, 성명, 직위, 조직명, 회사명, 권한그룹, 최종접속, 사용기간, 사용여부에 대한 내용입니다.">
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
			<col style="width:10%">
			<col style="width:13%">
			<col style="width:7%">
			<col style="width:7%">
		</colgroup>
		<thead>
		<tr>
			<th scope="col">No</th>
			<th scope="col">
				휴일명
				<div class="tb_btn">
					<button type="button" class="btn_up" onclick="searchSort('user_id', 'asc');">아이디 오름차순</button>
					<button type="button" class="btn_down" onclick="searchSort('user_id', 'desc');">아이디 내림차순</button>
				</div>
			</th>
			<th scope="col">휴일타입
				<div class="tb_btn">
					<button type="button" class="btn_up" onclick="searchSort('user_nm', 'asc');">휴일명 오름차순</button>
					<button type="button" class="btn_down" onclick="searchSort('user_nm', 'desc');">휴일명 내림차순</button>
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
			<th scope="col">반복유형</th>
			<th scope="col">
				휴일시작일자
				<div class="tb_btn">
					<button type="button" class="btn_up" onclick="searchSort('last_log_dt', 'asc');">최종접속 오름차순</button>
					<button type="button" class="btn_down" onclick="searchSort('last_log_dt', 'desc');">최종접속 내림차순</button>
				</div>
			</th>
			<th scope="col">
				휴일종료일자
				<div class="tb_btn">
					<button type="button" class="btn_up" onclick="searchSort('end_dt', 'asc');">사용기간 오름차순</button>
					<button type="button" class="btn_down" onclick="searchSort('end_dt', 'desc');">사용기간 내림차순</button>
				</div>
			</th>
			<th colspan="2" scope="col">설명</th>
			
		</tr>
		</thead>
		<tbody >
			<tr <c:if test="${member.lockYn eq 'Y'}">class="tb_old"</c:if> userId="${member.userId}">
				<td scope="row"><c:out value="${pages.totalCount - (status.index + (pages.page -1) * pages.pageSize)}"/></td>
				<td><c:out value="${member.userId}"/></td>
				<td><c:out value="${member.userNm}"/></td>
				<td></td>
				<td></td>
				<td></td>
			<td colspan="2"></td>
						
			
					
		</tbody>
		</table>
   	
</section>
