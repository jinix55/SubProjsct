<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="/js/chart/Chart.bundle.min.js"></script>
<script type="text/javascript" src="/js/chart/Chart.min.js"></script>
<section class="content">

    <div class="content_tit">
         <div><span class="content_h1">대시보드</span></div>
        <ul class="content_nav">
            <li>HOME</li>
            <li>분석</li>
            <li>대시보드</li>
        </ul>
    </div>
    <div class="content-body">
	    <div class="stats-list">
	    		<c:forEach items="${data1.data }" var="list">
				<c:forEach items="${chatbotStatCd}" var="codeList">
					<c:if test="${codeList.codeId eq list.type }">
					    <div class="card-item">
					    		<div class="box-header">
								<p>
									<span class="title">
					   					${codeList.codeNm }
					   				</span>
					   			</p>
				   			</div>
				   			<div class="box-body">
				   				<p class="font-weight-bold">
				   					${list.longData}
				   				</p>
				   			</div>
				   		</div>
					</c:if>			
				</c:forEach>
	   		</c:forEach>
	    </div>
	</div>
	<div class="graph-body">
		<div class="graph-contnet">
			<canvas id="sessionGraph" style="width:100%;"></canvas>
		</div>
		<div class="graph-contnet">
			<canvas id="messageGraph" style="width:100%;"></canvas>
		</div>
		<div class="graph-contnet">
			<canvas id="sessionMessageGraph" style="width:100%;"></canvas>
		</div>
		<div class="graph-contnet">
			<canvas id="activeUserGraph" style="width:100%;"></canvas>
		</div>
	</div>
	
</section>
<script>

var chartDayData1 = [];
var chartCountData1 = [];
var chartDayData2 = [];
var chartCountData2 = [];
var chartDayData2 = [];
var chartCountData2 = [];
var chartDayData3 = [];
var chartCountData3 = [];
var chartDayData4 = [];
var chartCountData4 = [];

var ctx1 = document.getElementById('sessionGraph').getContext('2d');
var ctx2 = document.getElementById('messageGraph').getContext('2d');
var ctx3 = document.getElementById('sessionMessageGraph').getContext('2d');
var ctx4 = document.getElementById('activeUserGraph').getContext('2d');

var obj1 = JSON.parse('${data2}');
var obj2 = JSON.parse('${data3}');
var obj3 = JSON.parse('${data4}');
var obj4 = JSON.parse('${data5}');

var el1 = [];
var el2 = []; 
var el3 = []; 
var el4 = []; 

if(obj1 != null){
	el1 = obj1.data.sessionGraph.elements;
	el2 = obj2.data.messageGraph.elements;
	el3 = obj3.data.messagePerSessionGraph.elements;
	el4 = obj4.data.activeUserGraph.elements;
}

console.log(el1);
el1.forEach(function(item){
	chartDayData1.push(item.date.substring(0,10));
	chartCountData1.push(item.count);
});

el2.forEach(function(item){
	chartDayData2.push(item.date.substring(0,10));
	chartCountData2.push(item.count);
});

el3.forEach(function(item){
	chartDayData3.push(item.date.substring(0,10));
	chartCountData3.push(item.count);
});

el4.forEach(function(item){
	chartDayData4.push(item.date.substring(0,10));
	chartCountData4.push(item.count);
});




