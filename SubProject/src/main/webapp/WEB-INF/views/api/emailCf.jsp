<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
<title>포장재 재질 구조 증명서</title>
<style>
body {
	width: 100%;
	height: 100%;
	margin: 0;
	padding: 0;
	background-color: #FAFAFA;
}

* {
	box-sizing: border-box;
	-moz-box-sizing: border-box;
}

.page {
	width: 210mm;
	min-height: 297mm;
	padding: 20mm;
	margin: 10mm auto;
	border: 1px #D3D3D3 solid;
	border-radius: 5px;
	background: white;
	box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
}

.subpage>h1 {
	text-align: center;
	padding: 30px 0 50px;
	/*ext-decoration: underline;*/
}

.subpage>h2 {
	padding: 30px 0 10px;
}

.table-pk {
	width: 100%;
	border: 1px solid #444444;
	border-collapse: collapse;
}

.table-pk th {
	vertical-align: middle;
	text-align: center;
	box-sizing: border-box;
	height: 50px !important;
	background-color: #f7f7f7;
}

.table-pk th, .table-pk td {
	border: 1px solid #444444;
	height: 44px;
	text-align: center;
	word-break: break-all;
}

.content-pk {
	text-align: center;
	font-size: 16px;
	font-weight: 600;
	line-height: 26px;
}

.explain-pk {
	font-size: 12px;
	line-height: 20px;
}

@page {
	size: A4;
	margin: 0;
}

