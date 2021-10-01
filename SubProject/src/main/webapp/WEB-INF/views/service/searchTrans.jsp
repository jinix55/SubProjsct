<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<section class="content">
    <div class="content_tit">
        <div><span class="content_h1">녹취 내용 검색</span></div>
        <ul class="content_nav">
            <li>HOME</li>
            <li>서비스</li>
            <li>녹취 내용 검색</li>
        </ul>
    </div>
    
    <div class="radius_box">
   		<div class="boxHeader">
   		<div>
			<form>
			<div class="innerWrap">
				<label for="searchDate" class="bold">기간설정</label>
				<input type="text" id="searchDate" list="searchList">
					<datalist id="searchList">
						<option>직접입력</option>
						<option >오늘</option>
						<option>어제</option>
						<option>최근1주일</option>
						<option selected>최근2주일</option>
					</datalist>
			</div>
			</form>
			<div class="datePicker">2021-05-18~2021-06-16</div>
			<div class="Utc">(UTC+09:00)</div>		
			<div class="dataIndex point">07:24시까지의 데이터가 반영된 지표입니다</div>		
<!-- 			<input type="button" value="대화 기록 다운로드" id="hstDownload" onclick="HstDownload();" class="btn small blue ml10"  /> -->		
			<button type="button" id="hstDownload" onclick="HstDownload();" class="btn small blue ml10"><i class="fas fa-download" style="font-size: 16px;vertical-align: initial;"></i> 대화 기록 다운로드</button>
			<input type="button" value="검색" id="btnSmallGray" class="btn small search2" />		
		</div>
		<div class="boxBody mt20">
			<div class="rowOne">
					<span class="convName">대화이름</span>
					<input type="text"  id="convName" placeholder="대화이름을 입력하세요" class="w100">
			</div>		
				
			<div class="rowTwo">	
					<span class="convTag">대화태그</span>
					<input type="text" id="convTag" placeholder="대화 태그를 입력하거나 선택해주세요"  class="w100">
			</div>	
			<div class="rowThree">	
					<span class="answer">답변</span>
					<input type="text" id="answer" placeholder="검색어를 입력하세요"  class="w100">
			</div>		
			<div class="rowFour">	
					<span class="messenger">메신저</span>
						<div id="messenger">
							<input type="checkbox" id="line">LINE
							<input type="checkbox" id="lineWorks">LINE WORKS
							<input type="checkbox" id="faceBook">페이스북
							<input type="checkbox" id="clova">CLOVA
						</div>
			</div>	
			<div class="btn_wrap tc" style="padding-bottom: 0px;">
				<input type="button" value="초기화" class="btn small clear" />
				<input type="button" value="검색" onclick="search();" class="btn small search2"/>		
			</div>
		</div>
      </div>

	<form name="searchTransForm" id="searchTransForm" method="post" action="/service/searchTrans">
	<input type="hidden" name="page" id="page"
		value="<c:out value='${pages.page}'/>" /> 
		<input type="hidden" name="sortType" id="sortType"> 
		<input type="hidden" name="sortDirection" id="sortDirection">

		<div class="tb01_line"></div>
		<table class="tb01 cursor">
			<caption class="hidden">게시판 목록</caption>
			<colgroup>
				<col style="width: 15%">
				<col style="width: 12%">
				<col style="width: 10%">
				<col style="width: *%">
				<col style="width: 15%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">세션 시작 시나리오</th>
					<th scope="col">세션 시작 대화 태그</th>
					<th scope="col">세션 내 메시지 수</th>
					<th scope="col">메신저</th>
					<th scope="col">세션 시작 날짜</th>
					<th scope="col">실패</th>
					<th scope="col">대화목록</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>[System Message]</td>
					<td></td>
					<td>12</td>
					<td>CLOVA AiCall</td>
					<td>2021-06-18 10:00:15</td>
					<td>실패</td>
					<td>모든 대화 보기</td>
				</tr>		
				<tr>
					<td>[System Message]</td>
					<td></td>
					<td>12</td>
					<td>CLOVA AiCall</td>
					<td>2021-06-18 10:00:15</td>
					<td>실패</td>
					<td>모든 대화 보기</td>
				</tr>		
				<tr>
					<td>[System Message]</td>
					<td></td>
					<td>12</td>
					<td>CLOVA AiCall</td>
					<td>2021-06-18 10:00:15</td>
					<td>실패</td>
					<td>모든 대화 보기</td>
				</tr>		
				<tr>
					<td>[System Message]</td>
					<td></td>
					<td>12</td>
					<td>CLOVA AiCall</td>
					<td>2021-06-18 10:00:15</td>
					<td>실패</td>
					<td>모든 대화 보기</td>
				</tr>		
				<tr>
					<td>[System Message]</td>
					<td></td>
					<td>12</td>
					<td>CLOVA AiCall</td>
					<td>2021-06-18 10:00:15</td>
					<td>실패</td>
					<td>모든 대화 보기</td>
				</tr>		
				<tr>
					<td>[System Message]</td>
					<td></td>
					<td>12</td>
					<td>CLOVA AiCall</td>
					<td>2021-06-18 10:00:15</td>
					<td>실패</td>
					<td>모든 대화 보기</td>
				</tr>		
				<tr>
					<td>[System Message]</td>
					<td></td>
					<td>12</td>
					<td>CLOVA AiCall</td>
					<td>2021-06-18 10:00:15</td>
					<td>실패</td>
					<td>모든 대화 보기</td>
				</tr>		
				<tr>
					<td>[System Message]</td>
					<td></td>
					<td>12</td>
					<td>CLOVA AiCall</td>
					<td>2021-06-18 10:00:15</td>
					<td>실패</td>
					<td>모든 대화 보기</td>
				</tr>		
				<tr>
					<td>[System Message]</td>
					<td></td>
					<td>12</td>
					<td>CLOVA AiCall</td>
					<td>2021-06-18 10:00:15</td>
					<td>실패</td>
					<td>모든 대화 보기</td>
				</tr>		
				<tr>
					<td>[System Message]</td>
					<td></td>
					<td>12</td>
					<td>CLOVA AiCall</td>
					<td>2021-06-18 10:00:15</td>
					<td>실패</td>
					<td>모든 대화 보기</td>
				</tr>		
				<tr>
					<td>[System Message]</td>
					<td></td>
					<td>12</td>
					<td>CLOVA AiCall</td>
					<td>2021-06-18 10:00:15</td>
					<td>실패</td>
					<td>모든 대화 보기</td>
				</tr>		
				<tr>
					<td>[System Message]</td>
					<td></td>
					<td>12</td>
					<td>CLOVA AiCall</td>
					<td>2021-06-18 10:00:15</td>
					<td>실패</td>
					<td>모든 대화 보기</td>
				</tr>					
		</tbody>
		</table>
		<div class="page"></div>
	</form>
  </div>
</section>
<script type="text/javascript" src="/js/searchTrans.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#pageSize').val('${pages.pageSize}');
	
	});

	/**
	 * boxBody 접었다 펴기 
	 */

	$('#btnSmallGray').click(function(){
		if($('.boxBody').css('display') === 'none'){
			$('.boxBody').show();
			
		}else{
			$('.boxBody').hide();
		}
	});

/**
 * 페이징 처리 공통 함수
 */
$('.page').bootpag({        // 페이징을 표시할 div의 클래스
    total: 5,  // 페이징모델의 전체페이지수
    page: 1,        // 페이징모델의 현재페이지번호
    maxVisible: 5,  // 보여질 최대 페이지수
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
    $("#searchTransForm").submit();
});
</script>
