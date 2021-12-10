$(document).ready(function() {
    checkCurrentMenu();
    gnbUI();
    gnbSubUI();
    navigationUI();
    $('input, textarea').placeholder();
});

// 메뉴
function checkCurrentMenu() {
    var menuName = $('body').attr('class').split(' ');
    $('#gnb > ul > li').each(function() {
        if (menuName[1] === $(this).attr('data-menu')) {
            $(this).addClass('on');
        }
    });
    $('#lnb nav > ul > li, #gnb > ul > li.on > ul > li').each(function() {
        if (menuName[2] === $(this).attr('data-menu')) {
            $(this).addClass('on');
        }
    });
    $('#lnb nav > ul > li.on > ul > li, #gnb > ul > li.on > ul > li.on > ul > li').each(function() {
        if (menuName[3] === $(this).attr('data-menu')) {
            $(this).addClass('on');
        }
    });
}

function setSubResize(){ //메뉴위치
	$('#gnb > ul > li > ul').each(function() {
        var numMenu = $(this).find('> li').length;
        var left = Number($('#gnb').css('left').replace('px','')), width = Number($('#gnb').css('width').replace('px','')), wid = 0;
        var eleft = $(this).parent().position().left,
        	mar = Number($(this).parent().css('margin-left').replace('px', '')) + Number($(this).parent().css('width').replace('px', ''))/2;
        if (numMenu < 6) {
            wid = (numMenu * 140);
        } else {
            wid = (6 * 140);
        }
        if(eleft + wid > width){
        	eleft = width - wid;
        } else if(eleft + mar - wid/2 > 0) {
        	eleft = eleft + mar - wid/2;
        } else {
        	eleft = 0;
        }
        $(this).css({'width': wid + 'px', 'left' : eleft});
    });
}

function gnbUI() {
    // bar
    var timerSubNav = null;
    var ifFocusPrenvented = false;

	$('#gnb > ul > li > ul').each(function() {
        var heightSub = 0;
        heightSub = $(this).outerHeight() - 42;
        $(this).css({'height': heightSub + 'px'});
    });
    setSubResize();
    setTimeout(function() {moveToInitial('none');}, 500);

    $('#gnb > ul > li > a').on('mouseenter', function() {
    	$('section .layout.no-padding select').blur();
        var offsetLeft = $(this).position().left;
        var boxWidth = $(this).innerWidth();
        $('#gnb span.bar').css({'transition': 'all 0.3s', 'left': offsetLeft + 'px', 'width': boxWidth + 'px'/*, 'background' : '#e4007f'*/});
        clearTimeout(timerSubNav);
        if(!$(this).parent().hasClass('open'))
        	$(this).parent().toggleClass('open');
        $(this).parent().siblings().removeClass('open');
    });
    $('#gnb > ul > li').on('focusin', function() {
        if (ifFocusPrenvented) return false;
        var offsetLeft = $(this).find('> a').position().left;
        var boxWidth = $(this).find('> a').innerWidth();
        $('#gnb span.bar').css({'transition': 'all 0.3s', 'left': offsetLeft + 'px', 'width': boxWidth + 'px'});
        $(this).addClass('open');
        $(this).siblings().removeClass('open');
    });

    $('#gnb').on('mouseleave', function() {
        ifFocusPrenvented = false;
        timerSubNav = setTimeout(function() {moveToInitial('all 0.3s');}, 500);
    }).on('focusout', function() {
        timerSubNav = setTimeout(function() {moveToInitial('all 0.3s');}, 500);
    }).on('mouseenter', function() {
        ifFocusPrenvented = true;
        clearTimeout(timerSubNav);
    }).on('focusin', function() {
        clearTimeout(timerSubNav);
    });

    function moveToInitial(transition) {
        $('#gnb > ul > li').removeClass('open');
        if ($('#gnb ul li.on').length === 0) {
            $('#gnb span.bar').css({'width': 0});
            return false;
        }
        var offsetLeft = $('#gnb ul li.on a').position().left;
        var boxWidth = $('#gnb ul li.on a').innerWidth();
        $('#gnb span.bar').css({'transition': transition, 'left': offsetLeft + 'px', 'width': boxWidth + 'px'});
    }
}

