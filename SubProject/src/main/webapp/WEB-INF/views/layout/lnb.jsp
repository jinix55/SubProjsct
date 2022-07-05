<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%
	String serverName = request.getServerName();
	String subdomain = "";
	if(serverName.contains(".")) {
		subdomain = serverName.split("\\.")[0];
	}else {
		subdomain = "p";
	}
	if("www".equals(subdomain)) {
		subdomain = "p";
	}
	pageContext.setAttribute("subdomain", subdomain);
%>
<script type="text/javascript">
//Logo 조회
	var companyCode = '${subdomain}';
	if(companyCode !== 'P') {
		$.ajax({
		    type : 'get',
		    url : '/api/v1/company/'+companyCode+'/logo/',
		    data : {},
		    dataType : 'text',
		    error: function(xhr, status, error){
		        console.log(error);
		    },
		    success : function(result){
		    	console.log(result);
		    	$('#logonLogo').attr("src", "/api/v1/company/file/view/"+result);
		    }
		});
	}
</script>

<section id="lnb">
	<a href="#" class="menu" title="메뉴 열기/닫기"><img src="/images/arr_menu_left.png" alt="메뉴 열기/닫기"/></a>
	<div class="btn-lnb-comp">
		<img id="logonLogo" src="/images/logo_${subdomain}.png" alt="회사로고">
	</div>
	<div class="lnb-user">
		<span class="img"><img src="/images/icon_user02.png" alt="정보수정"></span>
		<div class="desc">
			<a href="/member/userInfoChange" class="depart">${myInfo.companyNm}
				<c:set var="userId" value="${fn:split(myInfo.userId, '@')}" />
				<small class="name">${myInfo.userNm}님(${userId[0]})</small>
			</a>
		</div>
	</div>
	<nav style="touch-action: none;">
		<ul style="transform: translate(0px, 0px) translateZ(0px);">
			<c:set var="downMenuYn" value="Y" />
			<c:forEach var="subMenu" items="${subMenuList}" varStatus="status">
			<c:if test="${subMenu.lv eq 1}">
				<li data-menu="${subMenu.menuId}M" ${fn:startsWith(myUri,subMenu.menuUrl) ? 'class=open' : ''}>
					<c:if test="${subMenu.menuSe eq 'A'}">
						<c:set var="downMenuYn" value="Y" />
						<a href="#" title="${subMenu.menuNm}"><span class="txtlmg ${subMenu.iconNm}"></span>${subMenu.menuNm}</a>
					</c:if>
					<c:if test="${subMenu.menuSe eq 'M'}">
						<c:set var="downMenuYn" value="N" />
						<li data-menu="UserMgt" <c:if test="${subMenu.menuUrl eq myUri}">class="on"</c:if>><a href="${subMenu.menuUrl}" title="${subMenu.menuNm}">${subMenu.menuNm}</a></li>
					</c:if>
					<c:set var="menuhg" value="0" />
					<c:set var="menuHginit" value="36" />
					<c:forEach var="menuGpCnt" items="${menuGpCnt}" varStatus="status2">
						<c:if test="${menuGpCnt.key eq subMenu.menuId && fn:startsWith(myUri,subMenu.menuUrl)}">
							<c:set var="menuhg" value="${menuHginit * menuGpCnt.value}" />
						</c:if>
					</c:forEach>
					<c:if test="${downMenuYn eq 'Y' }">
						<ul style="height: ${menuhg}px;">
							<c:forEach var="subMenu2" items="${subMenuList}" varStatus="status3">
								<c:if test="${subMenu2.lv ne 1 && subMenu.menuId eq subMenu2.upMenuId}">
									<li data-menu="UserMgt" <c:if test="${subMenu2.menuUrl eq myUri}">class="on"</c:if>><a href="${subMenu2.menuUrl}" title="${subMenu2.menuNm}">${subMenu2.menuNm}</a></li>
								</c:if>
							</c:forEach>
						</ul>
					</c:if>
				</li>
			</c:if>
			</c:forEach>
<%-- 			<c:if test="${!empty reportUrls}"> --%>
<%-- 				<li data-menu="reportMemu" ${fn:startsWith(myUri,'/report/reportView') ? 'class=open' : ''}> --%>
<!-- 					<a href="#" title=""><span class="txtlmg "></span>레포트 목록</a> -->
<%-- 					<c:forEach var="reportUrl" items="${reportUrls}" varStatus="status"> --%>
<!-- 						<ul style="height: 44px;"> -->
<!-- 							<li> -->
<%-- 								<li data-menu="UserMgt" <c:if test="${subMenu2.menuUrl eq myUri}">class="on"</c:if>><a href="${subMenu2.menuUrl}" title="${subMenu2.menuNm}"><span class="hexagon"></span>${subMenu2.menuNm}</a></li> --%>
<%-- 								${reportUrl } --%>
<!-- 							</li> -->
<!-- 						</ul> -->
<%-- 					</c:forEach> --%>
<!-- 				</li> -->
<%-- 			</c:if> --%>
     	</ul>
		<div class="iScrollVerticalScrollbar iScrollLoneScrollbar" style="position: absolute; z-index: 9999; width: 7px; bottom: 2px; top: 2px; right: 1px; overflow: hidden; transform: translateZ(0px); transition-duration: 0ms; opacity: 0;">
			<div class="iScrollIndicator" style="box-sizing: border-box; position: absolute; background: rgba(0, 0, 0, 0.5); border: 1px solid rgba(255, 255, 255, 0.9); border-radius: 3px; width: 100%; transition-duration: 0ms; display: none; height: 811px; transform: translate(0px, 0px) translateZ(0px);"></div>
		</div>	
	</nav>
</section>
				