@media print {
	html, body {
		width: 210mm;
		height: 297mm;
	}
	.page {
		margin: 0;
		border: initial;
		border-radius: initial;
		width: initial;
		min-height: initial;
		box-shadow: initial;
		background: initial;
		page-break-after: always;
	}
	.no-print {
		display: none !important;
	}
	body {
		background: #fff;
		color: #000;
		font-size: 9pt;
		line-height: 150%;
		margin: 0px;
	}
	h1, h2, h3, h4, h5, h6, code, pre {
		color: #000;
		text-transform: none;
		/* because sometimes I set all-caps */
	}
}
.MultiFile-applied{float: right;}
.MultiFile-list{float: left;}
.MultiFile-label{left: 0px;position: relative;height: 30px;}
/*
*/
</style>
</head>
<body>
	<a href="#" class="skip-nav">본문 바로가기</a>
	<form id="frm" action="/api/v1/setProdPackaging/update" method="post" enctype="multipart/form-data">
	<div class="wrapper">
		<!-- S_본문-->
		<div class="row">
			<div class="tab-content-box" style="width: 800px; margin: 0 auto; border: 2px solid #000; padding: 20px;">
				<h2 class="pt15 tc mb20">포장재 재질 구조 증명서</h2>
				<div class="tr mb20">
					<a href="#popup" role="button" data-toggle="modal" class="button btn-modify preView">출력물 확인하기</a>
				</div>
				<input type="hidden" id="companyCode" name="companyCode" value="${company.companyCode }">
				<input type="hidden" id="companyNm" name="companyNm" value="${company.companyNm }">
				<input type="hidden" id="representativeNm" name="representativeNm" value="${company.representativeNm }">
				<input type="hidden" id="telephoneNo" name="telephoneNo" value="${company.telephoneNo }">
				<input type="hidden" id="address" name="address" value="${company.address }">
				<input id="apiKey" name="apiKey" type="hidden" class="text-input w200" value="${packagingModel.apiKey }">
				<input id="packagingId" name="packagingId" type="hidden" class="text-input w200" value="${packagingModel.packagingId }">
				<input id="packagingNm" name="packagingNm" type="hidden" class="text-input w200" value="${packagingModel.packagingNm }">
				<input id="packagingOrder" name="packagingOrder" type="hidden" class="text-input w200" value="${packagingModel.packagingOrder }">
				<input id="productId" name="productId" type="hidden" class="text-input w200" value="${packagingModel.productId }">
				<input id="managementId" name="managementId" type="hidden" class="text-input w200" value="${packagingModel.managementId }">
				<div class="tab-in-nav d-flex">
					<span class="pt10 pr10">ㆍ재질유형</span>
					<c:forEach items="${largeEnv}" var="list" varStatus="status">
						<c:if test="${list.codeId eq packagingModel.matType.substring(0,2)}">
							<input id="matType" name="matType" type="hidden" class="text-input w200" value="${packagingModel.matType }">
							<input id="matTypeNm" name="matTypeNm" type="text" class="text-input w200" value="${list.codeNm }" disabled>
						</c:if>
					</c:forEach>
					<div class=" mr10 tc pt05 ml20">
			          	<c:choose>
			          		<c:when test="${!empty packagingModel.partType}">
					          	<c:forEach items="${middleEnv}" var="list" varStatus="status">
   						          	<c:if test="${list.codeId eq packagingModel.partType.substring(1)}">
										<input id="partType" name="partType" value="${packagingModel.partType}" type="hidden">
										<button id="partTypeNm" name="partTypeNm" value="${list.codeId}" type="button" class="button btn-radius partTypeCheck on">
										</button>
			          				</c:if>
								</c:forEach>
			          		</c:when>
			          		<c:otherwise>
			          			<button type="button" name="partType" class="button btn-radius partTypeCheck" value="B">
									몸체
								</button>
								<button type="button" name="partType" class="button btn-radius partTypeCheck" value="L">
									라벨
								</button>
								<button type="button" name="partType" class="button btn-radius partTypeCheck" value="C">
									마개
								</button>
								<button type="button" name="partType" class="button btn-radius partTypeCheck" value="M">
									잡자재
								</button>
								<button type="button" name="partType" class="button btn-radius partTypeCheck" value="S">
									별도포장
								</button>
			          		</c:otherwise>
			          	</c:choose>
					</div>
				</div>

				<!-- 몸체 상세-->
				<h4 class="tl pt15">
					<span class="title-point">[확인후 수정 해야 함 상세]</span>
				</h4>
				<div class="row">
					<div class="col-100">
						<div class="form-group">
							<label class="col-25 form-label">상품명</label>
							<div class="col-75">
								<div class="form-input">
									<input id="productNm" name="productNm" type="text" class="text-input" value="${packagingModel.productNm}" disabled>
								</div>
							</div>
						</div>
					</div>
					<div class="col-50">
						<div class="form-group">
							<label class="col-25 form-label">재질정보</label>
							<div class="col-75">
								<div class="form-input">
									<input id="matInfo" name="matInfo" type="text" class="text-input" value="${packagingModel.matInfo}">
								</div>
							</div>
						</div>
					</div>
					<div class="col-50">
						<div class="form-group">
							<label class="col-25 form-label">무게(g)</label>
							<div class="col-75">
								<div class="form-input">
									<input id="weight" name="weight" type="text" class="text-input" value="${packagingModel.weight}">
								</div>
							</div>
						</div>
					</div>
					<div class="col-50">
						<div class="form-group">
							<label class="col-25 form-label">규격</label>
							<div class="col-75">
								<div class="form-input">
									<input id="standard" name="standard" type="text" class="text-input" value="${packagingModel.standard}">
								</div>
							</div>
						</div>
					</div>
					<div class="col-50">
						<div class="form-group">
							<label class="col-25 form-label">색상</label>
							<div class="col-75">
								<div class="form-input">
									<input id="color" name="color" type="text" class="text-input" value="${packagingModel.color}">
								</div>
							</div>
						</div>
					</div>
					<div class="col-100">
						<div class="form-group">
							<label class="col-25 form-label-textarea">추가설명</label>
							<div class="col-75">
								<div class="form-input">
									<textarea id="addExplan" name="addExplan" class="textarea">${packagingModel.addExplan}</textarea>
								</div>
							</div>
						</div>
					</div>
				</div>
				<h4 class="tl pt15">
					<span class="title-point">[업체담당자정보]</span>
				</h4>
				<div class="row">
					<div class="col-50">
						<div class="form-group">
							<label class="col-25 form-label">공급업체</label>
							<div class="col-75">
								<div class="form-input">
									<input id="supplierCode" name="supplierCode" type="hidden" class="text-input" value="${packagingModel.supplierCode}">
									<input id="supplierNm" name="supplierNm"  type="text" class="text-input" value="${packagingModel.supplierNm}" disabled>
								</div>
							</div>
						</div>
					</div>
					<div class="col-50">
						<div class="form-group">
							<label class="col-25 form-label">담당자</label>
							<div class="col-75">
								<div class="form-input">
									<input id="managerId" name="managerId"  type="hidden" class="text-input" value="${packagingModel.managerId}">
									<input id="managerNm" name="managerNm"  type="text" class="text-input" value="${packagingModel.managerNm}" disabled>
								</div>
							</div>
						</div>
					</div>
					<div class="col-100">
						<div class="form-group">
							<label class="col-25 form-label">이메일</label>
							<div class="col-75">
								<div class="search-box">
									<input id="managerMail" name="managerMail"  type="text" class="text-input" value="${packagingModel.managerMail }" disabled>
								</div>
							</div>
						</div>
					</div>
				</div>
				<h4 class="tl pt15">
					<span class="title-point">[첨부파일]</span>
				</h4>
				<div class="row">
					<div class="col-100">
						<div class="form-group">
							<label class="col-25 form-label h60">포장재 재질 구조 증명서</label>
							<div class="col-75">
								<div class="form-input-txt h60">
									<input type="file" name="file" multiple="multiple" class="afile-txt"/>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer btn-group pt40">
					<button type="button" class="button btn-success" id="save" data-dismiss="modal">저장</button>
				</div>
			</div>
		</div>
		<!-- E_본문-->
	</div>
	</form>
	<div id="popup" class="modal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="page">
			<div class="tr mb20 no-print">
				<button type="button" class="button btn-modify"
					onclick="return window.print();">출력하기</button>
			</div>
			<div class="subpage">
				<h1>포장재 재질 구조 증명서</h1>
				<table class="table-pk">
					<tr>
						<th rowspan="3">공급받는자<br> (평가의무자)
						</th>
						<th>상호</th>
						<td>${company.companyNm }</td>
						<th>대표자 성명</th>
						<td>${company.representativeNm }</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="3">${company.address }</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td colspan="3">${company.telephoneNo }</td>
					</tr>
					<tr>
						<th>포장재 정보</th>
						<th>포장재 종류</th>
						<td class="packagingNm">
						<c:forEach items="${largeEnv}" var="list" varStatus="status">
							<c:if test="${list.codeId eq packagingModel.matType}">
								${list.codeNm}
							</c:if>
						</c:forEach>
						</td>
						<th>대표상품명<br>(평가신청한 상품명)
						</th>
						<td>${packagingModel.productNm}</td>
					</tr>
				</table>
				<h2 class="pt40">포장재 재질 구조</h2>
				<table class="table-pk">
					<colgroup>
						<col style="width: 30%;">
						<col style="width: 40%">
						<col style="width: 15%;">
						<col style="width: 15%;">
					</colgroup>
					<tr>
						<th>구분</th>
						<th>포장재 재질 구조 정보</th>
						<th>무게</th>
						<th>비고</th>
					</tr>
					<tbody id="tableBody">
						<tr id="tr_BODY">
							<td>몸체</td>
							<td>
								<div class="b_matInfo leftword"></div>
								<div class="b_standard leftword"></div>
								<div class="b_color leftword"></div>
								<div class="b_addExplan leftword"></div>
							</td>
							<td class="b_weight"></td>
							<td></td>
						</tr>
						<tr id="tr_LABEL">
							<td>라벨</td>
							<td> 
								<div class="l_matInfo leftword"></div>
								<div class="l_standard leftword"></div>
								<div class="l_color leftword"></div>
								<div class="l_addExplan leftword"></div>
							</td>
							<td class="l_weight"></td>
							<td></td>
						</tr>
						<tr id="tr_COVER">
							<td>마개</td>
							<td>
								<div class="c_matInfo leftword"></div>
								<div class="c_standard leftword"></div>
								<div class="c_color leftword"></div>
								<div class="c_addExplan leftword"></div>
							</td>
							<td class="c_weight"></td>
							<td></td>
						</tr>
						<tr id="tr_MISCELLANEOUS">
							<td>잡자재</td>
							<td>
								<div class="m_matInfo leftword"></div>
								<div class="m_standard leftword"></div>
								<div class="m_color leftword"></div>
								<div class="m_addExplan leftword"></div>
							</td>
							<td class="m_weight"></td>
							<td></td>
						</tr>
						<tr id="tr_SEPARATELYPACK">
							<td>별도포장</td>
							<td>
								<div class="s_matInfo leftword"></div>
								<div class="s_standard leftword"></div>
								<div class="s_color leftword"></div>
								<div class="s_addExplan leftword"></div>
							</td>
							<td class="s_weight"></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<div class="explain-pk">
					<ul>
						<li>1. 두께, 색상감소, 열알칼리성 분리 접착제 여부, 접착제 도포 면적 항목의 경우 기기분석
							정보(시험일시, 시험자, 분석장비명 및 분석겨로가 사진)는 별지로 작성</li>
						<li>2. 포자용기 또는 부자재 납품업체의 성적서, 포장재 발주규격서 및 납품확인서, 원료를 확인할 수 있는
							물질안전보건자료(MSDS) 첨부</li>
					</ul>
				</div>
				<c:set var="today" value="<%=new java.util.Date()%>" />
				<c:set var="year"><fmt:formatDate value="${today}" pattern="yyyy" /></c:set> 
				<c:set var="month"><fmt:formatDate value="${today}" pattern="MM" /></c:set>
				<c:set var="day"><fmt:formatDate value="${today}" pattern="dd" /></c:set> 
				<div class="tr mt60 font-bold ">${year}년 ${month}월 ${day}일</div>
				<div class="content-pk pt40">${packagingModel.supplierNm}</div>
				<div class="content-pk">대표이사 ${packagingModel.representativeNm}</div>
			</div>
		</div>
	</div>
