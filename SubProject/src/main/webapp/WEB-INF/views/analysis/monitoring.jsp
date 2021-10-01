<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.7.3/dist/Chart.min.js"></script>
<section class="content">
    <div class="content_tit">
         <div><span class="content_h1">모니터링</span></div>
        <ul class="content_nav">
            <li>HOME</li>
            <li>분석</li>
            <li>모니터링</li>
        </ul>
    </div>
    <div class="dashboard">
     <ul class="graph-list row">
	    <li class="list-group-item clearfix">
	    <div style="height: 240px;">
	    <div class="agent_log1 clearfix">
	    <p class="h5"><span class="required"></span> 의도</p>
	    <div class="clearfix mt10">
	       <div class="fl"><span class="countup">214건</span></div>
	       <div class="fr"><em style="line-height: 80px;">변동없음</em></div>
	     </div>
	    </div>
	    
	    <div class="agent_error">
		    <ul>
			    <li><i class="fas fa-exclamation-triangle" style="font-size: 14px;color:#de0104"></i> 답변 매핑 누락 : <span data-v-0abbdf5a="">116</span></li>
			     <li><i class="fas fa-exclamation-triangle" style="font-size: 14px;color:#de0104"></i> 의도패턴 매핑 누락 : <span data-v-0abbdf5a="">211</span></li>
			     <li><i class="fas fa-exclamation-triangle" style="font-size: 14px;color:#de0104"></i> 상태 매핑 누락 : <span data-v-0abbdf5a="">168</span></li>
			     <li><i class="fas fa-exclamation-triangle" style="font-size: 14px;color:#de0104"></i> 질의 매핑 누락 : <span data-v-0abbdf5a="">89</span></li>
		     </ul>
	     </div>
	     </div>
	     </li>
                        
	    <li class="list-group-item clearfix">
	    <div style="height: 240px;">
	    <div class="agent_log1 clearfix">
	    <p class="h5"><span class="required"></span> 질의</p>
	    <div class="clearfix mt10">
	       <div class="fl"><span class="countup">814건</span></div>
	       <div class="fr"><em style="line-height: 80px;">변동없음</em></div>
	     </div>
	    </div>
	    
	    <div class="agent_error">
		    <ul>
			    <li><i class="fas fa-info-circle" style="font-size: 14px;color:#de0104"></i> 답변 매핑 누락 : <span data-v-0abbdf5a="">116</span></li>
			     <li><i class="fas fa-info-circle" style="font-size: 14px;color:#de0104"></i> 의도패턴 매핑 누락 : <span data-v-0abbdf5a="">211</span></li>
			     <li><i class="fas fa-info-circle" style="font-size: 14px;color:#de0104"></i> 상태 매핑 누락 : <span data-v-0abbdf5a="">168</span></li>
			     <li><i class="fas fa-info-circle" style="font-size: 14px;color:#de0104"></i> 질의 매핑 누락 : <span data-v-0abbdf5a="">89</span></li>
		     </ul>
	     </div>
	     </div>
	     </li>
	     
   		<li class="list-group-item clearfix">
	    <div style="height: 240px;">
	    <div class="agent_log1 clearfix">
	     <p class="h5"><span class="required"></span> 처리현황</p>
	    </div>
	    <div class="agent_error">
           <table>
            <colgroup>
               <col width="30%"/>
               <col width="70%"/>
             </colgroup> 
            <tbody>
            <tr>
              <td>자동이체</td>
              <td class="last">
                <div class="w3-light-grey w3-round-xlarge">
			    <div class="w3-container w3-blue w3-round-xlarge" style="width:25%">25%</div>
			  </div>
              </td>
            </tr>
            <tr>    
              <td>거래내역</td>
              <td class="last">
                <div class="w3-light-grey w3-round-xlarge">
			    <div class="w3-container w3-blue w3-round-xlarge" style="width:70%">70%</div>
			  </div>
              </td>
            </tr>
            <tr>
              <td>공인인증서</td>
              <td class="last">
                <div class="w3-light-grey w3-round-xlarge">
			    <div class="w3-container w3-blue w3-round-xlarge" style="width:55%">55%</div>
			  </div>
              </td>
            </tr>
            <tr>
              <td>쏠편한환전</td>
              <td class="last">
                <div class="w3-light-grey w3-round-xlarge">
			    <div class="w3-container w3-blue w3-round-xlarge" style="width:55%">55%</div>
			  </div>
              </td>
            </tr>
            </tbody>
             </table>
	      </div>
	     </div>
	     </li>
	     
        <li class="list-group-item clearfix">
	    <div style="height: 240px;">
	    <div class="agent_log1 clearfix">
	     <p class="h5"><span class="required"></span> 처리현황</p>
	    </div>
	    <div class="agent_error">     
	        <div class="chart-container" style="position: relative;height:auto;width:19vw">
	        	<canvas id="pie-chart"></canvas>
	        </div>
	        <script>
	        new Chart(document.getElementById("pie-chart"), {
	        type: 'pie',
	        data: {
	          labels: ["투자상품", "수신만기", "외환", "부수업무"],
	          datasets: [{
	            label: "Population (millions)",
	            backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9"],
	            data: [2478,5267,734,784]
	          }]
	        },
	        options: {
	        legend: {
	            display: true,
	            position: 'bottom',
	            labels: {
	                fontColor: '#333',
	                boxWidth: 4,
	                padding: 10,
	                usePointStyle: true
	              }
	
	        },
	        plugins: {
	          // Change options for ALL labels of THIS CHART
	            datalabels: {
	            color: '#fff',
	            labels: {
	            title: {
	                font: {weight: 'bold'}
	                }
	            }
	          }
	      }
	      }
	        // ,options: {
	        //   title: {
	        //     display: true,
	        //     text: 'Predicted world population (millions) in 2050'
	        //   }
	        // }
	    });
	        </script>
          </div>      
      </div> 
     </li>
    </ul>
    
    <div class="mt30">
    <div class="clearfix mb10"><span class="required"></span><h2 class="content_h2">메뉴적용 현황</h2></div>
       <!--  <div class="tb01_line"></div> -->
        <table class="tb01 tc">
       <%--    <colgroup>
                <col style="width:20%">
                <col style="width:20%">
                <col style="width:20%">
                <col style="width:20%">
                <col style="width:20%">
              </colgroup> --%>
              <thead>
                <tr>
	                <th scope="col" colspan=2>과제명</th>
	                <th scope="col">투자상품</th>
	                <th scope="col">수신만기</th>
	                <th scope="col">외환</th>
	                <th scope="col">부수업무</th>
                </tr>
              </thead>
              <tbody>     
	            <tr>
	                <th rowspan=2>쏠라</th>
	                <th class="tb_bg">대상고객</th>
	                <td>내용</td>
	                <td>내용</td>
	                <td>내용</td>
	                <td>내용</td>
	            </tr>
	            <tr>
	                <th class="tb_bg">진행고객</th>
	                <td>내용</td>
	                <td>내용</td>
	                <td>내용</td>
	                <td>내용</td>
	            </tr>
	          </tbody>
	        </table>
    </div>
    </div>
</section>