function gnbSubUI() {
    function checkMainSub() {
        $('#gnb a.open').css({'display': 'none'}).removeClass('on');
        $('#gnb > ul > li').each(function() {
            var offsetTop = $(this).position().top;
            if (offsetTop > 20) {
                $(this).css({'height': 0});
                $('#gnb a.open').css({'display': 'inline-block'});
            } else {
                $(this).css({'height': 'auto'});
            }
        });
    }
}


//  LNB UI
function navigationUI() {
    var myScroll = applyIScroll('#lnb nav');

    $('#lnb nav > ul > li').each(function() {
        if ($(this).find('ul li').length > 0) {
            $(this).find(' > a').append('<span class="sub"><img src=/images/arr_menu.png></span>');
        }
    });

    $('#lnb a.menu').on('click', function() {
        $('#body').toggleClass('off');
        var transitionEnd = 'transitionend webkitTransitionEnd oTransitionEnd otransitionend';

        $('#body').one(transitionEnd, function(event){
        	if(ddgrdLst.length > 0){
            	for(var i = 0; i < ddgrdLst.length; i++){
            		window[ddgrdLst[i].strId].rebuild();
            		ddgrdLst[i].gridSummary.setStyleFormat();
            	}
            }
        });
    });

    $('#lnb nav > ul > li > a').on('click', function() {
        var subHeight = 0;
        if ($(this).parent().attr('class') !== undefined && $(this).parent().attr('class').indexOf('open') !== -1) { // open class媛� 遺숈뼱 �덉쑝硫�
            $(this).parent().removeClass('open');
            $(this).next().css({'height': 0}).one('transitionend', function() {myScroll.refresh();});
        } else {
            $(this).parent().addClass('open');
            $(this).next().find('li').each(function() {
                subHeight += $(this).outerHeight();
            });
            $(this).next().css({'height': subHeight + 'px'}).one('transitionend', function() {myScroll.refresh();});
        }
    });

    $('#lnb nav > ul > li.on > a').trigger('click');
}

// iScroll
function applyIScroll(selector) {
    var myScroll = new IScroll(selector, {
        snap: false,
        click: true,
        mouseWheel: true,
        scrollbars: true,
        fadeScrollbars: true,
        interactiveScrollbars: true,
        resizeScrollbars: true,
        shrinkScrollbars: 'scale',
        scrollX: false,
        scrollY: true
    });
    return myScroll;
}
//레이어 팝업
function layerPopup(IdName){
 var maskWidth = $(window).width();
 var maskHeight = $(window).height();
   $('.mask-box').css({'width':maskWidth,'height':maskHeight});
   $(IdName).before('<div class="mask-box"></div>');
   $(IdName).show();
   $(IdName).center();
  };
  //레이어 팝업 스크롤
 //$(document).ready(function () {
  //$('#register,#overlap,#detail,#edit,#delete,#Alldelete').append('<style type="text/css">.modal .modal-body {max-height: ' + ($('body').height() * .5) + 'px;overflow-y: auto;}.modal-open .modal{overflow-y: hidden !important;}</style>');
  //});
  //레이어 팝업 닫기
