<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="/css/style.css">
<title>'PPLUS Echo'(친환경 통합관리 서비스)</title>
<style>
.wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
}
</style>
</head>
<body>
	<a href="#" class="skip-nav">본문 바로가기</a>
	<div class="wrapper">
		<!-- S_본문-->
		<section class="container">
			<div class="inspect-pop">
				<c:choose>
					<c:when test="${resultCode eq 'fail' }">
						<strong class="inspect-title" style="line-height: 1.5;">이메일 기간 만료</strong>
						<p class="inspect-text">안녕하세요. 피플러스 에코입니다.<br><br>
							요청하신 이메일 주소는 기간이 만료된 주소입니다.<br>
							다시 한번 확인해 주시고 담당자에게 재요청하시기 바랍니다.
						</p>
					</c:when>
					<c:otherwise>
						<strong class="inspect-title" style="line-height: 1.5;">등록 완료</strong>
						<p class="inspect-text">안녕하세요. 피플러스 에코입니다.<br><br>
							입력하신 정보가 정상적으로 등록되었습니다.<br>
							감사합니다.
						</p>
					</c:otherwise>
				</c:choose>
			</div>
		</section>
		<!-- E_본문-->
	</div>
</body>
</html>
