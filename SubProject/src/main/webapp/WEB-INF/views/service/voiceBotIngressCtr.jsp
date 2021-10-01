<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<section class="content">
	<div class="content_tit">
		<div><span class="content_h1">음성봇 인입 제어</span></div>
		<ul class="content_nav">
			<li>HOME</li>
			<li>시스템 관리</li>
			<li>음성봇 인입 제어</li>
		</ul>
	</div>
   <ul class="tabs">
       <li><a href="#tab1"><i class="fas fa-phone-volume" style="font-size: 16px;vertical-align: inherit;"></i>폰뱅킹 ARS</a></li>
       <li><a href="#tab2"><i class="fas fa-people-arrows" style="font-size: 16px;vertical-align: inherit;"></i>거래</a></li>
       <li><a href="#tab3"><i class="fas fa-user-astronaut" style="font-size: 16px;vertical-align: inherit;"></i>AI 상담사</a></li>
    </ul> 
	<div id="tab1" class="tab_content mt30">
	<div class="mb10"><span class="required"></span><h2 class="content_h2">폰뱅킹 ARS</h2></div>
	<div class="tb01_line"></div>
		<table class="tb01 cursor">
			<caption class="hidden">게시판 목록</caption>
			<colgroup>
				<col style="width: 8%">
				<col style="width: 12%">
				<col style="width: 25%">
				<col style="width: *%">
				<col style="width: 10%">
				<col style="width: 10%">
				<col style="width: 20%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">대상 서비스</th>
					<th scope="col">서비스</th>
					<th scope="col">이용 가능 시간</th>
					<th scope="col">이용 가능 연령</th>
					<th scope="col">조작자</th>
					<th scope="col">조작일</th>
					<th scope="col">설명</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>주말실행여부</td>
					<td>
						<div class="select">
							<select id="service" size="1"> 
								<option value="평일만" >평일만</option>
								<option value="월수금">월수금</option>
								<option value="화목">화목</option>
							</select>
						</div>
					</td>
					<td>
						<input type="time" style="width:130px"></input>
						~
						<input type="time" style="width:130px"></input>
					
					</td>
					<td>
						<input type="number" value="20" min="0" max="150" step="1" style="width:60px"></input>
						~
						<input type="number" value="60" min="0" max="150" step="1" style="width:60px"></input>
					</td>
					<td>신한은행_현업</td>
					<td>2021-07-24 20:20:20</td>
					<td>폰뱅킹에서 주말에 AI상담연결 제어</td>
				</tr>
					<tr>
					<td>상담멘트위치</td>
					<td>
						<label class="switch">
						  <input type="checkbox" checked>
						  <span class="slider round"></span>
						</label>
					</td>
					<td>
						<input type="time" style="width:130px"></input>
						~
						<input type="time" style="width:130px"></input>
					
					</td>
					<td>
						<input type="number" value="20" min="0" max="150" step="1" style="width:60px"></input>
						~
						<input type="number" value="60" min="0" max="150" step="1" style="width:60px"></input>
					</td>
					<td>신한은행_현업</td>
					<td>2021-07-24 20:20:20</td>
					<td>폰뱅킹에서 주말에 AI상담연결 제어</td>
				</tr>							
		</tbody>
		</table>
		</div>
		
		<div id="tab2" class="tab_content mt30">
		<div class="mb10"><span class="required"></span><h2 class="content_h2">거래</h2></div>
		<div class="tb01_line"></div>
		<table class="tb01 cursor">
			<caption class="hidden">게시판 목록</caption>
			<colgroup>
				<col style="width: 8%">
				<col style="width: 8%">
				<col style="width: 25%">
				<col style="width: *%">
				<col style="width: 10%">
				<col style="width: 15%">
				<col style="width: 20%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">대상 서비스</th>
					<th scope="col">서비스</th>
					<th scope="col">이용 가능 시간</th>
					<th scope="col">이용 가능 연령</th>
					<th scope="col">조작자</th>
					<th scope="col">조작일</th>
					<th scope="col">설명</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>주말실행여부</td>
					<td>
						<div class="select">
							<select id="service" size="1" > 
								<option value="평일만" >평일만</option>
								<option value="월수금">월수금</option>
								<option value="화목">화목</option>
							</select>
						</div>	
					<td>
						<input type="time" style="width:130px"></input>
						~
						<input type="time"style="width:130px"></input>
					
					</td>
					<td>
						<input type="number" value="20" min="0" max="150" step="1" style="width:60px"></input>
						~
						<input type="number" value="60" min="0" max="150" step="1" style="width:60px"></input>
					</td>
					<td>신한은행_현업</td>
					<td>2021-07-24 20:20:20</td>
					<td>폰뱅킹에서 주말에 AI상담연결 제어</td>
				</tr>
		</tbody>
		</table>
		</div>	
	    <div id="tab3" class="tab_content mt30">
		<div class="mb10"><span class="required"></span><h2 class="content_h2">AI 상담사 연결 상세 목록</h2></div>
		<div class="tb01_line"></div>
		<table class="tb01 cursor">
			<caption class="hidden">게시판 목록</caption>
			<colgroup>
				<col style="width: 3%">
				<col style="width: 8%">
				<col style="width: 8%">
				<col style="width: 15%">
				<col style="width: 6%">
				<col style="width: 6%">
				<col style="width: 6%">
				<col style="width: 6%">
				<col style="width: 8%">
				<col style="width: 12%">
				<col style="width: *%">
			</colgroup>
			<thead>
				<tr  style="background: #EFEFEF;">
					<th scope="col" rowspan="2">NO</th>
					<th scope="col" rowspan="2">대상 서비스 분류</th>
					<th scope="col" rowspan="2">대상 서비스</th>
					<th scope="col" rowspan="2">서비스</th>
					<th scope="col" colspan="2" id="use" style="border-bottom: 1px solid #E0DEDF;">이용 가능 시간</th>
					<th scope="col" colspan="2" id="use2" style="border-bottom: 1px solid #E0DEDF;">이용 가능 연령</th>
					<th scope="col" rowspan="2">조작자</th>
					<th scope="col" rowspan="2">조작 일시</th>
					<th scope="col" rowspan="2">설명</th>
					
				</tr>
				<tr>
					<th scope="col">시작</th>
					<th scope="col">종료</th>
					<th scope="col">최저</th>
					<th scope="col">최고</th>
			    </tr>
			</thead>
			<tbody>
				<tr>
					<td class="this_no">1</td>
					<td>AI상담사연결</td>
					<td>자동이체</td>
					<td>
					<input type="radio" name="useYnView" id="useYView" value="Y" checked="checked">
		              <label for="useYn">ON</label>
		             <input type="radio" ame="useYnView" value="N" id="useNView">
		              <label for="useYn">OFF</label>      
					</td>
					<td>09:00</td>
					<td>16:00</td>
					<td>20</td>
					<td>60</td>
					<td>신한은행_현업</td>
					<td>2021-07-24 20:20:20</td>
					<td>자동이체 과제 업무를 상담사로 연결</td>
				</tr>		
				<tr>
					<td class="this_no">1</td>
					<td>AI상담사연결</td>
					<td>자동이체</td>
					<td>
					<input type="radio" name="useYnView" id="useYView" value="Y" checked="checked">
		              <label for="useYn">ON</label>
		             <input type="radio" name="useYnView" value="N" id="useNView">
		              <label for="useYn">OFF</label>      
					</td>
					<td>09:00</td>
					<td>16:00</td>
					<td>20</td>
					<td>60</td>
					<td>신한은행_현업</td>
					<td>2021-07-24 20:20:20</td>
					<td>자동이체 과제 업무를 상담사로 연결</td>
				</tr>		
				<tr>
					<td class="this_no">1</td>
					<td>AI상담사연결</td>
					<td>자동이체</td>
					<td>
					<input type="radio" name="useYnView" id="useYView" value="Y" checked="checked">
		              <label for="useYn">ON</label>
		             <input type="radio" name="useYnView" value="N" id="useNView">
		              <label for="useYn">OFF</label>      
					</td>
					<td>09:00</td>
					<td>16:00</td>
					<td>20</td>
					<td>60</td>
					<td>신한은행_현업</td>
					<td>2021-07-24 20:20:20</td>
					<td>자동이체 과제 업무를 상담사로 연결</td>
				</tr>		
				<tr>
					<td class="this_no">1</td>
					<td>AI상담사연결</td>
					<td>자동이체</td>
					<td>
					<input type="radio" name="useYnView" id="useYView" value="Y" checked="checked">
		              <label for="useYn">ON</label>
		             <input type="radio" name="useYnView" value="N" id="useNView">
		              <label for="useYn">OFF</label>      
					</td>
					<td>09:00</td>
					<td>16:00</td>
					<td>20</td>
					<td>60</td>
					<td>신한은행_현업</td>
					<td>2021-07-24 20:20:20</td>
					<td>자동이체 과제 업무를 상담사로 연결</td>
				</tr>		
				<tr>
					<td class="this_no">1</td>
					<td>AI상담사연결</td>
					<td>자동이체</td>
					<td>
					<input type="radio" name="useYnView" id="useYView" value="Y" checked="checked">
		              <label for="useYn">ON</label>
		             <input type="radio" name="useYnView" value="N" id="useNView">
		              <label for="useYn">OFF</label>      
					</td>
					<td>09:00</td>
					<td>16:00</td>
					<td>20</td>
					<td>60</td>
					<td>신한은행_현업</td>
					<td>2021-07-24 20:20:20</td>
					<td>자동이체 과제 업무를 상담사로 연결</td>
				</tr>		
		</tbody>
		</table>	
    </div>	
</section>
