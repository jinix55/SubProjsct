function search() {
	$('#page').val(1);
	$('#holiBdForm').submit();
}

function searchSort(type, direction) {
	$('#sortType').val(type);
	$('#sortDirection').val(direction);

	search();
}

$("#newbt").click(function(){
	$('#newbt').hide();
	$('#modibt').hide();
	let result = confirm("입력이나 수정중인 항목이 모두 초기화 됩니다.\n진행하시겠습니까?");
	if(result){
		initDetail();
	}
});

// 사용자 선택시 입력값 초기화
function initData(){
};

$("#orgSolarDate").change(function(){
	$("#solarDate").val($("#orgSolarDate").val());
	
});

$("#orgHoliNm").change(function(){
	$("#holiNm").val($("#orgHoliNm").val());
	
});


// 휴일 데이터를 요청하여 가져온다.
function getHoliData(solarDate) {
	if(solarDate != '') {
		$.ajax({
			type: "post",
			url: "/admin/holiday/detail/" + solarDate,
			dataType: "text",
			success: function (result) {
				let holiday = JSON.parse(result);
				initData();
				viewDetail(holiday);
			}
		});
	}
}


// 가져온 데이터를 상세에 셋팅
function viewDetail(holiday) {
	$('#solarDateView').val(holiday.solarDate);
	$('#holiTypeView').val(holiday.holiType);
	$('#holiNmView').val(holiday.holiNm);
	$('#holiUseYn').val(holiday.useYn);
	if(holiday.useYn == 'Y'){
		$('#useYView').attr('checked',true);
	}else{
		$('#useNView').attr('checked',true);
	}
	$('#holiUseYnView').val(holiday.useYn);
}

//서비스 ON/OFF active
$(".switchYn").click(function () {
	var solarDate = $(this).parents('tr').attr('solarDate');
	if($(this).is(":checked") == true){
	    useYn = "Y";
	} else if($(this).is(":checked") == false) {
	    useYn = "N";
	}
	param = {
		solarDate : solarDate,
		useYn : useYn
	}
	
	$.ajax({
		type: "post",
		url: "/admin/holiday/update/active",
		dataType: "text",
		data: param,
		success: function (result) {
			console.log("result : ", result);
			if(result == "Update") {
				alert("항목이 수정되었습니다.");
			} else {
				alert("항목 수정에 실패했습니다. 다시 시도해 주세요");
				return;
			}
		},
		error : function (result){
			console.log("error result : " , result);
		}
	});
		
});


$("#savebt").click(function () {

	if($('#solarDateView').val() == '') {
		alert('정보를 변경하기 원하는 휴일 일자를 등록해 주세요.');
		return;
	}
	if($('#holiNmView').val() == '') {
		alert('정보를 변경하기 원하는 휴일명를 등록해 주세요.');
		return;
	}
	if($('#holiTypeView').val() == '') {
		alert('정보를 변경하기 원하는 휴일타입을 등록해 주세요.');
		return;
	}
	if($('#holiUseYn').val() == '') {
		alert('정보를 변경하기 원하는 서비스 ON/OFF를 등록해 주세요.');
		return;
	}

	let result = confirm("항목을 저장하시겠습니까?");

	if(result) {

		const formData = $("#holiForm").serialize();
		$.ajax({
			type: "post",
			url: "/admin/holiday/insert",
			dataType: "text",
			data: formData,
			success: function (result) {
				console.log("result : ", result);
				if(result == "Insert") {
					alert("항목이 입력되었습니다.");
				} else {
					alert("항목 입력에 실패했습니다. 다시 시도해 주세요");
					return;
				}
				$('#holiForm').submit();
			},
			error : function (result){
				console.log("error result : " , result);
			}
		});
	}
});

$("#modibt").click(function () {

	if($('#solarDateView').val() == '') {
		alert('정보를 변경하기 원하는 휴일 일자를 등록해 주세요.');
		return;
	}
	if($('#holiNmView').val() == '') {
		alert('정보를 변경하기 원하는 휴일명를 등록해 주세요.');
		return;
	}
	if($('#holiTypeView').val() == '') {
		alert('정보를 변경하기 원하는 휴일타입을 등록해 주세요.');
		return;
	}
	if($('#holiUseYn').val() == '') {
		alert('정보를 변경하기 원하는 서비스 ON/OFF를 등록해 주세요.');
		return;
	}

	let result = confirm("항목을 수정하시겠습니까?");

	if(result) {

		const formData = $("#holiForm").serialize();
		$.ajax({
			type: "post",
			url: "/admin/holiday/update",
			dataType: "text",
			data: formData,
			success: function (result) {
				console.log("result : ", result);
				if(result == "Update") {
					alert("항목이 수정되었습니다.");
				} else {
					alert("항목 수정에 실패했습니다. 다시 시도해 주세요");
					return;
				}
				$('#holiForm').submit();
			},
			error : function (result){
				console.log("error result : " , result);
			}
		});
	}
});
// 신규 추가시 초기화
function initDetail() {
	$('#solarDateView').val('');
	$('#holiNmView').val('');
	$('#holiTypeView').val('');
	$('#holiUseYn').val('');
	$('#memo').val('');
}
