<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src="//cdnjs.cloudflare.com/ajax/libs/wavesurfer.js/1.4.0/wavesurfer.min.js"></script>
<section class="content">
    <div class="content_tit">
        <div><span class="content_h1">대화트래킹</span></div>
        <ul class="content_nav">
            <li>HOME</li>
            <li>서비스</li>
            <li>대화트래킹</li>
        </ul>
    </div>
    
    <div class="radius_box">
    <div class="tb01_line"></div>
		<table class="tb01 cursor">
			<caption class="hidden">게시판 목록</caption>
			<colgroup>
				<col style="width: 4%">
				<col style="width: 3%">
				<col style="width: 6%">
				<col style="width: 7%">
				<col style="width: 6%">
				<col style="width: 6%">
				<col style="width: 6%">
				<col style="width: 6%">
				<col style="width: 6%" >
				<col style="width: 6%">
				<col style="width: 5%">
				<col style="width: 6%">
				<col style="width: 6%">
				<col style="width: 7%">
				<col style="width: 6%">
				<col style="width: 7%">
			</colgroup>
			<thead>
				<tr style="background: #EFEFEF;">
					<th scope="col" rowspan="2" colspan="2">번호</th>
					<th scope="col" colspan="5" id="use" style="border-bottom: 1px solid #E0DEDF;">고객 정보</th>
					<th scope="col" colspan="8" id="use2" style="border-bottom: 1px solid #E0DEDF;">콜정보</th>
					<th scope="col" id="use3" style="border-bottom: 1px solid #E0DEDF;">정보</th>	
				</tr>
				<tr>
					<th scope="col">캠페인</th>
					<th scope="col">시나리오</th>
					<th scope="col">고객번호</th>
					<th scope="col">고객명</th>
					<th scope="col">전화번호</th>
					<th scope="col">추출일</th>
					<th scope="col">지수</th>
					<th scope="col">채널</th>
					<th scope="col">콜ID</th>
					<th scope="col">처리상태</th>
					<th scope="col">업무명</th>
					<th scope="col">통화일시</th>
					<th scope="col">통화시간</th>
					<th scope="col">섭외일시</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="checkbox"></td>
					<td class="this_no">1</td>
					<td>R_이관</td>
				    <td>투자상품(단건)</td>
					<td>20200724</td>
					<td class="this_auth">문세윤</td>
					<td>01024569872</td>
					<td>20210724</td>
					<td>1</td>
					<td>상담사</td>
					<td>FE92</td>
					<td>통화종료</td>
					<td>기타</td>
					<td>2021-07-24</td>
					<td>00:07:24</td>
					<td>2021-07-24</td>
				</tr>	
				<tr>
					<td><input type="checkbox"></td>
					<td class="this_no">1</td>
					<td>R_이관</td>
				    <td>투자상품(단건)</td>
					<td>20200724</td>
					<td class="this_auth">문세윤</td>
					<td>01024569872</td>
					<td>20210724</td>
					<td>1</td>
					<td>상담사</td>
					<td>FE92</td>
					<td>통화종료</td>
					<td>기타</td>
					<td>2021-07-24</td>
					<td>00:07:24</td>
					<td>2021-07-24</td>
				</tr>		
				<tr>
					<td><input type="checkbox"></td>
					<td class="this_no">1</td>
					<td>R_이관</td>
				    <td>투자상품(단건)</td>
					<td>20200724</td>
					<td class="this_auth">문세윤</td>
					<td>01024569872</td>
					<td>20210724</td>
					<td>1</td>
					<td>상담사</td>
					<td>FE92</td>
					<td>통화종료</td>
					<td>기타</td>
					<td>2021-07-24</td>
					<td>00:07:24</td>
					<td>2021-07-24</td>
				</tr>		
				<tr>
					<td><input type="checkbox"></td>
					<td class="this_no">1</td>
					<td>R_이관</td>
				    <td>투자상품(단건)</td>
					<td>20200724</td>
					<td class="this_auth">문세윤</td>
					<td>01024569872</td>
					<td>20210724</td>
					<td>1</td>
					<td>상담사</td>
					<td>FE92</td>
					<td>통화종료</td>
					<td>기타</td>
					<td>2021-07-24</td>
					<td>00:07:24</td>
					<td>2021-07-24</td>
				</tr>		
				<tr>
					<td><input type="checkbox"></td>
					<td class="this_no">1</td>
					<td>R_이관</td>
				    <td>투자상품(단건)</td>
					<td>20200724</td>
					<td class="this_auth">문세윤</td>
					<td>01024569872</td>
					<td>20210724</td>
					<td>1</td>
					<td>상담사</td>
					<td>FE92</td>
					<td>통화종료</td>
					<td>기타</td>
					<td>2021-07-24</td>
					<td>00:07:24</td>
					<td>2021-07-24</td>
				</tr>			
		</tbody>
		</table>
	
	<div class="btn_wrap tr">
	<!-- 	<input type="button" value="통화내용" onclick="modalOpen();" class="btn big blue" data-toggle="modal" data-target="#my80sizeCenterModal"></input> -->
	    <button type="button" onclick="modalOpen();" class="btn big blue" data-toggle="modal" data-target="#my80sizeCenterModal"><i class="fas fa-microphone-alt" style="font-size: 16px;"></i> 통화내용</button>
	</div>
	</div>
	
	<div class="modal modal-center fade" id="CenterModal" tabindex="-1" style="display: none;">
		<div class="modal-dialog modal-center" style="width: 800px;height: auto;">
			<div class="modal-content">
				<div class="modal-header"> 
					<button type="button" class="close"  onclick="modalClose();">
					<span aria-hidden="true"></span>&times;</button>
					<h4 class="modal-title" id="myModalLabel">대화트래킹</h4>
				</div>		  
				
				 <div class="tab">
					 <ul class="tabs">
				       <li><a href="#tab1">서비스 트래킹 상세 </a></li>
				       <li><a href="#tab2">통화내용</a></li>
				    </ul>
			    </div>
				<div id="tab1" class="tab_content">
					<div class="modal-body">
					<table class="tb02">
					<caption class="hidden">서비스 트래킹 상세</caption>
					<colgroup>
						<col style="width: 15%">
						<col style="width: 35%">
						<col style="width: 15%">
						<col style="width: 35%">
					</colgroup>
					<tbody>
						<tr class="tb02_line">
							<th scope="row"><label>콜ID</label></th>
							<td colspan=3>
							   <input type="text"/>
							</td>
						</tr>
						<tr>
							<th scope="row"><label>전화번호</label></th>
							<td>
							   <input type="text"/>
							</td>
							<th scope="row"><label>콜구분</label></th>
							<td>
							   <input type="text"/>
							</td>		
						</tr>
						<tr>
							<th scope="row"><label>실행채널</label></th>
							<td>
							   <input type="text"/>
							</td>
							<th scope="row"><label>처리결과</label></th>
							<td>
							   <input type="text"/>
							</td>		
						</tr>
						<tr>
							<th scope="row"><label class="tc">섭외결과</label></th>
							<td>
							   <input type="text"/>
							</td>
							<th scope="row"><label>VDN</label></th>
							<td>
							   <input type="text"/>
							</td>		
						</tr>
						<tr>
							<th scope="row"><label class="tc">통화일시</label></th>
							<td>
							   <input type="text"/>
							</td>
							<th scope="row"><label>통화시간</label></th>
							<td>
							   <input type="text"/>
							</td>		
						</tr>
					</tbody>
				</table>
				
				<div class="chatbotbox mt20">
					<div class="chatbot-LeftBox">
						<span class="img-Profile"><i class="fas fa-user-astronaut" style="font-size: 40px;vertical-align: top;color: #e2e2e2;"></i></span>
						<div class="chatbot-Com">
							<span class="chatbot-BoxBg"></span>0
							<p>상담원<br>송금을 원하시는 은행명 또는 증권사명을<br> “국민은행” “삼성증권”처럼 말씀해주세요</p>
						</div>
					</div>
				    <div class="chatbot-RightBox">
						<div class="chatbot-Com">
							<span class="chatbot-BoxBg"></span>
							<p>고객</p>
							<p>삼성증권</p>
						</div>
					</div>
					<div class="chatbot-LeftBox">
						<span class="img-Profile"><i class="fas fa-user-astronaut" style="font-size: 40px;vertical-align: top;color: #e2e2e2;"></i></span>
						<div class="chatbot-Com">
							<span class="chatbot-BoxBg"></span>
							<p>상담원<br>송금을 원하시는 은행명 또는 증권사명을 “국민은행” “삼성증권”처럼 말씀해주세요</p>
						</div>
					</div>
				    <div class="chatbot-RightBox">
						<div class="chatbot-Com">
							<span class="chatbot-BoxBg"></span>
							<p>고객</p>
							<p>삼성증권</p>
						</div>
					</div>
				</div>			  
			</div>
			 
			 <div class="modal-footer mt20">
				<button type="button" class="btn small grayb"  onclick="modalClose();">닫기</button>
			</div>	
		    </div>  
			<div id="tab2" class="tab_content">
			  <div class="modal-body">
			  <table class="tb02">
						<caption class="hidden">통화내용</caption>
						<colgroup>
							<col style="width: 15%">
							<col style="width: 35%">
							<col style="width: 15%">
							<col style="width: 35%">
						</colgroup>
						<tbody>
							<tr class="tb02_line">
								<th scope="row"><label for="solarDateView">통화시간</label></th>
								<td>
								   <input type="text"/>
								</td>
								<th scope="row"><label for="holiTypeView">소요시간</label></th>
								<td>
								   <input type="text"/>
								</td>		
							</tr>
							<tr>
								<th scope="row"><label for="solarDateView">콜 ID</label></th>
								<td>
								   <input type="text"/>
								</td>
								<th scope="row"><label for="holiTypeView">소요시간</label></th>
								<td>
								   <input type="text"/>
								</td>		
							</tr>
							<tr>
								<th scope="row"><label for="solarDateView" class="tc">인아웃구분</label></th>
								<td>
								   <input type="text"/>
								</td>
								<th scope="row"><label for="holiTypeView">화자구분</label></th>
								<td>
								   <input type="text"/>
								</td>		
							</tr>
						</tbody>
					</table>
					
					<div class="modal-body-second">
						<div class="voiceForm">
						<div class="playTime">
							재생시간:<span class="msg" id="msg"></span>초
						</div>
						<div>
							<div class="waveform" id="waveform">
								<div class="loading">
									<div id='loadingImg'>
										<img src='/images/loading-spinner.gif'
											style='position: relative; display: block; margin: 0px auto;' />
									</div>
								</div>
							</div>
						</div>
						<div class="btn_wrap voiceForm">
							<button type="button" id="playStop" class="btn small blue" onclick="wavesurfer.playPause()">Play/Pause</button>
							<button type="button" id="stop" class="btn small clear" onclick="wavesurfer.stop()">취소</button>
						</div>
					</div>
				</div>
			<!-- 	<div class="modal-footer mt20">
					<button type="button" class="btn btn-default grayb"  onclick="modalClose();">닫기</button>
				</div> -->
	
				<div class="chatbotbox mt20">
					<div class="chatbot-LeftBox">
						<span class="img-Profile"><i class="fas fa-user-astronaut" style="font-size: 40px;vertical-align: top;color: #e2e2e2;"></i></span>
						<div class="chatbot-Com">
							<span class="chatbot-BoxBg"></span>0
							<p>상담원<br>송금을 원하시는 은행명 또는 증권사명을<br> “국민은행” “삼성증권”처럼 말씀해주세요</p>
						</div>
					</div>
				    <div class="chatbot-RightBox">
						<div class="chatbot-Com">
							<span class="chatbot-BoxBg"></span>
							<p>고객</p>
							<p>삼성증권</p>
						</div>
					</div>
					<div class="chatbot-LeftBox">
						<span class="img-Profile"><i class="fas fa-user-astronaut" style="font-size: 40px;vertical-align: top;color: #e2e2e2;"></i></span>
						<div class="chatbot-Com">
							<span class="chatbot-BoxBg"></span>
							<p>상담원<br>송금을 원하시는 은행명 또는 증권사명을 “국민은행” “삼성증권”처럼 말씀해주세요</p>
						</div>
					</div>
				    <div class="chatbot-RightBox">
						<div class="chatbot-Com">
							<span class="chatbot-BoxBg"></span>
							<p>고객</p>
							<p>삼성증권</p>
						</div>
					</div>
							<div class="chatbot-LeftBox">
						<span class="img-Profile"><i class="fas fa-user-astronaut" style="font-size: 40px;vertical-align: top;color: #e2e2e2;"></i></span>
						<div class="chatbot-Com">
							<span class="chatbot-BoxBg"></span>0
							<p>상담원<br>송금을 원하시는 은행명 또는 증권사명을<br> “국민은행” “삼성증권”처럼 말씀해주세요</p>
						</div>
					</div>
				    <div class="chatbot-RightBox">
						<div class="chatbot-Com">
							<span class="chatbot-BoxBg"></span>
							<p>고객</p>
							<p>삼성증권</p>
						</div>
					</div>
					<div class="chatbot-LeftBox">
						<span class="img-Profile"><i class="fas fa-user-astronaut" style="font-size: 40px;vertical-align: top;color: #e2e2e2;"></i></span>
						<div class="chatbot-Com">
							<span class="chatbot-BoxBg"></span>
							<p>상담원<br>송금을 원하시는 은행명 또는 증권사명을 “국민은행” “삼성증권”처럼 말씀해주세요</p>
						</div>
					</div>
				    <div class="chatbot-RightBox">
						<div class="chatbot-Com">
							<span class="chatbot-BoxBg"></span>
							<p>고객</p>
							<p>삼성증권</p>
						</div>
					</div>
				</div>	
			</div>
			<div class="btn_wrap modal_btn">
				<button type="button" class="btn small blue"  onclick="modalClose();">파일다운</button>
				<button type="button" class="btn small grayb"  onclick="modalClose();">닫기</button>
			</div>
		 </div> 
		</div>
	 </div>
	</div> 
