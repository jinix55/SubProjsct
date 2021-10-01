<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<section class="content">

    <div class="content_tit">
        <h1 class="content_h1">채널별 모니터링</h1>
        <ul class="content_nav">
            <li>HOME</li>
            <li>분석</li>
            <li>채널별 모니터링</li>
        </ul>
    </div>

	<br /><br /><br />
	/analysis/channel<c:if test="${not empty channelId }">/detail/${channelId}</c:if>
</section>
