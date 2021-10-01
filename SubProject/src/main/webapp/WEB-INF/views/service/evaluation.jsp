<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<section class="content">
	<div class="content_tit">
		<div><span class="content_h1">평가셋 관리</span></div>
		<ul class="content_nav">
			<li>HOME</li>
			<li>서비스</li>
			<li>평가셋 관리</li>
		</ul>
	</div>
	<div class="radius_box">
	<form name="searchForm" id="searchForm" method="post" action="/admin/member">
		<input type="hidden" name="page" id="page" value="<c:out value='${pages.page}'/>" /> 
		<input type="hidden" name="sortType" id="sortType"> <input type="hidden" name="sortDirection" id="sortDirection">
		
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
					<option value='<c:out value="${role.authId}"/>'>
					<c:out value="${role.authNm}" /></option>
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
		<div class="form-inline mr5">
			<div class="select">
			<select name="filterLockYn" id="filterLockYn">
				<option value="">전체</option>
				<option value="Y">잠김</option>
				<option value="N">미잠김</option>
			</select>
			</div>
			<button type="button" class="btn small search" onclick="search();">검색</button>
		</div>
		<div class="form-inline">
			<span class="mr10">	
			<input type="button" value="추가" onclick="modalOpen();" class="btn big blue" data-toggle="modal" data-target="#my80sizeCenterModal" class="btn small new" /> </span>
			<span class="mr10"><input type="button" value="삭제" onclick="search();" class="btn small clear" /></span> 
			<span><input type="button" value="실행" onclick="search();" class="btn small success" /></span>
		</div>
    </div>
    
       </form>
		<!-- <div class="tb01_line"></div> -->
		<table class="tb01 cursor">
			<caption class="hidden">사용자 목록</caption>
			<colgroup>
				<col style="width: 7%">
				<col style="width: 7%">
				<col style="width: 7%">
				<%--
			<col style="width:7%">
			<col style="width:*">
			<col style="width:10%">
			 --%>
				<col style="width: *">
				<col style="width: 7%">
				<col style="width: 7%">
				<col style="width: 7%">
				<col style="width: 7%">
				<col style="width: 7%">
				<col style="width: 7%">
				<col style="width: 7%">
				<col style="width: 14%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">No</th>
					<th scope="col">생성일자
						<div class="tb_btn">
							<button type="button" class="btn_up" onclick="searchSort('user_id', 'asc');">아이디 오름차순</button>
							<button type="button" class="btn_down" onclick="searchSort('user_id', 'desc');">아이디 내림차순</button>
						</div>
					</th>
					<th scope="col">도메인코드
						<div class="tb_btn">
							<button type="button" class="btn_up" onclick="searchSort('user_nm', 'asc');">성명 오름차순</button>
							<button type="button" class="btn_down" onclick="searchSort('user_nm', 'desc');">성명 내림차순</button>
						</div>
					</th>
					<th scope="col">도메인
						<div class="tb_btn">
							<button type="button" class="btn_up" onclick="searchSort('user_id', 'asc');">아이디 오름차순</button>
							<button type="button" class="btn_down" onclick="searchSort('user_id', 'desc');">아이디 내림차순</button>
						</div>
					</th>
					<th scope="col">순번</th>
					<th scope="col">평가셋명</th>
					<th scope="col">질문수</th>
					<th scope="col">응답수</th>
					<th scope="col">임계치</th>
					<th scope="col">미인식</th>
					<th scope="col">처리상태
						<div class="tb_btn">
							<button type="button" class="btn_up" onclick="searchSort('user_id', 'asc');">아이디 오름차순</button>
							<button type="button" class="btn_down" onclick="searchSort('user_id', 'desc');">아이디 내림차순</button>
						</div>
					</th>
					<th scope="col">작업일시
						<div class="tb_btn">
							<button type="button" class="btn_up" onclick="searchSort('user_id', 'asc');">아이디 오름차순</button>
							<button type="button" class="btn_down" onclick="searchSort('user_id', 'desc');">아이디 내림차순</button>
						</div>
					</th>
				</tr>
			</thead>
			<tbody id="memberListTbody">
				<tr>
					<td class="this_no">1</td>
					<td>2021-07-24</td>
					<td>INBD.B.101</td>
					<td>인바운드 B.영업점</td>
					<td>1</td>
					<td>test</td>
					<td>1</td>
					<td>1</td>
					<td>미사용</td>
					<td>사용</td>
					<td>완료</td>
					<td>2021-07-24 07:24:20</td>
				</tr>
				<tr>
					<td class="this_no">2</td>
					<td>2021-07-24</td>
					<td>INBD.B.101</td>
					<td>인바운드 B.영업점</td>
					<td>1</td>
					<td>test</td>
					<td>1</td>
					<td>1</td>
					<td>미사용</td>
					<td>사용</td>
					<td>완료</td>
					<td>2021-07-24 07:24:20</td>
				</tr>
				<tr>
					<td class="this_no">3</td>
					<td>2021-07-24</td>
					<td>INBD.B.101</td>
					<td>인바운드 B.영업점</td>
					<td>1</td>
					<td>test</td>
					<td>1</td>
					<td>1</td>
					<td>미사용</td>
					<td>사용</td>
					<td>완료</td>
					<td>2021-07-24 07:24:20</td>
				</tr>
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
				<c:forEach var="memSearchCd" items="${codeMemSearchCdList}"
					varStatus="status">
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
		<div class="mb10"><span class="required"></span>
		<h2 class="content_h2">평가셋 항목</h2></div>
		<form name="searchForm" id="searchForm" method="post" action="/admin/member">
			<input type="hidden" name="page" id="page" value="<c:out value='${pages.page}'/>" /> 
			<input type="hidden" name="sortType" id="sortType"> 
			<input type="hidden" name="sortDirection" id="sortDirection">
			<div class="select_wrap tr mb10">
				<label for="evalQst">평가 문항</label>
				<input type="text" id="evalQst" class="input2"></input>

				<label for="expAnswer">예상 정답</label>
				<input type="text" id="expAnswer" class="input2"></input>
				
				<label for="convNm">대화명</label>
				<input type="text" id="convNm" class="input2"></input>
				<button type="button" class="btn_search" onclick="search();"  id="searchBtn"><img src="/images/icon_search.png" title="검색"></button>
			</div>
			<div class="indexWrap">
				<div class="indexRow1">
					(<label for="oneHot"><em>ONEHOT threshold</em></label>
					<input type="text" id="oneHot" class="input2"></input>
					<label for="weight1"><em>weight</em></label>
					<input type="text" id="weight1" class="input2"></input>)
					<span>&nbsp;/&nbsp;</span>
					(<label for="elmo"><em>ELMO threshold</em></label>
					<input type="text" id="elmo" class="input2"></input>
					<label for="weight2"><em>weight</em></label>
					<input type="text" id="weight2" class="input2"></input>)
				</div>
				
				<div class="indexRow2">
					
				</div>
			</div>
			<div class="tb01_line"></div>
			<div class="tb01 cursor">
			<table class="tb01 cursor">
				<caption class="hidden">사용자 목록</caption>
				<colgroup>
					<col style="width: 7%">
					<col style="width: 15%">
					<col style="width: 7%">
					<%--
			<col style="width:7%">
			<col style="width:*">
			<col style="width:10%">
			 --%>
					<col style="width: *">
					<col style="width: 25%">
					<col style="width: 7%">
					<col style="width: 7%">
					<col style="width: 7%">
					<col style="width: 7%">
					<col style="width: 7%">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">순번</th>
						<th scope="col">평가문장
							<div class="tb_btn">
								<button type="button" class="btn_up"
									onclick="searchSort('user_id', 'asc');">아이디 오름차순</button>
								<button type="button" class="btn_down"
									onclick="searchSort('user_id', 'desc');">아이디 내림차순</button>
							</div>
						</th>
						<th scope="col">예상정답
							<div class="tb_btn">
								<button type="button" class="btn_up"
									onclick="searchSort('user_nm', 'asc');">성명 오름차순</button>
								<button type="button" class="btn_down"
									onclick="searchSort('user_nm', 'desc');">성명 내림차순</button>
							</div>
						</th>
						<th scope="col">순위
							<div class="tb_btn">
								<button type="button" class="btn_up"
									onclick="searchSort('user_id', 'asc');">아이디 오름차순</button>
								<button type="button" class="btn_down"
									onclick="searchSort('user_id', 'desc');">아이디 내림차순</button>
							</div>
						</th>
						<th scope="col">대화명</th>
						<th scope="col">대화ID</th>
						<th scope="col">일치</th>
						<th scope="col">ONEHOT(M)</th>
						<th scope="col">ELMO(M)</th>
						<th scope="col">평가점수
							<div class="tb_btn">
								<button type="button" class="btn_up"
									onclick="searchSort('user_id', 'asc');">아이디 오름차순</button>
								<button type="button" class="btn_down"
									onclick="searchSort('user_id', 'desc');">아이디 내림차순</button>
							</div>
						</th>
					</tr>
				</thead>
				<tbody id="memberListTbody">
					<tr>
						<td class="this_no">1</td>
						<td>응</td>
						<td><span class="btn no">No</span></td>
						<td>1/10</td>
						<td>WE_위치_주차장</td>
						<td>test</td>
						<td>1</td>
						<td class="font_gree">일치</td>
						<td>미사용</td>
						<td class="this_auth">0.158</td>
					</tr>
						<tr>
						<td class="this_no">1</td>
						<td>응</td>
						<td><span class="btn yes">Yes</span></td>
						<td>1/10</td>
						<td>WE_위치_주차장</td>
						<td>test</td>
						<td>1</td>
						<td class="font_red">불일치</td>
						<td>미사용</td>
						<td class="this_auth">0.158</td>
					</tr>
						<tr>
						<td class="this_no">1</td>
						<td>응</td>
						<td><span class="btn yes">Yes</span></td>
						<td>1/10</td>
						<td>WE_위치_주차장</td>
						<td>test</td>
						<td>1</td>
						<td class="font_red">불일치</td>
						<td>미사용</td>
						<td class="this_auth">0.158</td>
					</tr>
				</tbody>
			</table>
			</div>
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
		</div>