</section>
<script>
$(document).ready(function() {
	$('#pageSize').val('${pages.pageSize}');
});

function modalClose(){
	$('.modal.modal-center').toggleClass(' in');
	$('.modal.modal-center').css('display','none');
	$(".modal-backdrop").detach();
};

function modalOpen(){
	$('.modal.modal-center').toggleClass(' in');
	$('.modal.modal-center').css('display','block');
	$('.content').append('<div class="modal-backdrop fade in"></div>');
};

$(document).ready(function () {
});
//Create new wavesurfer
wavesurfer = WaveSurfer.create({
    container: '#waveform',
    waveColor: 'pink',
    progressColor: 'violet',
    scrollParent: false,
    normalize: true
});

$("#date_before").datepicker({
//	showOn : "both",
dateFormat : 'yy-mm-dd',
onClose : function(selectedDate){
	$("#date_after").datepicker(
		"option",
		"minDate",
		selectedDate
	);
}
});

$("#date_after").datepicker({
//	showOn : "both",
dateFormat : 'yy-mm-dd',
onClose : function(selectedDate){
	$("#date_before").datepicker(
		"option",
		"maxDate",
		selectedDate
	);
}
});


//Set song
wavesurfer.load('http://ia902606.us.archive.org/35/items/shortpoetry_047_librivox/song_cjrg_teasdale_64kb.mp3');

wavesurfer.on('ready', function () {
	closeLoadingWithMask();
    document.getElementById("msg").innerText = Math.floor(wavesurfer.getDuration());
});
</script>