</body>
<script src='/js/plugins/jquery.MultiFile.min.js' type="text/javascript" language="javascript"></script>
<script type="text/javascript">
var isDisabled = false;
$(document).ready(function() {
		$('.afile-txt').MultiFile({
			// 옵션 설정
			max : 1, //업로할수있는 최대 파일 갯수
			accept : 'txt|pptx|xlsx|pdf|hwp', //허용할수있는 파일 확장자
			STRING : { //Multi-lingual support : 메시지 수정 가능
				//remove : "제거", //추가한 파일 제거 문구, 이미태그를 사용하면 이미지사용가능
				duplicate : "$file 은 이미 선택된 파일입니다.",
				denied : "$ext 는(은) 업로드 할수 없는 파일확장자입니다.",
				selected : '$file 을 선택했습니다.',
				toomany : "업로드할 수 있는 최대 갯수는 $max개 입니다.",
			}
		});

		$('.preView').click(function() {
			var tr = $('.partTypeCheck.on').val();
			var target = '';
			if (tr == 'B') {
				target = 'b_';
			} else if (tr == 'L') {
				target = 'l_';
			} else if (tr == 'C') {
				target = 'c_';
			} else if (tr == 'M') {
				target = 'm_';
			} else if (tr == 'S') {
				target = 's_';
			}
			$('.' + target + 'weight').text($('#weight').val());
			$('.' + target + 'matInfo').text($('#matInfo').val());
			$('.' + target + 'standard').text($('#standard').val());
			$('.' + target + 'color').text($('#color').val());
			$('.' + target + 'addExplan').text($('#addExplan').val());
		});
		
		$('#save').click(function() {
			valyCheck();
			if(isDisabled){
				return false;
			}else{
		        event.preventDefault();
		        
		        $('#frm input').prop('disabled',false);
				var action = 'update'; 
				var form = $('#frm')[0];
			    var data = new FormData(form);
			    
				isDisabled = true;
				$.ajax({
					type : 'post',
					enctype: 'multipart/form-data',
					url : '/api/v1/setProdPackaging/' + action,
					data : data,
					dataType : 'TEXT',
			        processData: false,
			        contentType: false,
			        cache: false,
			        timeout: 600000,
					error : function(xhr, status, error) {
						console.log(error);
					},
					success : function(result) {
						if(result == 'success'){
							location.href = '/api/v1/update/success';
						}else if(result == 'notFile'){
							alert("포장재 재질 구조 증명서 파일을 등록해 주세요.");
							isDisabled = false;
						}
					}
				});
			}
		});
		
	});
		
	function valyCheck() {
		if ($('#weight').val() == '') {
			alert('무게을 입력해 주세요.');
			$('#midCodeId').focus();
			return false;
		}
		if ($('#matInfo').val() == '') {
			alert('재질정보를 입력해 주세요.');
			$('#midCodeNm').focus();
			return false;
		}
		if ($('#standard').val() == '') {
			alert('규격을 입력해 주세요.');
			$('#midCodeKey').focus();
			return false;
		}
		if ($('#color').val() == '') {
			alert('색상을 입력해 주세요.');
			$('#midOrdSeq').focus();
			return false;
		}
		if ($('#addExplan').val() == '') {
			alert('추가설명를 입력해 주세요.');
			$('#midOrdSeq').focus();
			return false;
		}
		return true;
	}
</script>
</html>
