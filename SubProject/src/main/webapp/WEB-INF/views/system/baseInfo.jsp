<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<section class="content">

   <div class="content_tit">
       <h1 class="content_h1">시스템</h1>
       <ul class="content_nav">
           <li>HOME</li>
           <li>시스템</li>
           <li>시스템 정보</li>
       </ul>
   </div>

   <div class="tb01_line"></div>
   <table class="tb01" summary="첫째줄은 순차적인 게시물 번호이며, 다른 칼럼들은 권한ID, 권한명, 비고, 생성날짜 대한 내용입니다.">
       <caption class="hidden">시스템 관리</caption>
       <colgroup>
           <col style="width:6%">
           <col style="width:22%">
           <col style="width:15%">
           <col style="width:10%">
           <col style="width:*%">
           <col style="width:*%">
       </colgroup>
       <thead>
       <tr>
           <th scope="col">No</th>
           <th scope="col">시스템 명</th>
           <th scope="col">호스트명</th>
           <th scope="col">IP버전</th>
           <th scope="col">IP</th>
           <th scope="col">MAC</th>
       </tr>
       </thead>
       <tbody>
       
       <tr>
           <td scope="row">1</td>
           <td>${info.os}</td>
           <td>
           	${info.hostName}
           </td>
           <td>${info.serverIpVer}</td>
           <td>${info.serverIp}</td>
           <td>${info.serverMac}</td>
       </tr>
       </tbody>
   </table>

   <%-- <div class="page"><div class="page bootpag"><a href="javascript:void(0);" data-lp="1" class="first disabled"><span aria-hidden="true">←</span></a><a href="javascript:void(0);" data-lp="1" class="prev disabled">«</a><a href="javascript:void(0);" data-lp="1" class="on">1</a><a href="javascript:void(0);" class="next disabled" data-lp="1">»</a><a href="javascript:void(0);" class="last disabled" data-lp="1"><span aria-hidden="true">→</span></a></div></div> --%>

</section>
