<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

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
<script type="text/javascript" src="/js/plugins/iscroll.js"></script>
<!-- lnb메뉴스크롤-->
<title>'PPLUS Echo'(친환경 통합관리 서비스)</title>
</head>
<style>
#body {
	padding: 0;
}

.content {
	padding: 30px 30px 40px 30px;
	overflow: hidden;
}

.btn-group, .btn-Tgroup {
	padding: 20px 20px;
}
</style>
<script type="text/javascript">
var grade = [];
    //이미지툴팁
    function tools(target, contents, option) {

      function makeid(length) { //툴팁의 고유 아이디를 만들어주는 함수
        var result = '';
        var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        var charactersLength = characters.length;
        for (var i = 0; i < length; i++) {
          result += characters.charAt(Math.floor(Math.random() * charactersLength));
        }
        return result;
      }

      function _pxToNum(arg) { //픽셀을 숫자로 치환
        arg = arg.replace('px', '');
        return Number(arg);
      }

      function _type(arg, offset, width, height, tooltip_width, tooltip_height) { //툴팀을 표현할 위치를 계산하는 함수
        if (arg == 'bottom') {
          return {
            x: offset.left + _pxToNum(width) - 24,
            y: offset.top + 24
          }
        }
        //return { x: offset.left + _pxToNum(width) * 0.5 - _pxToNum(tooltip_width) / 2, y: offset.top + _pxToNum(height) * 0.5 }
      }


      var uniqueId = makeid(33); //툴팁으로 보여줄 엘리먼트 아이디
      var turnOff = true;

      $(target).mouseenter(function (event) {
        event.stopPropagation();
        event.preventDefault();
        if (!turnOff) {
          return;
        }

        if ($('#' + uniqueId).length == 0) { //해당 대상이 없으면
          $('body').append(
            $('<div>').attr({
              id: uniqueId
            }).addClass('my_tootip').addClass(option.class).append(contents)
          );
        }
        var position = _type(option.type, $(this).offset(), $(this).css('width'), $(this).css('height'), $('#' +
          uniqueId).css('width'), $('#' + uniqueId).css('height'));
        var x = position.x;
        var y = position.y;
        $('#' + uniqueId).css({
          'left': x,
          'top': y
        }).fadeIn(); //툴팁 보이기
      })
      $(target).mouseout(function (event) {
        event.stopPropagation();
        event.preventDefault();
        if (!turnOff) {
          return;
        }
        $('#' + uniqueId).fadeOut(250); //툴팁 가리기
      });

      function turnOffFun() { //툴팁 사용함수
        if (turnOff) {
          turnOff = false;
          $('#' + uniqueId).fadeOut(250);
        } else {
          turnOff = true;
          return 'on';
        }
        return 'off';
      }

      return {
        yourOption: option,
        tooltipId: uniqueId,
        turnOff: turnOffFun
      };
    }
    var res = tools('#texter', '<img src=../images/pro_img01.jpeg>', {
      type: 'bottom'
    });
    var res2 = tools('#texter2', '<img src=../images/pro_img02.jpeg>', {
      type: 'bottom'
    });
    
    $(document).ready(function() {
    	$('#largeCategory').change(function(){
    		$('#frm').submit();
    	});
    	
    	$('.saveResult').click(function(){
    		result();
    	});
    	
    	$('.isClose,.close').click(function(){
    		 $('#score').hide();
    	});
    });
    
    function chkClick(that){
   		var id = $(that).attr('id');
   		console.log(id);
   		if($('.checkbox_'+id.split('-')[0]).is(':checked')){
	   		$('.checkbox_'+id.split('-')[0]).prop('checked',false);
   		}
   		$('#'+id).prop('checked', true);
   		
		var rptMatStruct = $(that).attr('data-a');
		var rptDevAnal = $(that).attr('data-b');
		var rptVisualJudg = $(that).attr('data-c');
		var rptTest = $(that).attr('data-d');
		var rptPermission = $(that).attr('data-e');
		var rptEtc = $(that).attr('data-f');
		$('.word_check-'+id.split('-')[0]).prop('checked',false);
		if($('#'+id).prop('checked')){
			if(rptMatStruct == 'Y'){
				$('#chk_rptMatStruct-'+id.split('-')[0]).prop('checked',true);
			}
			if(rptDevAnal == 'Y'){
				$('#chk_rptDevAnal-'+id.split('-')[0]).prop('checked',true);
			}
			if(rptVisualJudg == 'Y'){
				$('#chk_rptVisualJudg-'+id.split('-')[0]).prop('checked',true);
			}
			if(rptTest == 'Y'){
				$('#chk_rptTest-'+id.split('-')[0]).prop('checked',true);
			}
			if(rptPermission == 'Y'){
				$('#chk_rptPermission-'+id.split('-')[0]).prop('checked',true);
			}
			if(rptEtc == 'Y'){
				$('#chk_rptEtc-'+id.split('-')[0]).prop('checked',true);
			}
		}
		
		var isSeasonChk = false;
        var chk = $('.checkbox_'+id.split('-')[0]);
        for(var i=0;i<chk.length;i++){
            if(chk[i].checked == true) {
            	if($(that).attr('data-Key') == 'D'){
                	isSeasonChk = true;
        			if(grade.indexOf(id.split('-')[0]) == -1){
        				grade.push(id.split('-')[0]);
        			}
                	break;
            	}else{
            		if(grade.indexOf(id.split('-')[0]) > -1){
	            		for (var i = 0; i < grade.length; i++) {
	            		    if (grade[i] === id.split('-')[0]) {
	            		    	grade.splice(i, 1);
	            		    }
	            		}
            		}
            	}
            }
        }
    }
    
    function result(){
	    var gradeResult = [];
        var chkCnt = 0;
        var sc = $('.choice-title').length;
        var text = '';
        var isAlert = true; 
        for(var i = 0 ; i < sc ; i++){
        	var id = $('.choice-title')[i].id;
        	var chkList = $('.checkbox_'+id);
        	for(var j=0;j<chkList.length;j++){
        		if(chkList[j].checked == true) {
        			gradeResult.push(chkList[j].dataset.key);
        			chkCnt++;
        			isAlert = false;
        			break;
        		}
        	}
        	text = $('.choice-title')[i].children[0].innerText;
        	if(isAlert){
	        	alert(text+' 항목을 선택하지 않으셨습니다.');
	        	isAlert = true;
	        	break;
        	}
        	isAlert = true;
        }
        console.log(gradeResult);
        if(chkCnt == $('.choice-title').length){
        	var gradeNum = 0;
        	gradeResult.forEach(function(item){
		        if(item == 'A'){
		        	if(gradeNum < 1){
			        	$('.fz').text('최우수');
			        	$('.fz').css('color','black');
			        	gradeNum = 1;
		        	}
		        }else if(item == 'B'){
		        	if(gradeNum < 2){
			        	$('.fz').text('우수');
			        	$('.fz').css('color','black');
			        	gradeNum = 2;
		        	}
		        }else if(item == 'C'){
		        	if(gradeNum < 3){
			        	$('.fz').text('보통');
			        	$('.fz').css('color','black');
			        	gradeNum = 3;
		        	}
		        }else if(item == 'D'){
		        	if(gradeNum < 4){
			        	$('.fz').text('어려움');
			        	$('.fz').css('color','red');
			        	gradeNum = 4;
		        	}
		        }
        	})
	        $('#score').show();
        }
    }
  </script>