</section>
<div class="modal modal-center fade" id="CenterModal" tabindex="-1" style="display: none;">
	<div class="modal-dialog modal-center" style="width: 600px;height: auto;">
		<div class="modal-content">
			<div class="modal-header"> 
				<button type="button" class="close"  onclick="modalClose();">
				<span aria-hidden="true"></span>&times;</button>
				<h4 class="modal-title" id="myModalLabel">평가셋 관리</h4>
			</div>
			<div class="modal-body">
				<table class="tb02">
				<caption class="hidden">평가셋 관리</caption>
				<colgroup>
					<col style="width: 30%">
					<col style="width: 70%">
				</colgroup>
				<tbody>
					<tr class="tb02_line">
						<th scope="row"><label for="solarDateView">평가셋명</label></th>
						<td>
						   <input type="text"/>
						</td>
					</tr>	
					<tr>	
						<th scope="row"><label for="holiTypeView">도메인코드</label></th>
						<td>
						   <input type="text"/>
						</td>		
					</tr>	
					<tr>
						<th scope="row"><label for="solarDateView">임계치사용</label></th>
						<td>
						  <div class="select">
								<input type="hidden" id="" name="" value="N"/>
								<select name="" id="">
									<option value="">yes</option>
									<option value="">No</option>
								</select>
							</div>
						</td>
					</tr>	
					<tr>	
						<th scope="row"><label for="holiTypeView">평가셋</label></th>
						<td>
						  <textarea class="textarea">최대 3000개 입력이 가능합니다.</textarea>
						</td>		
					</tr>
					<tr>
						<th scope="row"><label for="solarDateView" class="tc">평가셋수</label></th>
						<td>
						   <input type="text" style="width:100px"/>  / <span>3000</span>
						</td>
					</tr>	
					<tr>	 
						<th scope="row"><label for="holiTypeView">정답</label></th>
						<td>
						   <textarea class="textarea">입력하세요</textarea>
						</td>		
					</tr>
					<tr>
						<th scope="row"><label for="solarDateView" class="tc">작업일시</label></th>
						<td>
						   <span>작업일시는 저장시 생성됩니다</span> 						   
						</td>
					</tr>	
				</tbody>
			</table>
	     </div>
		 <div class="modal-footer mt20">
			<button type="button" class="btn btn-default grayb"  onclick="modalClose();">닫기</button>
		 </div>
	</div>
 </div>
</div>
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
</script>
