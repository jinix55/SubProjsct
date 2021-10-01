<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<section class="content">

    <div class="content_tit">
        <h1 class="content_h1">FAQ</h1>
        <ul class="content_nav">
            <li>HOME</li>
            <li>시스템 관리</li>
            <li>FAQ</li>
        </ul>
    </div>

    <div class="faq_all">총 62건</div>
    <ul class="faq_ul">
        <li><dl class="faq_dl">
            <dt class="faq_dt"><button type="button">
                <span class="faq_tit">Q<span>질문</span></span>
                <span class="faq_cate lo">로그인</span>
                <!-- <span class="faq_cate pro">프로젝트</span> -->
                <span class="faq_con">로그인이 안됩니다.</span>
            </button></dt>
            <dd class="faq_dd">
                <span class="faq_tit">A<span>답변</span></span>
                <span class="faq_con">
        업무포털로 문의하시기 바랍니다. 업무포털로 문의하시기 바랍니다. 업무포털로 문의하시기 바랍니다. <br>
        업무포털로 문의하시기 바랍니다.업무포털로 문의하시기 바랍니다. 업무포털로 문의하시기 바랍니다.<br>
        업무포털로 문의하시기 바랍니다.
      </span>
            </dd>
        </dl></li>
        <li><dl class="faq_dl">
            <dt class="faq_dt"><button type="button">
                <span class="faq_tit">Q<span>질문</span></span>
                <!-- <span class="faq_cate lo">로그인</span> -->
                <span class="faq_cate pro">프로젝트</span>
                <span class="faq_con">로그인이 안됩니다.</span>
            </button></dt>
            <dd class="faq_dd">
                <span class="faq_tit">A<span>답변</span></span>
                <span class="faq_con">
        업무포털로 문의하시기 바랍니다. 업무포털로 문의하시기 바랍니다. 업무포털로 문의하시기 바랍니다. <br>
        업무포털로 문의하시기 바랍니다.업무포털로 문의하시기 바랍니다. 업무포털로 문의하시기 바랍니다.<br>
        업무포털로 문의하시기 바랍니다.
      </span>
            </dd>
        </dl></li>
        <li><dl class="faq_dl">
            <dt class="faq_dt"><button type="button">
                <span class="faq_tit">Q<span>질문</span></span>
                <span class="faq_cate lo">로그인</span>
                <!-- <span class="faq_cate pro">프로젝트</span> -->
                <span class="faq_con">로그인이 안됩니다.</span>
            </button></dt>
            <dd class="faq_dd">
                <span class="faq_tit">A<span>답변</span></span>
                <span class="faq_con">
        업무포털로 문의하시기 바랍니다. 업무포털로 문의하시기 바랍니다. 업무포털로 문의하시기 바랍니다. <br>
        업무포털로 문의하시기 바랍니다.업무포털로 문의하시기 바랍니다. 업무포털로 문의하시기 바랍니다.<br>
        업무포털로 문의하시기 바랍니다.
      </span>
            </dd>
        </dl></li>
        <li><dl class="faq_dl">
            <dt class="faq_dt"><button type="button">
                <span class="faq_tit">Q<span>질문</span></span>
                <!-- <span class="faq_cate lo">로그인</span> -->
                <span class="faq_cate pro">프로젝트</span>
                <span class="faq_con">로그인이 안됩니다.</span>
            </button></dt>
            <dd class="faq_dd">
                <span class="faq_tit">A<span>답변</span></span>
                <span class="faq_con">
        업무포털로 문의하시기 바랍니다. 업무포털로 문의하시기 바랍니다. 업무포털로 문의하시기 바랍니다. <br>
        업무포털로 문의하시기 바랍니다.업무포털로 문의하시기 바랍니다. 업무포털로 문의하시기 바랍니다.<br>
        업무포털로 문의하시기 바랍니다.
      </span>
            </dd>
        </dl></li>
    </ul>

    <div class="btn_wrap tr">
        <button type="submit" class="btn big orange" onclick="location.href='/board/faq/regist'">등록</button>
    </div>

    <div class="page">
        <a href="#none" class="first">처음 목록으로 이동</a>
        <a href="#none" class="prev">이전 목록으로 이동</a>
        <a href="#none" class="on" title="현재 페이지">1</a>
        <a href="#none">2</a>
        <a href="#none">3</a>
        <a href="#none">4</a>
        <a href="#none">5</a>
        <a href="#none">6</a>
        <a href="#none">7</a>
        <a href="#none">8</a>
        <a href="#none">9</a>
        <a href="#none">10</a>
        <a href="#none" class="next">다음 목록으로 이동</a>
        <a href="#none" class="last">마지막 목록으로 이동</a>
    </div>

    <form class="search_wrap"><fieldset>
        <legend class="hidden">사용자 목록 게시물 검색</legend>

        <div class="select">
            <label class="hidden" for="search01">게시물 갯수</label>
            <select name="search01" id="search01">
                <option value="10건">10건</option>
            </select>
        </div>

        <div class="select">
            <label class="hidden" for="search02">검색 항목</label>
            <select name="search02" id="search02">
                <option value="전체">전체</option>
            </select>
        </div>

        <label class="hidden" for="search03">검색어</label>
        <input type="text" class="input" id="search03" placeholder="검색어를 입력하세요.">
        <input type="submit" value="검색" class="btn small grays">
    </fieldset></form>

</section>
<script>
    $(function() {
        // 002. 팝업 초점 이동 추가
        $('.faq_dt button').on('click', function() {
            $(this).parent().toggleClass('on').parent().children('.faq_dd').slideToggle(300);
        });
    });
</script>
