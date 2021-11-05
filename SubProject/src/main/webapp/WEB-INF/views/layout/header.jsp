<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<sec:authorize access="isAuthenticated()">
	<sec:authentication var="user" property="principal" />
</sec:authorize>
<script type="text/javascript">
$(document).ready(function() {
// 	$.ajax({
// 		url : '/alarm/alarm/select',
// 		dataType : 'json',
// 		success : function(data) {
// 			var result = data;
// 			console.log(result);
// 			$('.alarmTxet').val(data.length);
// 		}
// 	});

	$(".dropdown-notification").on("click", function(){
		$('.dropdown-no-content').toggle();
	});
});
</script>
<section class="container">
<header class="header">
	<div class="top-location">
		<ul class="location">
			<li><a href="#">홈</a></li>
			<li><em>계정관리</em></li>
		</ul>
	</div>
	<ul class="top-nav">
		<li><span class="top-nav-bi top-nav-bilink"><a href="/BIChat.html" title="BI분석플랫품">BI분석플랫품</a></span></li>
       <li class="dropdown-notification"><a href="#" title="알림" style="position:relative;"><img src="/images/icon_bell.png" alt="알림"><span class="nav-mark">2</span></a>
			<div class="dropdown-no-content">
				<span class="arrow"></span>
				<div class="notification">
					<div class="dropdown">
						<div class="dropdown-body">
							<a href="#">
							 <p class="text-point">알림1</p> 내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
							</a>
						</div>
						<div class="meta">2h ago</div>
					</div>
					<div class="dropdown">
						<div class="dropdown-body">
							<a href="#">
							 <p class="text-point">알림2</p> 내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
							</a>
						</div>
						<div class="meta">2h ago</div>
					</div>
				</div>
				<div class="dropdown-footer">
				<a href="/Notifiations.html">전체 알림보기</a>
			</div>
			</div>
		</li>
		<li><a href="/member/pwdChange" title="비밀번호 변경"><img src="/images/icon_user.png" alt="비밀번호 변경"></a></li>
		<li><a href="/logout" title="로그아웃"><img src="/images/icon_off.png" alt="로그아웃"></a></li>
	</ul>

</header>
</section>