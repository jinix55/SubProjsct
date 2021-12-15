<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
<c:when test="${!empty report && report.useYn eq 'Y'}" >
<div class="content">
	<!-- S_아이프레임-->
	<div class="countsort">
		<iframe src="${report.reportUrl}" frameborder="0" allowfullscreen="" class="video"></iframe>
	</div>
	<!-- E_아이프레임-->
</div>
</c:when>
<c:otherwise>
	<div class="countsort">
		등록된 레포트가 없습니다.
	</div>
</c:otherwise>
</c:choose>
<script type="text/javascript">
</script>