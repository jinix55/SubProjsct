<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<section class="content">

    <div class="content_tit">
        <h1 class="content_h1">사용자 로그</h1>
        <ul class="content_nav">
            <li>HOME</li>
            <li>사용자 관리</li>
            <li>사용자 로그</li>
        </ul>
    </div>

    <form name="searchForm" id="searchForm" method="post">
        <input type="hidden" name="page" id="page" value="<c:out value='${pages.page}'/>" />
        <input type="hidden" name="sortType" id="sortType" >
        <input type="hidden" name="sortDirection" id="sortDirection" >
    <div class="search_bg_wrap">
        <div class="input_date_wrap">
            <div class="input_date">
                <label class="hidden" for="date_before">사용기간 시작 날짜</label><input type="text" class="input" id="date_before" name="startDate" ><button type="button" class="btn_date">사용기간 시작 날짜 검색</button>
            </div>
            <div class="input_wave">~</div>
            <div class="input_date">
                <label class="hidden" for="date_after">사용기간 끝나는 날짜</label><input type="text" class="input" id="date_after" name="endDate"><button type="button" class="btn_date">사용기간 끝나는 날짜 검색</button>
            </div>
        </div>
        <input type="button" value="검색" onclick="search();" class="btn small grays">
    </div>

    <div class="faq_all">총 ${pages.totalCount}건</div>
    <div class="tb01_line"></div>
    <table class="tb01" summary="첫째줄은 순차적인 게시물 번호이며, 다른 칼럼들은 시간, 사용자, 접근로그에 대한 내용입니다.">
        <caption class="hidden">사용자 로그 목록</caption>
        <colgroup>
            <col style="width:6%">
            <col style="width:20%">
            <col style="width:20%">
            <col style="width:20%">
            <col style="width:34%">
        </colgroup>
        <thead>
        <tr>
            <th scope="col">No</th>
            <th scope="col">
                시간
                <div class="tb_btn">
                    <button type="button" class="btn_up" onclick="searchSort('log_dt', 'asc');">시간 오름차순</button>
                    <button type="button" class="btn_down" onclick="searchSort('log_dt', 'desc');">시간 내림차순</button>
                </div>
            </th>
            <th scope="col">사용자</th>
            <th scope="col">접근 로그</th>
            <th scope="col">접근 URL</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="log" items="${logs}">
        <tr>
            <td scope="row">${log.rownum}</td>
            <td><spring:eval expression="log.logDt"/></td>
            <td>${log.userNm}</td>
            <td>${log.programNm}</td>
            <td style="text-align: left">${log.rqstUrl}</td>
        </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="page"></div>

    <div class="search_wrap">
        <fieldset>
            <legend class="hidden">사용자 목록 게시물 검색</legend>

            <div class="select">
                <label class="hidden" for="pageSize">게시물 갯수</label>
                <select name="pageSize" id="pageSize">
                    <option value="10">10건</option>
                    <option value="20">20건</option>
                    <option value="50">50건</option>
                </select>
            </div>

            <div class="select">
                <label class="hidden" for="searchKey">검색 항목</label>
                <select name="searchKey" id="searchKey">
                    <option value="ALL">전체</option>
                    <option value="userNm">사용자</option>
                    <option value="programNm">접근 로그</option>
                </select>
            </div>

            <label class="hidden" for="searchValue">검색어</label>
            <input type="text" class="input" id="searchValue" name="searchValue"  placeholder="검색어를 입력하세요.">
            <input type="button" value="검색" onclick="search();" class="btn small grays">
        </fieldset>
    </div>
    </form>

</section>
<script type="text/javascript" src="/js/log.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $('#date_before').val('<spring:eval expression="pages.startDt"/>');
        $('#date_after').val('<spring:eval expression="pages.endDt"/>');
        $('#pageSize').val('${pages.pageSize}');
        $('#searchKey').val('${pages.searchKey}');
        $('#searchValue').val('${pages.searchValue}');
    });

    $(function() {
        $("#date_before").datetimepicker({
            dateFormat:'yy-mm-dd',
            monthNamesShort:[ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
            dayNamesMin:[ '일', '월', '화', '수', '목', '금', '토' ],
            changeMonth:true,
            changeYear:true,
            showMonthAfterYear:true,

            // timepicker 설정
            timeFormat:'HH:mm:ss',
            controlType:'select',
            oneLine:true
        });
        $("#date_after").datetimepicker({
            dateFormat:'yy-mm-dd',
            monthNamesShort:[ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
            dayNamesMin:[ '일', '월', '화', '수', '목', '금', '토' ],
            changeMonth:true,
            changeYear:true,
            showMonthAfterYear:true,

            // timepicker 설정
            timeFormat:'HH:mm:ss',
            controlType:'select',
            oneLine:true
        });
    });

    /**
     * 페이징 처리 공통 함수
     */
    $('.page').bootpag({        // 페이징을 표시할 div의 클래스
        total: ${pages.totalPage},  // 페이징모델의 전체페이지수
        page: ${pages.page},        // 페이징모델의 현재페이지번호
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
        $("#searchForm").submit();
    });
</script>