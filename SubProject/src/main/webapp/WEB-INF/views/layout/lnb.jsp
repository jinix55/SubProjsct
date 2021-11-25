<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<script type="text/javascript">

</script>

<section id="lnb">
	<a href="#" class="menu" title="메뉴 열기/닫기"><img src="/images/arr_menu_left.png" alt="메뉴 열기/닫기"/></a>
	<div class="btn-lnb_user">
		<span class="lnb-user">
			<span class="img"><img src="/images/logo_p.png" alt="회사로고"></span>
			<span class="desc">
			<span class="depart">PPlueEco</span><p class="name">PKG Production&Development</p>
			</span>
		</span>
	</div>
	<nav style="touch-action: none;">
		<ul style="transform: translate(0px, 0px) translateZ(0px);">
			<c:forEach var="subMenu" items="${subMenuList}" varStatus="status">
			<c:if test="${subMenu.lv eq 1}">
				<li data-menu="${subMenu.menuId}M" ${fn:startsWith(myUri,subMenu.menuUrl) ? 'class=open' : ''}>
					<c:if test="${subMenu.menuSe eq 'A'}">
						<a href="#" title="${subMenu.menuNm}"><span class="txtlmg ${subMenu.iconNm}"></span>${subMenu.menuNm}</a>
					</c:if>
					<c:set var="menuhg" value="0" />
					<c:set var="menuHginit" value="44" />
					<c:forEach var="menuGpCnt" items="${menuGpCnt}" varStatus="status2">
						<c:if test="${menuGpCnt.key eq subMenu.menuId && fn:startsWith(myUri,subMenu.menuUrl)}">
							<c:set var="menuhg" value="${menuHginit * menuGpCnt.value}" />
						</c:if>
					</c:forEach>
					<ul style="height: ${menuhg}px;">
						<c:forEach var="subMenu2" items="${subMenuList}" varStatus="status3">
							<c:if test="${subMenu2.lv ne 1 && subMenu.menuId eq subMenu2.upMenuId}">
								<li data-menu="UserMgt" <c:if test="${subMenu2.menuUrl eq myUri}">class="on"</c:if>><a href="${subMenu2.menuUrl}" title="${subMenu2.menuNm}"><span class="hexagon"></span>${subMenu2.menuNm}</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</li>
			</c:if>
			</c:forEach>
     	</ul>
		<div class="iScrollVerticalScrollbar iScrollLoneScrollbar" style="position: absolute; z-index: 9999; width: 7px; bottom: 2px; top: 2px; right: 1px; overflow: hidden; transform: translateZ(0px); transition-duration: 0ms; opacity: 0;">
			<div class="iScrollIndicator" style="box-sizing: border-box; position: absolute; background: rgba(0, 0, 0, 0.5); border: 1px solid rgba(255, 255, 255, 0.9); border-radius: 3px; width: 100%; transition-duration: 0ms; display: none; height: 811px; transform: translate(0px, 0px) translateZ(0px);"></div>
		</div>
	</nav>
</section>
				