var myChart = new Chart(ctx1, {
	// abels : 데이터의 라벨을 입력하는 부분.
	// data : 실제 값.
	// backgroundbackgroundColor : 데이터의 백그라운드 색상을 지정하는 부분.
	// borderColor : 이름 그대로 border의 색상인데 선의 이나 태두리의 색.
	// borderWidth: border의 굵기.
    type: 'line',
    data: {
        labels: chartDayData1,
        datasets: [{
            label: '모든 세션 건수',
            data: chartCountData1,
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    },
    // 옵션은 responsive와 scales가 있음.
    // responsive는 디폴트로 true임. false로 바꿔주지 않으면 canvas에 설정한 값과 달리 화면에 꽉차는 반응형으로 만들어 진다.
    // canvas에 설정한 width값과 height값을 쓰려면 반드시 false로 바꾸어 주어야 한다.
    // scales의 yAxes 는 y축에 관련된 옵션이고, beginAtZero는 0부터 표기할지 이다.
	options: {
		responsive: false,
		scales: {
			yAxes: [{
				ticks: {
					beginAtZero: true,
					fontSize : 14,
				}
			}]
		}
	}
});

var myChart = new Chart(ctx2, {
	// abels : 데이터의 라벨을 입력하는 부분.
	// data : 실제 값.
	// backgroundbackgroundColor : 데이터의 백그라운드 색상을 지정하는 부분.
	// borderColor : 이름 그대로 border의 색상인데 선의 이나 태두리의 색.
	// borderWidth: border의 굵기.
    type: 'line',
    data: {
        labels: chartDayData2,
        datasets: [{
            label: '모든 메시지 건수',
            data: chartCountData2,
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 0
        }]
    },
    // 옵션은 responsive와 scales가 있음.
    // responsive는 디폴트로 true임. false로 바꿔주지 않으면 canvas에 설정한 값과 달리 화면에 꽉차는 반응형으로 만들어 진다.
    // canvas에 설정한 width값과 height값을 쓰려면 반드시 false로 바꾸어 주어야 한다.
    // scales의 yAxes 는 y축에 관련된 옵션이고, beginAtZero는 0부터 표기할지 이다.
	options: {
		responsive: false,
		scales: {
			yAxes: [{
				ticks: {
					beginAtZero: true,
					fontSize : 14,
				}
			}]
		}
	}
});

var myChart = new Chart(ctx3, {
	// abels : 데이터의 라벨을 입력하는 부분.
	// data : 실제 값.
	// backgroundbackgroundColor : 데이터의 백그라운드 색상을 지정하는 부분.
	// borderColor : 이름 그대로 border의 색상인데 선의 이나 태두리의 색.
	// borderWidth: border의 굵기.
    type: 'line',
    data: {
        labels: chartDayData3,
        datasets: [{
            label: '세션 당 평균 메시지 건수',
            data: chartCountData3,
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 0
        }]
    },
    // 옵션은 responsive와 scales가 있음.
    // responsive는 디폴트로 true임. false로 바꿔주지 않으면 canvas에 설정한 값과 달리 화면에 꽉차는 반응형으로 만들어 진다.
    // canvas에 설정한 width값과 height값을 쓰려면 반드시 false로 바꾸어 주어야 한다.
    // scales의 yAxes 는 y축에 관련된 옵션이고, beginAtZero는 0부터 표기할지 이다.
	options: {
		responsive: false,
		scales: {
			yAxes: [{
				ticks: {
					beginAtZero: true,
					fontSize : 14,
				}
			}]
		}
	}
});

var myChart = new Chart(ctx4, {
	// abels : 데이터의 라벨을 입력하는 부분.
	// data : 실제 값.
	// backgroundbackgroundColor : 데이터의 백그라운드 색상을 지정하는 부분.
	// borderColor : 이름 그대로 border의 색상인데 선의 이나 태두리의 색.
	// borderWidth: border의 굵기.
    type: 'line',
    data: {
        labels: chartDayData4,
        datasets: [{
            label: '실사용자',
            data: chartCountData4,
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 0
        }]
    },
    // 옵션은 responsive와 scales가 있음.
    // responsive는 디폴트로 true임. false로 바꿔주지 않으면 canvas에 설정한 값과 달리 화면에 꽉차는 반응형으로 만들어 진다.
    // canvas에 설정한 width값과 height값을 쓰려면 반드시 false로 바꾸어 주어야 한다.
    // scales의 yAxes 는 y축에 관련된 옵션이고, beginAtZero는 0부터 표기할지 이다.
	options: {
		responsive: false,
		scales: {
			yAxes: [{
				ticks: {
					beginAtZero: true,
					fontSize : 14,
				}
			}]
		}
	}
});
</script>