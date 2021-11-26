<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<sec:authorize access="isAuthenticated()">
	<sec:authentication var="user" property="principal" />
</sec:authorize>
<script type="text/javascript">
$(document).ready(function() {
	var intervalTime = 10000;
// 	callAlarm();
	setInterval(function() {
// 		callAlarm();
	}, intervalTime);
	
	$(".dropdown-notification").on("click", function(){
		$('.dropdown-no-content').toggle();
	});
});
	
function callAlarm(){
	$.ajax({
		url : '/alarm/alarm/detail',
		dataType : 'json',
		success : function(data) {
			var result = data.alarmList;
			console.log(result);
			if(result.length > 0){
				$('.nav-mark').html(result.length);
				$('.nav-mark').show();;
				setAlarm(result);
			}else{
				$('.nav-mark').html(0);
				$('.nav-mark').hide();;
				var html = '';
				$('.notification').append(html);
			}
		}
	});
}

function setAlarm(data){
	var html = '';
	$('.dropdown').remove();
	data.forEach(function(item,index){
		html += '<div class="dropdown">';
		html += '	<div class="dropdown-body">';
		html += '		<a href="#">';
		html += '		 <p class="text-point">'+item.sj+'</p>'+item.cn+'';
		html += '		</a>';
		html += '	</div>';
		html += '	<div class="meta">'+intervalTime(item.rgstDt)+'</div>';
		html += '</div>';
	});
	$('.notification').append(html);
}

function intervalTime(t){
	var nowTime = new Date();
	var dataTime   = new Date(t);
	var seconds = (nowTime.getTime() - dataTime.getTime()) / 1000 / 60;
	var time = parseInt(seconds);
	if(time < 60){
		return time+'분전';
	}else{
		time = time / 60;
		if(time < 24){
			return parseInt(time)+'시간전';
		}else{
			time = time / 24;
			return parseInt(time)+'일전';
		}
	}
}
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
				<div class="notification"></div>
				<div class="dropdown-footer">
				<a href="/alarm/alarm">전체 알림보기</a>
			</div>
			</div>
		</li>
		<li><a href="/member/pwdChange" title="비밀번호 변경"><img src="/images/icon_user.png" alt="비밀번호 변경"></a></li>
		<li><a href="/logout" title="로그아웃"><img src="/images/icon_off.png" alt="로그아웃"></a></li>
	</ul>

</header>
</section>