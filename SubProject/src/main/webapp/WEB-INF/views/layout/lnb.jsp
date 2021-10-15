<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<script type="text/javascript">
$(document).ready(function() {
	var panel = document.querySelector(".accordion_active").nextElementSibling;
    panel.style.maxHeight = panel.scrollHeight + "px";
});
	
</script>
<div id="gnb">
	<div class="gnb_header">
	<h1 class="logo">
		<a href="javascript:void(0)">
			<span>로고</span>
			<img src="../../images/icon-recycling.png" alt="로고">
		</a>
		<p>친환경을 최우선으로 생각하는 기업</p>
	</h1>
	</div>
	<div class="gnb_stn">
		<div class="gnb_user">
			<button class="btn_gnb_user">
				<span class="user_left">
					<a href="login/ChangePswdResetLogin.html" title="정보수정"><img src="../../images/user.png" alt="정보수정"></a>
					<span class="desc">
						<span class="depart">PPLUS Echo</span><b class="name">플랫품</b>
					</span>
				</span>
			<span class="acclcon"><img src="../../images/arr-name.png"></span>
			</button>
			<div class="user_cont">
				<div class="inner_usercont">
					<div class="btn_cont">
						<button type="button" class="btn_default"><a href="#user-edit" data-toggle="modal">개인정보수정</a></button>
						<button type="button" class="btn_default"><a href="/logout">로그아웃</a></button>
					</div>
				</div>
			</div>
		</div>

		<ul class="gnb_menu">
			<c:forEach var="subMenu" items="${subMenuList}" varStatus="status">
			<c:if test="${subMenu.lv eq 1}">
			<li>
				<button type="button" name="button" class="icon accordion<c:if test="${subMenu.menuSe eq 'M'}">_none</c:if>
				<c:if test="${subMenu.menuUrl eq myUri}">accordion_active</c:if>
				${fn:startsWith(myUri,subMenu.menuUrl) ? 'accordion_active' : ''}"
				<c:if test="${subMenu.menuSe eq 'M'}">onclick="location.href='${subMenu.menuUrl}'"</c:if> >
					<span class="txt">
						<span class="txtlmg ${subMenu.iconNm}"></span>${subMenu.menuNm}
					</span>
				<c:if test="${subMenu.menuSe eq 'A'}"><span class="acclcon"><img src="../../images/checkbox_checked.png" alt="화살표"></span></c:if>
				</button>
				<div class="panel">
					<ul>
						<c:forEach var="subMenu2" items="${subMenuList}" varStatus="status">
							<c:if test="${subMenu2.lv ne 1 && subMenu.menuId eq subMenu2.upMenuId}">
								<li <c:if test="${subMenu2.menuUrl eq myUri}">class="on"</c:if>><a href="${subMenu2.menuUrl }"><span class="hexagon"></span>${subMenu2.menuNm }</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
			</li>
			</c:if>
			</c:forEach>
		</ul>
	</div>
</div>