<body class="sub">
	<div class="wrapper">
		<div id="body">
			<!-- S_본문-->
			<section class="container">
				<header class="header">
					<div class="top-location">
						<!--<h2><em>PPLUS Echo</em></h2>-->
						<ul class="location">
							<li><a href="#">Pplus</a></li>
							<li><em>자가진단기 </em></li>
						</ul>
					</div>
				</header>

				<div class="content">
					<!-- S_검색-->
					<form id="frm" action="/open/selfDiagnosis" method="post">
						<div class="justify-content-between pt30">
							<div class="form-group">
								<div class="form-inline">
									<label for="" class="form-label02">갱신일 : </label> <input
										type="text" class="text-input border-line"
										style="width: 100px"
										value="${dayList.revisionYear}년 ${dayList.revisionMonth}월"
										readonly="readonly">
								</div>
								<div class="form-inline">
									<label for="" class="form-label02">포장지유형 </label> <select
										id="largeCategory" name="largeCategory" class="select-box">
										<c:forEach items="${largeCodeList }" var="list">
											<option value="${list.codeId }"
												<c:if test="${setLargeCategory eq list.codeId }">selected</c:if>>${list.codeNm }</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
					</form>
					<!-- E_검색-->
					<div>
						<c:forEach items="${middleCodeList}" var="list">
							<h2 class="choice-title" id="${list.codeId }">
								<span class="title-point">[${list.codeNm }]</span>
							</h2>
							<div style="min-height: 180px; max-height: auto; padding-bottom: 20px;">
								<c:forEach items="${smallCodeList}" var="listLow">
									<c:if test="${listLow.groupId eq list.codeId }">
										<div class="choice-box">
											<h4 class="line-br">재활용-${listLow.codeNm}</h4>
											<div class="choice-cont">
												<ul>
													<c:forEach items="${lastCodeList }" var="lalist"
														varStatus="status">
														<c:if test="${lalist.groupId eq listLow.codeId }">
															<li class="d-flex">
																<div>
																	<input type="checkbox"
																		id="${list.codeId }-${status.index}"
																		data-key="${listLow.codeKey }"
																		data-a="${lalist.rptMatStruct}"
																		data-b="${lalist.rptDevAnal}"
																		data-c="${lalist.rptVisualJudg}"
																		data-d="${lalist.rptTest}"
																		data-e="${lalist.rptPermission}"
																		data-f="${lalist.rptEtc}"
																		name="checkbox_${list.codeId }"
																		class="checkbox_${list.codeId }"
																		onclick="chkClick(this);">
																</div> <label for="">${lalist.codeNm}</label>
															</li>
														</c:if>
													</c:forEach>
												</ul>
											</div>
										</div>
									</c:if>
								</c:forEach>
								<div class="choice-box" style="float: right;">
									<h4 class="line-br">필요서류</h4>
									<div class="choice-cont">
										<ul>
											<li><input type="checkbox"
												class="word_check-${list.codeId }"
												id="chk_rptDevAnal-${list.codeId }" disabled> <label
												for="" class="ellipsis">기기분석</label></li>
											<li><input type="checkbox"
												class="word_check-${list.codeId }"
												id="chk_rptVisualJudg-${list.codeId }" disabled> <label
												for="" class="ellipsis">육안판정</label></li>
											<li><input type="checkbox"
												class="word_check-${list.codeId }"
												id="chk_rptTest-${list.codeId }" disabled> <label
												for="" class="ellipsis">공인시험성적서</label></li>
											<li><input type="checkbox"
												class="word_check-${list.codeId }"
												id="chk_rptPermission-${list.codeId }" disabled> <label
												for="" class="ellipsis">신고허가서류</label></li>
											<li><input type="checkbox"
												class="word_check-${list.codeId }"
												id="chk_rptEtc-${list.codeId }" disabled> <label
												for="" class="ellipsis">기타</label></li>
										</ul>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>

					<div class="modal-footer btn-group">
						<button type="button" class="button btn-success saveResult">
							결과확인</button>
					</div>
				</div>
			</section>
			<!-- E_본문-->
		</div>
	</div>
	<div id="score" class="modal" data-backdrop-limit="1" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
		data-modal-parent="#myModal">
		<!-- Modal content-->
		<div class="modal-content" style="width: 400px">
			<div class="modal-header">
				<h4 class="modal-title">재활용 등급</h4>
				<button type="button" class="close" data-dismiss="modal">
					<img src="../images/icon_close.png">
				</button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-100">
						<div class="form-group">
							<div class="fz">양호</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer btn-group">
				<button type="button" class="button btn-success isClose"
					data-dismiss="modal">확인</button>
			</div>
		</div>
	</div>
</body>
</html>