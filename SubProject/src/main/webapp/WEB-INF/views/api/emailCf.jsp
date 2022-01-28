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
<script type="text/javascript" src="/js/plugins/jquery-3.5.1.js"></script>
<script type="text/javascript" src="/js/plugins/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/plugins/bootstrap.min.js"></script>
<script type="text/javascript" src="/js/plugins/iscroll.js"></script><!-- lnb메뉴스크롤-->
<script type="text/javascript" src="/js/ui/global_script.js"></script><!-- lnb-->
<title>'PPLUS Echo'(친환경 통합관리 서비스)</title>
<style>
@media print {
	body {
	    background: #fff;
	    color: #000;
	    font-size: 8pt;
	    line-height: 150%;
	    margin: 0px;
	  }
	  h1, h2, h3, h4, h5, h6, code, pre {
	    color: #000;
	    text-transform: none; /* because sometimes I set all-caps */
	  }
}
</style>
</head>
<body>
	<a href="#" class="skip-nav">본문 바로가기</a>
	<div class="wrapper">
		<!-- S_본문-->
			<div class="row">
				<div class="tab-content-box" style="width:800px;margin:30px auto;border:2px solid #000;padding:20px;">
					<h2 class="pt15 tc mb20">포장재 재질.구조 증명서</h2>
						<div class="tr mb20"><button type="button" class="button btn-modify" onclick="return window.print();">출력하기</button></div>
						<div class="tab-in-nav d-flex">
								<span class="pt10 pr10">ㆍ재질유형</span>
								<select class="select-box w200">
									<option value="0">종이팩</option>
									<option value="1">플라스틱</option>
								</select>
							<div class=" ml10 tc pt05">
								<button type="button" class="button btn-radius on"><a href="#tab01">몸체</a></button>
								<button type="button" class="button btn-radius"><a href="#tab02">라벨</a></button>
								<button type="button" class="button btn-radius"><a href="#tab03">마개및잡자재</a></button>
								<button type="button" class="button btn-radius"><a href="#tab04">라벨 마개 및 잡자재</a></button>
							</div>
						</div>

						<!-- 몸체 상세-->
						<h4 class="tl pt15"><span class="title-point">[몸체 상세]</span></h4>
						<div class="row">
							<div class="col-100">
								 <div class="form-group">
									 <label class="col-25 form-label">제품명</label>
									 <div class="col-75">
										 <div class="form-input">
											 <input type="text" class="text-input" value="">
										 </div>
									 </div>
								 </div>
							 </div>
						 <div class="col-50">
							 <div class="form-group">
								 <label class="col-25 form-label">재질정보</label>
								 <div class="col-75">
									 <div class="form-input">
										 <input type="text" class="text-input" value="">
									 </div>
								 </div>
							 </div>
						 </div>
						 <div class="col-50">
							 <div class="form-group">
								 <label class="col-25 form-label">무게</label>
								 <div class="col-75">
									 <div class="form-input">
										 <input type="text" class="text-input">
									 </div>
								 </div>
							 </div>
						 </div>
						 <div class="col-50">
							 <div class="form-group">
								 <label class="col-25 form-label">규격</label>
								 <div class="col-75">
									 <div class="form-input">
										 <input type="text" class="text-input">
									 </div>
								 </div>
							 </div>
						 </div>
						 <div class="col-50">
							 <div class="form-group">
								 <label class="col-25 form-label">색상</label>
								 <div class="col-75">
									 <div class="form-input">
										 <input type="text" class="text-input">
									 </div>
								 </div>
							 </div>
						 </div>
						 <div class="col-100">
							 <div class="form-group">
								 <label class="col-25 form-label-textarea">비고</label>
								 <div class="col-75">
									 <div class="form-input">
										 <textarea class="textarea"></textarea>
									 </div>
								 </div>
							 </div>
							 <div class="form-group">
								 <label class="col-25 form-label-img">사진등록</label>
								 <div class="col-75">
									 <div class="form-input-img">
										 <input name="files[]" type="file" multiple="multiple" id="our-file03" class="multi with-preview">
									 </div>
								 </div>
							 </div>
							 <div class="form-group">
								 <label class="col-25 form-label">참고도면 및 문서</label>
								 <div class="col-75">
										 <input type="file" multiple="multiple" class="text-input">
								 </div>
							 </div>
							 <div class="form-group">
									<label class="col-25 form-label">포장재질구조증명서</label>
									<div class="col-75">
											<input type="file" class="text-input">
									</div>
								</div>
						 </div>
						</div>
						<div class="modal-footer btn-group">
							<button type="button" class="button btn-success" data-dismiss="modal">저장</button>
							<button type="button" class="button btn-cancel" data-dismiss="modal">보내기</button>
						</div>
				</div>
			</div>
	  <!-- E_본문-->
	</div>
</body>
<script src='/js/plugins/jquery.MultiFile.min.js' type="text/javascript" language="javascript"></script>
</html>