function layerPopupClose(IdInfo){
   $(IdInfo).hide();
   $(".mask-box").remove();
  }

  // 숨기기보이기
    $(function(){
        var article = (".table-actions .tr-show");
        $(".table-actions .tr-item").click(function() {
            var taArticle =$(this).parents().next("tr");
            if($(taArticle).hasClass('tr-hide')) {
                $(article).removeClass('tr-show').addClass('tr-hide');
                $(taArticle).removeClass('tr-hide').addClass('tr-show');
            }
            else {
                $(taArticle).addClass('tr-hide').removeClass('tr-show');
            }
        });
        $('.form-view').attr('disabled', true);
        $(".btnEdit").click(function(){
            if($(".form-view").attr('disabled')!=""){
                  $(".form-view").attr("disabled", false);
                  $(".btnEdit").text('저장');
                  $(".btn-warning").hide();
              }else{
                  $(".form-view").attr("disabled", true);
                  $(".btnEdit").text('수정');
              }
        });
        //체크박스 클릭
         $("#checkAll").click(function(){
             //클릭되었으면
             if($("#checkAll").prop("checked")){
                 //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
                 $("input[name=chk]").prop("checked",true);
                 $(".buttons-action").show();
                 $(".btn-round").attr('disabled', true);
                 $(".btn-group").attr('disabled', true);

             }else{
                 //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
                 $("input[name=chk]").prop("checked",false);
                 $(".buttons-action").hide();
                 $(".btn-round").attr('disabled', false);
                 $(".btn-group").attr('disabled', false);
             }
         })
         $(".btn-allcancel").click(function(){
             //클릭되었으면
             $(".buttons-action").hide();
             $("input[name=chk]").prop("checked",false);
             $("input[name=all]").prop("checked",false);
             $(".btn-round").attr('disabled', false);
             $(".btn-group").attr('disabled', false);
         })
    });


 //리사이징
 $.fn.center = function () {
       this.css("position","absolute");
       this.css("top", ( $(".sub").height() - this.outerHeight() ) / 3  + "px");
       this.css("left", ( $(".sub").width() - this.outerWidth() ) / 2 + "px");
       return this;
   }

   //달력
   $(function(){
   	$("#date1").datepicker();
   });
   (function($)
   {
       $.fn.calendar = function( toObj )
       {
       	var opts = {
       		id : {from:null, to:null},
       		flag : "-"
       	}

       	var funcDate = {

       		// 날짜포맷에 맞는지 검사
       		isDateFormat : function( d ) {
       			var df;
       			if( opts.flag == "-" ) {
       				df = /[0-9]{4}-[0-9]{2}-[0-9]{2}/;
       			} else if( opts.flag == "." ) {
       				df = /[0-9]{4}.[0-9]{2}.[0-9]{2}/;
       			}
   			    return d.match(df);
   			},

   			// 윤년여부 검사
   			isLeaf : function( year )
   			{
   			    var leaf = false;
   			    if(year % 4 == 0) {
   			        leaf = true;
   			        if(year % 100 == 0) leaf = false;
   			        if(year % 400 == 0) leaf = true;
   			    }

   			    return leaf;
   			},

   			// 날짜가 유효한지 검사
   			isValidDate : function(d)
   			{
   			    // 포맷에 안맞으면 false리턴
   			    if( !funcDate.isDateFormat(d) ) return false;
   			    var month_day = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
   			    var dateToken = d.split( opts.flag );
   			    var year = Number(dateToken[0]);
   			    var month = Number(dateToken[1]);
   			    var day = Number(dateToken[2]);

   			    // 날짜가 0이면 false
   			    if(day == 0) return false;
   			    var isValid = false;

   			    // 윤년일때
   			    if( funcDate.isLeaf( year ) ) {
   			        if(month == 2) {
   			            if(day <= month_day[month-1] + 1) isValid = true;
   			        } else {
   			            if(day <= month_day[month-1]) isValid = true;
   			        }
   			    } else {
   			        if(day <= month_day[month-1]) isValid = true;
   			    }

   			    return isValid;
   			}
       	}

       	var funcEvent = {

   			change : function()
   			{
   				var $fromObj = opts.id.from;
   				var $toObj = opts.id.to;

   				if( $fromObj ) {
   					if( $fromObj.val().length >= 8 ) {
   						if( funcDate.isValidDate( $fromObj.val() ) ) {
   							if( $toObj ) {
   								$toObj.datepicker('option', 'minDate', $fromObj.val());
   							}
   						} else {
   							alert("존재하지 않는 날짜입니다.");
   							$fromObj.val("");
   							$fromObj.focus();
   							return;
   						}
   					}
   				}

   				if( $toObj ) {
   					if( $toObj.val().length >= 8 ) {
   						if( funcDate.isValidDate( $toObj.val() ) ) {
   							if( $fromObj ) {
   								$fromObj.datepicker('option', 'maxDate', $toObj.val());
   							}
   						} else {
   							alert("존재하지 않는 날짜입니다.");
   							$toObj.val("");
   							$toObj.focus();
   							return;
   						}
   					}
   				}
   			}
       	}

       	var setCalendar = function( fromObj )
       	{
       		opts.id.from = $(fromObj);
       		$(fromObj).attr("maxlength", 10);
       		$(fromObj).change( funcEvent.change );

       		// from 달력 세팅
       		$(fromObj).datepicker({
                   showOn: "button",
                   dateFormat: "yy-mm-dd",
                   changeMonth: true,
                   changeYear: true,
                   showButtonPanel: true,
                   onSelect: function() {
                   	funcEvent.change();
                   }
               });

       		// to 달력 세팅
       		if( toObj )
       		{
           		opts.id.to = $(toObj);
           		$(toObj).attr("maxlength", 10);
           		$(toObj).change( funcEvent.change );

           		$(toObj).datepicker({
   					showOn: "button",
   					dateFormat: "yy-mm-dd",
   					changeMonth: true,
   					changeYear: true,
   					showButtonPanel: true,
   					onSelect: function() {
   						funcEvent.change();
   					}
   				});
       		}
       	}

       	return this.each(function(){
       		setCalendar( this );
       	});
       }
   })
   (jQuery);
   $(function(){
       // 달력 하나짜리 세팅
       $("[name=solarDate]").calendar();

       // 기간( from~to ) 달력 세팅
       $("[name=dateFrom]").calendar( $("[name=dateTo]") );
   });
// 탭추가
  $(function(){
    $('.tab-in-content > div').hide();
    $('.tab-in-nav a').click(function () {
      $('.tab-in-content > div').hide().filter(this.hash).fadeIn();
      $('.tab-in-nav a').removeClass('active');
      $(this).addClass('active');
      return false;
    }).filter(':eq(0)').click();
  });

  //체크박스//
//     function customSelectBox(){
//       var customSelectEle, i, j, selElmnt, divEle, divEleSelected, c;
//       customSelectEle = document.querySelector(".custom_select");
//       selElmnt = customSelectEle.getElementsByTagName("select")[0];
//       divEle = document.createElement("DIV");
//       divEle.setAttribute("class","select_selected");
//       divSpan = document.createElement("span");
//       divSpan = divEle.appendChild(divSpan)
//       divSpan.innerHTML = selElmnt.options[selElmnt.selectedIndex].innerHTML;
//       customSelectEle.appendChild(divEle);
//       divEle.children[0].classList.add("color_lightGray");
//       divEleSelected = document.createElement("ul");
//       divEleSelected.setAttribute("class","select_items select_hide");
//       Array.from(selElmnt).forEach((item, index) => {
//         c = document.createElement("li");
//         cSpan = document.createElement("span");
//         cSpan = c.appendChild(cSpan);
//         cSpan.innerHTML = selElmnt.options[index].innerHTML;
//         c.addEventListener("click", function(e){
//           var y, i, k, selEleParent, selEleSibling;
//           selEleParent = this.parentNode.parentNode.getElementsByTagName("select")[0];
//           selEleSibling = this.parentNode.previousSibling;
//           for ( i = 0; i < selEleParent.length; i++){
//             if (selEleParent.options[i].innerHTML == this.children[0].innerHTML){
//                 selEleParent.selectedIndex = i;
//                 selEleSibling.innerHTML = this.innerHTML;
//                 y = this.parentNode.getElementsByClassName("sameSelected");
//                 for (k = 0; k < y.length; k++){
//                   y[k].removeArribute("class");
//                 }
//                 this.setAttribute("class","sameSelected");
//                 break;
//             }
//           }
//           selEleSibling.click();
//         });
//         divEleSelected.appendChild(c);
//           c.children[0].classList.add("color_lightGray")
//       });
//       customSelectEle.appendChild(divEleSelected);
//       divEle.addEventListener("click", function(e){
//         e.stopPropagation();
//         closeSelect(this);
//         this.nextSibling.classList.toggle("select_hide");
//         this.classList.toggle("select_arrow_active");
//       });
//       var text = document.getElementsByClassName("");
//       function closeSelect(elmnt){
//         var customSelectEle, y, i,
//         arrNo = [];
//         customSelectEle = document.getElementsByClassName("select_items");
//         y = document.getElementsByClassName("select_selected");
//         for ( i = 0; i < y.length; i++){
//           if (elmnt == y[i]){
//             arrNo.push(i);
//           }
//           else {
//             y[i].classList.remove("select_arrow_active");
//           }
//         }
//         for ( i = 0; i < customSelectEle.length; i++){
//           if (arrNo.indexOf(i)){
//             customSelectEle[i].classList.add("select_hide");
//           }
//         }
//       }
//       document.addEventListener("click", closeSelect);
//     }
//     window.onload = function(){
//       customSelectBox();
//     };